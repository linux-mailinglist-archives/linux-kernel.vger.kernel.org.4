Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EAC85F0611
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 09:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbiI3Hxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 03:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbiI3Hx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 03:53:27 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FAC215ED33
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 00:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664524384; x=1696060384;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vhsp8GlSHDd8/AmhSlTSi78LT62QfZBL8pEfN0JGc3E=;
  b=ZlIo6rCPazbYYzp6DgB0/m59logGWcswDtKqs5U+bVjGkV3DaP4zdhqa
   ZazL/7ZvVUyVRcP+hWMdIiGe7x4K4wDxSIINL012aibcjEb4SRSq+9B/X
   qMWq1tAwKYzA9g/AEvnjOl09ekNlZjqBYrkaZGQdhkWCKgYFxBhNABpOD
   IhU5z36PBNb/nMmqgGGzMfooAh/YhZRfKajaF1i/R1W2JkUoL+uKHnvev
   LObWBBpInpkWRzgI5zd+u01s/mN+5NV2b3Dw8dePyewzLJbcIa+u7/UQ1
   nvRF8kFoy9M7zCMqGuc6RtsJW3qoR7fdw8j5CUSYFKFTt4ePIOF2BT0nl
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="388409726"
X-IronPort-AV: E=Sophos;i="5.93,357,1654585200"; 
   d="scan'208";a="388409726"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2022 00:53:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="765046044"
X-IronPort-AV: E=Sophos;i="5.93,357,1654585200"; 
   d="scan'208";a="765046044"
Received: from skxmcp01.bj.intel.com ([10.240.193.86])
  by fmsmga001.fm.intel.com with ESMTP; 30 Sep 2022 00:49:55 -0700
From:   Yu Zhang <yu.c.zhang@linux.intel.com>
To:     joro@8bytes.org, will@kernel.org, robin.murphy@arm.com
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] iommu: remove useless parameter in iommu_bus_init().
Date:   Fri, 30 Sep 2022 15:02:02 +0800
Message-Id: <20220930070202.105663-1-yu.c.zhang@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Parameter 'ops' is no longer used by iommu_bus_init(), after
commit 8cec63e52966 ("iommu: Remove iommu_callback_data").

So just remove it.

Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
---
 drivers/iommu/iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 3a808146b50f..bedda1e0f016 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1775,7 +1775,7 @@ int bus_iommu_probe(struct bus_type *bus)
 	return ret;
 }
 
-static int iommu_bus_init(struct bus_type *bus, const struct iommu_ops *ops)
+static int iommu_bus_init(struct bus_type *bus)
 {
 	struct notifier_block *nb;
 	int err;
@@ -1836,7 +1836,7 @@ int bus_set_iommu(struct bus_type *bus, const struct iommu_ops *ops)
 	bus->iommu_ops = ops;
 
 	/* Do IOMMU specific setup for this bus-type */
-	err = iommu_bus_init(bus, ops);
+	err = iommu_bus_init(bus);
 	if (err)
 		bus->iommu_ops = NULL;
 
-- 
2.25.1

