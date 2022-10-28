Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2EB6118A1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 19:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbiJ1RBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 13:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbiJ1RAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 13:00:02 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52236183AF;
        Fri, 28 Oct 2022 09:59:40 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id bh7-20020a05600c3d0700b003c6fb3b2052so4280703wmb.2;
        Fri, 28 Oct 2022 09:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LKcaGbOXyklscEgGaVZeABkCmiJQn+cua48lgHGMfSM=;
        b=XktKVyJAuhuTpNR50IVXpi86/f94SIWNs0zsXo+KJ65lgHjA881DzW/wOJXK/1NGc2
         0vkKWNR6w4FpkETSCedXeeprIXWBMiL0fGkeqZkV1X4nW7QgeZu8YrsRg4j0oNJJoDOD
         lJFRSxAahXLc8XpGSkCGmZOvlEo1ogXWzGZQwpVfvtTs+0bwszHZCdLTjkd9CmaF9kVR
         yHPkAyWqdTogWDLkOKOOXOZ1qpEJZdmTsEoBlyhHrzxJ20bI3iIECOMZIQ8ZyifX4M83
         K6C73Law77r6z7dCI039sPXzxm3FSRo1d95BOSOB6WWKH5+Zi08rRYTzXpJr3QCKZfYW
         yJKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LKcaGbOXyklscEgGaVZeABkCmiJQn+cua48lgHGMfSM=;
        b=fWLQYM+R9T5hGdbxaGJfmEanQd7rxdV4VVThBoU4mlY2irl+6HCNgntb4tAuJsrUnk
         cdrTE2c25jZEl1gvh5T+LFBAVkXcVArU/JCs+bmDCzRY11cC4Jn5X1LTsoZ3HheTutpM
         eakjHNHjcc3i747eP0S7iTbCpJtFXDJ1J86xzAedrT2HH9utMjpJ1YT+M0r40TY1c8N/
         G1n3rEpohb4ieiyWqlrK2q8aZQrYZsWFG5vpYY3ucpg3McKlfehAcPs9QGVSLH8Ttnbj
         OZlBIxSdNxDCUCj6JGKHXARFKkjLIJCg5bHBk41quBs9JOvuHG4OK0T+zOVKyfgxWiPA
         2LIw==
X-Gm-Message-State: ACrzQf2tiYK8E9e6t7uIJiePRfVeREGJ3u7s1OYEf4eIX09J3Ba0/zKv
        qeBo1x8txevlXp61FLRJFLo=
X-Google-Smtp-Source: AMsMyM7SrqgUatgxtKzxUbci+TsYWLGOUnEsW59p/P1BaS1TwA7Vn45N9ioYHZP45iv2M+iI+IDVrg==
X-Received: by 2002:a05:600c:230d:b0:3c4:2975:321a with SMTP id 13-20020a05600c230d00b003c42975321amr10195946wmo.155.1666976379388;
        Fri, 28 Oct 2022 09:59:39 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:d53b:eaf9:15f:6a8a])
        by smtp.gmail.com with ESMTPSA id h2-20020adfe982000000b002322bff5b3bsm4939689wrm.54.2022.10.28.09.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 09:59:38 -0700 (PDT)
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
Subject: [PATCH v5 7/7] riscv: configs: defconfig: Enable Renesas RZ/Five SoC
Date:   Fri, 28 Oct 2022 17:59:21 +0100
Message-Id: <20221028165921.94487-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Enable Renesas RZ/Five SoC config in defconfig. It allows the default
upstream kernel to boot on RZ/Five SMARC EVK board.

Alongside enable SERIAL_SH_SCI config so that the serial driver used by
RZ/Five SoC is built-in.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v4 -> v5
* No change

v3 -> v4
* Explicitly enabled ARCH_R9A07G043 config (note I have restored the RB
  tags with this change)
* Used riscv instead of RISC-V in subject line

v2 -> v3
* Included RB tags
* Updated commit description

v1 -> v2
* New patch
---
 arch/riscv/configs/defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index 05fd5fcf24f9..97fba7884d7a 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -29,6 +29,8 @@ CONFIG_SOC_MICROCHIP_POLARFIRE=y
 CONFIG_SOC_SIFIVE=y
 CONFIG_SOC_STARFIVE=y
 CONFIG_SOC_VIRT=y
+CONFIG_ARCH_RENESAS=y
+CONFIG_ARCH_R9A07G043=y
 CONFIG_SMP=y
 CONFIG_HOTPLUG_CPU=y
 CONFIG_PM=y
@@ -123,6 +125,7 @@ CONFIG_INPUT_MOUSEDEV=y
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_OF_PLATFORM=y
+CONFIG_SERIAL_SH_SCI=y
 CONFIG_VIRTIO_CONSOLE=y
 CONFIG_HW_RANDOM=y
 CONFIG_HW_RANDOM_VIRTIO=y
-- 
2.25.1

