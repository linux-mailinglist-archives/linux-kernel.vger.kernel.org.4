Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C81766E349F
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 02:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjDPAsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 20:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjDPAsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 20:48:33 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A0B0235A3;
        Sat, 15 Apr 2023 17:48:31 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F23411063;
        Sat, 15 Apr 2023 17:49:15 -0700 (PDT)
Received: from slackpad.lan (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CEFE93F73F;
        Sat, 15 Apr 2023 17:48:29 -0700 (PDT)
Date:   Sun, 16 Apr 2023 01:47:56 +0100
From:   Andre Przywara <andre.przywara@arm.com>
To:     Jonathan McDowell <noodles@earth.li>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] ARM: dts: sun5i: Add port E pinmux settings for
 mmc2
Message-ID: <20230416014756.2270af13@slackpad.lan>
In-Reply-To: <00d37ef9bf70785d05fb446ee6d0060c4a8d521a.1681580558.git.noodles@earth.li>
References: <cover.1681580558.git.noodles@earth.li>
        <00d37ef9bf70785d05fb446ee6d0060c4a8d521a.1681580558.git.noodles@earth.li>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Apr 2023 18:46:24 +0100
Jonathan McDowell <noodles@earth.li> wrote:

Hi,

> These alternate pins for mmc2 are brought out to the 40 pin U14 header
> on the C.H.I.P and can be used to add an external MMC device with a 4
> bit interface. See
> 
> https://byteporter.com/ntc-chip-micro-sd-slot/
> 
> for further details on how.
> 
> Signed-off-by: Jonathan McDowell <noodles@earth.li>
> ---
>  arch/arm/boot/dts/sun5i.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun5i.dtsi b/arch/arm/boot/dts/sun5i.dtsi
> index 250d6b87ab4d..e4922506ce22 100644
> --- a/arch/arm/boot/dts/sun5i.dtsi
> +++ b/arch/arm/boot/dts/sun5i.dtsi
> @@ -517,6 +517,14 @@ mmc2_4bit_pc_pins: mmc2-4bit-pc-pins {
>  				bias-pull-up;
>  			};
> 

As this seems to be a highly non-standard and rare modification, that
doesn't even get used in the mainline DT, please add a:
			/omit-if-no-ref/
line, so we don't get this into every sun5i board.

Otherwise looks good, though I don't know if that should belong into
the same DT overlay that is probably used to also enable the MMC2 node.

Cheers,
Andre


> +			mmc2_4bit_pe_pins: mmc2-4bit-pe-pins {
> +				pins = "PE4", "PE5", "PE6", "PE7",
> +				       "PE8", "PE9";
> +				function = "mmc2";
> +				drive-strength = <30>;
> +				bias-pull-up;
> +			};
> +
>  			mmc2_8bit_pins: mmc2-8bit-pins {
>  				pins = "PC6", "PC7", "PC8", "PC9",
>  				       "PC10", "PC11", "PC12", "PC13",

