Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95D9266B060
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 11:32:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbjAOKcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 05:32:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbjAOKcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 05:32:24 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADCD7CDE1;
        Sun, 15 Jan 2023 02:32:23 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id bk15so4362483ejb.9;
        Sun, 15 Jan 2023 02:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9KIBzV9X4o03JcBg5zot6EBDFjNtT0pLDm4cxXYovEw=;
        b=pkOw/e39Pv2VcryuSD5fKB8JSMxsN3VIshk7WHp/MzFoeisi6QMjGviViO+onXfhOL
         db9xGoD1gBDgyLyt/PFuQeWzGrmfxHK1UJEacfMHX0Ktae3921WHoiMo6/wJ5K27Wdta
         BRP8ZxZbjTo1KkJ6hnOW7xkVsDnOeS1Qlj/lDGZkj/fUHxZncLd8At295EpEH7XM/0Ni
         e2Vejgy9qUEMOgrj1fMx/5Lducd/QXLlfXlcE3S5Tl2dp26Lx7X+uLVRoeA+k6lxA/29
         7r3mnQTdUcznEYmmxtOt4tNHdIYQG+J4Rz23kXmRXWR8dEXWeKGblTX8nwrDRowKwe15
         KXtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9KIBzV9X4o03JcBg5zot6EBDFjNtT0pLDm4cxXYovEw=;
        b=qEb1/b7ZV7g+blpz1V5TOmx0sGBI3WVSROXX2iHEh60mqEfNrM9i9bmIUBuwZtJF1q
         9tz5jHY2PFtxQDg9NXBTMQECuiA0gxAb7WJuGM9eAIJtqo6UoUXC8hqflLWKcFSO9F9L
         wQDpyDEDDxGj2h1gw67dGVl7Jf9J6rSZ09cr7mwKLUOxJVxkOkxUwlTK0tHujVn5mR5Y
         8/vkGluweNozckmMI/9WsvOefiIhPiNW4d+rkQFb4IiL23jmfpepZ4ULuTR5UOxNZWQ6
         mydPWWMFZAlfPpCCuW3O/ITYb0Ng33RvUXcTtBcccJcusDhx70Ddkd1Id13JGL5zZzDX
         ds8A==
X-Gm-Message-State: AFqh2krehnlx1foEbW91uTAq777JPDmcCtQaq2JfNk+GxZVSjQijFWB6
        P3+qnApysGGI9PeAQVR+Olo=
X-Google-Smtp-Source: AMrXdXuk1LPqMQ8uNBuUFu/1NVOWt0V2hz2ECmm9fMjMXpSyvXWmuzlKCkkK/oEvveTNpiv0BsOcIg==
X-Received: by 2002:a17:906:16db:b0:86b:9216:2ddb with SMTP id t27-20020a17090616db00b0086b92162ddbmr8264630ejd.52.1673778742113;
        Sun, 15 Jan 2023 02:32:22 -0800 (PST)
Received: from localhost.localdomain (host-79-51-7-163.retail.telecomitalia.it. [79.51.7.163])
        by smtp.googlemail.com with ESMTPSA id 11-20020a170906318b00b0078d3f96d293sm10576106ejy.30.2023.01.15.02.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jan 2023 02:32:21 -0800 (PST)
From:   Pierluigi Passaro <pierluigi.passaro@gmail.com>
X-Google-Original-From: Pierluigi Passaro <pierluigi.p@variscite.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, pierluigi.p@variscite.com,
        marex@denx.de, peng.fan@nxp.com, marcel.ziswiler@toradex.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     eran.m@variscite.com, nate.d@variscite.com
Subject: [PATCH] arm64: dts: imx8mm: Fix pad control for UART1_DTE_RX
Date:   Sun, 15 Jan 2023 11:32:17 +0100
Message-Id: <20230115103217.9232-1-pierluigi.p@variscite.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

According section
    8.2.5.313 Select Input Register (IOMUXC_UART1_RXD_SELECT_INPUT)
of 
    i.MX 8M Mini Applications Processor Reference Manual, Rev. 3, 11/2020
the required setting for this specific pin configuration is "1"

Signed-off-by: Pierluigi Passaro <pierluigi.p@variscite.com>
---
 arch/arm64/boot/dts/freescale/imx8mm-pinfunc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-pinfunc.h b/arch/arm64/boot/dts/freescale/imx8mm-pinfunc.h
index 83c8f715cd90..b1f11098d248 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-pinfunc.h
+++ b/arch/arm64/boot/dts/freescale/imx8mm-pinfunc.h
@@ -602,7 +602,7 @@
 #define MX8MM_IOMUXC_UART1_RXD_GPIO5_IO22                                   0x234 0x49C 0x000 0x5 0x0
 #define MX8MM_IOMUXC_UART1_RXD_TPSMP_HDATA24                                0x234 0x49C 0x000 0x7 0x0
 #define MX8MM_IOMUXC_UART1_TXD_UART1_DCE_TX                                 0x238 0x4A0 0x000 0x0 0x0
-#define MX8MM_IOMUXC_UART1_TXD_UART1_DTE_RX                                 0x238 0x4A0 0x4F4 0x0 0x0
+#define MX8MM_IOMUXC_UART1_TXD_UART1_DTE_RX                                 0x238 0x4A0 0x4F4 0x0 0x1
 #define MX8MM_IOMUXC_UART1_TXD_ECSPI3_MOSI                                  0x238 0x4A0 0x000 0x1 0x0
 #define MX8MM_IOMUXC_UART1_TXD_GPIO5_IO23                                   0x238 0x4A0 0x000 0x5 0x0
 #define MX8MM_IOMUXC_UART1_TXD_TPSMP_HDATA25                                0x238 0x4A0 0x000 0x7 0x0
-- 
2.37.2

