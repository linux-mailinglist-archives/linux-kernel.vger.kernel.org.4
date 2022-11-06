Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D52561E383
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 17:43:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbiKFQnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 11:43:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbiKFQno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 11:43:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2384BE3C
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 08:43:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 74D3FB8013C
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 16:43:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0D12C433D6;
        Sun,  6 Nov 2022 16:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1667753021;
        bh=DqJbdByfgSiyjE2Pg/kYXTeQpByNVtD3R7IyUGu7NI8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oXfcaR5U1UBwAhBQoQneNSLTnbLUog92sEGazVO3NzIDrcdYW7XQdbhtGKk4aZMAg
         2Uq2RgOspL25y1sC/yGUmRuP7Exs6G+tptAP5ts3E7PfP1dW98AQWjMdOH69MnLLEu
         IqJsl0X4U9V/8i7SQsiA3fdIo8ugQ2WJ5klP5P+o=
Date:   Sun, 6 Nov 2022 17:43:38 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Deepak R Varma <drv@mailo.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: simplify complex pointer casting
Message-ID: <Y2fkOjPM0aEfJQOl@kroah.com>
References: <Y2dvmdGxQfmK4O6F@qemulion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2dvmdGxQfmK4O6F@qemulion>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 06, 2022 at 01:56:01PM +0530, Deepak R Varma wrote:
> Pointers to structures udphdr and dhcpMessage are derived by casting
> adjacent pointers with size_t. Such typecast of pointer using size_t
> is not preferred. The code looks complex and delicate. Simplify such
> casting by utilizing generic "void *" casting.
> While at this change, remove the unnecessary __be32 casting for member
> variable "cookie".

Wait, why is that unecessary?

And why is that part of this change, that should be a separate one, so
that it can be reverted when it's found to be buggy :)

> 
> Suggested-by: Joe Perches <joe@perches.com>
> Signed-off-by: Deepak R Varma <drv@mailo.com>
> ---
>  drivers/staging/r8188eu/core/rtw_br_ext.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_br_ext.c b/drivers/staging/r8188eu/core/rtw_br_ext.c
> index a23f7df373ed..e9b0906d0d74 100644
> --- a/drivers/staging/r8188eu/core/rtw_br_ext.c
> +++ b/drivers/staging/r8188eu/core/rtw_br_ext.c
> @@ -610,13 +610,15 @@ void dhcp_flag_bcast(struct adapter *priv, struct sk_buff *skb)
>  			struct iphdr *iph = (struct iphdr *)(skb->data + ETH_HLEN);
> 
>  			if (iph->protocol == IPPROTO_UDP) { /*  UDP */
> -				struct udphdr *udph = (struct udphdr *)((size_t)iph + (iph->ihl << 2));
> +				struct udphdr *udph = (void *)iph + (iph->ihl << 2);
> 
>  				if ((udph->source == htons(CLIENT_PORT)) &&
>  				    (udph->dest == htons(SERVER_PORT))) { /*  DHCP request */
> -					struct dhcpMessage *dhcph =
> -						(struct dhcpMessage *)((size_t)udph + sizeof(struct udphdr));
> -					u32 cookie = be32_to_cpu((__be32)dhcph->cookie);
> +					u32 cookie;
> +					struct dhcpMessage *dhcph;

Why reorder these variables?

> +
> +					dhcph = (void *)udph + sizeof(struct udphdr);
> +					cookie = be32_to_cpu(dhcph->cookie);

The cookie change should be separate please.

thanks,

greg k-h
