Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44AF76057D6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 09:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbiJTHDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 03:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiJTHDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 03:03:45 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B05FB122BE0;
        Thu, 20 Oct 2022 00:03:44 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 686CB22D59;
        Thu, 20 Oct 2022 07:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1666249423; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AZgVjyqLYAgCOTJCxpyzq3En8/Sc8UTiYSdG0XUo3fw=;
        b=LJQl4PNUvJ/yLxJmWmMJLnXtp62LKVWkCk/ps2Sg0Sd1GxuIi1q35M5otI9N/8Hv90O1qU
        VKcatypiFhA4hRaVOntaS3ihTSdDRIAqkOKy2/K3z17mwIZsdyCsCsb6e3UNbbi5kidjDo
        lKGVsobPUj90hQw+qTdU7TAHE6F5Iaw=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 46A782C141;
        Thu, 20 Oct 2022 07:03:43 +0000 (UTC)
Date:   Thu, 20 Oct 2022 09:03:39 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Petr Pavlu <petr.pavlu@suse.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Prarit Bhargava <prarit@redhat.com>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] module: Merge same-name module load requests
Message-ID: <Y1Dyy/SAP1U3tPve@alley>
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
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2022-10-19 14:00:55, Petr Pavlu wrote:
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
>
>  		goto out;
>  	}
>  	mod_update_bounds(mod);
> 
> This is an alternative approach to fix the issue that 6e6de3dee51a addressed
> and it preserves the previous handling of same-module parallel loads.
> 
> It works well in practice but a problem is that this previous handling is
> somewhat fragile because it requires specific timings. A second load of a same
> module returns EBUSY only if it observes the first load in the going state.
> 
> The following can then happen:
> * A first load of module A is requested. It passes add_unformed_module() and
>   proceeds with full initialization.
> * A second load of module A arrives. It proceeds up to add_unformed_module()
>   where it waits on the first module to complete its initialization.
> * The first load fails because its init function happens to produce an error.
>   The cleanup code in do_init_module() unlinks the module from the modules
>   list, frees the module and finally calls wake_up_all(&module_wq).
> * The second load gets woken up. It sees that there is no module with the same
>   name in the modules list and continues with its full initialization, which
>   likely again fails in the init function.

Another solution would be to add one more reference counter directly
into struct module. The existing counter is about dependencies on the
module. It forces the module to stay in MODULE_STATE_LIVE when there
is some dependency. The new reference counter would be just about
life time of struct module.

It should be easier than to add new structure for passing err code.

Also it would allow to remove the racy finished_loading().
wait_event_interruptible() could just check mod->state.

Best Regards,
Petr
