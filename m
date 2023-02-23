Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 456B86A0F9A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 19:42:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbjBWSl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 13:41:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbjBWSl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 13:41:56 -0500
Received: from wind.enjellic.com (wind.enjellic.com [76.10.64.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D25545BBBE;
        Thu, 23 Feb 2023 10:41:51 -0800 (PST)
Received: from wind.enjellic.com (localhost [127.0.0.1])
        by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 31NIfNDg025492;
        Thu, 23 Feb 2023 12:41:23 -0600
Received: (from greg@localhost)
        by wind.enjellic.com (8.15.2/8.15.2/Submit) id 31NIfLQ4025490;
        Thu, 23 Feb 2023 12:41:21 -0600
Date:   Thu, 23 Feb 2023 12:41:21 -0600
From:   "Dr. Greg" <greg@enjellic.com>
To:     Hillf Danton <hdanton@sina.com>
Cc:     linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/14] Add namespace implementation.
Message-ID: <20230223184121.GA25233@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <20230204050954.11583-1-greg@enjellic.com> <20230204115917.1015-1-hdanton@sina.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230204115917.1015-1-hdanton@sina.com>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Thu, 23 Feb 2023 12:41:23 -0600 (CST)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 04, 2023 at 07:59:17PM +0800, Hillf Danton wrote:

Good afternoon Hillf, I hope this note finds your week going well.

Sorry for the delay in getting back to you on this, had some travel
and we are now in the process of readying the second spin of the
patches.

Thank you, up front, for taking the time to comment on the series.

> [with lkml Cced]

Noted.

> On Fri, 3 Feb 2023 23:09:49 -0600 Dr. Greg <greg@enjellic.com>
> > +/**
> > + * tsem_ns_free() - Releases the namespace model infrastructure.
> > + * @kref: A pointer to the reference counting structure for the namespace.
> > + *
> > + * This function is called when the last reference to a kernel
> > + * based TMA model structure is released.
> > + */
> > +void tsem_ns_free(struct kref *kref)
> > +{
> > +	struct tsem_TMA_context *ctx;
> > +
> > +	ctx = container_of(kref, struct tsem_TMA_context, kref);
> > +
> > +	if (ctx->external) {
> > +		tsem_fs_remove_external(ctx->external->dentry);
> > +		kfree(ctx->external);
> > +	} else
> > +		tsem_model_free(ctx);
> > +
> > +	kfree(ctx);
> > +}
> > +
> > +static void wq_put(struct work_struct *work)
> > +{
> > +	struct tsem_TMA_work *tsem_work;
> > +	struct tsem_TMA_context *ctx;
> > +
> > +	tsem_work = container_of(work, struct tsem_TMA_work, work);
> > +	ctx = tsem_work->ctx;
> > +	kref_put(&ctx->kref, tsem_ns_free);
> > +}
> > +
> > +/**
> > + * tsem_ns_get() - Obtain a reference on a TSEM TMA namespace.
> > + * @ctx: A pointer to the TMA modeling context for which a reference is
> > + *	 to be released.
> > + *
> > + * This function is called to release a reference to a TMA modeling
> > + * domain.
> > + */
> > +void tsem_ns_put(struct tsem_TMA_context *ctx)
> > +{
> > +	if (kref_read(&ctx->kref) > 1) {
> > +		kref_put(&ctx->kref, tsem_ns_free);
> > +		return;
> > +	}

> Given ctx->kref is 2, in the below scenario
> 
> 	cpu 0		cpu 2
> 	---		---
> 	ctx->kref > 1
> 			ctx->kref > 1
> 			kref_put
> 	kref_put
> 
> no work will be scheduled, so it makes sense to move scheduling work to
> tsem_ns_free() by making tsem_ns_put() only a wrapper of kref_put(), if
> ctx has to be released in workqueue.
> 
> void tsem_ns_put(struct tsem_TMA_context *ctx)
> {
> 	kref_put(&ctx->kref, tsem_ns_free);
> }

Missed this issue, thank you for pointing it out.

Based on your observations we re-worked the handling of the modeling
context reference handling and release and we should have the issue
addressed.

In the process we managed to clean up and simplify the implementation
as well, always good.

The changes will be in the second version of the patch series.

> > +
> > +	INIT_WORK(&ctx->work.work, wq_put);
> > +	ctx->work.ctx = ctx;
> > +	if (!queue_work(release_wq, &ctx->work.work))
> > +		WARN_ON_ONCE(1);
> > +}

> PS given system_unbound_wq and system_wq for instance, release_wq looks
> not mandatory if kfree is the major job.

Based on this observation, we also dropped the TSEM specific workqueue
and the code is now scheduling the modeling domain release work onto
the system_wq queue, given that there is nothing sophisticated about
the work that is being scheduled.

This work includes the freeing of the memory for the structure that
defines the external modeling context, or in the case of an internally
modeled domain, the internal model description state.

In addition, in the case of an externally modeled domain, the
workqueue also handles the removal of the securityfs based pseudo-file
that surfaces the event descriptions to the trust orchestrator.

The use of the workqueue silences a series of lock debugging
complaints about the release of the modeling domain/namespace
infrastructure.

Thanks again for your comments, have a good day.

As always,
Dr. Greg

The Quixote Project - Flailing at the Travails of Cybersecurity
