Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9AED70DC47
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 14:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236767AbjEWMQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 08:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236760AbjEWMQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 08:16:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 706D7109
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 05:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684844130;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RMfXzJcNmXtD5s5OdLp9quleEGVvmdXTdhN2MxgG29w=;
        b=bnFjOgny1jFxIB0eL8FZIFM2sub7mevouwziBdjb2EGo8IbSkWa19GhYjT9zruI+hehZvG
        fzMGPvSfvkMuXRdRfZFULO7zAeNa7R2ctcmKGYRGjL6jYY8JB2BDYKEU2IQW0CRdlTkH3d
        VcSr1WWLBn5RD96PVSGWcs1/KHrLf9c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-140-APhMgIePNlaesPXpS6PWkg-1; Tue, 23 May 2023 08:15:27 -0400
X-MC-Unique: APhMgIePNlaesPXpS6PWkg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D46B9811E7F;
        Tue, 23 May 2023 12:15:26 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.170])
        by smtp.corp.redhat.com (Postfix) with SMTP id 30AA9140E95D;
        Tue, 23 May 2023 12:15:23 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 23 May 2023 14:15:10 +0200 (CEST)
Date:   Tue, 23 May 2023 14:15:06 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Mike Christie <michael.christie@oracle.com>
Cc:     linux@leemhuis.info, nicolas.dichtel@6wind.com, axboe@kernel.dk,
        ebiederm@xmission.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, mst@redhat.com,
        sgarzare@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        brauner@kernel.org
Subject: Re: [PATCH 3/3] fork, vhost: Use CLONE_THREAD to fix freezer/ps
 regression
Message-ID: <20230523121506.GA6562@redhat.com>
References: <20230522025124.5863-1-michael.christie@oracle.com>
 <20230522025124.5863-4-michael.christie@oracle.com>
 <20230522123029.GA22159@redhat.com>
 <cfca7764-d210-6df9-e182-2c093101c6cf@oracle.com>
 <20230522174757.GC22159@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522174757.GC22159@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/22, Oleg Nesterov wrote:
>
> Right now I think that "int dead" should die,

No, probably we shouldn't call get_signal() if we have already dequeued SIGKILL.

> but let me think tomorrow.

May be something like this... I don't like it but I can't suggest anything better
right now.

	bool killed = false;

	for (;;) {
		...
	
		node = llist_del_all(&worker->work_list);
		if (!node) {
			schedule();
			/*
			 * When we get a SIGKILL our release function will
			 * be called. That will stop new IOs from being queued
			 * and check for outstanding cmd responses. It will then
			 * call vhost_task_stop to tell us to return and exit.
			 */
			if (signal_pending(current)) {
				struct ksignal ksig;

				if (!killed)
					killed = get_signal(&ksig);

				clear_thread_flag(TIF_SIGPENDING);
			}

			continue;
		}

-------------------------------------------------------------------------------
But let me ask a couple of questions. Let's forget this patch, let's look at the
current code:

		node = llist_del_all(&worker->work_list);
		if (!node)
			schedule();

		node = llist_reverse_order(node);
		... process works ...

To me this looks a bit confusing. Shouldn't we do

		if (!node) {
			schedule();
			continue;
		}

just to make the code a bit more clear? If node == NULL then
llist_reverse_order() and llist_for_each_entry_safe() will do nothing.
But this is minor.



		/* make sure flag is seen after deletion */
		smp_wmb();
		llist_for_each_entry_safe(work, work_next, node, node) {
			clear_bit(VHOST_WORK_QUEUED, &work->flags);

I am not sure about smp_wmb + clear_bit. Once we clear VHOST_WORK_QUEUED,
vhost_work_queue() can add this work again and change work->node->next.

That is why we use _safe, but we need to ensure that llist_for_each_safe()
completes LOAD(work->node->next) before VHOST_WORK_QUEUED is cleared.

So it seems that smp_wmb() can't help and should be removed, instead we need

		llist_for_each_entry_safe(...) {
			smp_mb__before_atomic();
			clear_bit(VHOST_WORK_QUEUED, &work->flags);

Also, if the work->fn pointer is not stable, we should read it before
smp_mb__before_atomic() as well.

No?


			__set_current_state(TASK_RUNNING);

Why do we set TASK_RUNNING inside the loop? Does this mean that work->fn()
can return with current->state != RUNNING ?


			work->fn(work);

Now the main question. Whatever we do, SIGKILL/SIGSTOP/etc can come right
before we call work->fn(). Is it "safe" to run this callback with
signal_pending() or fatal_signal_pending() ?


Finally. I never looked into drivers/vhost/ before so I don't understand
this code at all, but let me ask anyway... Can we change vhost_dev_flush()
to run the pending callbacks rather than wait for vhost_worker() ?
I guess we can't, ->mm won't be correct, but can you confirm?

Oleg.

