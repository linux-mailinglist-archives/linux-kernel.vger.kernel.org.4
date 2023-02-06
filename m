Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADF2468B8E6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 10:47:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjBFJrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 04:47:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjBFJre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 04:47:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13DF6F747
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 01:47:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A3EC760DD1
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 09:47:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CB7CC433EF;
        Mon,  6 Feb 2023 09:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675676853;
        bh=F1zVXNR0pCBjMMQRJ8RZFHCDx+mRQOAL4BbWy1HOY7k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MmtYlDvBA+icC7EHF91v2UQqj137PRgCJeR0R7irElNN2XAQRWYkoPLjOF7YTvLhV
         d/TyiSSJWOj6PHx822sJRVsxxraMjugfbi/I+hJnpQAtam3RlTnKGg2j+ggl5Gk1xz
         0yJL0hyh6jgQeOPU1ReWhrmc6yX8gKROOGFPU8r0=
Date:   Mon, 6 Feb 2023 10:47:29 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Michael Straube <straube.linux@gmail.com>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] staging: r8188eu: correct error logic of
 _rtw_init_recv_priv()
Message-ID: <Y+DMsdD4l2qPpKjM@kroah.com>
References: <20230204101654.10232-1-straube.linux@gmail.com>
 <20230204101654.10232-3-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230204101654.10232-3-straube.linux@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 04, 2023 at 11:16:54AM +0100, Michael Straube wrote:
> Convert the function _rtw_init_recv_priv() away from returning _FAIL
> and _SUCCESS, which uses inverted error logic. Return 0 for success
> and negative values for failure instead.
> 
> Signed-off-by: Michael Straube <straube.linux@gmail.com>
> ---
>  drivers/staging/r8188eu/core/rtw_recv.c   | 17 +++++------------
>  drivers/staging/r8188eu/os_dep/os_intfs.c |  2 +-
>  2 files changed, 6 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
> index 70d43c10e53d..4c823bbcc22b 100644
> --- a/drivers/staging/r8188eu/core/rtw_recv.c
> +++ b/drivers/staging/r8188eu/core/rtw_recv.c
> @@ -99,10 +99,8 @@ static int rtl8188eu_init_recv_priv(struct adapter *padapter)
>  int _rtw_init_recv_priv(struct recv_priv *precvpriv, struct adapter *padapter)
>  {
>  	int i;
> -
>  	struct recv_frame *precvframe;
> -
> -	int	res = _SUCCESS;
> +	int err = 0;
>  
>  	spin_lock_init(&precvpriv->lock);
>  
> @@ -115,11 +113,8 @@ int _rtw_init_recv_priv(struct recv_priv *precvpriv, struct adapter *padapter)
>  	precvpriv->free_recvframe_cnt = NR_RECVFRAME;
>  
>  	precvpriv->pallocated_frame_buf = vzalloc(NR_RECVFRAME * sizeof(struct recv_frame) + RXFRAME_ALIGN_SZ);
> -
> -	if (!precvpriv->pallocated_frame_buf) {
> -		res = _FAIL;
> -		goto exit;
> -	}
> +	if (!precvpriv->pallocated_frame_buf)
> +		return -ENOMEM;
>  
>  	precvpriv->precv_frame_buf = (u8 *)ALIGN((size_t)(precvpriv->pallocated_frame_buf), RXFRAME_ALIGN_SZ);
>  
> @@ -139,16 +134,14 @@ int _rtw_init_recv_priv(struct recv_priv *precvpriv, struct adapter *padapter)
>  	}
>  	precvpriv->rx_pending_cnt = 1;
>  
> -	if (rtl8188eu_init_recv_priv(padapter))
> -		res = _FAIL;
> +	err = rtl8188eu_init_recv_priv(padapter);

You are keeping the original logic here, but this is odd, nothing
actually changes if this is an error except you return it?  That seems
wrong, and you might want to fix that up in further patches.

thanks,

greg k-h
