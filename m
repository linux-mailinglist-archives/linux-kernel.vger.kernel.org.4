Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52A0E6DB5D8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 23:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbjDGVmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 17:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjDGVmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 17:42:13 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE52BBA6
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 14:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1680903728;
        bh=N11iNEj2chynP21eWZ21gOdewyzfyjq67gakjvMjDv4=;
        h=Message-ID:Subject:From:To:Date:From;
        b=so243AGbOwcjhsthxzo0bUPWCSAEwDTAL5ifG0rV5ya+ufpfSv0FuxXCJuBu8D5SA
         1l2fIH1EilfXm6ZE+PkIJRm8N8vWay0bD8aJGn/lq6f7qkwjIn5XRT6l2i4+I/DxAd
         /MHBnYEi6mvoSkP5uHI+rji2jfC3ND1qmWaXKOwY=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 6788612802D4;
        Fri,  7 Apr 2023 17:42:08 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id 9w6ksplEjQaT; Fri,  7 Apr 2023 17:42:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1680903728;
        bh=N11iNEj2chynP21eWZ21gOdewyzfyjq67gakjvMjDv4=;
        h=Message-ID:Subject:From:To:Date:From;
        b=so243AGbOwcjhsthxzo0bUPWCSAEwDTAL5ifG0rV5ya+ufpfSv0FuxXCJuBu8D5SA
         1l2fIH1EilfXm6ZE+PkIJRm8N8vWay0bD8aJGn/lq6f7qkwjIn5XRT6l2i4+I/DxAd
         /MHBnYEi6mvoSkP5uHI+rji2jfC3ND1qmWaXKOwY=
Received: from [IPv6:2601:5c4:4302:c21::a774] (unknown [IPv6:2601:5c4:4302:c21::a774])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id BE44512802AD;
        Fri,  7 Apr 2023 17:42:07 -0400 (EDT)
Message-ID: <255a80b21248110095a4e3a6c993183f1046a4b2.camel@HansenPartnership.com>
Subject: [GIT PULL] SCSI fixes for 6.3-rc5
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Fri, 07 Apr 2023 17:42:04 -0400
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Four small fixes, all in drivers.  They're all one or two lines except
for the ufs one, but that's a simple revert of a previous feature.

The patch is available here:

git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

The short changelog is:

Adrien Thierry (1):
      scsi: Revert "scsi: ufs: core: Initialize devfreq synchronously"

Li Zetao (1):
      scsi: qla2xxx: Fix memory leak in qla2x00_probe_one()

Ranjan Kumar (1):
      scsi: mpi3mr: Handle soft reset in progress fault code (0xF002)

Zhong Jinghua (1):
      scsi: iscsi_tcp: Check that sock is valid before iscsi_set_param()

And the diffstat:

 drivers/scsi/iscsi_tcp.c        |  3 +--
 drivers/scsi/mpi3mr/mpi3mr_fw.c |  2 +-
 drivers/scsi/qla2xxx/qla_os.c   |  1 +
 drivers/ufs/core/ufshcd.c       | 47 ++++++++++++++---------------------------
 include/ufs/ufshcd.h            |  1 -
 5 files changed, 19 insertions(+), 35 deletions(-)

With full diff below.

James

---

