Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D72436D59BC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 09:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233701AbjDDHer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 03:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjDDHeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 03:34:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2BBB137
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 00:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680593641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=/5C/yOSwsdBflA8qC2A6ywwjDfEDFy/JAgkrHH95HtM=;
        b=LjjeHvTi6SD+pusjfiYe/9M6eXRNHCUOMPfjRYibGEIwzMXOVUm6P92IpfgVNSE1y5N9PC
        zb94kDaNC06xVd+dAO26UZ0w+jnynokMLPS/ZjVpg1BzmxwlRvGrSwqMcLiS/FqV5JS0Ee
        yP+OX3moMBM54bfLnTM4pNLx8TRdzT8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-155-VhQV1HVlNiqg9xFomLDR7w-1; Tue, 04 Apr 2023 03:27:46 -0400
X-MC-Unique: VhQV1HVlNiqg9xFomLDR7w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7EC733C1014A;
        Tue,  4 Apr 2023 07:27:45 +0000 (UTC)
Received: from cantor.redhat.com (unknown [10.2.16.124])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6F68A440BC;
        Tue,  4 Apr 2023 07:27:44 +0000 (UTC)
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Cc:     Vasant Hegde <vasant.hegde@amd.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>
Subject: [PATCH] iommu: amd: Set page size bitmap during V2 domain allocation
Date:   Tue,  4 Apr 2023 00:27:42 -0700
Message-Id: <20230404072742.1895252-1-jsnitsel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the addition of the V2 page table support, the domain page size
bitmap needs to be set prior to iommu core setting up direct mappings
for reserved regions. When reserved regions are mapped, if this is not
done, it will be looking at the V1 page size bitmap when determining
the page size to use in iommu_pgsize(). When it gets into the actual
amd mapping code, a check of see if the page size is supported can
fail, because at that point it is checking it against the V2 page size
bitmap which only supports 4K, 2M, and 1G.

Add a check to __iommu_domain_alloc() to not override the
bitmap if it was already set by the iommu ops domain_alloc() code path.

Cc: Vasant Hegde <vasant.hegde@amd.com>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Joerg Roedel <joro@8bytes.org>
Fixes: 4db6c41f0946 ("iommu/amd: Add support for using AMD IOMMU v2 page table for DMA-API")
Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
---
 drivers/iommu/amd/iommu.c | 6 ++----
 drivers/iommu/iommu.c     | 9 +++++++--
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 5a505ba5467e..167da5b1a5e3 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1666,10 +1666,6 @@ static void do_attach(struct iommu_dev_data *dev_data,
 	domain->dev_iommu[iommu->index] += 1;
 	domain->dev_cnt                 += 1;
 
-	/* Override supported page sizes */
-	if (domain->flags & PD_GIOV_MASK)
-		domain->domain.pgsize_bitmap = AMD_IOMMU_PGSIZES_V2;
-
 	/* Update device table */
 	set_dte_entry(iommu, dev_data->devid, domain,
 		      ats, dev_data->iommu_v2);
@@ -2048,6 +2044,8 @@ static int protection_domain_init_v2(struct protection_domain *domain)
 
 	domain->flags |= PD_GIOV_MASK;
 
+	domain->domain.pgsize_bitmap = AMD_IOMMU_PGSIZES_V2;
+
 	if (domain_enable_v2(domain, 1)) {
 		domain_id_free(domain->id);
 		return -ENOMEM;
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 10db680acaed..256a38371120 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1964,8 +1964,13 @@ static struct iommu_domain *__iommu_domain_alloc(struct bus_type *bus,
 		return NULL;
 
 	domain->type = type;
-	/* Assume all sizes by default; the driver may override this later */
-	domain->pgsize_bitmap = bus->iommu_ops->pgsize_bitmap;
+	/*
+	 * If not already set, assume all sizes by default; the driver
+	 * may override this later
+	 */
+	if (!domain->pgsize_bitmap)
+		domain->pgsize_bitmap = bus->iommu_ops->pgsize_bitmap;
+
 	if (!domain->ops)
 		domain->ops = bus->iommu_ops->default_domain_ops;
 
-- 
2.38.1

