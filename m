Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45EA36D59FD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 09:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233735AbjDDHvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 03:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233481AbjDDHv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 03:51:28 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A538120;
        Tue,  4 Apr 2023 00:51:24 -0700 (PDT)
Received: from ip4d1634d3.dynamic.kabel-deutschland.de ([77.22.52.211] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1pjbRg-0004x9-HG; Tue, 04 Apr 2023 09:51:12 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     linux-kernel@vger.kernel.org,
        Javier Martinez Canillas <javierm@redhat.com>
Cc:     Peter Robinson <pbrobinson@gmail.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Caleb Connolly <kc@postmarketos.org>,
        Jarrah Gosbell <kernel@undef.tools>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Martijn Braam <martijn@brixit.nl>, Ondrej Jirman <megi@xff.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Tom Fitzhenry <tom@tom-fitzhenry.me.uk>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: rockchip: Change serial baud rate for Pinephone Pro
 to 1.5 MB
Date:   Tue, 04 Apr 2023 09:51:11 +0200
Message-ID: <3738011.44csPzL39Z@diego>
In-Reply-To: <20230403175937.2842085-1-javierm@redhat.com>
References: <20230403175937.2842085-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_PASS,T_SPF_HELO_TEMPERROR
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am Montag, 3. April 2023, 19:59:37 CEST schrieb Javier Martinez Canillas:
> This baud rate is set for the device by mainline u-boot and is also what
> is set in the Pinebook Pro Device Tree, which is a device similar to the
> PinePhone Pro but with a different form factor.
> 
> Otherwise, the baud rate of the firmware and Linux don't match by default
> and a 'console=ttyS2,1500000n8' kernel command line parameter is required
> to have proper output for both.

The interesting question is always if this will break someone else's setup.
I've never really understood the strange setting of 1.5MBps, but on the
other hand it _is_ a reality on most boards.

Personally I don't care that much either way, but would like a comment
from the other people working on that device - if possible.

I guess if we don't hear anything, I'll apply it nevertheless at some point


Heiko


> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> ---
> 
> I tried to instead get rid of the baud rate altogether, as suggested by
> Peter Robinson. AFAIU that should just pick whatever bad rate has been
> using by the early console.
> 
> But neither using 'stdout-path = "serial2" nor 'stdout-path = &uart2'
> worked for me.
> 
> In both cases I didn't have any output unless setting a baud rate using
> the 'console='param.
> 
>  arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
> index a0795a2b1cb1..6bbe65bd5bd4 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
> @@ -26,7 +26,7 @@ aliases {
>  	};
>  
>  	chosen {
> -		stdout-path = "serial2:115200n8";
> +		stdout-path = "serial2:1500000n8";
>  	};
>  
>  	gpio-keys {
> 
> base-commit: 3adf89324a2b2a9dbc2c12d8895021e7e34e3346
> 




