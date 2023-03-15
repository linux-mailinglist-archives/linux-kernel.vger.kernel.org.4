Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34C3B6BA927
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 08:30:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbjCOHab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 03:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231772AbjCOH36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 03:29:58 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39E76C690;
        Wed, 15 Mar 2023 00:29:11 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id nn12so17846624pjb.5;
        Wed, 15 Mar 2023 00:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678865351;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ed17VsKqIYY1EHY3aBloZZET84zjPJ3dZSJioIcN9l0=;
        b=jCejio4JOFaEEdujj2UtxzkEnwWmbwdk4jb7/APQfQbPL7rfxOy4DfJrcSAHA4gSuw
         Ux7tgN+9bErK7Pe2KwoqNcZhxLHx6MG7MS97cnHTuIV5UZO3csvYS1aaPaGzntKQn3jL
         40M0KAMMYQNOk1VZkNwUXNy6EF4gTgAQJsfurqyMxrN9SU3YaoTJXO6/TkY4GekXXrVH
         W0oluaacMemPG4fiEfsDvdv6pCpaKhYuq2OpP9/lN5VhTOWvXFPt7xAby8uu80Wv8Vpl
         GdWHojEfPr9CBIuy5CuXmZn0+2awb9Mq1meIV8IqrrNtFWDUu5HxmSswFRfmyGPKrQ4I
         sZ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678865351;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ed17VsKqIYY1EHY3aBloZZET84zjPJ3dZSJioIcN9l0=;
        b=sdMT2DRDj794tAUfuXRRwWOsyebI0r4zlXI4Ep4Y6Ff+fW2iSErN2eJWXYikopCU6t
         JkRo8AApNs4yToFAUn2SjZSy/jiUR1os60Fgy8Ot6Ci1ZZ009LRJQs3lkByXa/+YRa9j
         THiUiIpDUZncn8j/IqP9OCXmv1Uzeza5/4bGcfIMRzDf5sGCxurfSs8lLpAUGR+HRfyu
         8YaU0n+GunkqWz0hcsUZhGYqe2gHw9ae7oPIaKGTustycBFd6Q1zqrRRnUG67sUDLjc7
         YudLJPZ+wVZ29RR/DnLRSbLxybVEE+Whl/rDDSkuU73qRWAoH3jFSBKoL8JeMMWIqa+X
         QQrg==
X-Gm-Message-State: AO0yUKX9aRQktQPBo9fr8UHSzII29EfWC3urexifMHhW02g7kGo49hpA
        vw/Qe9dJcmY4wlXc2wH0uvA=
X-Google-Smtp-Source: AK7set9KTk8ds9IJJR2XfY2NSP8RNVnPplOwDXkJJflpiW1QbzAegPBDrWjapjJZ8dsePZeKiNH6iQ==
X-Received: by 2002:a17:902:d2d1:b0:19a:a520:b203 with SMTP id n17-20020a170902d2d100b0019aa520b203mr1677475plc.25.1678865351189;
        Wed, 15 Mar 2023 00:29:11 -0700 (PDT)
Received: from a28aa0606c51.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id kz11-20020a170902f9cb00b001a0667822c8sm2740003plb.94.2023.03.15.00.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 00:29:10 -0700 (PDT)
From:   Jacky Huang <ychuang570808@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        schung@nuvoton.com, Jacky Huang <ychuang3@nuvoton.com>
Subject: [PATCH 01/15] arm64: Kconfig.platforms: Add config for Nuvoton MA35 platform
Date:   Wed, 15 Mar 2023 07:28:48 +0000
Message-Id: <20230315072902.9298-2-ychuang570808@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230315072902.9298-1-ychuang570808@gmail.com>
References: <20230315072902.9298-1-ychuang570808@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jacky Huang <ychuang3@nuvoton.com>

Add ARCH_NUVOTON configuration option for Nuvoton MA35 family SoCs.

Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
---
 arch/arm64/Kconfig.platforms | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 89a0b13b058d..c1f277c05569 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -236,6 +236,15 @@ config ARCH_NPCM
 	  General support for NPCM8xx BMC (Arbel).
 	  Nuvoton NPCM8xx BMC based on the Cortex A35.
 
+config ARCH_NUVOTON
+	bool "Nuvoton MA35 Platforms"
+	select GPIOLIB
+	select PINCTRL
+	select RESET_CONTROLLER
+	help
+	  This enables support for the ARMv8 based Nuvoton SoCs such
+	  as MA35D1.
+
 config ARCH_QCOM
 	bool "Qualcomm Platforms"
 	select GPIOLIB
-- 
2.34.1

