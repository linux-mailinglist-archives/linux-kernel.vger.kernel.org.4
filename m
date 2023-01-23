Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B65CD678725
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 21:05:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbjAWUFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 15:05:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231951AbjAWUFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 15:05:19 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B73BE10FF;
        Mon, 23 Jan 2023 12:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1674504311;
        bh=aQ5YOIM1ra3YARccrkKwJgESOHM0e6DhFasW8i0W6jk=;
        h=Message-ID:Subject:From:To:Date:From;
        b=L8OTHGcr0s6GhVJEryRlWPyNtbUFlIvNBZDbEvVl7sYumJmX5+M+MCoNUoq6b5RWN
         rI8vuEqiaAlWyviJnYbtQR9c5v2qwdfobHq/qYfjJV+5BAcrEE6WFob6IO6ztVwF0d
         6UntV+RRNVMf5EcqgAC5Lm/2WKCvxT51st2qTYM8=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 6BB6C128644A;
        Mon, 23 Jan 2023 15:05:11 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 9tljaDrGIn8u; Mon, 23 Jan 2023 15:05:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1674504311;
        bh=aQ5YOIM1ra3YARccrkKwJgESOHM0e6DhFasW8i0W6jk=;
        h=Message-ID:Subject:From:To:Date:From;
        b=L8OTHGcr0s6GhVJEryRlWPyNtbUFlIvNBZDbEvVl7sYumJmX5+M+MCoNUoq6b5RWN
         rI8vuEqiaAlWyviJnYbtQR9c5v2qwdfobHq/qYfjJV+5BAcrEE6WFob6IO6ztVwF0d
         6UntV+RRNVMf5EcqgAC5Lm/2WKCvxT51st2qTYM8=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::c14])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id B9DE31286425;
        Mon, 23 Jan 2023 15:05:10 -0500 (EST)
Message-ID: <87b5e16ec007de3523fd78534a48d6244bda3f46.camel@HansenPartnership.com>
Subject: [GIT PULL] SCSI fixes for 6.1-rc5
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Mon, 23 Jan 2023 15:05:08 -0500
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Six fixes, all in drivers.  The biggest are the UFS devfreq fixes which
address a lock inversion and the two iscsi_tcp fixes which try to
prevent a use after free from userspace still accessing an area which
the kernel has released (seen by KASAN).

The patch is available here:

git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

The short changelog is:

Alexey V. Vissarionov (1):
      scsi: hpsa: Fix allocation size for scsi_host_alloc()

Bart Van Assche (1):
      scsi: device_handler: alua: Remove a might_sleep() annotation

Johan Hovold (1):
      scsi: ufs: core: Fix devfreq deadlocks

Maurizio Lombardi (1):
      scsi: target: core: Fix warning on RT kernels

Mike Christie (2):
      scsi: iscsi_tcp: Fix UAF during login when accessing the shost ipaddress
      scsi: iscsi_tcp: Fix UAF during logout when accessing the shost ipaddress


And the diffstat:

 drivers/scsi/device_handler/scsi_dh_alua.c |  5 ++--
 drivers/scsi/hpsa.c                        |  2 +-
 drivers/scsi/iscsi_tcp.c                   | 20 ++++++++++++----
 drivers/scsi/libiscsi.c                    | 38 ++++++++++++++++++++++++------
 drivers/target/target_core_tmr.c           |  4 ++--
 drivers/ufs/core/ufshcd.c                  | 29 ++++++++++++-----------
 include/scsi/libiscsi.h                    |  2 ++
 include/ufs/ufshcd.h                       |  2 ++
 8 files changed, 71 insertions(+), 31 deletions(-)

With full diff below.

James

---

diff --git a/drivers/scsi/device_handler/scsi_dh_alua.c b/drivers/scsi/device_handler/scsi_dh_alua.c
index 49cc18a87473..29a2865b8e2e 100644
--- a/drivers/scsi/device_handler/scsi_dh_alua.c
+++ b/drivers/scsi/device_handler/scsi_dh_alua.c
@@ -981,6 +981,9 @@ static void alua_rtpg_work(struct work_struct *work)
  *
  * Returns true if and only if alua_rtpg_work() will be called asynchronously.
  * That function is responsible for calling @qdata->fn().
