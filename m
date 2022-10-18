Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0E0C602CA0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 15:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbiJRNOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 09:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiJRNOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 09:14:16 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7C949C7070;
        Tue, 18 Oct 2022 06:14:15 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 79216113E;
        Tue, 18 Oct 2022 06:14:21 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0A0383F792;
        Tue, 18 Oct 2022 06:14:13 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     rafael@kernel.org
Cc:     lvjianmin@loongson.cn, yangyicong@huawei.com,
        lpieralisi@kernel.org, chenhuacai@loongson.cn,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        lenb@kernel.org, jeremy.linton@arm.com
Subject: [PATCH] ACPI: scan: Fix DMA range assignment
Date:   Tue, 18 Oct 2022 14:14:04 +0100
Message-Id: <e94f99cfe09a64c590f009d21c566339117394e2.1666098844.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.36.1.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Assigning the device's dma_range_map from the iterator variable after
the loop means it always points to the empty terminator at the end of
the map, which is not what we want. Similarly, freeing the iterator on
error when it points to somwhere in the middle of the allocated array
won't work either. Fix this.

Fixes: bf2ee8d0c385 ("ACPI: scan: Support multiple DMA windows with different offsets")
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/acpi/scan.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 558664d169fc..024cc373a197 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1509,9 +1509,12 @@ int acpi_dma_get_range(struct device *dev, const struct bus_dma_region **map)
 			goto out;
 		}
 
+		*map = r;
+
 		list_for_each_entry(rentry, &list, node) {
 			if (rentry->res->start >= rentry->res->end) {
-				kfree(r);
+				kfree(*map);
+				*map = NULL;
 				ret = -EINVAL;
 				dev_dbg(dma_dev, "Invalid DMA regions configuration\n");
 				goto out;
@@ -1523,8 +1526,6 @@ int acpi_dma_get_range(struct device *dev, const struct bus_dma_region **map)
 			r->offset = rentry->offset;
 			r++;
 		}
-
-		*map = r;
 	}
  out:
 	acpi_dev_free_resource_list(&list);
-- 
2.36.1.dirty

