Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED6B35B7D59
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 01:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbiIMXOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 19:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiIMXOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 19:14:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C3CEC29
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 16:14:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DBC796164B
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 23:14:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3B42C433D6;
        Tue, 13 Sep 2022 23:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663110869;
        bh=eD7OnuNEg2BVPLGRpHp+6sLXUAMjcwcu/sAlw9lLAAc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gNxd+VvmGpzmAkO9OC8ubGFXxVjXjTTKD9JzCqSberTiHB+qi26dpbQYfvk/n7LUA
         dcvttc/w0Pd+JTYzS0cczu4rFgBS+qZx3BCRofTwofTxxWECmvbnH81xEncWscQqja
         vl6usMgzBnYFYuVrO2l+IqZZ6gzjh/xEXjCtEN5pfDx2u2N7diDnwyclWfvt9LBklf
         g4SfdK4Vgj5SjEKhaPmCN5aTiVAnKzcV4kUPZVb2wM9E1z5eJ4AoGZ5JF58PMUj7kV
         AuXvgZuwsu1rwHxSRZzYik84GvGZCQG9LclCUXpui8cSTvsTVmUjtxqOxN911szY/p
         ttvkNxI/15xEw==
Date:   Tue, 13 Sep 2022 16:14:27 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Nathan Huckleberry <nhuck@google.com>
Cc:     Dan Carpenter <error27@gmail.com>, llvm@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: Fix rtw_xmit_entry return type
Message-ID: <YyEO01+suq0Wl/2F@dev-arch.thelio-3990X>
References: <20220912214617.929240-1-nhuck@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220912214617.929240-1-nhuck@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2022 at 02:46:14PM -0700, Nathan Huckleberry wrote:
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

The prototype in drivers/staging/rtl8723bs/include/xmit_osdep.h should
be updated as well. With that:

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  drivers/staging/rtl8723bs/os_dep/xmit_linux.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/os_dep/xmit_linux.c b/drivers/staging/rtl8723bs/os_dep/xmit_linux.c
> index 530e7a6c67c5..472d3ac0179b 100644
> --- a/drivers/staging/rtl8723bs/os_dep/xmit_linux.c
> +++ b/drivers/staging/rtl8723bs/os_dep/xmit_linux.c
> @@ -181,7 +181,7 @@ static int rtw_mlcst2unicst(struct adapter *padapter, struct sk_buff *skb)
>  	return true;
>  }
>  
> -int _rtw_xmit_entry(struct sk_buff *pkt, struct net_device *pnetdev)
> +netdev_tx_t _rtw_xmit_entry(struct sk_buff *pkt, struct net_device *pnetdev)
>  {
>  	struct adapter *padapter = rtw_netdev_priv(pnetdev);
>  	struct xmit_priv *pxmitpriv = &padapter->xmitpriv;
> @@ -217,15 +217,12 @@ int _rtw_xmit_entry(struct sk_buff *pkt, struct net_device *pnetdev)
>  	dev_kfree_skb_any(pkt);
>  
>  exit:
> -	return 0;
> +	return NETDEV_TX_OK;
>  }
>  
> -int rtw_xmit_entry(struct sk_buff *pkt, struct net_device *pnetdev)
> +netdev_tx_t rtw_xmit_entry(struct sk_buff *pkt, struct net_device *pnetdev)
>  {
> -	int ret = 0;
> -
>  	if (pkt)
> -		ret = _rtw_xmit_entry(pkt, pnetdev);
> -
> -	return ret;
> +		return _rtw_xmit_entry(pkt, pnetdev);
> +	return NETDEV_TX_OK;
>  }
> -- 
> 2.37.2.789.g6183377224-goog
> 
