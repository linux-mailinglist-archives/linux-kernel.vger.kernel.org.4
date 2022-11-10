Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52249624531
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 16:09:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbiKJPIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 10:08:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbiKJPIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 10:08:42 -0500
Received: from mx.msync.work (mx.msync.work [185.250.0.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9991823157;
        Thu, 10 Nov 2022 07:08:38 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F14AD123169;
        Thu, 10 Nov 2022 15:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
        t=1668092469; h=from:subject:date:message-id:to:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=dONz83S/sl0lvYKGXEj7vcvWK71sD2+ztpm57yFpufg=;
        b=OTavFoQLMbkEqY41c8FhiUtigQYo9tCEen8cj5clEkrfIdSs/a2eaDQC69VZY0uoB2otoN
        ++qyL00LAa2ymvVaLaAGYwr8PD0HNk97Qd40oz/Wl1PGUx/mTFQYYzZNFsM+UkwvhUlrPU
        b59Au0227AfMxPCq0qq0vaLAwxlBWdoCxPooBnfsCwmAIjkZdp0SmUoosZ8e3TL2eAIvEx
        ScisEvn3ghRTbEUg/EeAHFm1B9EHSvfiMT2mvvWYbLnEUc4EJitW3mJ6kCZPjRdFiVyV5x
        lZmA9Y/zZoI+PQDDl0JNUuLKyemTzhFLZe/AfNsqGhBY8ukXMVPAJBg3rvGmPQ==
From:   Vyacheslav Bocharov <adeep@lexina.in>
To:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] arm64: dts: docs: Update mmc meson-gx documentation for new config option amlogic,mmc-phase
Date:   Thu, 10 Nov 2022 18:00:35 +0300
Message-Id: <20221110150035.2824580-5-adeep@lexina.in>
In-Reply-To: <20221110150035.2824580-1-adeep@lexina.in>
References: <20221110150035.2824580-1-adeep@lexina.in>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- amlogic,mmc-phases: 3-element array of clock phases for core, tx, rx
clock with values:
	0: CLK_PHASE_0 - 0 phase
	1: CLK_PHASE_90 - 90 phase
	2: CLK_PHASE_180 - 180 phase
	3: CLK_PHASE_270 - 270 phase
By default driver use <CLK_PHASE_180 CLK_PHASE_0 CLK_PHASE_0> value.

Signed-off-by: Vyacheslav Bocharov <adeep@lexina.in>

diff --git a/Documentation/devicetree/bindings/mmc/amlogic,meson-gx.txt b/Documentation/devicetree/bindings/mmc/amlogic,meson-gx.txt
index ccc5358db131..98c89c5b3455 100644
--- a/Documentation/devicetree/bindings/mmc/amlogic,meson-gx.txt
+++ b/Documentation/devicetree/bindings/mmc/amlogic,meson-gx.txt
@@ -25,6 +25,12 @@ Required properties:
 Optional properties:
 - amlogic,dram-access-quirk: set when controller's internal DMA engine cannot access the
   DRAM memory, like on the G12A dedicated SDIO controller.
+- amlogic,mmc-phases: 3-element array of clock phases for core, tx, rx clock with values:
+	0: CLK_PHASE_0 - 0 phase
+	1: CLK_PHASE_90 - 90 phase
+	2: CLK_PHASE_180 - 180 phase
+	3: CLK_PHASE_270 - 270 phase
+  By default driver use <CLK_PHASE_180 CLK_PHASE_0 CLK_PHASE_0> value.
 
 Example:
 
@@ -36,4 +42,5 @@ Example:
 		clock-names = "core", "clkin0", "clkin1";
 		pinctrl-0 = <&emmc_pins>;
 		resets = <&reset RESET_SD_EMMC_A>;
+		amlogic,mmc-phases = <CLK_PHASE_180 CLK_PHASE_0 CLK_PHASE_0>;
 	};
-- 
2.30.2

