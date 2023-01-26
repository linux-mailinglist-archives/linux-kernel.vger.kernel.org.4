Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B812C67D421
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 19:26:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232020AbjAZS0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 13:26:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbjAZS0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 13:26:34 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AA0A0677A7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 10:26:33 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 216944B3;
        Thu, 26 Jan 2023 10:27:15 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2FF463F71E;
        Thu, 26 Jan 2023 10:26:32 -0800 (PST)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org, will@kernel.org
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org, hch@lst.de,
        jgg@nvidia.com, baolu.lu@linux.intel.com
Subject: [PATCH v2 3/8] iommu: Add lockdep annotations for group list iterators
Date:   Thu, 26 Jan 2023 18:26:18 +0000
Message-Id: <57cba0cf89556d586e554a9c64cbd28205d67c5c.1674753627.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.36.1.dirty
In-Reply-To: <cover.1674753627.git.robin.murphy@arm.com>
References: <cover.1674753627.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before we add any more common helpers for iterating or otherwise
accessing the group device list, let's start the good habit of
annotating their locking expectations for robustness.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v2: New. Note that I've left the group_pasid helpers, since they're
    pretty much right next to where the relevant locking happens, and
    highly unlikely to be reused from anywhere else anyway.

 drivers/iommu/iommu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index d48e5499e0fa..77f076030995 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -20,6 +20,7 @@
 #include <linux/iommu.h>
 #include <linux/idr.h>
 #include <linux/err.h>
+#include <linux/lockdep.h>
 #include <linux/pci.h>
 #include <linux/pci-ats.h>
 #include <linux/bitops.h>
@@ -1100,6 +1101,7 @@ static int iommu_group_device_count(struct iommu_group *group)
 	struct group_device *entry;
 	int ret = 0;
 
+	lockdep_assert_held(&group->mutex);
 	list_for_each_entry(entry, &group->devices, list)
 		ret++;
 
@@ -1112,6 +1114,7 @@ static int __iommu_group_for_each_dev(struct iommu_group *group, void *data,
 	struct group_device *device;
 	int ret = 0;
 
+	lockdep_assert_held(&group->mutex);
 	list_for_each_entry(device, &group->devices, list) {
 		ret = fn(device->dev, data);
 		if (ret)
-- 
2.36.1.dirty

