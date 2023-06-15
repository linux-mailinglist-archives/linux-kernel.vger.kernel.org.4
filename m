Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD0777320A5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 22:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234225AbjFOUK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 16:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231580AbjFOUKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 16:10:50 -0400
X-Greylist: delayed 10831 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 15 Jun 2023 13:10:49 PDT
Received: from s.wrqvwxzv.outbound-mail.sendgrid.net (s.wrqvwxzv.outbound-mail.sendgrid.net [149.72.154.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3067E12E
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 13:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
        h=from:subject:in-reply-to:references:mime-version:to:cc:
        content-transfer-encoding:content-type:cc:content-type:from:subject:to;
        s=s1; bh=InoMtFPn0qTi9rWJ9dL8ZNuMI6SUv/MQcYAVE6/OKuo=;
        b=HiCP8luTDml4dCPktTvI4G2UlOh2JqkOCf/aGXztdfKU9pDKYRW1eYvbwGA77RClrwUq
        ALcRzlSdAjaPwSy12HtHnldT3u/ghdJxx8AVijFBmON6CitofS5IIg7T6xmDyCL9r8mkYu
        Pn31l4ZYbpCyYAuAjOtSgiIJN/+HHf9XwCoLUOJJrkMwkO3KKAIKmdl2Qq0X7c8PnkPNEX
        EeSiTxErTQHQW384TL3a/ErkaCV3oCRTFsTRw9DEepQHGT6MwvTCaRveHm1JBEjtURvBfm
        hKsrYjTBfjHGnjzSrfnZVxqNmPSVEmMiTMVwrX81/HPVVZMCn0HNbhG71JEU7dTw==
Received: by filterdrecv-84b96456cb-bvsrh with SMTP id filterdrecv-84b96456cb-bvsrh-1-648B7046-1F
        2023-06-15 20:10:46.550315811 +0000 UTC m=+3097935.073942733
Received: from bionic.localdomain (unknown)
        by geopod-ismtpd-5 (SG)
        with ESMTP
        id iwNkUP0QQjuksV59p23YJg
        Thu, 15 Jun 2023 20:10:46.259 +0000 (UTC)
From:   Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 1/3] iommu: rockchip: Fix discovery table address encoding
Date:   Thu, 15 Jun 2023 20:10:46 +0000 (UTC)
Message-Id: <20230615201042.2291867-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230615201042.2291867-1-jonas@kwiboo.se>
References: <20230615201042.2291867-1-jonas@kwiboo.se>
MIME-Version: 1.0
X-SG-EID: =?us-ascii?Q?TdbjyGynYnRZWhH+7lKUQJL+ZxmxpowvO2O9SQF5CwCVrYgcwUXgU5DKUU3QxA?=
 =?us-ascii?Q?fZekEeQsTe+RrMu3cja6a0h2WrMIoUX2Eyj8rSF?=
 =?us-ascii?Q?yVoSoz7tVbeJqQR7WFNCHUyheNyk=2FbPq147L39v?=
 =?us-ascii?Q?x2smspVWTq7LOi9K7FyO33CWUW1L7UiSaro3wMB?=
 =?us-ascii?Q?CdxO2VJSfXHJfvm1Oh7s5cScqDRccDPhGy2gEmB?=
 =?us-ascii?Q?QKp=2FRRiy+o0MFVJA6pbeFvloXVXsQ2Ry82eSPX?=
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jonas Karlman <jonas@kwiboo.se>, Joerg Roedel <jroedel@suse.de>
X-Entity-ID: P7KYpSJvGCELWjBME/J5tg==
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_BL_SPAMCOP_NET,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The address to the discovery table is currently encoded using the
following bit layout.

 31:12 - Address bit 31:0
 11: 4 - Address bit 39:32

This is also the bit layout used by the vendor kernel.

However, testing has shown that addresses to the discovery/page tables
and memory pages are all encoded using the same bit layout.

IOMMU v1:
 31:12 - Address bit 31:0

IOMMU v2:
 31:12 - Address bit 31:0
 11: 8 - Address bit 35:32
  7: 4 - Address bit 39:36

Change to use the mk_dtentries ops to encode the discovery table address
correctly. Also update the bit layout comment for the page address.

These changes render the dte_addr_phys and dma_addr_dte ops unused
and will be removed in a following patch.

Fixes: 227014b33f62 ("iommu: rockchip: Add internal ops to handle variants")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2:
- replace currently with correctly in commit message

 drivers/iommu/rockchip-iommu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index 4054030c3237..d46319f77e5c 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -278,8 +278,8 @@ static u32 rk_mk_pte(phys_addr_t page, int prot)
 /*
  * In v2:
  * 31:12 - Page address bit 31:0
- *  11:9 - Page address bit 34:32
- *   8:4 - Page address bit 39:35
+ * 11: 8 - Page address bit 35:32
+ *  7: 4 - Page address bit 39:36
  *     3 - Security
  *     2 - Writable
  *     1 - Readable
@@ -577,7 +577,7 @@ static void log_iova(struct rk_iommu *iommu, int index, dma_addr_t iova)
 	page_offset = rk_iova_page_offset(iova);
 
 	mmu_dte_addr = rk_iommu_read(base, RK_MMU_DTE_ADDR);
-	mmu_dte_addr_phys = rk_ops->dte_addr_phys(mmu_dte_addr);
+	mmu_dte_addr_phys = rk_ops->pt_address(mmu_dte_addr);
 
 	dte_addr_phys = mmu_dte_addr_phys + (4 * dte_index);
 	dte_addr = phys_to_virt(dte_addr_phys);
@@ -967,7 +967,7 @@ static int rk_iommu_enable(struct rk_iommu *iommu)
 
 	for (i = 0; i < iommu->num_mmu; i++) {
 		rk_iommu_write(iommu->bases[i], RK_MMU_DTE_ADDR,
-			       rk_ops->dma_addr_dte(rk_domain->dt_dma));
+			       rk_ops->mk_dtentries(rk_domain->dt_dma));
 		rk_iommu_base_command(iommu->bases[i], RK_MMU_CMD_ZAP_CACHE);
 		rk_iommu_write(iommu->bases[i], RK_MMU_INT_MASK, RK_MMU_IRQ_MASK);
 	}
-- 
2.40.1

