Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD02C729B78
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 15:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241423AbjFINU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 09:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240396AbjFINUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 09:20:46 -0400
Received: from mail.8bytes.org (mail.8bytes.org [IPv6:2a01:238:42d9:3f00:e505:6202:4f0c:f051])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7E1C54214
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 06:20:30 -0700 (PDT)
Received: from lemmy.home.8bytes.org (p4ff2bfbf.dip0.t-ipconnect.de [79.242.191.191])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id 15A36224B97;
        Fri,  9 Jun 2023 15:20:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1686316829;
        bh=axvTLCs/VkrEYtwl5oudimjwcRrwclSaLs8CTeOkB8o=;
        h=From:To:Cc:Subject:Date:From;
        b=fQXdFALxUVhVcjHlv95huuf9/zaIB1gbt8II7zaUlzsjz6xs/Dr/8QMa7pGU/tWC+
         Y933+8Lk1y+DNkrtWFyFqZ9tp4B9b9R97uekpqxLqUMAB4kkVQ8+TJuoA4/5SpMsvH
         NQF1HPlXQCnuLsG3ZLJabKH/gZrQsaBYG6dlWf1m3FeryGsCo2euygizC2PjPZO16R
         TJVy4LgV0y/qDqrIPc55vPmDl3ZUA5UOf6h9Dse+9qHm3GQUqEZi/RfHXTOaF4NIHN
         j7WyN8vupz5DODVPbLDuIT3dtIhE3/IEm3P5pj9i/TSDYZCok5wg9FTKgWdqBCVRts
         R8jLQ7DWRkk0A==
From:   Joerg Roedel <joro@8bytes.org>
To:     iommu@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH] iommu/amd: Fix compile error for unused function
Date:   Fri,  9 Jun 2023 15:20:13 +0200
Message-Id: <20230609132013.11609-1-joro@8bytes.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

Recent changes introduced a compile error:

drivers/iommu/amd/iommu.c:1285:13: error: ‘iommu_flush_irt_and_complete’ defined but not used [-Werror=unused-function]
 1285 | static void iommu_flush_irt_and_complete(struct amd_iommu *iommu, u16 devid)
      |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~

This happens with defconfig-x86_64 because AMD IOMMU is enabled but
CONFIG_IRQ_REMAP is disabled. Move the function under #ifdef
CONFIG_IRQ_REMAP to fix the error.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/amd/iommu.c | 52 +++++++++++++++++++--------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index e47c8c520708..13097619fc4c 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1275,32 +1275,6 @@ static void amd_iommu_flush_irt_all(struct amd_iommu *iommu)
 	iommu_completion_wait(iommu);
 }
 
-static void iommu_flush_irt_and_complete(struct amd_iommu *iommu, u16 devid)
-{
-	int ret;
-	u64 data;
-	unsigned long flags;
-	struct iommu_cmd cmd, cmd2;
-
-	if (iommu->irtcachedis_enabled)
-		return;
-
-	build_inv_irt(&cmd, devid);
-	data = atomic64_add_return(1, &iommu->cmd_sem_val);
-	build_completion_wait(&cmd2, iommu, data);
-
-	raw_spin_lock_irqsave(&iommu->lock, flags);
-	ret = __iommu_queue_command_sync(iommu, &cmd, true);
-	if (ret)
-		goto out;
-	ret = __iommu_queue_command_sync(iommu, &cmd2, false);
-	if (ret)
-		goto out;
-	wait_on_sem(iommu, data);
-out:
-	raw_spin_unlock_irqrestore(&iommu->lock, flags);
-}
-
 void iommu_flush_all_caches(struct amd_iommu *iommu)
 {
 	if (iommu_feature(iommu, FEATURE_IA)) {
@@ -2831,6 +2805,32 @@ EXPORT_SYMBOL(amd_iommu_device_info);
 static struct irq_chip amd_ir_chip;
 static DEFINE_SPINLOCK(iommu_table_lock);
 
+static void iommu_flush_irt_and_complete(struct amd_iommu *iommu, u16 devid)
+{
+	int ret;
+	u64 data;
+	unsigned long flags;
+	struct iommu_cmd cmd, cmd2;
+
+	if (iommu->irtcachedis_enabled)
+		return;
+
+	build_inv_irt(&cmd, devid);
+	data = atomic64_add_return(1, &iommu->cmd_sem_val);
+	build_completion_wait(&cmd2, iommu, data);
+
+	raw_spin_lock_irqsave(&iommu->lock, flags);
+	ret = __iommu_queue_command_sync(iommu, &cmd, true);
+	if (ret)
+		goto out;
+	ret = __iommu_queue_command_sync(iommu, &cmd2, false);
+	if (ret)
+		goto out;
+	wait_on_sem(iommu, data);
+out:
+	raw_spin_unlock_irqrestore(&iommu->lock, flags);
+}
+
 static void set_dte_irq_entry(struct amd_iommu *iommu, u16 devid,
 			      struct irq_remap_table *table)
 {
-- 
2.40.1

