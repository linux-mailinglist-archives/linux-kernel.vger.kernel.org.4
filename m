Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22A7C6229E0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 12:13:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbiKILNA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 06:13:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiKILMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 06:12:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C30128704
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 03:12:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AA667B81D7E
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 11:12:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDB7BC433D6;
        Wed,  9 Nov 2022 11:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1667992366;
        bh=cBNVVy2XQTnhLulDF5VKWQjp25xKbYOz3XlbA6B82qI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xQR4+JUGjxFm+DUdj/oQSk99WN50lW5tNj2qdosi1/1Hqm6XXffT8NFMKXp4cV1K4
         /10DPAmce3jvZdOUMvUjq+rV04R6Y0w7jGWol9YiKB9nM2TTyjYxsTEIEYG5phyQ0w
         h7GObr8bj7b9GlRwBLrTSuhp+CvpxctvCS6mA1+I=
Date:   Wed, 9 Nov 2022 12:12:43 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zheng Wang <zyytlz.wz@163.com>
Cc:     zhengyejian1@huawei.com, dimitri.sivanich@hpe.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org, hackerzheng666@gmail.com,
        alex000young@gmail.com, security@kernel.org, sivanich@hpe.com,
        lkp@intel.com
Subject: Re: [PATCH v8] misc: sgi-gru: fix use-after-free error in
 gru_set_context_option, gru_fault and gru_handle_user_call_os
Message-ID: <Y2uLK6Zxsz9TD9WV@kroah.com>
References: <20221109105158.230081-1-zyytlz.wz@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221109105158.230081-1-zyytlz.wz@163.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2022 at 06:51:58PM +0800, Zheng Wang wrote:
> Gts may be freed in gru_check_chiplet_assignment.
> The caller still use it after that, UAF happens.

I do not understand what this text means, sorry.  Can you try to make it
more descriptive?

> 
> Fix it by introducing a return value to see if it's in error path or not.
> Free the gts in caller if gru_check_chiplet_assignment check failed.

Please wrap all of your changelog text at 72 columns, you have 2
paragraphs with different wrappings.

> 
> Fixes: 55484c45dbec ("gru: allow users to specify gru chiplet 2")
> Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
> Acked-by: Dimitri Sivanich <sivanich@hpe.com>
> ---
> v8:
> - remove tested-by tag suggested by Greg
> 
> v7:
> - fix some spelling problems suggested by Greg, change kernel test robot from reported-by tag to tested-by tag
> 
> v6:
> - remove unused var checked by kernel test robot
> 
> v5:
> - fix logical issue and remove unnecessary variable suggested by Dimitri Sivanich
> 
> v4:
> - use VM_FAULT_NOPAGE as failure code in gru_fault and -EINVAL in other functions suggested by Yejian
> 
> v3:
> - add preempt_enable and use VM_FAULT_NOPAGE as failure code suggested by Yejian
> 
> v2:
> - commit message changes suggested by Greg
> 
> v1: https://lore.kernel.org/lkml/CAJedcCzY72jqgF-pCPtx66vXXwdPn-KMagZnqrxcpWw1NxTLaA@mail.gmail.com/
> ---
>  drivers/misc/sgi-gru/grufault.c  | 14 ++++++++++++--
>  drivers/misc/sgi-gru/grumain.c   | 16 ++++++++++++----
>  drivers/misc/sgi-gru/grutables.h |  2 +-
>  3 files changed, 25 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/misc/sgi-gru/grufault.c b/drivers/misc/sgi-gru/grufault.c
> index d7ef61e602ed..bdd515d33225 100644
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
> @@ -874,7 +880,11 @@ int gru_set_context_option(unsigned long arg)
>  		} else {
>  			gts->ts_user_blade_id = req.val1;
>  			gts->ts_user_chiplet_id = req.val0;
> -			gru_check_context_placement(gts);
> +			if (gru_check_context_placement(gts)) {
> +				gru_unlock_gts(gts);
> +				gru_unload_context(gts, 1);
> +				return -EINVAL;
> +			}
>  		}
>  		break;
>  	case sco_gseg_owner:
> diff --git a/drivers/misc/sgi-gru/grumain.c b/drivers/misc/sgi-gru/grumain.c
> index 9afda47efbf2..beba69fc3cd7 100644
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

Why does this check return "all is good!" ?

Shouldn't that be an error?

thanks,

greg k-h
