Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 418EA722493
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 13:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbjFEL3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 07:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231789AbjFEL3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 07:29:47 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18376DF
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 04:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685964586; x=1717500586;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xTKbEBDDCXHkiOwFc8keR7O1v8qG4g2CVMGkrh5HwGY=;
  b=F4qmDLinHiPUi1r4HMGClI4bzPYB+Idiyoie6zQ+StyadjzFnt507zoT
   ByhdC/xvn6WnMPXEmBr5FHaZFR94BRmzrXd6aE2LVzSqKoxB753EQ6JFJ
   J3araf93lCAoe39ah6s+y5QjRNp+JjvSCzgptwyUdCPfUeIKZFUR6LmwH
   rLONSxUgBH5uF3NrCKRjdRK2H8j9WiAItQDaiMfEcK67HzsAILVu3iev0
   YUd+BoADalqgZ6xEeWI4jk3SoavhfzWK5IF/aY4KkW/twlQhO1CxCYCHo
   oyLu9UHYNZbN1yg8QbyPwzZaWkgVpXks/TgEb56PO5M+Fxi3b/slq7jFI
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="336699349"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="336699349"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 04:29:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="708626664"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="708626664"
Received: from tower.bj.intel.com ([10.238.157.62])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 04:29:43 -0700
From:   Yanfei Xu <yanfei.xu@intel.com>
To:     dwmw2@infradead.org, baolu.lu@linux.intel.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        yanfei.xu@intel.com
Subject: [PATCH v3 1/2] iommu/vt-d: Handle the failure case of dmar_reenable_qi()
Date:   Mon,  5 Jun 2023 19:26:58 +0800
Message-Id: <20230605112659.308981-2-yanfei.xu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230605112659.308981-1-yanfei.xu@intel.com>
References: <20230605112659.308981-1-yanfei.xu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dmar_reenable_qi() may not succeed. Check and return when it fails.

Signed-off-by: Yanfei Xu <yanfei.xu@intel.com>
---
 drivers/iommu/intel/iommu.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 8096273b034c..c13c6475b626 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2967,10 +2967,15 @@ static int init_iommu_hw(void)
 {
 	struct dmar_drhd_unit *drhd;
 	struct intel_iommu *iommu = NULL;
+	int ret;
 
-	for_each_active_iommu(iommu, drhd)
-		if (iommu->qi)
-			dmar_reenable_qi(iommu);
+	for_each_active_iommu(iommu, drhd) {
+		if (iommu->qi) {
+			ret = dmar_reenable_qi(iommu);
+			if (ret)
+				return ret;
+		}
+	}
 
 	for_each_iommu(iommu, drhd) {
 		if (drhd->ignored) {
-- 
2.34.1

