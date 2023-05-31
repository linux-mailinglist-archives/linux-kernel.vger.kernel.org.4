Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28C8E717769
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 09:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234221AbjEaHAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 03:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234178AbjEaHAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 03:00:31 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE101191;
        Wed, 31 May 2023 00:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1685516422; x=1717052422;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YXpx3yM4Suqm0VCw9TdB9UswMWJVrTNbcmDdWnEz2nk=;
  b=jyASKr1X+A2YUSxUutovPetHciG7f8dOJW9sBXIh6AhT/anSLMCDt2Lk
   aYiBZm0F9TN1ZfbQq62lGosg8z5cfoTiOljpWgfU5vdXBPMBqnqJ7J4uA
   DKkPAMnyo9af8Ig4ruhK9pktBoD+oK3R8YbrD0xB7/5XFWuxQJFvzrLNz
   nbujYjpH/baRezTzTcgUZhjcJVGlqgoVpxJYkP0LYmpKU+k3Ke4JlIvPE
   2aWblwD6hSa+KroAEW5Ck4dZKX9xEMKzx5kQC4zUBT45zMaUR0+Li+j4+
   52n1IHqiS6IFeoxuhNaakrUohjM05zMyKvbawxpogr5ZPn60jKRhi0qrF
   A==;
X-IronPort-AV: E=Sophos;i="6.00,205,1681142400"; 
   d="scan'208";a="232046476"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 31 May 2023 15:00:22 +0800
IronPort-SDR: w8+4n6OVNRbQJ5B1ovaG7Uc5t4k8rvKXR+8aQOTqviXZ0hyB9dfLp5UWV5MRoPuB2Agjq+uP6B
 Dc3nNXFodhLAmEAoVQCeF05PXT5XldTEXYIIV2iaRlOlNYKc+7QkMzYRjfTiKaws+2d1e+mN7M
 76WGTN1+sKpfYTdtcD+L7RgqM223zvedLTfnItEVA9t6TifwQrLoFX9xUIPeYaYkHa2NCE+ktU
 eVP50eKp5/Rk8l3ok+X/cpuxzx9gLULb7jtEk6vcJG2iCI7RqG39YL5epYsr0thgtVjgUg1kKV
 VVI=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 May 2023 23:15:14 -0700
IronPort-SDR: I0TsztWyONMduGLihP2HSwXpPfaPukw/UYTuRo8ZJyV6gNYo6s/rJ04IWd1huNrbn3Qjr7vTih
 NhACNHzRQXHJgmWJHXVOXm1D2bMijTGy5EKVs4TX2LLxURNQ9SvPsFiElncA6muMqV1GYxf1xj
 m6i9u23kjuHSd0vZSKW+TP8lFfa5dm4C+uLEdvfrQhRq5kQLHauO+duSccG0anXRB4ftsBuyFs
 fhfJsi/nsXDnYwyebJt7w1catiAKDQ7J4Fh615K6CbBRufYKTkXbBl1m0uM5uVyRKeatIPDfs2
 +RQ=
WDCIronportException: Internal
Received: from bxygm33.ad.shared ([10.45.31.229])
  by uls-op-cesaip02.wdc.com with ESMTP; 31 May 2023 00:00:19 -0700
From:   Avri Altman <avri.altman@wdc.com>
To:     "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Keoseong Park <keosung.park@samsung.com>,
        "Bao D . Nguyen" <quic_nguyenb@quicinc.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bean Huo <beanhuo@micron.com>,
        Stanley Chu <stanley.chu@mediatek.com>
Subject: [PATCH v3] scsi: ufs: core: Do not open code SZ_x
Date:   Wed, 31 May 2023 10:00:09 +0300
Message-Id: <20230531070009.4593-1-avri.altman@wdc.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2 -> v3: few more
v1 -> v2: Attend UTMRD as well

A tad cleanup - No functional change.

