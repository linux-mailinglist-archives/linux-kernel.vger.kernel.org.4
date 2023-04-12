Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44D456DF7EE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 16:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbjDLODw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 10:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjDLODt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 10:03:49 -0400
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4584E49;
        Wed, 12 Apr 2023 07:03:46 -0700 (PDT)
Received: by mail-oi1-f174.google.com with SMTP id w13so28323187oik.2;
        Wed, 12 Apr 2023 07:03:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681308226; x=1683900226;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XkKJbGcmCESOp5kGHyfKWXGMOOU/ouU4bAVhUJXQjqA=;
        b=tl+5V09PvydyydndoVI67mjeSLhi3IhyuMMHX1eOjbKuOiKOfx4DWPvA0kmzJeOgQJ
         LuW424x8hiu8YeTMSbZ9vhzsUsRR1jEpVHCuUSkbq0izVzrq78RDWOoGbt+Uctgx2/K5
         GAmL4akCjBT7e2RfaXschMyXnNoizx0u1duPb0N1qpL2b0kEKSuVJZjiV1GJUJVnQrmu
         0vz7SDptp6uG6/UMhlQQ2UdsTtXG+zWF/UW4p40vC+FoevH5Y7h0Zcp31IYYC5WjuwzK
         LZU6nzpNP/aVue3TQAbQEvesJc9AeN7AhTf5kI0yetFR1N9F5hE2UJRyrGaD+kGPWBix
         iJog==
X-Gm-Message-State: AAQBX9em0ZNGAMXv2eacSULwseyAH/s04gBKXdlaJZUFq4hnFCpDctqF
        8SBkyVvmOn+h+9ObTfaMZQ==
X-Google-Smtp-Source: AKy350Y4tWN4Ri2Yf9zEZz08i2glwRo8Dr90/wmyCM6hmihMUWaqoNcTtQG0LOp2GloTALjDW2dmog==
X-Received: by 2002:a05:6808:352:b0:38b:a4f9:2570 with SMTP id j18-20020a056808035200b0038ba4f92570mr3031262oie.16.1681308225748;
        Wed, 12 Apr 2023 07:03:45 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id p5-20020a4a95c5000000b0053a7aaa85a0sm7063881ooi.0.2023.04.12.07.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 07:03:45 -0700 (PDT)
Received: (nullmailer pid 2248174 invoked by uid 1000);
        Wed, 12 Apr 2023 14:03:44 -0000
Date:   Wed, 12 Apr 2023 09:03:44 -0500
From:   Rob Herring <robh@kernel.org>
To:     Niko Pasaloukos <nikolaos.pasaloukos@blaize.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "soc@kernel.org" <soc@kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "olof@lixom.net" <olof@lixom.net>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        James Cowgill <james.cowgill@blaize.com>,
        Matt Redfearn <matthew.redfearn@blaize.com>,
        Neil Jones <neil.jones@blaize.com>
Subject: Re: [PATCH 5/5] arm64: Add initial support for Blaize BLZP1600 CB2
Message-ID: <20230412140344.GA2234522-robh@kernel.org>
References: <20230406102149.729726-1-nikolaos.pasaloukos@blaize.com>
 <20230406102149.729726-6-nikolaos.pasaloukos@blaize.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230406102149.729726-6-nikolaos.pasaloukos@blaize.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 06, 2023 at 10:22:32AM +0000, Niko Pasaloukos wrote:
> Adds support for the Blaize CB2 development board based on
> BLZP1600 SoC. This consists of a Carrier-Board and a SoM.
> 
> The blaize-blzp1600.dtsi is the common part for the SoC,
> blaize-blzp1600-som.dtsi is the common part for the SoM and
> blaize-blzp1600-som-cb2.dts is the board specific file.
> 
> Co-developed-by: James Cowgill <james.cowgill@blaize.com>
> Signed-off-by: James Cowgill <james.cowgill@blaize.com>
> Co-developed-by: Matt Redfearn <matt.redfearn@blaize.com>
> Signed-off-by: Matt Redfearn <matt.redfearn@blaize.com>
> Co-developed-by: Neil Jones <neil.jones@blaize.com>
> Signed-off-by: Neil Jones <neil.jones@blaize.com>
> Signed-off-by: Nikolaos Pasaloukos <nikolaos.pasaloukos@blaize.com>
> ---
>  arch/arm64/Kconfig.platforms                  |   5 +
>  arch/arm64/boot/dts/Makefile                  |   1 +
>  arch/arm64/boot/dts/blaize/Makefile           |   2 +
>  .../dts/blaize/blaize-blzp1600-som-cb.dtsi    | 217 +++++
>  .../dts/blaize/blaize-blzp1600-som-cb2.dts    | 103 ++
>  .../boot/dts/blaize/blaize-blzp1600-som.dtsi  | 104 ++
>  .../boot/dts/blaize/blaize-blzp1600.dtsi      | 894 ++++++++++++++++++
>  arch/arm64/configs/defconfig                  |   1 +
>  8 files changed, 1327 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/blaize/Makefile
>  create mode 100644 arch/arm64/boot/dts/blaize/blaize-blzp1600-som-cb.dtsi
>  create mode 100644 arch/arm64/boot/dts/blaize/blaize-blzp1600-som-cb2.dts
>  create mode 100644 arch/arm64/boot/dts/blaize/blaize-blzp1600-som.dtsi
>  create mode 100644 arch/arm64/boot/dts/blaize/blaize-blzp1600.dtsi

New platforms should be free of warnings from 'make dtbs_check'. Please 
run and fix if you have not, and confirm that in the commit message.

Rob
