Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E80470A1BD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 23:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbjESVZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 17:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjESVZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 17:25:37 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1903DCF;
        Fri, 19 May 2023 14:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1684531529;
        bh=094Puwu8vIezV8RK/4d0Dgvl5Ma8uw6FQGF92DXq06Q=;
        h=Message-ID:Subject:From:To:Date:From;
        b=QEeTAToK4iZo36U9cWzSZbJA1+hpdoCE7fOllsscIQG+2wAz0bC6PsbzfEVHWPY3y
         C/ojGyuRVybUu1Z0HWKD4LUSeOaX+Jvv7Ora79qmmj3E9S0gvUnxbmAOX8nT2xdlTo
         t1ta3RUmVSxBJ7m82SCPZT/AVEsTjAU2SlKWrJqE=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id F1AD81289E47;
        Fri, 19 May 2023 17:25:29 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id 3rvcKCwLSxje; Fri, 19 May 2023 17:25:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1684531529;
        bh=094Puwu8vIezV8RK/4d0Dgvl5Ma8uw6FQGF92DXq06Q=;
        h=Message-ID:Subject:From:To:Date:From;
        b=QEeTAToK4iZo36U9cWzSZbJA1+hpdoCE7fOllsscIQG+2wAz0bC6PsbzfEVHWPY3y
         C/ojGyuRVybUu1Z0HWKD4LUSeOaX+Jvv7Ora79qmmj3E9S0gvUnxbmAOX8nT2xdlTo
         t1ta3RUmVSxBJ7m82SCPZT/AVEsTjAU2SlKWrJqE=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 54F611289E43;
        Fri, 19 May 2023 17:25:29 -0400 (EDT)
Message-ID: <2238c5b07fdbaca34f4fdba4ad6c79ee3d214c7c.camel@HansenPartnership.com>
Subject: [GIT PULL] SCSI fixes for 6.4-rc2
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Fri, 19 May 2023 17:25:27 -0400
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Six small fixes.  Four in drivers and the two core changes should be
read together as a correction to a prior iorequest_cnt fix that exposed
us to a potential use after free. 

The patch is available here:

git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

The short changelog is:

Michael Kelley (1):
      scsi: storvsc: Don't pass unused PFNs to Hyper-V host

Po-Wen Kao (3):
      scsi: ufs: core: Fix MCQ nr_hw_queues
      scsi: ufs: core: Rename symbol sizeof_utp_transfer_cmd_desc()
      scsi: ufs: core: Fix MCQ tag calculation

Wenchao Hao (2):
      scsi: core: Decrease scsi_device's iorequest_cnt if dispatch failed
      scsi: Revert "scsi: core: Do not increase scsi_device's iorequest_cnt if dispatch failed"

And the diffstat:

 drivers/scsi/scsi_lib.c    |  5 ++++-
 drivers/scsi/storvsc_drv.c |  8 ++++----
 drivers/ufs/core/ufs-mcq.c |  5 +++--
 drivers/ufs/core/ufshcd.c  | 10 +++++-----
 include/ufs/ufshcd.h       |  2 +-
 5 files changed, 17 insertions(+), 13 deletions(-)

With full diff below.

James

---

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index b7c569a42aa4..0226c9279cef 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1463,6 +1463,8 @@ static int scsi_dispatch_cmd(struct scsi_cmnd *cmd)
 	struct Scsi_Host *host = cmd->device->host;
 	int rtn = 0;
 
+	atomic_inc(&cmd->device->iorequest_cnt);
+
 	/* check if the device is still usable */
 	if (unlikely(cmd->device->sdev_state == SDEV_DEL)) {
 		/* in SDEV_DEL we error all commands. DID_NO_CONNECT
@@ -1483,6 +1485,7 @@ static int scsi_dispatch_cmd(struct scsi_cmnd *cmd)
 		 */
 		SCSI_LOG_MLQUEUE(3, scmd_printk(KERN_INFO, cmd,
 			"queuecommand : device blocked\n"));
+		atomic_dec(&cmd->device->iorequest_cnt);
 		return SCSI_MLQUEUE_DEVICE_BUSY;
 	}
 
@@ -1515,6 +1518,7 @@ static int scsi_dispatch_cmd(struct scsi_cmnd *cmd)
 	trace_scsi_dispatch_cmd_start(cmd);
 	rtn = host->hostt->queuecommand(host, cmd);
 	if (rtn) {
+		atomic_dec(&cmd->device->iorequest_cnt);
 		trace_scsi_dispatch_cmd_error(cmd, rtn);
 		if (rtn != SCSI_MLQUEUE_DEVICE_BUSY &&
 		    rtn != SCSI_MLQUEUE_TARGET_BUSY)
@@ -1761,7 +1765,6 @@ static blk_status_t scsi_queue_rq(struct blk_mq_hw_ctx *hctx,
 		goto out_dec_host_busy;
 	}
 
-	atomic_inc(&cmd->device->iorequest_cnt);
 	return BLK_STS_OK;
 
 out_dec_host_busy:
diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index d9ce379c4d2e..e6bc622954cf 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -1780,7 +1780,7 @@ static int storvsc_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *scmnd)
 
 	length = scsi_bufflen(scmnd);
 	payload = (struct vmbus_packet_mpb_array *)&cmd_request->mpb;
