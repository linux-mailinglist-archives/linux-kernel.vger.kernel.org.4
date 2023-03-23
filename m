Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF656C723E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 22:21:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbjCWVVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 17:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbjCWVVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 17:21:13 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C8A2CC70;
        Thu, 23 Mar 2023 14:21:12 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id s13so29254wmr.4;
        Thu, 23 Mar 2023 14:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679606470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OVc7Of+Ix0ryK/+RAH7Z4FzYtXWWON2rs5eqRA4tiWA=;
        b=XEapRCAfRjQ3Vvhm/kfmQ20knSNfS4nyJ/DeNjhfKvWH2mP0mTbIUKHMGqzD4Cny7L
         pnHGYrLZhiQ3qpg0UnAKWYhtQZymabZ89gHgA1UyPiUr4X7/ZucB76UM7P0gfnMvc6+w
         N5ju5ShkPJ2UoqBR347f7Sp37dTkbdMKiUc9AA7vOWH0vKbb1W/v4qj5vn/YMqyPRi1U
         lXEjFYiMa/v/g6AvU66r1/KY0L+P0QKdJTvenLQcUmsEoGVjxZlcqUlAN8BPK9i3oDcF
         Xpqr43xWIu9Ae7F5+NEs5ALgrRlDuC7Rws/EFSWvlJeAFI8XZV9HC8BQB7pdZxSqO4ew
         JX3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679606470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OVc7Of+Ix0ryK/+RAH7Z4FzYtXWWON2rs5eqRA4tiWA=;
        b=YM9d2Qggeknso3Fxr0TgRERxPVOCI2tNQxJ84fNWzksZqwqXF3I2wcCu6Z/8H/4c8C
         6QOVsiTgSNjP36Nk/Co/iolHGKR5Wi893+CnYgoKYBVFbRCTmXUkZIsKZ+mKWbVF/X+A
         p3q0hqVAzp17uTDbiuIuzAUUmrz1TCI12UPYqP9LV4XfU/rSMtQ8LiNu25JdK07ExmST
         fdcqW0xMH/AkRNAW8pyGMZ03JRBVucQ9DyUZh2RXH5iVSJNLC9wvyddnhPaYPFFY3/5w
         DgFbh1DviPA6+JKUoBmpdnBDvYxc3nJqZpNa5XC7D1hehsQ0TRhcN9U4lV/puC86ebFT
         sVXg==
X-Gm-Message-State: AO0yUKWfzUCmol7Hjuf7jyPKoC4dKW4BO1Ah3IsBEs6AzXu34NTfE1XZ
        WFEAoQJZeIimI/Hewey+DcI=
X-Google-Smtp-Source: AK7set+7XkMQw//QRP6U0zw01ONMG6SisHKvyle8hz7Ra/I8s94s0O0zFWuYYD6E3TY5EKsJLVrbaA==
X-Received: by 2002:a7b:cd10:0:b0:3ee:672d:caa4 with SMTP id f16-20020a7bcd10000000b003ee672dcaa4mr686528wmj.17.1679606470461;
        Thu, 23 Mar 2023 14:21:10 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id t7-20020a05600c450700b003edddae1068sm3135457wmo.9.2023.03.23.14.21.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 14:21:10 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Andre Przywara <andre.przywara@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        =?ISO-8859-1?Q?Andr=E1s_Szemz=F6?= <szemzo.andras@gmail.com>,
        Icenowy Zheng <uwu@icenowy.me>,
        Fabien Poussin <fabien.poussin@gmail.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Belisko Marek <marek.belisko@gmail.com>
Subject: Re: [PATCH v2 4/4] ARM: dts: sunxi: add MangoPi MQ-R-T113 board
Date:   Thu, 23 Mar 2023 22:21:08 +0100
Message-ID: <3225657.44csPzL39Z@jernej-laptop>
In-Reply-To: <20230320005249.13403-5-andre.przywara@arm.com>
References: <20230320005249.13403-1-andre.przywara@arm.com>
 <20230320005249.13403-5-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne ponedeljek, 20. marec 2023 ob 01:52:49 CET je Andre Przywara napisal(a):
> The MangoPi MQ-R-T113 is a small SBC with the Allwinner T113-s3 SoC.
> The SoC features two Arm Cortex-A7 cores and 128 MB of co-packaged DDR3
> DRAM. The board adds mostly connectors and the required regulators, plus
> a Realtek RTL8189FTV WiFi chip.
> Power comes in via a USB-C connector wired as a peripheral, and there is
> a second USB-C connector usable as a host port.
> 
> Add a .dtsi file describing most of the board's peripherals, and include
> that from the actual board .dts file. This allows to re-use the .dtsi
> for the MQ-R-F113 RISC-V variant of that board.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


