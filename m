Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 677AB6C06AA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 00:47:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjCSXre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 19:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjCSXrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 19:47:33 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000151ABE6
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 16:47:31 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id u5so10744318plq.7
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 16:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679269651;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NMDlQfcAjVNl3W7QApbZUBXbSMBH3lZmqJskB+yG5tc=;
        b=X0mFsaIEakBErdrlC/ZuEnlPF9jrUjhQRA5+YgtU6jEIoSzg/XCvs37gRka9Pgbq1i
         gHLpHsYyztnVMPpxtsX3wgbQ/R4b8iCUAtaD/5vbFMfTto6FQDtBUiJD6f8G0DrnjOqg
         xLDvw+L7iiMGXB75fk3yKWOdG3LWz9pGKZW57+jYcogz4uEpxXE/K8SDpZtJHDokHQV2
         cAPR0EnJ78nKG72Bgnrtu2DPH8fl+Wo9Gis/A4Y7aEe/a9U4SldhWO9O6c7QcqP0b9+s
         L5MLfPMPgImFGWsOWbiLDJC9BmD8rjVUoTU60u6E10xz3tPOkmPru8lgkol4S7rGg+j0
         QsmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679269651;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NMDlQfcAjVNl3W7QApbZUBXbSMBH3lZmqJskB+yG5tc=;
        b=G7PCs9YL9zO+s1jsV1HUeF9VzZBpBvr7dAGvDzzJH0S9PthTsAIZFtrnFBIDZ+6Exe
         nAHw7A0m+UMzKqRZ+bh6UofWVH1IXOLgDHNr2wpfnUQRVDxRnfvxoe6sF2/bOMc8yHNJ
         pD1gfNIza6+GMJkz/UX4mgLz3ahPw/1iFlTqO/h7LlC11nuYoy2WMvK4azNg4nfbi9Zk
         msHCkm8Pp0E02Ms4ZvPqi80HAIAGcIoUF2OALmaveYgaqVDqkuPL6A+ncaMt1j3tKfGX
         /HNz0wTyS27XPYcyQN6Kia/ZiKd6m9lYRY4htfFgKjaFK8Gdy959gvTxHISLdKo4e4YP
         NUew==
X-Gm-Message-State: AO0yUKWc/9SP3aj6/hUe3youyAJ0aY6R3hFNjPS+6KySrtQk+ZSxYjfh
        fbgQwkQV4qfipUJfuDNr9jk=
X-Google-Smtp-Source: AK7set/f4yzW2fpBrWNFAkD93JLukx1PuWs19fG3EQsp+PGpucb/0tJGePw2NmYXtlwSdcURZpx2Yg==
X-Received: by 2002:a17:902:dac6:b0:1a1:cef9:cc5c with SMTP id q6-20020a170902dac600b001a1cef9cc5cmr2530784plx.15.1679269651224;
        Sun, 19 Mar 2023 16:47:31 -0700 (PDT)
Received: from localhost.localdomain.com (2603-8001-4200-6311-92a0-3d53-9224-b276.res6.spectrum.com. [2603:8001:4200:6311:92a0:3d53:9224:b276])
        by smtp.gmail.com with ESMTPSA id o12-20020a1709026b0c00b001a1a9a5e53fsm4906008plk.136.2023.03.19.16.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Mar 2023 16:47:30 -0700 (PDT)
From:   Chris Healy <cphealy@gmail.com>
To:     linux@armlinux.org.uk, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        arnd@arndb.de, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, andrew@lunn.ch
Cc:     Chris Healy <healych@amazon.com>
Subject: [PATCH 1/1] ARM: imx_v6_v7_defconfig: Enable SMSC Ethernet PHY
Date:   Sun, 19 Mar 2023 16:47:10 -0700
Message-Id: <20230319234710.1749455-1-cphealy@gmail.com>
X-Mailer: git-send-email 2.39.2
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

From: Chris Healy <healych@amazon.com>

The imx53 base imx53qsb uses an SMSC Ethernet PHY.  Enable it's driver.

Signed-off-by: Chris Healy <healych@amazon.com>
---
 arch/arm/configs/imx_v6_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 6dc6fed12af8..a12d45e99782 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -135,6 +135,7 @@ CONFIG_SMSC911X=y
 # CONFIG_NET_VENDOR_STMICRO is not set
 CONFIG_MICREL_PHY=y
 CONFIG_AT803X_PHY=y
+CONFIG_SMSC_PHY=y
 CONFIG_CAN_FLEXCAN=y
 CONFIG_USB_PEGASUS=m
 CONFIG_USB_RTL8150=m
-- 
2.39.2