Signed-off-by: Avri Altman <avri.altman@wdc.com>
Reviewed-by: Bean Huo <beanhuo@micron.com>
Reviewed-by: Stanley Chu <stanley.chu@mediatek.com>
Reviewed-by: Keoseong Park <keosung.park@samsung.com>
---
 drivers/ufs/core/ufshcd.c     | 14 +++++++-------
 drivers/ufs/core/ufshpb.c     |  6 +++---
 drivers/ufs/core/ufshpb.h     |  2 +-
 drivers/ufs/host/ufs-exynos.c |  2 +-
 drivers/ufs/host/ufs-hisi.c   | 24 ++++++++++++------------
 include/ufs/ufshci.h          |  2 +-
 6 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index fdf5073c7c6c..2c938713bcd0 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -2519,7 +2519,7 @@ static void ufshcd_sgl_to_prdt(struct ufs_hba *hba, struct ufshcd_lrb *lrbp, int
 			 * 11b to indicate Dword granularity. A value of '3'
 			 * indicates 4 bytes, '7' indicates 8 bytes, etc."
 			 */
-			WARN_ONCE(len > 256 * 1024, "len = %#x\n", len);
+			WARN_ONCE(len > SZ_256K, "len = %#x\n", len);
 			prd->size = cpu_to_le32(len - 1);
 			prd->addr = cpu_to_le64(sg->dma_address);
 			prd->reserved = 0;
@@ -3765,7 +3765,7 @@ static int ufshcd_memory_alloc(struct ufs_hba *hba)
 
 	/*
 	 * Allocate memory for UTP Transfer descriptors
-	 * UFSHCI requires 1024 byte alignment of UTRD
+	 * UFSHCI requires 1KB alignment of UTRD
 	 */
 	utrdl_size = (sizeof(struct utp_transfer_req_desc) * hba->nutrs);
 	hba->utrdl_base_addr = dmam_alloc_coherent(hba->dev,
@@ -3773,7 +3773,7 @@ static int ufshcd_memory_alloc(struct ufs_hba *hba)
 						   &hba->utrdl_dma_addr,
 						   GFP_KERNEL);
 	if (!hba->utrdl_base_addr ||
-	    WARN_ON(hba->utrdl_dma_addr & (1024 - 1))) {
+	    WARN_ON(hba->utrdl_dma_addr & (SZ_1K - 1))) {
 		dev_err(hba->dev,
 			"Transfer Descriptor Memory allocation failed\n");
 		goto out;
@@ -3789,7 +3789,7 @@ static int ufshcd_memory_alloc(struct ufs_hba *hba)
 		goto skip_utmrdl;
 	/*
 	 * Allocate memory for UTP Task Management descriptors
-	 * UFSHCI requires 1024 byte alignment of UTMRD
+	 * UFSHCI requires 1KB alignment of UTMRD
 	 */
 	utmrdl_size = sizeof(struct utp_task_req_desc) * hba->nutmrs;
 	hba->utmrdl_base_addr = dmam_alloc_coherent(hba->dev,
@@ -3797,7 +3797,7 @@ static int ufshcd_memory_alloc(struct ufs_hba *hba)
 						    &hba->utmrdl_dma_addr,
 						    GFP_KERNEL);
 	if (!hba->utmrdl_base_addr ||
-	    WARN_ON(hba->utmrdl_dma_addr & (1024 - 1))) {
+	    WARN_ON(hba->utmrdl_dma_addr & (SZ_1K - 1))) {
 		dev_err(hba->dev,
 		"Task Management Descriptor Memory allocation failed\n");
 		goto out;
@@ -5134,7 +5134,7 @@ static int ufshcd_slave_configure(struct scsi_device *sdev)
 
 	blk_queue_update_dma_pad(q, PRDT_DATA_BYTE_COUNT_PAD - 1);
 	if (hba->quirks & UFSHCD_QUIRK_4KB_DMA_ALIGNMENT)
-		blk_queue_update_dma_alignment(q, 4096 - 1);
+		blk_queue_update_dma_alignment(q, SZ_4K - 1);
 	/*
 	 * Block runtime-pm until all consumers are added.
 	 * Refer ufshcd_setup_links().
@@ -8760,7 +8760,7 @@ static const struct scsi_host_template ufshcd_driver_template = {
 	.cmd_per_lun		= UFSHCD_CMD_PER_LUN,
 	.can_queue		= UFSHCD_CAN_QUEUE,
 	.max_segment_size	= PRDT_DATA_BYTE_COUNT_MAX,
-	.max_sectors		= (1 << 20) / SECTOR_SIZE, /* 1 MiB */
+	.max_sectors		= SZ_1M / SECTOR_SIZE,
 	.max_host_blocked	= 1,
 	.track_queue_depth	= 1,
 	.skip_settle_delay	= 1,
diff --git a/drivers/ufs/core/ufshpb.c b/drivers/ufs/core/ufshpb.c
index a46a7666c891..255f8b38d0c2 100644
--- a/drivers/ufs/core/ufshpb.c
+++ b/drivers/ufs/core/ufshpb.c
@@ -30,7 +30,7 @@ static struct kmem_cache *ufshpb_mctx_cache;
 static mempool_t *ufshpb_mctx_pool;
 static mempool_t *ufshpb_page_pool;
 /* A cache size of 2MB can cache ppn in the 1GB range. */
-static unsigned int ufshpb_host_map_kbytes = 2048;
+static unsigned int ufshpb_host_map_kbytes = SZ_2K;
 static int tot_active_srgn_pages;
 
 static struct workqueue_struct *ufshpb_wq;
@@ -2461,7 +2461,7 @@ static void ufshpb_hpb_lu_prepared(struct ufs_hba *hba)
 
 	init_success = !ufshpb_check_hpb_reset_query(hba);
 
-	pool_size = PAGE_ALIGN(ufshpb_host_map_kbytes * 1024) / PAGE_SIZE;
+	pool_size = PAGE_ALIGN(ufshpb_host_map_kbytes * SZ_1K) / PAGE_SIZE;
 	if (pool_size > tot_active_srgn_pages) {
 		mempool_resize(ufshpb_mctx_pool, tot_active_srgn_pages);
 		mempool_resize(ufshpb_page_pool, tot_active_srgn_pages);
@@ -2527,7 +2527,7 @@ static int ufshpb_init_mem_wq(struct ufs_hba *hba)
 		return -ENOMEM;
 	}
 
-	pool_size = PAGE_ALIGN(ufshpb_host_map_kbytes * 1024) / PAGE_SIZE;
+	pool_size = PAGE_ALIGN(ufshpb_host_map_kbytes * SZ_1K) / PAGE_SIZE;
 	dev_info(hba->dev, "%s:%d ufshpb_host_map_kbytes %u pool_size %u\n",
 	       __func__, __LINE__, ufshpb_host_map_kbytes, pool_size);
 
diff --git a/drivers/ufs/core/ufshpb.h b/drivers/ufs/core/ufshpb.h
index 0d6e6004d783..b428bbdd2799 100644
--- a/drivers/ufs/core/ufshpb.h
+++ b/drivers/ufs/core/ufshpb.h
@@ -25,7 +25,7 @@
 
 /* hpb map & entries macro */
 #define HPB_RGN_SIZE_UNIT			512
-#define HPB_ENTRY_BLOCK_SIZE			4096
+#define HPB_ENTRY_BLOCK_SIZE			SZ_4K
 #define HPB_ENTRY_SIZE				0x8
 #define PINNED_NOT_SET				U32_MAX
 
diff --git a/drivers/ufs/host/ufs-exynos.c b/drivers/ufs/host/ufs-exynos.c
index 0bf5390739e1..d56840447bd0 100644
--- a/drivers/ufs/host/ufs-exynos.c
+++ b/drivers/ufs/host/ufs-exynos.c
@@ -1306,7 +1306,7 @@ static int exynos_ufs_hce_enable_notify(struct ufs_hba *hba,
 		 * (ufshcd_async_scan()). Note: this callback may also be called
 		 * from other functions than ufshcd_init().
 		 */
-		hba->host->max_segment_size = 4096;
+		hba->host->max_segment_size = SZ_4K;
 
 		if (ufs->drv_data->pre_hce_enable) {
 			ret = ufs->drv_data->pre_hce_enable(ufs);
diff --git a/drivers/ufs/host/ufs-hisi.c b/drivers/ufs/host/ufs-hisi.c
index 4c423eba8aa9..1e1d388f359a 100644
--- a/drivers/ufs/host/ufs-hisi.c
+++ b/drivers/ufs/host/ufs-hisi.c
@@ -335,29 +335,29 @@ static void ufs_hisi_pwr_change_pre_change(struct ufs_hba *hba)
 	/* PA_TxSkip */
 	ufshcd_dme_set(hba, UIC_ARG_MIB(0x155c), 0x0);
 	/*PA_PWRModeUserData0 = 8191, default is 0*/
-	ufshcd_dme_set(hba, UIC_ARG_MIB(0x15b0), 8191);
+	ufshcd_dme_set(hba, UIC_ARG_MIB(0x15b0), SZ_8K - 1);
 	/*PA_PWRModeUserData1 = 65535, default is 0*/
-	ufshcd_dme_set(hba, UIC_ARG_MIB(0x15b1), 65535);
+	ufshcd_dme_set(hba, UIC_ARG_MIB(0x15b1), SZ_64K - 1);
 	/*PA_PWRModeUserData2 = 32767, default is 0*/
-	ufshcd_dme_set(hba, UIC_ARG_MIB(0x15b2), 32767);
+	ufshcd_dme_set(hba, UIC_ARG_MIB(0x15b2), SZ_32K - 1);
 	/*DME_FC0ProtectionTimeOutVal = 8191, default is 0*/
-	ufshcd_dme_set(hba, UIC_ARG_MIB(0xd041), 8191);
+	ufshcd_dme_set(hba, UIC_ARG_MIB(0xd041), SZ_8K - 1);
 	/*DME_TC0ReplayTimeOutVal = 65535, default is 0*/
-	ufshcd_dme_set(hba, UIC_ARG_MIB(0xd042), 65535);
+	ufshcd_dme_set(hba, UIC_ARG_MIB(0xd042), SZ_64K - 1);
 	/*DME_AFC0ReqTimeOutVal = 32767, default is 0*/
-	ufshcd_dme_set(hba, UIC_ARG_MIB(0xd043), 32767);
+	ufshcd_dme_set(hba, UIC_ARG_MIB(0xd043), SZ_32K - 1);
 	/*PA_PWRModeUserData3 = 8191, default is 0*/
-	ufshcd_dme_set(hba, UIC_ARG_MIB(0x15b3), 8191);
+	ufshcd_dme_set(hba, UIC_ARG_MIB(0x15b3), SZ_8K - 1);
 	/*PA_PWRModeUserData4 = 65535, default is 0*/
-	ufshcd_dme_set(hba, UIC_ARG_MIB(0x15b4), 65535);
+	ufshcd_dme_set(hba, UIC_ARG_MIB(0x15b4), SZ_64K - 1);
 	/*PA_PWRModeUserData5 = 32767, default is 0*/
-	ufshcd_dme_set(hba, UIC_ARG_MIB(0x15b5), 32767);
+	ufshcd_dme_set(hba, UIC_ARG_MIB(0x15b5), SZ_32K - 1);
 	/*DME_FC1ProtectionTimeOutVal = 8191, default is 0*/
-	ufshcd_dme_set(hba, UIC_ARG_MIB(0xd044), 8191);
+	ufshcd_dme_set(hba, UIC_ARG_MIB(0xd044), SZ_8K - 1);
 	/*DME_TC1ReplayTimeOutVal = 65535, default is 0*/
-	ufshcd_dme_set(hba, UIC_ARG_MIB(0xd045), 65535);
+	ufshcd_dme_set(hba, UIC_ARG_MIB(0xd045), SZ_64K - 1);
 	/*DME_AFC1ReqTimeOutVal = 32767, default is 0*/
-	ufshcd_dme_set(hba, UIC_ARG_MIB(0xd046), 32767);
+	ufshcd_dme_set(hba, UIC_ARG_MIB(0xd046), SZ_32K - 1);
 }
 
 static int ufs_hisi_pwr_change_notify(struct ufs_hba *hba,
diff --git a/include/ufs/ufshci.h b/include/ufs/ufshci.h
index 11424bb03814..db2d5db5c88e 100644
--- a/include/ufs/ufshci.h
+++ b/include/ufs/ufshci.h
@@ -453,7 +453,7 @@ enum {
 };
 
 /* The maximum length of the data byte count field in the PRDT is 256KB */
-#define PRDT_DATA_BYTE_COUNT_MAX	(256 * 1024)
+#define PRDT_DATA_BYTE_COUNT_MAX	SZ_256K
 /* The granularity of the data byte count field in the PRDT is 32-bit */
 #define PRDT_DATA_BYTE_COUNT_PAD	4
 
-- 
2.40.0

