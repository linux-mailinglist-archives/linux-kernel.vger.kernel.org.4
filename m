Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F72D717609
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 07:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbjEaFRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 01:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjEaFRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 01:17:44 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A4BEE;
        Tue, 30 May 2023 22:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1685510263; x=1717046263;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=94X5Z+UvPJK1zi7w2X/0f3fQtNDeUM/fnP+10RCVJro=;
  b=kvn/giNfJNJxwLMUjJQlLuk3Yqw+eSsas78rMDw92txge3cBeHTGmqoj
   VVDzBKqQJg7MFlThbd5WXBbs++d7IUkAa3Fkdqvr1u8ljRV5lUoeIsBPU
   LC/+tcHOXDgPxWtYEwoiFMgoBu3uK1mkvyMcX7kRyXNdZ5Rs2U3Bu9aVw
   /PU1rh/pzBYQsfMEuKbhcLL6r1dl5rY91AJKsYtUYjhSs85mvh5ST/7As
   EphoRoPJlGwrjhSdMgzr3GuSzJfXwg/EUsL0aiBzuhiqzj7IlRbgpoxmj
   /y4TvhcXPMlRd4NeyynUdzRBnicnufF6RU2+f7+Eq8bSwER+nxX+vZ0GL
   w==;
X-IronPort-AV: E=Sophos;i="6.00,205,1681142400"; 
   d="scan'208";a="231960727"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 31 May 2023 13:17:43 +0800
IronPort-SDR: ZYNbjkDNMDsZTou9fpQp32sqjT2FOZGNzpFWezEJTFhOrEd5T1I835zqgnWsfNs5l6+dAFvP1G
 nQRjSw+OwZRcr9uvMQ8Roxw4F5mT622GYCasXltpg4xqTs2WWXavXZvdpQkIkeU0YH80RXfqUq
 3CLYR0nNmA02vnRwv+xAnWDRNt235BZ8WER8Ei38hCSEngmdgVQ6O1mEnE7U4YkRt7uyFTUw6J
 SETvAi1evS6hoQ97+VOP8aOIKq1/KINr6V1MYHDuQw5C3m2kQh7mb+U7HexhuO2uiwwpg+v3ie
 Zig=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 May 2023 21:26:52 -0700
IronPort-SDR: OUobx68EAOXv7s/RHNxh1zp+W2kjrB1dIFEge/xKAIPIJcKTYtUBsf31xNLn8wfBsWU97OJJG2
 pc9iLzUHlsY41RfBWBFZYMHsrOZQRZktnklKy0f1J1L8a1gUlkSaqjpOFGBZ2TgWDHBD5gmQVw
 PFACZdlASZlrFirmz4B9AToVhcY7N1HwHG/KPvY+E8ufTTU5CL+pYtmekcTp823Qlx3Aq45hOc
 Nd9wpXDBPpu+0L5Kjm1jT5zgFJdM2y8va17cgRVe8GpcH/MYFqcrtYSr32zk0hzA9E8X47g+vD
 ZBg=
WDCIronportException: Internal
Received: from bxygm33.ad.shared ([10.45.31.229])
  by uls-op-cesaip02.wdc.com with ESMTP; 30 May 2023 22:17:39 -0700
From:   Avri Altman <avri.altman@wdc.com>
To:     "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Keoseong Park <keosung.park@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bean Huo <beanhuo@micron.com>,
        Stanley Chu <stanley.chu@mediatek.com>
Subject: [PATCH v2] scsi: ufs: core: Do not open code SZ_x
Date:   Wed, 31 May 2023 08:17:13 +0300
Message-Id: <20230531051713.2080-1-avri.altman@wdc.com>
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

v1 -> v2: Attend UTMRD as well

A tad cleanup - No functional change.

Signed-off-by: Avri Altman <avri.altman@wdc.com>
Reviewed-by: Bean Huo <beanhuo@micron.com>
Reviewed-by: Stanley Chu <stanley.chu@mediatek.com>
---
 drivers/ufs/core/ufshcd.c | 10 +++++-----
 include/ufs/ufshci.h      |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index fdf5073c7c6c..10a10f8f0bd1 100644
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
@@ -3797,7 +3797,7 @@ static int ufshcd_memory_alloc(struct ufs_hba *hba)
 						    &hba->utmrdl_dma_addr,
 						    GFP_KERNEL);
 	if (!hba->utmrdl_base_addr ||
-	    WARN_ON(hba->utmrdl_dma_addr & (1024 - 1))) {
+	    WARN_ON(hba->utmrdl_dma_addr & (SZ_1K - 1))) {
 		dev_err(hba->dev,
 		"Task Management Descriptor Memory allocation failed\n");
 		goto out;
@@ -8760,7 +8760,7 @@ static const struct scsi_host_template ufshcd_driver_template = {
 	.cmd_per_lun		= UFSHCD_CMD_PER_LUN,
 	.can_queue		= UFSHCD_CAN_QUEUE,
 	.max_segment_size	= PRDT_DATA_BYTE_COUNT_MAX,
-	.max_sectors		= (1 << 20) / SECTOR_SIZE, /* 1 MiB */
+	.max_sectors		= SZ_1M / SECTOR_SIZE,
 	.max_host_blocked	= 1,
 	.track_queue_depth	= 1,
 	.skip_settle_delay	= 1,
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

