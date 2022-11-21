Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2A296327CC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 16:23:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232045AbiKUPXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 10:23:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbiKUPWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 10:22:50 -0500
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB693D87
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 07:22:26 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed10:4821:1ba5:2638:5c3a])
        by baptiste.telenet-ops.be with bizsmtp
        id n3NP2800R5WXlCv013NP3Q; Mon, 21 Nov 2022 16:22:24 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1ox8cp-0019CK-PT; Mon, 21 Nov 2022 16:22:23 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1ox8co-00BPxI-VQ; Mon, 21 Nov 2022 16:22:22 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] usb: USB_FOTG210 should depend on ARCH_GEMINI
Date:   Mon, 21 Nov 2022 16:22:19 +0100
Message-Id: <a989b3b798ecaf3b45f35160e30e605636d66a77.1669044086.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Faraday Technology FOTG210 USB2 Dual Role Controller is only present
on Cortina Systems Gemini SoCs.  Hence add a dependency on ARCH_GEMINI,
to prevent asking the user about its drivers when configuring a kernel
without Cortina Systems Gemini SoC support.

Fixes: 1dd33a9f1b95ab59 ("usb: fotg210: Collect pieces of dual mode controller")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/usb/fotg210/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/fotg210/Kconfig b/drivers/usb/fotg210/Kconfig
index 534206ee0d1db74f..dad1b088aba59217 100644
--- a/drivers/usb/fotg210/Kconfig
+++ b/drivers/usb/fotg210/Kconfig
@@ -4,6 +4,7 @@ config USB_FOTG210
 	tristate "Faraday FOTG210 USB2 Dual Role controller"
 	depends on USB || USB_GADGET
 	depends on HAS_DMA && HAS_IOMEM
+	depends on ARCH_GEMINI || COMPILE_TEST
 	default ARCH_GEMINI
 	select MFD_SYSCON
 	help
-- 
2.25.1

