Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8EC7320A6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 22:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234129AbjFOULB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 16:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbjFOUKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 16:10:51 -0400
Received: from s.wrqvtbkv.outbound-mail.sendgrid.net (s.wrqvtbkv.outbound-mail.sendgrid.net [149.72.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94771BDB
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 13:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
        h=from:subject:in-reply-to:references:mime-version:to:cc:
        content-transfer-encoding:content-type:cc:content-type:from:subject:to;
        s=s1; bh=/qL4tWH5vlfUGDltwgczmV318twf9yMJvn1JbUu8GiY=;
        b=Oci/zWt4tgI1SRFLzpYzM1/YhWgKLN++0kQB/UrIyGdcxHE9JjapDGiGKk4efPOZLgf9
        R3H+LI+3oeIyEUf+h2WAi9ni5//WfQGwSAOruYTyMjLZS5z3IuPi3t7QGAWKacHelM1JwA
        7GwXbbL37UEi/aTaJ4i8eNECvwYkE4hYAhicBv4gsVPMGDUyGaK/IuBCSYfExxwi2L2kOY
        eyOA7DEIvALtozWTqML2K25reBwoAKSVs0boFeBnvry3XNkLXJkcWncRpR5tcQo8v4Td1x
        CKAvvto5ebEeVCvNt4wjGv+O/wcCEI1T53uGb/wFi1PFtZ1I10XNtddq1ouhDF+A==
Received: by filterdrecv-65f68489c8-xfp5j with SMTP id filterdrecv-65f68489c8-xfp5j-1-648B7048-2B
        2023-06-15 20:10:48.817052942 +0000 UTC m=+3098087.423003092
Received: from bionic.localdomain (unknown)
        by geopod-ismtpd-5 (SG)
        with ESMTP
        id UaAYmYNhTEmHCxT9KxKCWA
        Thu, 15 Jun 2023 20:10:48.624 +0000 (UTC)
From:   Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 3/3] iommu: rockchip: Allocate tables from all available
 memory
Date:   Thu, 15 Jun 2023 20:10:49 +0000 (UTC)
Message-Id: <20230615201042.2291867-4-jonas@kwiboo.se>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230615201042.2291867-1-jonas@kwiboo.se>
References: <20230615201042.2291867-1-jonas@kwiboo.se>
MIME-Version: 1.0
X-SG-EID: =?us-ascii?Q?TdbjyGynYnRZWhH+7lKUQJL+ZxmxpowvO2O9SQF5CwCVrYgcwUXgU5DKUU3QxA?=
 =?us-ascii?Q?fZekEeQsTe+RrMu3cja6a0hwSnsPxsggRhT=2FD+A?=
 =?us-ascii?Q?9yEtkGRht4pdol+jy3k6QpCorymp5gRwI4WQaU7?=
 =?us-ascii?Q?3dOcXB8iUX5JPwAso4KvAGCmmGsdC8xW80R1JvI?=
 =?us-ascii?Q?Q=2FXn9yJjPjX=2FuSKbOcTHJdEbgtge3ity=2F2paIrx?=
 =?us-ascii?Q?XuUf=2FVgpsldhx8UNlWhCA7ZO7dIxRgoy2Qtyb9?=
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jonas Karlman <jonas@kwiboo.se>
X-Entity-ID: P7KYpSJvGCELWjBME/J5tg==
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_BL_SPAMCOP_NET,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Newer Rockchip SoCs, RK356x and RK3588, support more then 4GB of memory.
However, the RK IOMMU driver is using the GFP_DMA32 flag to limit
allocation of the discovery and page tables into memory below 4GB.

Let's remove this limitation now that the discovery table address is
correctly configured for addresses above 4GB.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2:
- no change

 drivers/iommu/rockchip-iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index 62be9bf42390..46498fc382ee 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -727,7 +727,7 @@ static u32 *rk_dte_get_page_table(struct rk_iommu_domain *rk_domain,
 	if (rk_dte_is_pt_valid(dte))
 		goto done;
 
-	page_table = (u32 *)get_zeroed_page(GFP_ATOMIC | GFP_DMA32);
+	page_table = (u32 *)get_zeroed_page(GFP_ATOMIC);
 	if (!page_table)
 		return ERR_PTR(-ENOMEM);
 
@@ -1076,7 +1076,7 @@ static struct iommu_domain *rk_iommu_domain_alloc(unsigned type)
 	 * Each level1 (dt) and level2 (pt) table has 1024 4-byte entries.
 	 * Allocate one 4 KiB page for each table.
 	 */
-	rk_domain->dt = (u32 *)get_zeroed_page(GFP_KERNEL | GFP_DMA32);
+	rk_domain->dt = (u32 *)get_zeroed_page(GFP_KERNEL);
 	if (!rk_domain->dt)
 		goto err_free_domain;
 
-- 
2.40.1

