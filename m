Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC4C460F626
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 13:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235246AbiJ0LZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 07:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235178AbiJ0LZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 07:25:19 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A56C43328;
        Thu, 27 Oct 2022 04:25:17 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id y10so758645wma.0;
        Thu, 27 Oct 2022 04:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i7wM3m18YxeVNzjNxwf4KcaB1sq+2kufm8mhS2pGbtk=;
        b=lcF1djpINOFGXYHAZJo7HGmSyKZbDeLQOEVFZQO6BJD0KGPIOH4bWdTiI/45rLBJLX
         5EhxSTuvPHWplLjng2zgR/EzBeWThne2vstnq5p7fE3y4G3nRWyxRm9xDx1WJ1naM/z+
         2V6HpvKCVYk2RS1RoqHh3w8/vGkz7tqnjq8aaHlxeyNjexTlR50PpkeqiM6W1+MrkLM8
         qvayngCgLXeHtw6o27djIUVURuY7i8BI/4yh6MMWb3wWPlmDU4AZ/NMNxtP0dz+DGf3T
         2KdRjjL2c9d+z5T6Bag5RDct5L0CRp94jNk+p/sz0Q7+jCCJ0gwkYT+s2W8MpBKdVBW1
         eGzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i7wM3m18YxeVNzjNxwf4KcaB1sq+2kufm8mhS2pGbtk=;
        b=iNOOpeUug+oa/ol1F/ob1TKEAe9IV4jI4KDu8tP+78+NOZQR2TXIIPCrxq3vqUYG06
         fsk3mZDrnT+FvnED5u+K51vTBXVAjlv9pZ2JN7/POiRou0r5ENScDXX7OuRlKSnLnEvd
         O+AXsTShtUZel0L2tYhc7YJgoz1I7rf/uGxQha9QhcArfuuwcKaaKmge/efeqzSuzB70
         fZ5uLgyVI7nnT5gdLQb5rEePJDu5dg14YQaLmpEnDPvulzc6cbmbWXV+w6SwccqZojaC
         IuTRXG+KlRbVN5fAQ5G2DEbUVBAiNPSsUbAi34nz0trMTPklYfTaxnESv5p74oibwTNo
         V/zA==
X-Gm-Message-State: ACrzQf0vvhW3Q3FqU5i8VkhZEziBSjdmtUF5J/yzl1QIGly7n11A0s9F
        S36/p0v/H0ocOy3qwM0IWZU=
X-Google-Smtp-Source: AMsMyM4QoxqEIuqNv4YlI8xRpnE40wr3v9CNW9t76zwRsxuBFlEorzAg6XpvND/iMcSanWCu5ZzNTA==
X-Received: by 2002:a05:600c:6028:b0:3c6:f0bb:316a with SMTP id az40-20020a05600c602800b003c6f0bb316amr5546401wmb.1.1666869915828;
        Thu, 27 Oct 2022 04:25:15 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:66:ff81:b0d3:60a0])
        by smtp.gmail.com with ESMTPSA id n5-20020a05600c304500b003a84375d0d1sm4216841wmh.44.2022.10.27.04.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 04:25:15 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-renesas-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH] arm64: renesas: Drop selecting GPIOLIB and PINCTRL
Date:   Thu, 27 Oct 2022 12:24:59 +0100
Message-Id: <20221027112459.77413-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
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

Don't automatically select the GPIOLIB and PINCTRL config options as we
already have automatically selected it as part of the SOC_RENESAS config
option [0].

[0] drivers/soc/renesas/Kconfig

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/Kconfig.platforms | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 76580b932e44..d1970adf80ab 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -252,8 +252,6 @@ config ARCH_REALTEK
 
 config ARCH_RENESAS
 	bool "Renesas SoC Platforms"
-	select GPIOLIB
-	select PINCTRL
 	help
 	  This enables support for the ARMv8 based Renesas SoCs.
 
-- 
2.17.1

