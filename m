Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD5D46E8C39
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 10:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234147AbjDTIIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 04:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234328AbjDTIIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 04:08:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D25011A
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 01:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681978049;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=oiFbyJM/OVQzht3NVRAuOeDRCZOh3MADqrY1DUOhLSk=;
        b=W44CJRy1XCEmXAOJfq1j1i8m5ot2mGt1/2t049S0Ole+PcZSGboZCJuxwb2GlCXXMFv63r
        VDYWN4Kpvf9W3bXUOJrvR3NTCF9eE/evJ8DPK5/SLV8lXGBRNdRstU8eWoiGots2GWHAsc
        T1tAdKarT5V7HKV1cCBJLXaqi5xpAGI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-180-oMS7FFhqMkiBaKPbv7BaSg-1; Thu, 20 Apr 2023 04:07:25 -0400
X-MC-Unique: oMS7FFhqMkiBaKPbv7BaSg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B9BB329AB405;
        Thu, 20 Apr 2023 08:07:24 +0000 (UTC)
Received: from cantor.redhat.com (unknown [10.2.16.45])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DA9DD1121315;
        Thu, 20 Apr 2023 08:07:23 +0000 (UTC)
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     iommu@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Joerg Roedel <joro@8bytes.org>
Subject: [PATCH] iommu: amd: Use page mode macros in fetch_pte
Date:   Thu, 20 Apr 2023 01:07:18 -0700
Message-Id: <20230420080718.523132-1-jsnitsel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the page mode macros instead of magic numbers in fetch_pte.

Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: Joerg Roedel <joro@8bytes.org>
Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
---
 drivers/iommu/amd/io_pgtable.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/io_pgtable.c b/drivers/iommu/amd/io_pgtable.c
index ace0e9b8b913..61a99d715b23 100644
--- a/drivers/iommu/amd/io_pgtable.c
+++ b/drivers/iommu/amd/io_pgtable.c
@@ -310,8 +310,8 @@ static u64 *fetch_pte(struct amd_io_pgtable *pgtable,
 			return NULL;
 
 		/* Large PTE */
-		if (PM_PTE_LEVEL(*pte) == 7 ||
-		    PM_PTE_LEVEL(*pte) == 0)
+		if (PM_PTE_LEVEL(*pte) == PAGE_MODE_7_LEVEL ||
+		    PM_PTE_LEVEL(*pte) == PAGE_MODE_NONE)
 			break;
 
 		/* No level skipping support yet */
-- 
2.38.1

