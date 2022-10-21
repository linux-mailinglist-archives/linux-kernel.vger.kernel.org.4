Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F414D607E1E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 20:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbiJUSKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 14:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbiJUSKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 14:10:36 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B9FCD2CC1;
        Fri, 21 Oct 2022 11:10:34 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id r8-20020a1c4408000000b003c47d5fd475so5662546wma.3;
        Fri, 21 Oct 2022 11:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SCMIWHkICzZX+kzd/gI/19yCCEBlViFGlZeb1lVVKQg=;
        b=ATNr3M0VRGusUEwflQ479GhtRIKW9FvwjCy8T7uu6a4Ao3Htu8J2o/Uxu4KvLqAVBF
         Rt/hjm4xIhTmGAkBi9RFa0wzdZ2KcpRqzNSZeT0p8/Zr9IH2NoCmCUPXkAHnCBOfx7WA
         w6m0jVoyAq61lw/arct5Ix6Uby5aVZcZjwKMd7Q2rs5SRPnjC+3fUnU1hChkeGEvSLdl
         nBohAnz+/Wu/h0zbhLlwrehNTODOU0+5ECxZsqiEvFFKGA7f8JWs5Lb3KB4YpKRfXei9
         tyDkhS/AbiQ+Wz1tQzsKoCAOlcjF7cpcAl7ijlFenqA/bf0LNeBoXHNtMpegIRSQvdee
         vwIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SCMIWHkICzZX+kzd/gI/19yCCEBlViFGlZeb1lVVKQg=;
        b=aSaJUQHOOHJhPCg+feFVwlWaCfRiGyxxF4uoSvxwfMHNf+4FioeCwLPHcux3vFWL9X
         nwv+cC6AchuOniM735PLHBGQQec0x3eX8EfOWf2ptiom4rLgcVypG4IZVNz1dzcUkbkj
         zs+nVK/U/fUp4lOWQ7AZqziggMiMw6MH/fPUqCF5Ufgn9c99rXWy6ScYxKNFCEhrUJJo
         LRpq3nfGUxFO9bRXdgJrbgPdOJCTmoB4nqY4zNcA7r65fW+onSPmBhWxyX+Mje01DLGu
         7Ui49VFvFNJKeiprKACyLtZVNlFa99t/TXREs1MOmCP3fbHGn66TdtdCGnW6jQ2o4gmQ
         x2WQ==
X-Gm-Message-State: ACrzQf3rjgBAkFcUMfxe2MIh//oLnO1YVXhDp1iPQiWiEhwUGmg7GBot
        mfCOiBFKnEOJq0WySTbNZ1g=
X-Google-Smtp-Source: AMsMyM5fYQqms17JBH73QPjPi8937bCrhD3OavyX5Wvz4WFDIYa/O9aNVXfJcuMLX1G1w9HAStRCpQ==
X-Received: by 2002:a7b:c047:0:b0:3b4:adc7:1ecb with SMTP id u7-20020a7bc047000000b003b4adc71ecbmr14010575wmc.144.1666375832503;
        Fri, 21 Oct 2022 11:10:32 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-134.ip85.fastwebnet.it. [93.42.70.134])
        by smtp.googlemail.com with ESMTPSA id fc18-20020a05600c525200b003b505d26776sm356335wmb.5.2022.10.21.11.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 11:10:32 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Russell King <linux@armlinux.org.uk>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Nick Hawkins <nick.hawkins@hpe.com>,
        John Crispin <john@phrozen.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH] ARM: mach-qcom: fix support for ipq806x
Date:   Fri, 21 Oct 2022 20:10:16 +0200
Message-Id: <20221021181016.14740-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.37.2
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

Add a specific config flag for Qcom IPQ806x as this SoC can't use
AUTO_ZRELADDR and require the PHYS_OFFSET set to 0x42000000.

This is needed as some legacy board (or some wrongly configured
bootloader) pass the wrong memory map and doesn't exclude the first
~20MB of RAM reserved for the hardware network accellerators.

With this change we can correctly support each board and prevent any
kind of misconfiguration done by the OEM.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 arch/arm/Kconfig           |  3 ++-
 arch/arm/mach-qcom/Kconfig | 13 +++++++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 1af63e17b4ad..0818d35973ad 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -282,6 +282,7 @@ config PHYS_OFFSET
 	default 0x30000000 if ARCH_S3C24XX
 	default 0xa0000000 if ARCH_IOP32X || ARCH_PXA
 	default 0xc0000000 if ARCH_EP93XX || ARCH_SA1100
+	default 0x42000000 if ARCH_IPQ806X
 	default 0
 	help
 	  Please provide the physical address corresponding to the
@@ -1701,7 +1702,7 @@ config CRASH_DUMP
 
 config AUTO_ZRELADDR
 	bool "Auto calculation of the decompressed kernel image address" if !ARCH_MULTIPLATFORM
-	default !(ARCH_FOOTBRIDGE || ARCH_RPC || ARCH_SA1100)
+	default !(ARCH_FOOTBRIDGE || ARCH_RPC || ARCH_SA1100 || ARCH_IPQ806X)
 	help
 	  ZRELADDR is the physical address where the decompressed kernel
 	  image will be placed. If AUTO_ZRELADDR is selected, the address
diff --git a/arch/arm/mach-qcom/Kconfig b/arch/arm/mach-qcom/Kconfig
index 12a812e61c16..b11b6e391ff0 100644
--- a/arch/arm/mach-qcom/Kconfig
+++ b/arch/arm/mach-qcom/Kconfig
@@ -46,4 +46,17 @@ config ARCH_MDM9615
 	bool "Enable support for MDM9615"
 	select CLKSRC_QCOM
 
+config ARCH_IPQ806X
+	bool "Enable support for IPQ806x"
+	help
+	  Enable support for the Qualcomm IPQ806x.
+
+	  IPQ806x require special PHYS_OFFSET and can't use AUTO_ZRELADDR.
+	  The first ~20MB of RAM is reserved for the hardware network accelerators,
+	  and the bootloader removes this section from the layout passed from the
+	  ATAGS (when used by some bootloader doesn't even do that).
+
+	  To support every system and handle legacy systems, hardcode PHYS_OFFSET and
+	  disable AUTO_ZRELADDR.
+
 endif
-- 
2.37.2

