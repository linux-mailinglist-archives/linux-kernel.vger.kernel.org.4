Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDA8260F350
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 11:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235383AbiJ0JLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 05:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235282AbiJ0JKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 05:10:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BDC734716
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 02:10:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9CD8062237
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 09:10:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CD5EC433D6;
        Thu, 27 Oct 2022 09:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666861830;
        bh=Qaxj1nZeuG+aVWYd4CtRyuAwL6cY1PqVxtIBhtixJQo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t4e34kMb+U8dXhEp/mB18wWn3/9U+N8u9fcvnyO2b5xIbGt5pt67D1wE4cVLoTbdP
         EE6iqcJrPr5swyQSS/k++kIPGtlIBTW0ebrjmycCjfLHc1uNCPhQiTRD0dm2SY75Xd
         LydMMtwQY9hrR0tgEKcOMWX0dAb3P/xtNcXg+GwMXBzqCZeT8559OICaxAE/6ByktL
         /Nia1qDiVX+dYDaCI0lIJQsZyT6qTFuAUpPyIi1wummn3j09QLEhU+Nem7WaNwW87z
         ECMLmgXcS21effqikSru/ltW5DDSfrjgxTr6KMkVdAjyxmQQqnVBBBk0JczOfCEYA8
         NlVsMn+7avt4Q==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH 13/15] habanalabs: fix PCIe access to SRAM via debugfs
Date:   Thu, 27 Oct 2022 12:10:05 +0300
Message-Id: <20221027091007.664797-13-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221027091007.664797-1-ogabbay@kernel.org>
References: <20221027091007.664797-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomer Tayar <ttayar@habana.ai>

hl_access_sram_dram_region() uses a region base which is set within the
hl_set_dram_bar() function. However, for SRAM access this function is
not called, and we end up with a wrong value of region base and with a
bad calculated address.
Fix it by initializing the region base value independently of whether
hl_set_dram_bar() is called or not.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/device.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index 61ddcb1ce508..cb8ecc17bba1 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -69,17 +69,17 @@ int hl_access_sram_dram_region(struct hl_device *hdev, u64 addr, u64 *val,
 	enum debugfs_access_type acc_type, enum pci_region region_type, bool set_dram_bar)
 {
 	struct pci_mem_region *region = &hdev->pci_mem_region[region_type];
-	u64 old_base = 0, rc, new_bar_region_base = 0;
+	u64 old_base = 0, rc, bar_region_base = region->region_base;
 	void __iomem *acc_addr;
 
 	if (set_dram_bar) {
-		old_base = hl_set_dram_bar(hdev, addr, region, &new_bar_region_base);
+		old_base = hl_set_dram_bar(hdev, addr, region, &bar_region_base);
 		if (old_base == U64_MAX)
 			return -EIO;
 	}
 
 	acc_addr = hdev->pcie_bar[region->bar_id] + region->offset_in_bar +
-			(addr - new_bar_region_base);
+			(addr - bar_region_base);
 
 	switch (acc_type) {
 	case DEBUGFS_READ8:
-- 
2.25.1

