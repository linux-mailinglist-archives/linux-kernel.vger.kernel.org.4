Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CBDD6D872A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 21:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbjDETqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 15:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjDETqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 15:46:04 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F2FE109;
        Wed,  5 Apr 2023 12:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gRyDGkNXA8X/Ou+wCx5J0rIg1wyfF74j9vjMPvDUruY=; b=tYXt24Fo50ltUGZjPjw2lPjPeF
        nzY6+MQSkeHE/QQynKGgV5VV5lcwL+HdN/7sVQPA/lOJowkAzVPwlrGZdP5RRyOlT9x5Or6Jud0RF
        rpjK/rHLoylED/BxIlOYor/5xjtmHNdH+Y92VoG8pEM6QJ410A2J6xQX2X5xzmPmm/sGx7GMD57/H
        fR/YNVwFPAg+dxxkHyps6vNJA6hvv+J2zaH3tcW+KrzQYlvD0Ai74boZq12pBdFycMCoY9rcMLD6N
        NZbanhKGgMn2inBPxugV6qcnRU6qemPwa/xBWnjEvce+TByP4Cq4QdDBhTfOmx8vzZ0Us5rav4nxk
        3NLOOFdg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pk94s-005Wvv-0J;
        Wed, 05 Apr 2023 19:45:54 +0000
Date:   Wed, 5 Apr 2023 12:45:54 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     patches@lists.linux.dev, linux-modules@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, pmladek@suse.com,
        petr.pavlu@suse.com, prarit@redhat.com,
        torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        rafael@kernel.org, christophe.leroy@csgroup.eu, tglx@linutronix.de,
        peterz@infradead.org, song@kernel.org, rppt@kernel.org,
        dave@stgolabs.net, willy@infradead.org, vbabka@suse.cz,
        mhocko@suse.com, dave.hansen@linux.intel.com,
        colin.i.king@gmail.com, jim.cromie@gmail.com,
        catalin.marinas@arm.com, jbaron@akamai.com,
        rick.p.edgecombe@intel.com
Subject: Re: [PATCH v2 3/6] module: extract patient module check into helper
Message-ID: <ZC3P8m1AN5XZNjrP@bombadil.infradead.org>
References: <20230405022702.753323-1-mcgrof@kernel.org>
 <20230405022702.753323-4-mcgrof@kernel.org>
 <b069b2b0-05fd-5c32-23c7-fbdd513681de@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b069b2b0-05fd-5c32-23c7-fbdd513681de@redhat.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 05, 2023 at 07:11:24PM +0200, David Hildenbrand wrote:
> On 05.04.23 04:26, Luis Chamberlain wrote:
> > The patient module check inside add_unformed_module() is large
> > enough as we need it. It is a bit hard to read too, so just
> > move it to a helper and do the inverse checks first to help
> > shift the code and make it easier to read. The new helper then
> > is module_patient_check_exists().
> > 
> > Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> > ---
> >   kernel/module/main.c | 71 +++++++++++++++++++++++++-------------------
> >   1 file changed, 40 insertions(+), 31 deletions(-)
> > 
> > diff --git a/kernel/module/main.c b/kernel/module/main.c
> > index 98c261928325..8f382580195b 100644
> > --- a/kernel/module/main.c
> > +++ b/kernel/module/main.c
> > @@ -2638,6 +2638,43 @@ static bool finished_loading(const char *name)
> >   	return ret;
> >   }
> > +/* Must be called with module_mutex held */
> > +static int module_patient_check_exists(const char *name)
> > +{
> > +	struct module *old;
> > +	int err = 0;
> > +
> > +	old = find_module_all(name, strlen(name), true);
> > +	if (old == NULL)
> > +		return 0;
> > +
> > +	if (old->state == MODULE_STATE_COMING
> > +	    || old->state == MODULE_STATE_UNFORMED) {
> 
> I never understood why people prefer to prefix the || on a newline. But it
> seems to be a thing in the module/ world :)

Yeah the other way seems better, I'll make it pretty.

> > +		/* Wait in case it fails to load. */
> > +		mutex_unlock(&module_mutex);
> > +		err = wait_event_interruptible(module_wq,
> > +				       finished_loading(name));
> > +		if (err)
> > +			return err;
> 
> You return with the mutex unlocked. The caller will unlock again ...

Fixed now by moving the mutex below up after the wait_event_interruptible(),
thanks.

> > +
> > +		/* The module might have gone in the meantime. */
> > +		mutex_lock(&module_mutex);
> > +		old = find_module_all(name, strlen(name), true);
> > +	}
> > +
> > +	/*
> > +	 * We are here only when the same module was being loaded. Do
> > +	 * not try to load it again right now. It prevents long delays
> > +	 * caused by serialized module load failures. It might happen
> > +	 * when more devices of the same type trigger load of
> > +	 * a particular module.
> > +	 */
> > +	if (old && old->state == MODULE_STATE_LIVE)
> > +		return -EEXIST;
> > +	else
> > +		return -EBUSY;
> 
> You can drop the else and return right away.

Will make it pretty like that, thanks.

  Luis