+ *
+ * Context: may be called from atomic context (alua_check()) only if the caller
+ *	holds an sdev reference.
  */
 static bool alua_rtpg_queue(struct alua_port_group *pg,
 			    struct scsi_device *sdev,
@@ -989,8 +992,6 @@ static bool alua_rtpg_queue(struct alua_port_group *pg,
 	int start_queue = 0;
 	unsigned long flags;
 
-	might_sleep();
-
 	if (WARN_ON_ONCE(!pg) || scsi_device_get(sdev))
 		return false;
 
diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
index 4dbf51e2623a..f6da34850af9 100644
--- a/drivers/scsi/hpsa.c
+++ b/drivers/scsi/hpsa.c
@@ -5850,7 +5850,7 @@ static int hpsa_scsi_host_alloc(struct ctlr_info *h)
 {
 	struct Scsi_Host *sh;
 
-	sh = scsi_host_alloc(&hpsa_driver_template, sizeof(h));
+	sh = scsi_host_alloc(&hpsa_driver_template, sizeof(struct ctlr_info));
 	if (sh == NULL) {
 		dev_err(&h->pdev->dev, "scsi_host_alloc failed\n");
 		return -ENOMEM;
diff --git a/drivers/scsi/iscsi_tcp.c b/drivers/scsi/iscsi_tcp.c
index 1d1cf641937c..0454d94e8cf0 100644
--- a/drivers/scsi/iscsi_tcp.c
+++ b/drivers/scsi/iscsi_tcp.c
@@ -849,7 +849,7 @@ static int iscsi_sw_tcp_host_get_param(struct Scsi_Host *shost,
 				       enum iscsi_host_param param, char *buf)
 {
 	struct iscsi_sw_tcp_host *tcp_sw_host = iscsi_host_priv(shost);
-	struct iscsi_session *session = tcp_sw_host->session;
+	struct iscsi_session *session;
 	struct iscsi_conn *conn;
 	struct iscsi_tcp_conn *tcp_conn;
 	struct iscsi_sw_tcp_conn *tcp_sw_conn;
@@ -859,6 +859,7 @@ static int iscsi_sw_tcp_host_get_param(struct Scsi_Host *shost,
 
 	switch (param) {
 	case ISCSI_HOST_PARAM_IPADDRESS:
+		session = tcp_sw_host->session;
 		if (!session)
 			return -ENOTCONN;
 
@@ -959,11 +960,13 @@ iscsi_sw_tcp_session_create(struct iscsi_endpoint *ep, uint16_t cmds_max,
 	if (!cls_session)
 		goto remove_host;
 	session = cls_session->dd_data;
-	tcp_sw_host = iscsi_host_priv(shost);
-	tcp_sw_host->session = session;
 
 	if (iscsi_tcp_r2tpool_alloc(session))
 		goto remove_session;
+
+	/* We are now fully setup so expose the session to sysfs. */
+	tcp_sw_host = iscsi_host_priv(shost);
+	tcp_sw_host->session = session;
 	return cls_session;
 
 remove_session:
@@ -983,10 +986,17 @@ static void iscsi_sw_tcp_session_destroy(struct iscsi_cls_session *cls_session)
 	if (WARN_ON_ONCE(session->leadconn))
 		return;
 
+	iscsi_session_remove(cls_session);
+	/*
+	 * Our get_host_param needs to access the session, so remove the
+	 * host from sysfs before freeing the session to make sure userspace
+	 * is no longer accessing the callout.
+	 */
+	iscsi_host_remove(shost, false);
+
 	iscsi_tcp_r2tpool_free(cls_session->dd_data);
-	iscsi_session_teardown(cls_session);
 
-	iscsi_host_remove(shost, false);
+	iscsi_session_free(cls_session);
 	iscsi_host_free(shost);
 }
 
diff --git a/drivers/scsi/libiscsi.c b/drivers/scsi/libiscsi.c
index ef2fc860257e..127f3d7f19dc 100644
--- a/drivers/scsi/libiscsi.c
+++ b/drivers/scsi/libiscsi.c
@@ -3104,17 +3104,32 @@ iscsi_session_setup(struct iscsi_transport *iscsit, struct Scsi_Host *shost,
 }
 EXPORT_SYMBOL_GPL(iscsi_session_setup);
 
-/**
- * iscsi_session_teardown - destroy session, host, and cls_session
- * @cls_session: iscsi session
+/*
+ * issi_session_remove - Remove session from iSCSI class.
  */
-void iscsi_session_teardown(struct iscsi_cls_session *cls_session)
+void iscsi_session_remove(struct iscsi_cls_session *cls_session)
 {
 	struct iscsi_session *session = cls_session->dd_data;
-	struct module *owner = cls_session->transport->owner;
 	struct Scsi_Host *shost = session->host;
 
 	iscsi_remove_session(cls_session);
+	/*
+	 * host removal only has to wait for its children to be removed from
+	 * sysfs, and iscsi_tcp needs to do iscsi_host_remove before freeing
+	 * the session, so drop the session count here.
+	 */
+	iscsi_host_dec_session_cnt(shost);
+}
+EXPORT_SYMBOL_GPL(iscsi_session_remove);
+
+/**
+ * iscsi_session_free - Free iscsi session and it's resources
+ * @cls_session: iscsi session
+ */
+void iscsi_session_free(struct iscsi_cls_session *cls_session)
+{
+	struct iscsi_session *session = cls_session->dd_data;
+	struct module *owner = cls_session->transport->owner;
 
 	iscsi_pool_free(&session->cmdpool);
 	kfree(session->password);
@@ -3132,10 +3147,19 @@ void iscsi_session_teardown(struct iscsi_cls_session *cls_session)
 	kfree(session->discovery_parent_type);
 
 	iscsi_free_session(cls_session);
-
-	iscsi_host_dec_session_cnt(shost);
 	module_put(owner);
 }
+EXPORT_SYMBOL_GPL(iscsi_session_free);
+
+/**
+ * iscsi_session_teardown - destroy session and cls_session
+ * @cls_session: iscsi session
+ */
+void iscsi_session_teardown(struct iscsi_cls_session *cls_session)
+{
+	iscsi_session_remove(cls_session);
+	iscsi_session_free(cls_session);
+}
 EXPORT_SYMBOL_GPL(iscsi_session_teardown);
 
 /**
diff --git a/drivers/target/target_core_tmr.c b/drivers/target/target_core_tmr.c
index bac111456fa1..2b95b4550a63 100644
--- a/drivers/target/target_core_tmr.c
+++ b/drivers/target/target_core_tmr.c
@@ -73,8 +73,8 @@ static bool __target_check_io_state(struct se_cmd *se_cmd,
 {
 	struct se_session *sess = se_cmd->se_sess;
 
-	assert_spin_locked(&sess->sess_cmd_lock);
-	WARN_ON_ONCE(!irqs_disabled());
+	lockdep_assert_held(&sess->sess_cmd_lock);
+
 	/*
 	 * If command already reached CMD_T_COMPLETE state within
 	 * target_complete_cmd() or CMD_T_FABRIC_STOP due to shutdown,
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index bda61be5f035..3a1c4d31e010 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -1234,12 +1234,14 @@ static int ufshcd_clock_scaling_prepare(struct ufs_hba *hba)
 	 * clock scaling is in progress
 	 */
 	ufshcd_scsi_block_requests(hba);
+	mutex_lock(&hba->wb_mutex);
 	down_write(&hba->clk_scaling_lock);
 
 	if (!hba->clk_scaling.is_allowed ||
 	    ufshcd_wait_for_doorbell_clr(hba, DOORBELL_CLR_TOUT_US)) {
 		ret = -EBUSY;
 		up_write(&hba->clk_scaling_lock);
+		mutex_unlock(&hba->wb_mutex);
 		ufshcd_scsi_unblock_requests(hba);
 		goto out;
 	}
@@ -1251,12 +1253,16 @@ static int ufshcd_clock_scaling_prepare(struct ufs_hba *hba)
 	return ret;
 }
 
-static void ufshcd_clock_scaling_unprepare(struct ufs_hba *hba, bool writelock)
+static void ufshcd_clock_scaling_unprepare(struct ufs_hba *hba, int err, bool scale_up)
 {
-	if (writelock)
-		up_write(&hba->clk_scaling_lock);
-	else
-		up_read(&hba->clk_scaling_lock);
+	up_write(&hba->clk_scaling_lock);
+
+	/* Enable Write Booster if we have scaled up else disable it */
+	if (ufshcd_enable_wb_if_scaling_up(hba) && !err)
+		ufshcd_wb_toggle(hba, scale_up);
+
+	mutex_unlock(&hba->wb_mutex);
+
 	ufshcd_scsi_unblock_requests(hba);
 	ufshcd_release(hba);
 }
@@ -1273,7 +1279,6 @@ static void ufshcd_clock_scaling_unprepare(struct ufs_hba *hba, bool writelock)
 static int ufshcd_devfreq_scale(struct ufs_hba *hba, bool scale_up)
 {
 	int ret = 0;
-	bool is_writelock = true;
 
 	ret = ufshcd_clock_scaling_prepare(hba);
 	if (ret)
@@ -1302,15 +1307,8 @@ static int ufshcd_devfreq_scale(struct ufs_hba *hba, bool scale_up)
 		}
 	}
 
-	/* Enable Write Booster if we have scaled up else disable it */
-	if (ufshcd_enable_wb_if_scaling_up(hba)) {
-		downgrade_write(&hba->clk_scaling_lock);
-		is_writelock = false;
-		ufshcd_wb_toggle(hba, scale_up);
-	}
-
 out_unprepare:
-	ufshcd_clock_scaling_unprepare(hba, is_writelock);
+	ufshcd_clock_scaling_unprepare(hba, ret, scale_up);
 	return ret;
 }
 
@@ -6066,9 +6064,11 @@ static void ufshcd_force_error_recovery(struct ufs_hba *hba)
 
 static void ufshcd_clk_scaling_allow(struct ufs_hba *hba, bool allow)
 {
+	mutex_lock(&hba->wb_mutex);
 	down_write(&hba->clk_scaling_lock);
 	hba->clk_scaling.is_allowed = allow;
 	up_write(&hba->clk_scaling_lock);
+	mutex_unlock(&hba->wb_mutex);
 }
 
 static void ufshcd_clk_scaling_suspend(struct ufs_hba *hba, bool suspend)
@@ -9793,6 +9793,7 @@ int ufshcd_init(struct ufs_hba *hba, void __iomem *mmio_base, unsigned int irq)
 	/* Initialize mutex for exception event control */
 	mutex_init(&hba->ee_ctrl_mutex);
 
+	mutex_init(&hba->wb_mutex);
 	init_rwsem(&hba->clk_scaling_lock);
 
 	ufshcd_init_clk_gating(hba);
diff --git a/include/scsi/libiscsi.h b/include/scsi/libiscsi.h
index 695eebc6f2c8..e39fb0736ade 100644
--- a/include/scsi/libiscsi.h
+++ b/include/scsi/libiscsi.h
@@ -422,6 +422,8 @@ extern int iscsi_host_get_max_scsi_cmds(struct Scsi_Host *shost,
 extern struct iscsi_cls_session *
 iscsi_session_setup(struct iscsi_transport *, struct Scsi_Host *shost,
 		    uint16_t, int, int, uint32_t, unsigned int);
+void iscsi_session_remove(struct iscsi_cls_session *cls_session);
+void iscsi_session_free(struct iscsi_cls_session *cls_session);
 extern void iscsi_session_teardown(struct iscsi_cls_session *);
 extern void iscsi_session_recovery_timedout(struct iscsi_cls_session *);
 extern int iscsi_set_param(struct iscsi_cls_conn *cls_conn,
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index 5cf81dff60aa..727084cd79be 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -808,6 +808,7 @@ struct ufs_hba_monitor {
  * @urgent_bkops_lvl: keeps track of urgent bkops level for device
  * @is_urgent_bkops_lvl_checked: keeps track if the urgent bkops level for
  *  device is known or not.
+ * @wb_mutex: used to serialize devfreq and sysfs write booster toggling
  * @clk_scaling_lock: used to serialize device commands and clock scaling
  * @desc_size: descriptor sizes reported by device
  * @scsi_block_reqs_cnt: reference counting for scsi block requests
@@ -951,6 +952,7 @@ struct ufs_hba {
 	enum bkops_status urgent_bkops_lvl;
 	bool is_urgent_bkops_lvl_checked;
 
+	struct mutex wb_mutex;
 	struct rw_semaphore clk_scaling_lock;
 	unsigned char desc_size[QUERY_DESC_IDN_MAX];
 	atomic_t scsi_block_reqs_cnt;

