Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72DF361189B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 19:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbiJ1RAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 13:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbiJ1Q76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 12:59:58 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC6C178B4;
        Fri, 28 Oct 2022 09:59:35 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id h9so7464278wrt.0;
        Fri, 28 Oct 2022 09:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gju3CMb3jhkVvblFFI0iIit6dBsGsDogFez5dmlOa7U=;
        b=OFPb950AFFtYvGt/Xeg5Zj3YPvS1iejKr+MH4Tub3vjKCSB+W3jmJiZaiIVsugX4N4
         MHouyPzNFbTkC0h2d8jUOXDJcJ30gGywsjjQVkeaz2IDKk0LcqOs5d4uNIUR6kj6/ntN
         AglmIJHgnnrLcSkjJHel2OZX+KEMcsXmjNy17kj4CPRUuXGLzAyFxT3k4WKcURZc47c8
         EnY++FcbgmnXmI0m9LfgdwBcMi0HOXE4i9OUnn7alyALEzb3SCtvoZlGknxdH++FQ8qg
         X58wC2ZHrVNuON3menp5RQSWj6lwbfdgb+bsvwMU0J9JCNRo4lpGhYRxZJTpcEKkAr/w
         1GMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gju3CMb3jhkVvblFFI0iIit6dBsGsDogFez5dmlOa7U=;
        b=64szUSSWbgv4BVhU+8rQL+EePXHkcm+SD92E50KVmUQV+KK+Hc/rbqrQAc0caBCrMx
         PqI3kpXIDqgeqvnF0MMfQXvVgiT8kTIETQQycaHkbdI3ryfSy881AhwNS9IyP1o+7ILa
         UzmRpAJlAl13pY6mEQIhFSHI2OF6RMJIosr5WP5BBBuv80STNHl/r8nhXryuyPYawjDg
         0QYZ+DiyUN4d9/7NGs3HsdRP6J4bHxMNaRRJClPfuKEoawFMDCojLz14VxKIJVRglzUl
         d2ifEJr4H90a9exWDJma00vaUv2nZx3cmhylh32fqOKNBjdl1su6ntWciT7uS58j7feF
         4rSA==
X-Gm-Message-State: ACrzQf0WN1GCLYKVkXshhGTJbx+0Ka9fekL0LW5oML5KMPrJo57z0+yQ
        CtD7HGNwHCZPbdqseLA0smQ=
X-Google-Smtp-Source: AMsMyM5SuJPSrAK5aGpUvx8QERyDnfD43NSpIueqn6+EN0Tj+1UdHXdVOzY1GxPeC0XLrPbi51Xilw==
X-Received: by 2002:adf:ab1d:0:b0:236:6301:c77 with SMTP id q29-20020adfab1d000000b0023663010c77mr178897wrc.119.1666976374229;
        Fri, 28 Oct 2022 09:59:34 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:d53b:eaf9:15f:6a8a])
        by smtp.gmail.com with ESMTPSA id h2-20020adfe982000000b002322bff5b3bsm4939689wrm.54.2022.10.28.09.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 09:59:33 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>, Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@rivosinc.com>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v5 3/7] riscv: Kconfig.socs: Add ARCH_RENESAS kconfig option
Date:   Fri, 28 Oct 2022 17:59:17 +0100
Message-Id: <20221028165921.94487-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221028165921.94487-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20221028165921.94487-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Add ARCH_RENESAS config option to allow selecting the Renesas RISC-V SoCs.
We currently have the newly added RZ/Five (R9A07G043) RISC-V based SoC.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
v4 -> v5
* Sorted as per SoC name
* Included RB tag from Conor

v3 -> v4
* Dropped SOC_RENESAS_RZFIVE config option
* Dropped explicitly selecting SOC_BUS/GPIOLIB/PINCTRL configs
  under ARCH_RENESAS
* Updated commit message
* Dropped RB tag
* Used riscv instead of RISC-V in subject line

v2 -> v3
* Included RB tag from Geert

v1 -> v2
* No Change
---
 arch/riscv/Kconfig.socs | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
index 69774bb362d6..75fb0390d6bd 100644
--- a/arch/riscv/Kconfig.socs
+++ b/arch/riscv/Kconfig.socs
@@ -7,6 +7,11 @@ config SOC_MICROCHIP_POLARFIRE
 	help
 	  This enables support for Microchip PolarFire SoC platforms.
 
+config ARCH_RENESAS
+	bool "Renesas RISC-V SoCs"
+	help
+	  This enables support for the RISC-V based Renesas SoCs.
+
 config SOC_SIFIVE
 	bool "SiFive SoCs"
 	select SERIAL_SIFIVE if TTY
-- 
2.25.1