-	payload_sz = sizeof(cmd_request->mpb);
+	payload_sz = 0;
 
 	if (scsi_sg_count(scmnd)) {
 		unsigned long offset_in_hvpg = offset_in_hvpage(sgl->offset);
@@ -1789,10 +1789,10 @@ static int storvsc_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *scmnd)
 		unsigned long hvpfn, hvpfns_to_add;
 		int j, i = 0, sg_count;
 
-		if (hvpg_count > MAX_PAGE_BUFFER_COUNT) {
+		payload_sz = (hvpg_count * sizeof(u64) +
+			      sizeof(struct vmbus_packet_mpb_array));
 
-			payload_sz = (hvpg_count * sizeof(u64) +
-				      sizeof(struct vmbus_packet_mpb_array));
+		if (hvpg_count > MAX_PAGE_BUFFER_COUNT) {
 			payload = kzalloc(payload_sz, GFP_ATOMIC);
 			if (!payload)
 				return SCSI_MLQUEUE_DEVICE_BUSY;
diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
index 202ff71e1b58..51b3c6ae781d 100644
--- a/drivers/ufs/core/ufs-mcq.c
+++ b/drivers/ufs/core/ufs-mcq.c
@@ -150,7 +150,8 @@ static int ufshcd_mcq_config_nr_queues(struct ufs_hba *hba)
 	u32 hba_maxq, rem, tot_queues;
 	struct Scsi_Host *host = hba->host;
 
-	hba_maxq = FIELD_GET(MAX_QUEUE_SUP, hba->mcq_capabilities);
+	/* maxq is 0 based value */
+	hba_maxq = FIELD_GET(MAX_QUEUE_SUP, hba->mcq_capabilities) + 1;
 
 	tot_queues = UFS_MCQ_NUM_DEV_CMD_QUEUES + read_queues + poll_queues +
 			rw_queues;
@@ -265,7 +266,7 @@ static int ufshcd_mcq_get_tag(struct ufs_hba *hba,
 	addr = (le64_to_cpu(cqe->command_desc_base_addr) & CQE_UCD_BA) -
 		hba->ucdl_dma_addr;
 
-	return div_u64(addr, sizeof(struct utp_transfer_cmd_desc));
+	return div_u64(addr, ufshcd_get_ucd_size(hba));
 }
 
 static void ufshcd_mcq_process_cqe(struct ufs_hba *hba,
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 45fd374fe56c..e7e79f515e14 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -2849,10 +2849,10 @@ static void ufshcd_map_queues(struct Scsi_Host *shost)
 static void ufshcd_init_lrb(struct ufs_hba *hba, struct ufshcd_lrb *lrb, int i)
 {
 	struct utp_transfer_cmd_desc *cmd_descp = (void *)hba->ucdl_base_addr +
-		i * sizeof_utp_transfer_cmd_desc(hba);
+		i * ufshcd_get_ucd_size(hba);
 	struct utp_transfer_req_desc *utrdlp = hba->utrdl_base_addr;
 	dma_addr_t cmd_desc_element_addr = hba->ucdl_dma_addr +
-		i * sizeof_utp_transfer_cmd_desc(hba);
+		i * ufshcd_get_ucd_size(hba);
 	u16 response_offset = offsetof(struct utp_transfer_cmd_desc,
 				       response_upiu);
 	u16 prdt_offset = offsetof(struct utp_transfer_cmd_desc, prd_table);
@@ -3761,7 +3761,7 @@ static int ufshcd_memory_alloc(struct ufs_hba *hba)
 	size_t utmrdl_size, utrdl_size, ucdl_size;
 
 	/* Allocate memory for UTP command descriptors */
-	ucdl_size = sizeof_utp_transfer_cmd_desc(hba) * hba->nutrs;
+	ucdl_size = ufshcd_get_ucd_size(hba) * hba->nutrs;
 	hba->ucdl_base_addr = dmam_alloc_coherent(hba->dev,
 						  ucdl_size,
 						  &hba->ucdl_dma_addr,
@@ -3861,7 +3861,7 @@ static void ufshcd_host_memory_configure(struct ufs_hba *hba)
 	prdt_offset =
 		offsetof(struct utp_transfer_cmd_desc, prd_table);
 
-	cmd_desc_size = sizeof_utp_transfer_cmd_desc(hba);
+	cmd_desc_size = ufshcd_get_ucd_size(hba);
 	cmd_desc_dma_addr = hba->ucdl_dma_addr;
 
 	for (i = 0; i < hba->nutrs; i++) {
@@ -8452,7 +8452,7 @@ static void ufshcd_release_sdb_queue(struct ufs_hba *hba, int nutrs)
 {
 	size_t ucdl_size, utrdl_size;
 
-	ucdl_size = sizeof(struct utp_transfer_cmd_desc) * nutrs;
+	ucdl_size = ufshcd_get_ucd_size(hba) * nutrs;
 	dmam_free_coherent(hba->dev, ucdl_size, hba->ucdl_base_addr,
 			   hba->ucdl_dma_addr);
 
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index f7553293ba98..df1d04f7a542 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -1133,7 +1133,7 @@ static inline size_t ufshcd_sg_entry_size(const struct ufs_hba *hba)
 	({ (void)(hba); BUILD_BUG_ON(sg_entry_size != sizeof(struct ufshcd_sg_entry)); })
 #endif
 
-static inline size_t sizeof_utp_transfer_cmd_desc(const struct ufs_hba *hba)
+static inline size_t ufshcd_get_ucd_size(const struct ufs_hba *hba)
 {
 	return sizeof(struct utp_transfer_cmd_desc) + SG_ALL * ufshcd_sg_entry_size(hba);
 }

