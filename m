Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4F95EC49E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 15:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232573AbiI0NgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 09:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231827AbiI0NgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 09:36:07 -0400
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC0E41983
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 06:36:05 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed50:d95b:5c9b:4085:7c0d])
        by michel.telenet-ops.be with bizsmtp
        id R1c3280073Qogd1061c30a; Tue, 27 Sep 2022 15:36:04 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1odAkk-006Qe5-HN; Tue, 27 Sep 2022 15:36:02 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1odAkj-000vhD-Vn; Tue, 27 Sep 2022 15:36:02 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Sven Peter <sven@svenpeter.dev>, Janne Grunau <j@jannau.net>,
        Hector Martin <marcan@marcan.st>
Cc:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] iommu/io-pgtable: Make IOMMU_IO_PGTABLE_DART invisible
Date:   Tue, 27 Sep 2022 15:36:01 +0200
Message-Id: <b0981cb5a97452af73b9dd0dd0eb03c5002f7af4.1664285626.git.geert+renesas@glider.be>
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

There is no point in asking the user about both "Apple DART Formats" and
"Apple DART IOMMU Support", as the former is useless without the latter,
and the latter auto-selects the former.

Fixes: 745ef1092bcfcf3b ("iommu/io-pgtable: Move Apple DART support to its own file")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Should IOMMU_IO_PGTABLE_LPAE and IOMMU_IO_PGTABLE_ARMV7S be made
invisible, too?
Are there users that do not select them?
---
 drivers/iommu/Kconfig | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index dc5f7a156ff5ec73..f1affca6022e0a54 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -68,16 +68,13 @@ config IOMMU_IO_PGTABLE_ARMV7S_SELFTEST
 	  If unsure, say N here.
 
 config IOMMU_IO_PGTABLE_DART
-	bool "Apple DART Formats"
+	bool
 	select IOMMU_IO_PGTABLE
-	depends on ARM64 || (COMPILE_TEST && !GENERIC_ATOMIC64)
 	help
 	  Enable support for the Apple DART pagetable formats. These include
 	  the t8020 and t6000/t8110 DART formats used in Apple M1/M2 family
 	  SoCs.
 
-	  If unsure, say N here.
-
 endmenu
 
 config IOMMU_DEBUGFS
-- 
2.25.1

