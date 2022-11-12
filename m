Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD2FA62663F
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 02:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233477AbiKLBrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 20:47:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233750AbiKLBrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 20:47:31 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF0AB5CD39;
        Fri, 11 Nov 2022 17:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1h4b36xjfrJxeVTHNiWTObUZ6e0AouI8FvL/L/clyFk=; b=hgypyjf+iYre0pd/UehroNA3Ow
        WXtRXmiviSXv6BjKh5VSOU9wa+UnrYyU0pYgxDHL1LvFbcX37VoW+FP0uexXeJlIfWnO32BZsG4/D
        zE+4RbUmDg1R+r5kkjebDP0zwi7N2mSoNtsQ02hnlH94Yu2bBhbnrmI6iw+VPP6/aXSaa2YdAYEEE
        lqfYqOgMfio1cTIG8JfQGdoNgmDhRXu1ZZawCCfBTtq0Obv/0gTVp0tGj7V235fYMKKnV5q71qExp
        do/r9iB25zNJxqFGojvahHaa1j6ti47P59cC4h/kTpG/1eOtBCZwLrAGxG/RrBdR1ag711F3RT2CQ
        l4wNhUGQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1otfc5-002QhM-DU; Sat, 12 Nov 2022 01:47:25 +0000
Date:   Fri, 11 Nov 2022 17:47:17 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Prarit Bhargava <prarit@redhat.com>,
        David Hildenbrand <david@redhat.com>
Cc:     pmladek@suse.com, Petr Pavlu <petr.pavlu@suse.com>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        mcgrof@kernel.org
Subject: Re: [PATCH v2 2/2] module: Merge same-name module load requests
Message-ID: <Y277Jb9i2VeXQoTL@bombadil.infradead.org>
References: <20220919123233.8538-1-petr.pavlu@suse.com>
 <20220919123233.8538-3-petr.pavlu@suse.com>
 <YzdR0gRNQI2BGnJ9@bombadil.infradead.org>
 <aa8d9456-b260-d999-0296-8e6ab876af7a@suse.com>
 <Y07xX2ejlg0oFoEy@bombadil.infradead.org>
 <d0bc50e3-0e42-311b-20ed-7538bb918c5b@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0bc50e3-0e42-311b-20ed-7538bb918c5b@suse.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 02:00:55PM +0200, Petr Pavlu wrote:
> On 10/18/22 20:33, Luis Chamberlain wrote:
> > On Sat, Oct 15, 2022 at 11:27:10AM +0200, Petr Pavlu wrote:
> >> The patch does address a regression observed after commit 6e6de3dee51a
> >> ("kernel/module.c: Only return -EEXIST for modules that have finished
> >> loading"). I guess it can have a Fixes tag added to the patch.
> >>
> >> I think it is hard to split this patch into parts because the implemented
> >> "optimization" is the fix.
> > 
> > git describe --contains 6e6de3dee51a
> > v5.3-rc1~38^2~6
> > 
> > I'm a bit torn about this situation. Reverting 6e6de3dee51a would be the
> > right thing to do, but without it, it still leaves the issue reported
> > by Prarit Bhargava. We need a way to resolve the issue on stable and
> > then your optimizations can be applied on top.
> 
> Simpler could be to do the following:
> 
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index d02d39c7174e..0302ac387e93 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -2386,7 +2386,8 @@ static bool finished_loading(const char *name)
>  	sched_annotate_sleep();
>  	mutex_lock(&module_mutex);
>  	mod = find_module_all(name, strlen(name), true);
> -	ret = !mod || mod->state == MODULE_STATE_LIVE;
> +	ret = !mod || mod->state == MODULE_STATE_LIVE
> +		|| mod->state == MODULE_STATE_GOING;
>  	mutex_unlock(&module_mutex);
>  
>  	return ret;
> @@ -2566,7 +2567,8 @@ static int add_unformed_module(struct module *mod)
>  	mutex_lock(&module_mutex);
>  	old = find_module_all(mod->name, strlen(mod->name), true);
>  	if (old != NULL) {
> -		if (old->state != MODULE_STATE_LIVE) {
> +		if (old->state == MODULE_STATE_COMING
> +		    || old->state == MODULE_STATE_UNFORMED) {
>  			/* Wait in case it fails to load. */
>  			mutex_unlock(&module_mutex);
>  			err = wait_event_interruptible(module_wq,
> @@ -2575,7 +2577,7 @@ static int add_unformed_module(struct module *mod)
>  				goto out_unlocked;
>  			goto again;
>  		}
> -		err = -EEXIST;
> +		err = old->state != MODULE_STATE_LIVE ? -EBUSY : -EEXIST;
>  		goto out;
>  	}
>  	mod_update_bounds(mod);


Prarit, can you verify this still does not break the issue you reported?
David, does this also fix your issue?

Petr, does this solve *any* of your issues? Can you also send a proper
patch with a commit log once we get confirmation of the tests.

I've been nose diving onto all of these 3 issues now and I have some
ideas of how to split this crap better and save even more memory on
bootup due to these stupid multiple requests. I want to first solve this
regression.

  Luis
