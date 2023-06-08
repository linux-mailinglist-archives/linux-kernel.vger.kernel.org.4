Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A5607274F6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 04:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233257AbjFHCWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 22:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233153AbjFHCWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 22:22:47 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 7E26D1BE2
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 19:22:45 -0700 (PDT)
Received: from localhost.localdomain (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id E2E3E1801128CB;
        Thu,  8 Jun 2023 10:20:42 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   Su Hui <suhui@nfschina.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     kevin.tian@intel.com, vasant.hegde@amd.com, jgg@ziepe.ca,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        Su Hui <suhui@nfschina.com>
Subject: [PATCH v2] iommu/amd: Fix possible memory leak of 'domain'
Date:   Thu,  8 Jun 2023 10:19:34 +0800
Message-Id: <20230608021933.856045-1-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move allocation code down to avoid memory leak.

Fixes: 29f54745f245 ("iommu/amd: Add missing domain type checks")
Signed-off-by: Su Hui <suhui@nfschina.com>
---
Changes in v2:
	change code order is better and more consistent with other
drivers. 
 drivers/iommu/amd/iommu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index dc1ec6849775..e8a2e5984acb 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2078,10 +2078,6 @@ static struct protection_domain *protection_domain_alloc(unsigned int type)
 	int mode = DEFAULT_PGTABLE_LEVEL;
 	int ret;
 
-	domain = kzalloc(sizeof(*domain), GFP_KERNEL);
-	if (!domain)
-		return NULL;
-
 	/*
 	 * Force IOMMU v1 page table when iommu=pt and
 	 * when allocating domain for pass-through devices.
@@ -2097,6 +2093,10 @@ static struct protection_domain *protection_domain_alloc(unsigned int type)
 		return NULL;
 	}
 
+	domain = kzalloc(sizeof(*domain), GFP_KERNEL);
+	if (!domain)
+		return NULL;
+
 	switch (pgtable) {
 	case AMD_IOMMU_V1:
 		ret = protection_domain_init_v1(domain, mode);
-- 
2.30.2

