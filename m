Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4805BA7F4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 10:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbiIPIQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 04:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbiIPIPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 04:15:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D35B64D26D
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 01:15:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1635B628FF
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 08:15:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAB3FC433D7;
        Fri, 16 Sep 2022 08:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1663316122;
        bh=Vmu2pXGR2qKDM5NtYPIEZZuJIRXmOGJUGhaCm1owV00=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KdrtgOKMaJSzn31boNkRiZJUxizzFmsYR6hhr2yc//e8vd4hkK6fCY98EY8wdDaua
         TuLv3B96CFGoXkZs7e9wM3+7n/Ah2lLlEzNpr/C3nnWJbCkEdo52UVJt51bJs5IJJR
         HQHKfQbDxfZB6H4+5MegHXK8tTL9ZpUVrMaSimXk=
Date:   Fri, 16 Sep 2022 10:15:47 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     xmzyshypnc <1002992920@qq.com>
Cc:     dimitri.sivanich@hpe.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org, hackerzheng666@gmail.com,
        alex000young@gmail.com, security@kernel.org
Subject: Re: [PATCH] misc: sgi-gru: fix use-after-free error in
 gru_set_context_option, gru_fault and gru_handle_user_call_os
Message-ID: <YyQwsxDoaWT6Y5a0@kroah.com>
References: <tencent_48738CD5589B4162E0D0B9D85B84DCD33C0A@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_48738CD5589B4162E0D0B9D85B84DCD33C0A@qq.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2022 at 03:39:57PM +0800, xmzyshypnc wrote:
> in drivers/misc/sgi-gru/grufile.c, gru_file_unlocked_ioctl function can be called by user. If the req is GRU_SET_CONTEXT_OPTION, it will call gru_set_context_option.

Please properly wrap your changelog text at 72 columns like your editor
asked you to when you wrote the changelog text.

> 
> In gru_set_context_option, as req can be controlled by user (copy_from_user(&req, (void __user *)arg, sizeof(req))), we can get into sco_blade_chiplet case and reach gru_check_context_placement function call.
> 
> in gru_check_context_placement function, if the error path was steped, say gru_check_chiplet_assignment return 0, then it will fall into gru_unload_context function,which will call gru_free_gru_context->gts_drop. As gts->ts_refcnt was set to 1 in gru_alloc_gts. It will finnaly call kfree(gts) in gts_drop function.
> 
> Then gru_unlock_gts will be called in gru_set_context_option function. which is a typical Use after free.
> 
> The same problem exists in gru_handle_user_call_os function and gru_fault function.
> 
> Fix it by introduce the return value to see if gts is in good case or not. Free the gts in caller when gru_check_chiplet_assignment check failed.
> 
> Signed-off-by: xmzyshypnc <1002992920@qq.com>
> ---
>  drivers/misc/sgi-gru/grufault.c  | 14 ++++++++++++--
>  drivers/misc/sgi-gru/grumain.c   | 19 +++++++++++++++----
>  drivers/misc/sgi-gru/grutables.h |  2 +-
>  3 files changed, 28 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/misc/sgi-gru/grufault.c b/drivers/misc/sgi-gru/grufault.c
> index d7ef61e602ed..08e837a45ad7 100644
> --- a/drivers/misc/sgi-gru/grufault.c
> +++ b/drivers/misc/sgi-gru/grufault.c
> @@ -656,7 +656,13 @@ int gru_handle_user_call_os(unsigned long cb)
>  	if (ucbnum >= gts->ts_cbr_au_count * GRU_CBR_AU_SIZE)
>  		goto exit;
>  
> -	gru_check_context_placement(gts);
> +	ret = gru_check_context_placement(gts);
> +
> +	if (ret) {

No blank line needed.

> +		gru_unlock_gts(gts);
> +		gru_unload_context(gts, 1);
> +		return -EINVAL;

Jump to an error block at the end of the function instead?

> +	}
>  
>  	/*
>  	 * CCH may contain stale data if ts_force_cch_reload is set.
> @@ -874,7 +880,7 @@ int gru_set_context_option(unsigned long arg)
>  		} else {
>  			gts->ts_user_blade_id = req.val1;
>  			gts->ts_user_chiplet_id = req.val0;
> -			gru_check_context_placement(gts);
> +			ret = gru_check_context_placement(gts);
>  		}
>  		break;
>  	case sco_gseg_owner:
> @@ -889,6 +895,10 @@ int gru_set_context_option(unsigned long arg)
>  		ret = -EINVAL;
>  	}
>  	gru_unlock_gts(gts);
> +	if (ret) {
> +		gru_unload_context(gts, 1);
> +		ret = -EINVAL;
> +	}
>  
>  	return ret;
>  }
> diff --git a/drivers/misc/sgi-gru/grumain.c b/drivers/misc/sgi-gru/grumain.c
> index 9afda47efbf2..e1ecf86df3c1 100644
> --- a/drivers/misc/sgi-gru/grumain.c
> +++ b/drivers/misc/sgi-gru/grumain.c
> @@ -716,9 +716,10 @@ static int gru_check_chiplet_assignment(struct gru_state *gru,
>   * chiplet. Misassignment can occur if the process migrates to a different
>   * blade or if the user changes the selected blade/chiplet.
>   */
> -void gru_check_context_placement(struct gru_thread_state *gts)
> +int gru_check_context_placement(struct gru_thread_state *gts)
>  {
>  	struct gru_state *gru;
> +	int ret = 0;
>  
>  	/*
>  	 * If the current task is the context owner, verify that the
> @@ -727,14 +728,16 @@ void gru_check_context_placement(struct gru_thread_state *gts)
>  	 */
>  	gru = gts->ts_gru;
>  	if (!gru || gts->ts_tgid_owner != current->tgid)
> -		return;
> +		return ret;

Why is this succeeding if there was an error?

>  
>  	if (!gru_check_chiplet_assignment(gru, gts)) {
>  		STAT(check_context_unload);
> -		gru_unload_context(gts, 1);
> +		ret = 1;

1 is not a valid error value;


>  	} else if (gru_retarget_intr(gts)) {
>  		STAT(check_context_retarget_intr);
>  	}
> +
> +	return ret;
>  }
>  
>  
> @@ -919,6 +922,7 @@ vm_fault_t gru_fault(struct vm_fault *vmf)
>  	struct gru_thread_state *gts;
>  	unsigned long paddr, vaddr;
>  	unsigned long expires;
> +	int ret;
>  
>  	vaddr = vmf->address;
>  	gru_dbg(grudev, "vma %p, vaddr 0x%lx (0x%lx)\n",
> @@ -934,7 +938,12 @@ vm_fault_t gru_fault(struct vm_fault *vmf)
>  	mutex_lock(&gts->ts_ctxlock);
>  	preempt_disable();
>  
> -	gru_check_context_placement(gts);
> +	ret = gru_check_context_placement(gts);
> +	if (ret) {
> +		mutex_unlock(&gts->ts_ctxlock);
> +		gru_unload_context(gts, 1);
> +		return VM_FAULT_NOPAGE;

Why not return ret?

> +	}
>  
>  	if (!gts->ts_gru) {
>  		STAT(load_user_context);
> @@ -958,6 +967,8 @@ vm_fault_t gru_fault(struct vm_fault *vmf)
>  	preempt_enable();
>  	mutex_unlock(&gts->ts_ctxlock);
>  
> +
> +

Why the blank lines added?

thanks,

greg k-h
