Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD0E5B30EF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 09:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbiIIHxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 03:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231891AbiIIHwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 03:52:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA72C5588
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 00:49:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 46F4461E5A
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 07:49:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56A76C433C1;
        Fri,  9 Sep 2022 07:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662709767;
        bh=Ywgr3/9Kad9XGc5SqNblH8MkkCw6DjuU6+0H6YSvzig=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F/ptCnACeRMoec8usrtMotwzIHZvmE4aF02OHwHhRUn9TjjENjUMMytuCPlPXZZrC
         Mn8D7QOWffcA+pvt2qZFQw6QV48vPhQtBaSaNOG9WQLJTCS3IlQ0ohmwef0BRGQcQN
         UhC1CGEyC1cgoy0RdTZyq7c8SBNQj/I/20d6nTno=
Date:   Fri, 9 Sep 2022 09:49:25 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     xkernel.wang@foxmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: rtl8723bs: fix a potential memory leak in
 rtw_init_cmd_priv()
Message-ID: <YxrwBV9Xb/5ucEHA@kroah.com>
References: <tencent_3FB11458E1274AF3FF69207CCC10B92F1C08@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_3FB11458E1274AF3FF69207CCC10B92F1C08@qq.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 08, 2022 at 03:33:00PM +0800, xkernel.wang@foxmail.com wrote:
> From: Xiaoke Wang <xkernel.wang@foxmail.com>
> 
> In rtw_init_cmd_priv(), if `pcmdpriv->rsp_allocated_buf` is allocated  
> in failure, then `pcmdpriv->cmd_allocated_buf` will be not properly 
> released. Besides, considering there are only two error paths and the 
> first one can directly return, so we do not need implicitly jump to the 
> `exit` tag to execute the error handler.
> 
> So this patch added `kfree(pcmdpriv->cmd_allocated_buf);` on the error 
> path to release the resource and simplified the return logic of 

Again, whitespace at end of changelog text :(

> rtw_init_cmd_priv(). As there is no FooBar device to test with, no runtime
> testing was performed.

"FooBar"?

> 
> Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
> ---
> ChangeLog:
> v1->v2 update the description.
> v2->v3 update the description.
>  drivers/staging/rtl8723bs/core/rtw_cmd.c | 17 +++++++----------
>  1 file changed, 7 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_cmd.c b/drivers/staging/rtl8723bs/core/rtw_cmd.c
> index e574893..9126ea9 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_cmd.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_cmd.c
> @@ -161,8 +161,6 @@ static struct cmd_hdl wlancmds[] = {
>  
>  int rtw_init_cmd_priv(struct	cmd_priv *pcmdpriv)
>  {
> -	int res = 0;
> -
>  	init_completion(&pcmdpriv->cmd_queue_comp);
>  	init_completion(&pcmdpriv->terminate_cmdthread_comp);
>  
> @@ -175,18 +173,17 @@ int rtw_init_cmd_priv(struct	cmd_priv *pcmdpriv)
>  
>  	pcmdpriv->cmd_allocated_buf = rtw_zmalloc(MAX_CMDSZ + CMDBUFF_ALIGN_SZ);
>  
> -	if (!pcmdpriv->cmd_allocated_buf) {
> -		res = -ENOMEM;
> -		goto exit;
> -	}
> +	if (!pcmdpriv->cmd_allocated_buf)
> +		return -ENOMEM;
>  
>  	pcmdpriv->cmd_buf = pcmdpriv->cmd_allocated_buf  +  CMDBUFF_ALIGN_SZ - ((SIZE_PTR)(pcmdpriv->cmd_allocated_buf) & (CMDBUFF_ALIGN_SZ-1));
>  
>  	pcmdpriv->rsp_allocated_buf = rtw_zmalloc(MAX_RSPSZ + 4);
>  
>  	if (!pcmdpriv->rsp_allocated_buf) {
> -		res = -ENOMEM;
> -		goto exit;
> +		kfree(pcmdpriv->cmd_allocated_buf);
> +		pcmdpriv->cmd_allocated_buf = NULL;

Why does this have to be set to NULL?

thanks,

greg k-h
