Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8202A616F4C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 22:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbiKBVAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 17:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbiKBVAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 17:00:37 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 126A1DEB0;
        Wed,  2 Nov 2022 14:00:36 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id r13-20020a056830418d00b0065601df69c0so10968266otu.7;
        Wed, 02 Nov 2022 14:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2WXSgV6gSBWXpZYt5R9dSU2XRI96JBuHJqksyBnzBTo=;
        b=JJAhyu9I9avCA18/elJljBaUZjEQ1AZLmiOifd0185Y3EK5HeaqP3S8tIt8gTFmmGA
         pUPV11+zpMkm8yra868gdu+JPvay5L/Opwv9NVBz2bTgI31wiopDPuGVdDBOeOv79yeS
         4wM2xoCUBswHSYlVSz0k6gih0dyDKp87PsHiT2VhdTtg84YFkXGF1EOFPpP8Y4ELfyVZ
         RKc/OhQocTKutC17cYFdo5bsOWcjqpuibRaBoG6O8Hj8QFbePWHaTtJuU/i2cE9PfSfY
         VPkhAfTwgP/OGt5nb9ZoCiysNro1ORT9McA5rRfRR9i9PAySfuTFBaiTO2OP2w2e75rt
         q7Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2WXSgV6gSBWXpZYt5R9dSU2XRI96JBuHJqksyBnzBTo=;
        b=gPE5x/Vn9Uw41jzhNwDcHEAzN74YyJmEMoT4ljgzUwINxaohk4g4OwuszPlWd7twZg
         R3bqi4tIh5PKcD8DqjR3TwoXL2P79ISC7pv3qkpYxpim1CR3331rbt1KEyFbvqTTveNs
         KEz9Q4Nuhl8TnM7MYAfnyrCFhec2HjoPED6ZZ8WT3WyxBeu/8QROF7b8Bu4IpL9VnVS/
         57rUctjr70wwVqkc/KDPezfWrLJ+rnXW/EicGuX2avwhR1J38SqCbNvZp/E3I7lDQ3T0
         GwrRJc7E61fMfDbP0MsN1Gk5Q5j2YgYO/xJnrzFLs5LKub63d0zJdA4vt3N7f3/DWDNZ
         kXWA==
X-Gm-Message-State: ACrzQf0fSJekDfcFABpfxeYhZFK5BpNRFvRDN/dIzCdcQN25nGHerqP3
        v8i3X6bo1WE0z66PsdUj+ut/IXcYQlE=
X-Google-Smtp-Source: AMsMyM7RqN8N0Q2iqpfM+uj7CGLUUNmPLN0Njp1cAr0gX8/yKSAoMNpTFaPaf9mD9I+AIPicd5Qs7g==
X-Received: by 2002:a05:6830:237d:b0:66c:4535:fe9c with SMTP id r29-20020a056830237d00b0066c4535fe9cmr11399540oth.30.1667422835383;
        Wed, 02 Nov 2022 14:00:35 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w15-20020a4a274f000000b004805c328971sm4775759oow.42.2022.11.02.14.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 14:00:35 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 2 Nov 2022 14:00:33 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-watchdog@vger.kernel.org, wim@linux-watchdog.org,
        joel@jms.id.au, andrew@aj.id.au, linux-aspeed@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] ARM: dts: aspeed: Setup watchdog pre-timeout
 interrupt
Message-ID: <20221102210033.GA2090211@roeck-us.net>
References: <20221101205338.577427-1-eajames@linux.ibm.com>
 <20221101205338.577427-3-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221101205338.577427-3-eajames@linux.ibm.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 01, 2022 at 03:53:38PM -0500, Eddie James wrote:
> Specify the interrupt lines for the base SOCs that support it.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  arch/arm/boot/dts/aspeed-g5.dtsi | 3 +++
>  arch/arm/boot/dts/aspeed-g6.dtsi | 4 ++++
>  2 files changed, 7 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
> index 04f98d1dbb97..b4b98bf38e48 100644
> --- a/arch/arm/boot/dts/aspeed-g5.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g5.dtsi
> @@ -410,18 +410,21 @@ wdt1: watchdog@1e785000 {
>  				compatible = "aspeed,ast2500-wdt";
>  				reg = <0x1e785000 0x20>;
>  				clocks = <&syscon ASPEED_CLK_APB>;
> +				interrupts = <27>;
>  			};
>  
>  			wdt2: watchdog@1e785020 {
>  				compatible = "aspeed,ast2500-wdt";
>  				reg = <0x1e785020 0x20>;
>  				clocks = <&syscon ASPEED_CLK_APB>;
> +				interrupts = <27>;
>  			};
>  
>  			wdt3: watchdog@1e785040 {
>  				compatible = "aspeed,ast2500-wdt";
>  				reg = <0x1e785040 0x20>;
>  				clocks = <&syscon ASPEED_CLK_APB>;
> +				interrupts = <27>;
>  				status = "disabled";
>  			};
>  
> diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed-g6.dtsi
> index ebbcfe445d9c..d9379fd7b1c2 100644
> --- a/arch/arm/boot/dts/aspeed-g6.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g6.dtsi
> @@ -539,23 +539,27 @@ uart5: serial@1e784000 {
>  
>  			wdt1: watchdog@1e785000 {
>  				compatible = "aspeed,ast2600-wdt";
> +				interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
>  				reg = <0x1e785000 0x40>;
>  			};
>  
>  			wdt2: watchdog@1e785040 {
>  				compatible = "aspeed,ast2600-wdt";
> +				interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
>  				reg = <0x1e785040 0x40>;
>  				status = "disabled";
>  			};
>  
>  			wdt3: watchdog@1e785080 {
>  				compatible = "aspeed,ast2600-wdt";
> +				interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
>  				reg = <0x1e785080 0x40>;
>  				status = "disabled";
>  			};
>  
>  			wdt4: watchdog@1e7850c0 {
>  				compatible = "aspeed,ast2600-wdt";
> +				interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
>  				reg = <0x1e7850C0 0x40>;
>  				status = "disabled";
>  			};
