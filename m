Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 812F9610B34
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 09:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbiJ1HWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 03:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiJ1HWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 03:22:37 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B45CD5F4
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 00:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=0kHs01PQa80TsHGmTZUZWsuUjTB6ZMnDZZBdpbxyknA=;
  b=kmbA+1YsZfLc5Zs/C/3vkxApFiJBMskkMPoxWrVI+g2B59zrCOE8LtdQ
   nw4rf0okywtJUeUa4lH00QjdggpCSf6buI5twHJK/aZCBVDFXBD0XLHXM
   LKf8REzP0hDfYaxd70T7Kn5SBauaHwOVJcV8h/7yMnsbI+3cMGH9AGuNG
   Y=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.95,220,1661810400"; 
   d="scan'208";a="35792117"
Received: from 51.123.68.85.rev.sfr.net (HELO hadrien) ([85.68.123.51])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2022 09:22:33 +0200
Date:   Fri, 28 Oct 2022 09:22:33 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     UMWARI JOVIAL <umwarijovial@gmail.com>
cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
Subject: Re: [PATCH] Remove Unnecessary typecast of c90 int constant
In-Reply-To: <20221028063711.GA35659@rdm>
Message-ID: <alpine.DEB.2.22.394.2210280918550.2845@hadrien>
References: <20221028063711.GA35659@rdm>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 28 Oct 2022, UMWARI JOVIAL wrote:

> According to Linux kernel coding style.
>
> Reported by checkpatch:
> WARNING: Unnecessary typecast of c90 int constant - '(int)2.412e8' could be '2.412e8'
> WARNING: Unnecessary typecast of c90 int constant - '(int)2.487e8' could be '2.487e8'

It's not ideal to just include the checkpatch messges verbatim in your log
message.  It woudl be better to say what you are doing and why, in
complete sentences ("According to the Linux coding style" is not a
complete sentence).

I also suspect that the checkpatch message is wrong.  Floating point
numbers cannot be used in the kernel, and the case of the constant ensures
that the value will be converted to an integer at compile time.

julia

>
> Signed-off-by: UMWARI JOVIAL <umwarijovial@gmail.com>
> ---
>  drivers/staging/rtl8192e/rtllib_softmac_wx.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/staging/rtl8192e/rtllib_softmac_wx.c b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
> index fdf867a5dd7a..4fc4fb25d8d6 100644
> --- a/drivers/staging/rtl8192e/rtllib_softmac_wx.c
> +++ b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
> @@ -41,8 +41,8 @@ int rtllib_wx_set_freq(struct rtllib_device *ieee, struct iw_request_info *a,
>
>  	/* if setting by freq convert to channel */
>  	if (fwrq->e == 1) {
> -		if ((fwrq->m >= (int)2.412e8 &&
> -		     fwrq->m <= (int)2.487e8)) {
> +		if ((fwrq->m >= 2.412e8 &&
> +		     fwrq->m <= 2.487e8)) {
>  			int f = fwrq->m / 100000;
>  			int c = 0;
>
> --
> 2.25.1
>
>
>
