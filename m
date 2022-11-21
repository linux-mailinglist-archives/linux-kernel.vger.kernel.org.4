Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCE726327CE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 16:24:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232355AbiKUPX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 10:23:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232296AbiKUPXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 10:23:41 -0500
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 190C71572D
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 07:23:06 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed10:4821:1ba5:2638:5c3a])
        by albert.telenet-ops.be with bizsmtp
        id n3P32800F5WXlCv063P3d2; Mon, 21 Nov 2022 16:23:04 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1ox8dT-0019CU-1i; Mon, 21 Nov 2022 16:23:03 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1ox8dS-00BPzz-MP; Mon, 21 Nov 2022 16:23:02 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Yicong Yang <yangyicong@hisilicon.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] hwtracing: HISI_PTT should depend on ARCH_HISI
Date:   Mon, 21 Nov 2022 16:23:01 +0100
Message-Id: <1a31a50f01e880f4c137298a12b8023c55f59cdc.1669044155.git.geert+renesas@glider.be>
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

The HiSilicon PCIe Tune and Trace Device is a PCIe Root Complex
integrated Endpoint (RCiEP) device, which is only present on HiSilicon
SoCs.  Hence add a dependency on ARCH_HISI, to prevent asking the user
about this driver when configuring a kernel without HiSilicon SoC
support.

Fixes: ff0de066b4632ccb ("hwtracing: hisi_ptt: Add trace function support for HiSilicon PCIe Tune and Trace device")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/hwtracing/ptt/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/ptt/Kconfig b/drivers/hwtracing/ptt/Kconfig
index 6d46a09ffeb91992..96ee94a5d5b9fab8 100644
--- a/drivers/hwtracing/ptt/Kconfig
+++ b/drivers/hwtracing/ptt/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config HISI_PTT
 	tristate "HiSilicon PCIe Tune and Trace Device"
-	depends on ARM64 || (COMPILE_TEST && 64BIT)
+	depends on ARCH_HISI || (COMPILE_TEST && 64BIT)
 	depends on PCI && HAS_DMA && HAS_IOMEM && PERF_EVENTS
 	help
 	  HiSilicon PCIe Tune and Trace device exists as a PCIe RCiEP
-- 
2.25.1

