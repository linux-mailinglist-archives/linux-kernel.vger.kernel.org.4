Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32992715797
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 09:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbjE3HvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 03:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjE3HvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 03:51:08 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12FDAE58;
        Tue, 30 May 2023 00:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1685433048; x=1716969048;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=W2RJCAhGRPaAGBO95KvplbcQKgF5ovbdTVy+xWn2k3M=;
  b=pdr2cNblqvCBxxdJakDjEUvQLPXYDpS2ixKSJe0zwUY8O4LVtWTDXw52
   a1mtULmNcA9Ih4p1eV2suhLzu3q+N3nzdRVYpCD1ksl4uD2C4BlHLBvnm
   GFR4kUPOo3PNhP1c5DJgvOwl9eJoNjSY2qk/Qrc5cwb3bwEcazuAvNDfz
   TnhbkAHPn1NgYApPjN4ecnN58ZV+EVKKvlBm2rROE1Wz6KjyN0Rf/Fwl0
   wZuUQr/V2q2oGyAiDPXVUh0sfQ8HiRIh2iKnaYVa45ju1nxk4YreS75zs
   1IVtgOaw8mss9015ZCnoP2s3xLP7Fy3oCphpVPsjtLbxRjN3S1GzO+eIp
   g==;
X-IronPort-AV: E=Sophos;i="6.00,203,1681142400"; 
   d="scan'208";a="231871569"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 30 May 2023 15:50:47 +0800
IronPort-SDR: RxpAn2xnF5aYozWyv6SkTGapNbE5ni6TbOnlTMm33VXnTKrT5xRFN3bd+v6/TpS6QVewXyr6c/
 IaQ146CFeTK98NuiO7jZQ3cM7uaJi+9SfvXuCmhtT/p8gnBd6GmYIeypBkNk7qsDAgUc8JIV1A
 vmFqX9ctjkn7x92+qjinfpkt1oSRe6JewNn+d+dkDjcB1jCU9mQS9vdj+39S4n083ZfySuXdY6
 rctPZ07dRsyVGEm5qD2jJRlCU/zhudo6DyzMCz4F+ozZ6Ja/rdUJx1HLdw1jsskD6EsyJtS3uq
 hcs=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 May 2023 00:00:00 -0700
IronPort-SDR: Hi/ewd4lS/E07568jT+oGMB4pKs7YvpTq1Cre3NYnTwM55i7s1pSNVhvm1HrVBjxTwzKvW/dWk
 iVeNbyhuGWkR9qaEbDuYDUDTwnykA4SNktkASB5cgxkGNYrcyDqqyE+G0DgWvWn8BX+ag2g+7h
 XpfmV6oWbZFWir9daDKn3q0eSyVh/0WzoPxYeDmb/fzxvyizy2q77aI4f4Pe7eYls4YmWaZatP
 ejt779MtgTbzjPMaBI0lqcJZP+CyoxS4Bhf8fVBTfb7fSUkCHD8jnf8+q/AGM7d4FjcN+m6HW8
 4BQ=
WDCIronportException: Internal
Received: from bxygm33.ad.shared ([10.45.31.229])
  by uls-op-cesaip02.wdc.com with ESMTP; 30 May 2023 00:50:45 -0700
From:   Avri Altman <avri.altman@wdc.com>
To:     "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Avri Altman <avri.altman@wdc.com>
Subject: [PATCH] scsi: ufs: core: Do not open code SZ_x
Date:   Tue, 30 May 2023 10:50:33 +0300
Message-Id: <20230530075033.11006-1-avri.altman@wdc.com>
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

A tad cleanup - No functional change.

Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 drivers/ufs/core/ufshcd.c | 8 ++++----
 include/ufs/ufshci.h      | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index fdf5073c7c6c..1f206bd453cf 100644
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

