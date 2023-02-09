Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0100168FC5C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 02:04:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbjBIBEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 20:04:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbjBIBED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 20:04:03 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 323C812851
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 17:04:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=1Gyq1awD3AbR7Lmv5tDTtOp1bGuIK/qy5UCH4ZKCpzA=; b=1GgKQNB2tG2kDejzQFjuAu3yN5
        z8j3w1kG6dBKT1aUQuDghMF/AWfUGHK8U2OL6+Za4vKT0ixlEw9u/+D7f6hBRrzJujGurz7iEnT6V
        9PYOvG2TfVF+auVMWC37/K8SitvGzaI00PfwUzew7BOvbTk9/LrdC+HBtsYpsJkWehTOKWBRrlGkc
        EYjzqGWsmqdVINhybhqg5+izd59iHqb1Z/X+NgumiBIMxoymv1pLoHN+VPPMUeP5JFlGTgwQWp3N4
        GkHW2UwQC1Bla9wMWyTfSGV3WV5LIEkbd3kaZQBD97L19WGbRBijfIzVsvcmr21DaWmKLJGgrYWc2
        sfD6dQuA==;
Received: from [2601:1c2:980:9ec0::df2f] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pPvM0-00HMPI-44; Thu, 09 Feb 2023 01:04:00 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Thierry Reding <treding@nvidia.com>,
        Joerg Roedel <jroedel@suse.de>, Will Deacon <will@kernel.org>,
        iommu@lists.linux.dev
Subject: [PATCH] iommu/of: mark an unused function as __maybe_unused
Date:   Wed,  8 Feb 2023 17:03:59 -0800
Message-Id: <20230209010359.23831-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_OF_ADDRESS is not set, there is a build warning/error
about an unused function.
Annotate the function to quieten the warning/error.

../drivers/iommu/of_iommu.c:176:29: warning: 'iommu_resv_region_get_type' defined but not used [-Wunused-function]
  176 | static enum iommu_resv_type iommu_resv_region_get_type(struct device *dev, struct resource *phys,
      |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~

Fixes: a5bf3cfce8cb ("iommu: Implement of_iommu_get_resv_regions()")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Thierry Reding <treding@nvidia.com>
Cc: Joerg Roedel <jroedel@suse.de>
Cc: Will Deacon <will@kernel.org>
Cc: iommu@lists.linux.dev
---
 drivers/iommu/of_iommu.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff -- a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -173,8 +173,9 @@ const struct iommu_ops *of_iommu_configu
 	return ops;
 }
 
-static enum iommu_resv_type iommu_resv_region_get_type(struct device *dev, struct resource *phys,
-						       phys_addr_t start, size_t length)
+static enum iommu_resv_type __maybe_unused iommu_resv_region_get_type(struct device *dev,
+						struct resource *phys,
+						phys_addr_t start, size_t length)
 {
 	phys_addr_t end = start + length - 1;
 