diff --git a/drivers/scsi/iscsi_tcp.c b/drivers/scsi/iscsi_tcp.c
index c76f82fb8b63..15f452908926 100644
--- a/drivers/scsi/iscsi_tcp.c
+++ b/drivers/scsi/iscsi_tcp.c
@@ -771,13 +771,12 @@ static int iscsi_sw_tcp_conn_set_param(struct iscsi_cls_conn *cls_conn,
 		iscsi_set_param(cls_conn, param, buf, buflen);
 		break;
 	case ISCSI_PARAM_DATADGST_EN:
-		iscsi_set_param(cls_conn, param, buf, buflen);
-
 		mutex_lock(&tcp_sw_conn->sock_lock);
 		if (!tcp_sw_conn->sock) {
 			mutex_unlock(&tcp_sw_conn->sock_lock);
 			return -ENOTCONN;
 		}
+		iscsi_set_param(cls_conn, param, buf, buflen);
 		tcp_sw_conn->sendpage = conn->datadgst_en ?
 			sock_no_sendpage : tcp_sw_conn->sock->ops->sendpage;
 		mutex_unlock(&tcp_sw_conn->sock_lock);
diff --git a/drivers/scsi/mpi3mr/mpi3mr_fw.c b/drivers/scsi/mpi3mr/mpi3mr_fw.c
index a565817aa56d..d109a4ceb72b 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_fw.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_fw.c
@@ -2526,7 +2526,7 @@ static void mpi3mr_watchdog_work(struct work_struct *work)
 		mrioc->unrecoverable = 1;
 		goto schedule_work;
 	case MPI3_SYSIF_FAULT_CODE_SOFT_RESET_IN_PROGRESS:
-		return;
+		goto schedule_work;
 	case MPI3_SYSIF_FAULT_CODE_CI_ACTIVATION_RESET:
 		reset_reason = MPI3MR_RESET_FROM_CIACTIV_FAULT;
 		break;
diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index bee1b8a82020..d0cdbfe771a9 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -3617,6 +3617,7 @@ qla2x00_probe_one(struct pci_dev *pdev, const struct pci_device_id *id)
 probe_failed:
 	qla_enode_stop(base_vha);
 	qla_edb_stop(base_vha);
+	vfree(base_vha->scan.l);
 	if (base_vha->gnl.l) {
 		dma_free_coherent(&ha->pdev->dev, base_vha->gnl.size,
 				base_vha->gnl.l, base_vha->gnl.ldma);
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 37e178a9ac47..70b112038792 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -1409,13 +1409,6 @@ static int ufshcd_devfreq_target(struct device *dev,
 	struct ufs_clk_info *clki;
 	unsigned long irq_flags;
 
-	/*
-	 * Skip devfreq if UFS initialization is not finished.
-	 * Otherwise ufs could be in a inconsistent state.
-	 */
-	if (!smp_load_acquire(&hba->logical_unit_scan_finished))
-		return 0;
-
 	if (!ufshcd_is_clkscaling_supported(hba))
 		return -EINVAL;
 
@@ -8399,6 +8392,22 @@ static int ufshcd_add_lus(struct ufs_hba *hba)
 	if (ret)
 		goto out;
 
+	/* Initialize devfreq after UFS device is detected */
+	if (ufshcd_is_clkscaling_supported(hba)) {
+		memcpy(&hba->clk_scaling.saved_pwr_info.info,
+			&hba->pwr_info,
+			sizeof(struct ufs_pa_layer_attr));
+		hba->clk_scaling.saved_pwr_info.is_valid = true;
+		hba->clk_scaling.is_allowed = true;
+
+		ret = ufshcd_devfreq_init(hba);
+		if (ret)
+			goto out;
+
+		hba->clk_scaling.is_enabled = true;
+		ufshcd_init_clk_scaling_sysfs(hba);
+	}
+
 	ufs_bsg_probe(hba);
 	ufshpb_init(hba);
 	scsi_scan_host(hba->host);
@@ -8670,12 +8679,6 @@ static void ufshcd_async_scan(void *data, async_cookie_t cookie)
 	if (ret) {
 		pm_runtime_put_sync(hba->dev);
 		ufshcd_hba_exit(hba);
-	} else {
-		/*
-		 * Make sure that when reader code sees UFS initialization has finished,
-		 * all initialization steps have really been executed.
-		 */
-		smp_store_release(&hba->logical_unit_scan_finished, true);
 	}
 }
 
@@ -10316,30 +10319,12 @@ int ufshcd_init(struct ufs_hba *hba, void __iomem *mmio_base, unsigned int irq)
 	 */
 	ufshcd_set_ufs_dev_active(hba);
 
-	/* Initialize devfreq */
-	if (ufshcd_is_clkscaling_supported(hba)) {
-		memcpy(&hba->clk_scaling.saved_pwr_info.info,
-			&hba->pwr_info,
-			sizeof(struct ufs_pa_layer_attr));
-		hba->clk_scaling.saved_pwr_info.is_valid = true;
-		hba->clk_scaling.is_allowed = true;
-
-		err = ufshcd_devfreq_init(hba);
-		if (err)
-			goto rpm_put_sync;
-
-		hba->clk_scaling.is_enabled = true;
-		ufshcd_init_clk_scaling_sysfs(hba);
-	}
-
 	async_schedule(ufshcd_async_scan, hba);
 	ufs_sysfs_add_nodes(hba->dev);
 
 	device_enable_async_suspend(dev);
 	return 0;
 
-rpm_put_sync:
-	pm_runtime_put_sync(dev);
 free_tmf_queue:
 	blk_mq_destroy_queue(hba->tmf_queue);
 	blk_put_queue(hba->tmf_queue);
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index 25aab8ec4f86..431c3afb2ce0 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -979,7 +979,6 @@ struct ufs_hba {
 	struct completion *uic_async_done;
 
 	enum ufshcd_state ufshcd_state;
-	bool logical_unit_scan_finished;
 	u32 eh_flags;
 	u32 intr_mask;
 	u16 ee_ctrl_mask;

