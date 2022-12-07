Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45314645433
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 07:45:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbiLGGpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 01:45:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbiLGGpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 01:45:39 -0500
Received: from soltyk.jannau.net (soltyk.jannau.net [144.76.91.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15ED611447;
        Tue,  6 Dec 2022 22:45:38 -0800 (PST)
Received: by soltyk.jannau.net (Postfix, from userid 1000)
        id CC5A826F498; Wed,  7 Dec 2022 07:40:05 +0100 (CET)
Date:   Wed, 7 Dec 2022 07:40:05 +0100
From:   Janne Grunau <j@jannau.net>
To:     Asahi Lina <lina@asahilina.net>
Cc:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Marc Zyngier <maz@kernel.org>, asahi@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: apple: t6002: Fix GPU power domains
Message-ID: <20221207064005.GA20388@jannau.net>
References: <20221207014305.21018-1-lina@asahilina.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221207014305.21018-1-lina@asahilina.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-12-07 10:43:04 +0900, Asahi Lina wrote:
> On t6002 (M1 Ultra), each die contains a self-contained GPU block.
> However, only the coprocessor and global management circuitry of the
> first die are used. This is what is represented by the "gpu" PS (the
> one in die1 is disabled). Nonetheless, this shared component drives the
> processing blocks in both dies, and therefore depends on the AFR fabric
> being powered up on both dies.
> 
> Add an explicit dependency from the GPU block on die0 to AFR on die1,
> next to the existing die0 AFR dependency.
> 
> Fixes: fa86294eb355 ("arm64: dts: apple: Add initial t6000/t6001/t6002 DTs")
> Signed-off-by: Asahi Lina <lina@asahilina.net>
> ---
>  arch/arm64/boot/dts/apple/t6002.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/apple/t6002.dtsi b/arch/arm64/boot/dts/apple/t6002.dtsi
> index 1376103b49c6..8fa2d8dd72ff 100644
> --- a/arch/arm64/boot/dts/apple/t6002.dtsi
> +++ b/arch/arm64/boot/dts/apple/t6002.dtsi
> @@ -296,3 +296,8 @@ &cpu_p20 &cpu_p21 &cpu_p22 &cpu_p23
>  		};
>  	};
>  };
> +
> +&ps_gfx {
> +	// On t6002, the die0 GPU power domain needs both AFR power domains
> +	power-domains = <&ps_afr>, <&ps_afr_die1>;
> +};

Reviewded-By: Janne Grunau <j@jannau.net>

Janne
