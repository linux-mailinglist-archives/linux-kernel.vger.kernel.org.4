Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3DE5FDD40
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 17:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiJMPeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 11:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiJMPeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 11:34:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 345A089CF1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 08:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665675248;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=b9+V6R7tFlbeiwac+o//rSY61pCcgVEQM77YrZbvp4g=;
        b=R9MrUHYaCTR94E9Rc3uLa4tg9GNUD37kRxdv8huKsqVHz0G0lUbHd7qH1qSfGuiaDp2L/b
        Kq6ImK7Hg1v2ybfvm2zFnOANC3uTEK+Q4v6p+WqoPp8CsEZayay7ePuW/YF0b8kyJ5rEvN
        JCwzR1VSv6YSCb84XFMiFp+nq/lN0d4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-658-mhXDiGpFPbyJlSVFSPWONA-1; Thu, 13 Oct 2022 11:34:07 -0400
X-MC-Unique: mhXDiGpFPbyJlSVFSPWONA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 58D8C2A5955A;
        Thu, 13 Oct 2022 15:34:06 +0000 (UTC)
Received: from cantor.redhat.com (unknown [10.2.16.57])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CAD6140C8461;
        Thu, 13 Oct 2022 15:33:57 +0000 (UTC)
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [RFC PATCH] iommu/vt-d: Add sanity check to iommu_sva_bind_device()
Date:   Thu, 13 Oct 2022 08:33:55 -0700
Message-Id: <20221013153355.2365865-1-jsnitsel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

iommu_sva_bind_device() should only be called if
iommu_dev_enable_feature() succeeded. There has been one case already
where that hasn't been the case, which resulted in a null pointer
deref in dev_iommu_ops(). To avoid that happening in the future if
another driver makes that mistake, sanity check dev->iommu and
dev->iommu->iommu_dev prior to calling dev_iommu_ops().

Cc: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
---
drivers/iommu/iommu.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 4893c2429ca5..20ec75667529 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2746,7 +2746,15 @@ iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, void *drvdata)
 {
 	struct iommu_group *group;
 	struct iommu_sva *handle = ERR_PTR(-EINVAL);
-	const struct iommu_ops *ops = dev_iommu_ops(dev);
+	const struct iommu_ops *ops;
+
+	if (!dev->iommu || !dev->iommu->iommu_dev) {
+		dev_warn(dev, "%s called without checking succes of iommu_dev_enable_feature?\n",
+			__func__);
+		return ERR_PTR(-ENODEV);
+	}
+
+	ops = dev_iommu_ops(dev);
 
 	if (!ops->sva_bind)
 		return ERR_PTR(-ENODEV);
-- 
2.37.2

