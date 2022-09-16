Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4FA45BA9E4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 12:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbiIPKBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 06:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbiIPKBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 06:01:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A191EC79
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 03:01:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A355DB824F2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 10:01:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DF19C433D6;
        Fri, 16 Sep 2022 10:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1663322498;
        bh=ktExfbKHD2JVs46DdWf9FPPZWx9TRmJfygezKJHNVHA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dl/t59CMoUMfxNBZXJ4JH0p7SPcwckCne4hUb2biZJ7Jz/6k0ImPOFzXfZQjNpdW1
         nrOJk7kR/5j3k/ETY0y2dRYCIy0JDHq8RevYPvqyEykdD2AsG5c/i+bBdQYwvhy0op
         +dRjQWWz/2CRQEPBBTFajO/ivNTkT5eTainxuT+c=
Date:   Fri, 16 Sep 2022 12:02:03 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     xmzyshypnc <1002992920@qq.com>
Cc:     dimitri.sivanich@hpe.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org, hackerzheng666@gmail.com,
        alex000young@gmail.com, security@kernel.org
Subject: Re: [PATCH] misc: sgi-gru: fix use-after-free error in
 gru_set_context_option, gru_fault and gru_handle_user_call_os
Message-ID: <YyRJm0bkAN3Z7/jn@kroah.com>
References: <tencent_45DC133D0F8DBD599F40D6E228B9305B240A@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_45DC133D0F8DBD599F40D6E228B9305B240A@qq.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2022 at 05:59:14PM +0800, xmzyshypnc wrote:
> In grufile.c, gru_file_unlocked_ioctl function can be called by user. 
> 
> If the req is GRU_SET_CONTEXT_OPTION, it will call gru_set_context_option.
> 
> In gru_set_context_option, as req can be controlled by user, 
> 
> We can reach gru_check_context_placement function call.
> 
> In gru_check_context_placement function, if the error path was steped, 
> 
> say gru_check_chiplet_assignment return 0, 
> 
> Then it will fall into gru_unload_context function.
> 
> And it will finnaly call kfree gts in gts_drop function.
> 
> Then gru_unlock_gts will be called in gru_set_context_option function. 
> 
> This is a typical Use after free.
> 
> The same problem exists in gru_handle_user_call_os and gru_fault.
> 
> Fix it by introduce the return value to see if gts is in good case or not. 
> 
> Free the gts in caller when gru_check_chiplet_assignment check failed.
> 
> Signed-off-by: xmzyshypnc <1002992920@qq.com>
> ---
>  drivers/misc/sgi-gru/grufault.c  | 14 ++++++++++++--
>  drivers/misc/sgi-gru/grumain.c   | 17 +++++++++++++----
>  drivers/misc/sgi-gru/grutables.h |  2 +-
>  3 files changed, 26 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/misc/sgi-gru/grufault.c b/drivers/misc/sgi-gru/grufault.c
> index d7ef61e602ed..2b5b049fbd38 100644
> --- a/drivers/misc/sgi-gru/grufault.c
> +++ b/drivers/misc/sgi-gru/grufault.c
> @@ -656,7 +656,9 @@ int gru_handle_user_call_os(unsigned long cb)
>  	if (ucbnum >= gts->ts_cbr_au_count * GRU_CBR_AU_SIZE)
>  		goto exit;
>  
> -	gru_check_context_placement(gts);
> +	ret = gru_check_context_placement(gts);
> +	if (ret)
> +		goto err;
>  
>  	/*
>  	 * CCH may contain stale data if ts_force_cch_reload is set.
> @@ -677,6 +679,10 @@ int gru_handle_user_call_os(unsigned long cb)
>  exit:
>  	gru_unlock_gts(gts);
>  	return ret;
> +err:
> +	gru_unlock_gts(gts);
> +	gru_unload_context(gts, 1);
> +	return -EINVAL;
>  }
>  
>  /*
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
> index 9afda47efbf2..79903cf7e706 100644
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
>  
>  	if (!gru_check_chiplet_assignment(gru, gts)) {
>  		STAT(check_context_unload);
> -		gru_unload_context(gts, 1);
> +		ret = -EINVAL;
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
> +		return ret;
> +	}
>  
>  	if (!gts->ts_gru) {
>  		STAT(load_user_context);
> diff --git a/drivers/misc/sgi-gru/grutables.h b/drivers/misc/sgi-gru/grutables.h
> index 5efc869fe59a..f4a5a787685f 100644
> --- a/drivers/misc/sgi-gru/grutables.h
> +++ b/drivers/misc/sgi-gru/grutables.h
> @@ -632,7 +632,7 @@ extern int gru_user_flush_tlb(unsigned long arg);
>  extern int gru_user_unload_context(unsigned long arg);
>  extern int gru_get_exception_detail(unsigned long arg);
>  extern int gru_set_context_option(unsigned long address);
> -extern void gru_check_context_placement(struct gru_thread_state *gts);
> +extern int gru_check_context_placement(struct gru_thread_state *gts);
>  extern int gru_cpu_fault_map_id(void);
>  extern struct vm_area_struct *gru_find_vma(unsigned long vaddr);
>  extern void gru_flush_all_tlb(struct gru_state *gru);
> -- 
> 2.25.1
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what is needed in order to
  properly describe the change.

- You did not write a descriptive Subject: for the patch, allowing Greg,
  and everyone else, to know what this patch is all about.  Please read
  the section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what a proper Subject: line should
  look like.

- It looks like you did not use your "real" name for the patch on either
  the Signed-off-by: line, or the From: line (both of which have to
  match).  Please read the kernel file, Documentation/SubmittingPatches
  for how to do this correctly.

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/SubmittingPatches for what needs to be done
  here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
