Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A213715760
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 09:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbjE3Hno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 03:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbjE3HnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 03:43:24 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD08C18F;
        Tue, 30 May 2023 00:42:57 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-53487355877so2569005a12.1;
        Tue, 30 May 2023 00:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685432555; x=1688024555;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OzBlnANu1AM5Fjx46MEeCrq3qasOfTTbM5uM0GEAlY0=;
        b=TAGvO9if8HnoRGOfYUkqCcPb2vjduCACEZckI7K1ogQnzFhxgff7oC5+t7qHj2cf6f
         oBifQX6ee1qn9DfbCGVkuZTAHZunOwtZJdCXnUIp7pfQEQ4XwG+OCDisa72bA6V6RWAB
         Ue8uO0UdOetz+oMvUzgqqi4pK4ucoB5hFSQeAJz8kGrLk6zJjwUvJ+4BPeP9gHMetSHh
         iawnP10Z2pHcwdM1iygL601SjZOfpMorLsFKqvxcuNuxPSnui0juCmrRSVX0phhEYXqt
         7wXSqtJmqPcTXnXom4ygFuaZw0Zwcv5ECqM5YLBc7J+zB+s1X8MJnHb4/1A/R3gpqBzW
         iM5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685432555; x=1688024555;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OzBlnANu1AM5Fjx46MEeCrq3qasOfTTbM5uM0GEAlY0=;
        b=IcHKlCfbsclmErBeWM/p8mFNLdtOeaAgyqyD/m5aEywh+L0wZC58Qpj/zQY99ZeN3w
         SRBAQ93G/LQA+2XRhEvAxltcr8Xsq7hEg25z4xT+oti4mnLycsCnQzOeJqvMn0ewYkii
         gBASGEOW+DGPfug5q02VG+JP9bLpB0kmN3i6QLvyd4vuC9OGRGbTepStRnExc1WoaNZT
         bBqOjJKYZZk3AVzlqhQcI+6q8if6BNG1AgpND2ZUJ/UmEZuOyGg8EbJmUU8YrikSQsjB
         vNehQ0rLVxDWshHZDPDMU88NlUrK8lRvcrkWwf7Rwtf5HEPNA8e0DIdri050aCtnuYkx
         JlFw==
X-Gm-Message-State: AC+VfDxq5DWQzQ9jsqi5F2PxDdyiV9h38C9EsSarAikNdp4qN8ZKgi5t
        hSYTDdtwLy865oMDni+vL9E=
X-Google-Smtp-Source: ACHHUZ7jcBNMiw+EBrLY0QRRvMn+SK4O3Q6KOWMJegrkpal3cBCjZN7a+HoEfLju4eaqfXKfdvX0fw==
X-Received: by 2002:a17:902:7c81:b0:1ae:1659:bfe2 with SMTP id y1-20020a1709027c8100b001ae1659bfe2mr1476067pll.34.1685432554948;
        Tue, 30 May 2023 00:42:34 -0700 (PDT)
Received: from a28aa0606c51.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id a14-20020a170902ecce00b001afb96f4b90sm5930793plh.274.2023.05.30.00.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 00:42:34 -0700 (PDT)
From:   Jacky Huang <ychuang570808@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, tmaimon77@gmail.com, catalin.marinas@arm.com,
        will@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-serial@vger.kernel.org, arnd@arndb.de, soc@kernel.org,
        schung@nuvoton.com, mjchen@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v12 02/10] arm64: defconfig: Add support for Nuvoton MA35 family SoCs
Date:   Tue, 30 May 2023 07:42:13 +0000
Message-Id: <20230530074221.1031011-3-ychuang570808@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230530074221.1031011-1-ychuang570808@gmail.com>
References: <20230530074221.1031011-1-ychuang570808@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jacky Huang <ychuang3@nuvoton.com>

This adds support for the Nuvoton MA35 family SoCs which
are based on the Cortex-A35 Armv8-A 64-bit architecture.

Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index a24609e14d50..0ee572753f1a 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -52,6 +52,7 @@ CONFIG_ARCH_NXP=y
 CONFIG_ARCH_LAYERSCAPE=y
 CONFIG_ARCH_MXC=y
 CONFIG_ARCH_S32=y
+CONFIG_ARCH_MA35=y
 CONFIG_ARCH_NPCM=y
 CONFIG_ARCH_QCOM=y
 CONFIG_ARCH_RENESAS=y
-- 
2.34.1

