Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B61C6DD36D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 08:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbjDKGvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 02:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbjDKGu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 02:50:59 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F07421F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 23:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681195822; x=1712731822;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tiukwRnefzsk0G3cv6MPqdFvIODlX3L3N/gwsxTD9ak=;
  b=TYYmQlf23hKJlTZzzU/jBNfNjkpByVzD5po2+SkVTTo6BFrhfPXwxSgP
   5GOt5+DDR+DuhLorLkJFQ5OA8aIgBEqj7y90w9k7fA5NzCZlIK2sVjtuT
   6njGOqZ2CnieccwCmUSlhZFBPMPj/+QI2zJZ8arY/HSO9+LCscqY4VwH1
   g3SBkXgvAIRW5gtCXnSXHXoBZzr+orSk/sFZzeDqkc23KwUsy36Rxkj8D
   r7OIfn8oWRh5Mii6rEHHLCV8BGMnkQbEgCbl25aXN6DNaim67UZnbxz6S
   yHemX15qNV3nBS1wjLcgdtcPuBWkOhf4zPxINfiQ072ftcF+RoPJGUqUa
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="341028633"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="341028633"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2023 23:48:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="1018256657"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="1018256657"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmsmga005.fm.intel.com with ESMTP; 10 Apr 2023 23:48:44 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Vinod Koul <vkoul@kernel.org>, Tina Zhang <tina.zhang@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 16/17] iommu/vt-d: Remove a useless BUG_ON(dev->is_virtfn)
Date:   Tue, 11 Apr 2023 14:48:14 +0800
Message-Id: <20230411064815.31456-17-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230411064815.31456-1-baolu.lu@linux.intel.com>
References: <20230411064815.31456-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tina Zhang <tina.zhang@intel.com>

When dmar_alloc_pci_notify_info() is being invoked, the invoker has
ensured the dev->is_virtfn is false. So, remove the useless BUG_ON in
dmar_alloc_pci_notify_info().

Signed-off-by: Tina Zhang <tina.zhang@intel.com>
Link: https://lore.kernel.org/r/20230406065944.2773296-7-tina.zhang@intel.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/dmar.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index f0f51c957ccb..9346c6e7ebae 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -127,8 +127,6 @@ dmar_alloc_pci_notify_info(struct pci_dev *dev, unsigned long event)
 	struct pci_dev *tmp;
 	struct dmar_pci_notify_info *info;
 
-	BUG_ON(dev->is_virtfn);
-
 	/*
 	 * Ignore devices that have a domain number higher than what can
 	 * be looked up in DMAR, e.g. VMD subdevices with domain 0x10000
-- 
2.34.1

