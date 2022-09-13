Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6635B7D5B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 01:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiIMXRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 19:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiIMXRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 19:17:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F35966110
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 16:17:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 11565B81107
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 23:17:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09C7AC433D6;
        Tue, 13 Sep 2022 23:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663111018;
        bh=3akCnlPgGO2b94vai2rGkaY0WUN32BXWSzV+OlLrLqI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oCck64zae9cjer4LrijeWD2DGLe3zG6FLrq+Tm2YyOvzNZ+BklYTVD2BuOWVKoOqy
         AIc4Z/uJJFlI85RtIZ5J1Yd888ZONiS8VOC8edKRoML9A5Tc8ZA+r622f0uPjVjiVi
         va0IVi7pRJn/PkAyStD0ryb9aAxDMFbGP2YmXp1biBqCLzO7maxxdP50Yyb1/2IpA4
         cnwbJu1x2p3ey30bxivvFjUahcggLq22Gd69mreKueyzod0vH4JeKv81C7YaO1TxyS
         O+zQzLegDkJiExDHKBCusvLd8fEVEP+2UOopc9B5CU9vLONxW6M7yHCebeqw/6gRRZ
         ZYkp5mcSLHbqQ==
Date:   Tue, 13 Sep 2022 16:16:56 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Nathan Huckleberry <nhuck@google.com>
Cc:     namcaov@gmail.com, Larry.Finger@lwfinger.net, error27@gmail.com,
        gregkh@linuxfoundation.org, insafonov@gmail.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        llvm@lists.linux.dev, makvihas@gmail.com, ndesaulniers@google.com,
        paskripkin@gmail.com, phil@philpotter.co.uk,
        saurav.girepunje@gmail.com, trix@redhat.com
Subject: Re: [PATCH v2] staging: r8188eu: Fix return type of rtw_xmit_entry
Message-ID: <YyEPaMVRmdGQdoql@dev-arch.thelio-3990X>
References: <CA+sZ8B8RStBhofQ0=vvzH5FeQ66fj90DdCj9EQSaVErbVPLi7g@mail.gmail.com>
 <20220913193322.18776-1-nhuck@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220913193322.18776-1-nhuck@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2022 at 12:33:22PM -0700, Nathan Huckleberry wrote:
> The ndo_start_xmit field in net_device_ops is expected to be of type
> netdev_tx_t (*ndo_start_xmit)(struct sk_buff *skb, struct net_device *dev).
> 
> The mismatched return type breaks forward edge kCFI since the underlying
> function definition does not match the function hook definition.
> 
> The return type of rtw_xmit_entry should be changed from int to
> netdev_tx_t.
> 
> Reported-by: Dan Carpenter <error27@gmail.com>
> Link: https://github.com/ClangBuiltLinux/linux/issues/1703
> Cc: llvm@lists.linux.dev
> Signed-off-by: Nathan Huckleberry <nhuck@google.com>

The prototype in drivers/staging/r8188eu/include/xmit_osdep.h should be
updated as well. With that:

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> Changes v1 -> v2:
>  - Rebased onto linux-next/master
> 
> ---
>  drivers/staging/r8188eu/core/rtw_xmit.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
> index 98864fc55b25..ea13f11b231b 100644
> --- a/drivers/staging/r8188eu/core/rtw_xmit.c
> +++ b/drivers/staging/r8188eu/core/rtw_xmit.c
> @@ -2289,7 +2289,7 @@ static int rtw_mlcst2unicst(struct adapter *padapter, struct sk_buff *skb)
>  	return true;
>  }
>  
> -int rtw_xmit_entry(struct sk_buff *pkt, struct net_device *pnetdev)
> +netdev_tx_t rtw_xmit_entry(struct sk_buff *pkt, struct net_device *pnetdev)
>  {
>  	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(pnetdev);
>  	struct xmit_priv *pxmitpriv = &padapter->xmitpriv;
> @@ -2323,5 +2323,5 @@ int rtw_xmit_entry(struct sk_buff *pkt, struct net_device *pnetdev)
>  	dev_kfree_skb_any(pkt);
>  
>  exit:
> -	return 0;
> +	return NETDEV_TX_OK;
>  }
> -- 
> 2.37.2.789.g6183377224-goog
> 
