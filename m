Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1179721165
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 19:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbjFCRng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 13:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjFCRnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 13:43:35 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A96CE;
        Sat,  3 Jun 2023 10:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1685814210;
        bh=4UU0xOOHSuWCxo0l5Cjn5Jk/3ZZTjPKm9lRGVRiXqDw=;
        h=Message-ID:Subject:From:To:Date:From;
        b=JPEx09Q03HgKAqnSBJpI25z8fsOx3EtC7ynXHOkaUT3eIzreNz83I5fd/EHeiFO1h
         teDLCevp6y0O9TpGF82cle0X94d93fkOktQKfsEHo9x77lXF6ZxBBiCepXiDfrRxJU
         9K0fe4fEHUFOgmnQnBXfzkkLKhNUgLRReLY/D13g=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 966D112860BA;
        Sat,  3 Jun 2023 13:43:30 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id 2A5IRiDUkcAe; Sat,  3 Jun 2023 13:43:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1685814210;
        bh=4UU0xOOHSuWCxo0l5Cjn5Jk/3ZZTjPKm9lRGVRiXqDw=;
        h=Message-ID:Subject:From:To:Date:From;
        b=JPEx09Q03HgKAqnSBJpI25z8fsOx3EtC7ynXHOkaUT3eIzreNz83I5fd/EHeiFO1h
         teDLCevp6y0O9TpGF82cle0X94d93fkOktQKfsEHo9x77lXF6ZxBBiCepXiDfrRxJU
         9K0fe4fEHUFOgmnQnBXfzkkLKhNUgLRReLY/D13g=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::c14])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id E73F312860B0;
        Sat,  3 Jun 2023 13:43:29 -0400 (EDT)
Message-ID: <b4e84e8564b86822ec4dab6ba85995888df20991.camel@HansenPartnership.com>
Subject: [GIT PULL] SCSI fixes for 6.4-rc4
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Sat, 03 Jun 2023 13:43:28 -0400
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

Five fixes, all in drivers. The most extensive is the target change to
fix the hang in the login code, which involves changing timers from per
login to per connection.

The patch is available here:

git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

The short changelog is:

Bart Van Assche (1):
      scsi: stex: Fix gcc 13 warnings

Gleb Chesnokov (1):
      scsi: qla2xxx: Fix NULL pointer dereference in target mode

Maurizio Lombardi (3):
      scsi: target: iscsi: Prevent login threads from racing between each other
      scsi: target: iscsi: Remove unused transport_timer
      scsi: target: iscsi: Fix hang in the iSCSI login code

And the diffstat:

 drivers/scsi/qla2xxx/qla_def.h            |  1 +
 drivers/scsi/qla2xxx/qla_init.c           |  3 ++
 drivers/scsi/qla2xxx/qla_inline.h         |  3 ++
 drivers/scsi/qla2xxx/qla_isr.c            |  3 ++
 drivers/scsi/stex.c                       |  4 ++
 drivers/target/iscsi/iscsi_target.c       |  2 -
 drivers/target/iscsi/iscsi_target_login.c | 63 +++-----------------------
 drivers/target/iscsi/iscsi_target_nego.c  | 74 ++++++++++++++++++-------------
 drivers/target/iscsi/iscsi_target_util.c  | 51 +++++++++++++++++++++
 drivers/target/iscsi/iscsi_target_util.h  |  4 ++
 include/target/iscsi/iscsi_target_core.h  |  7 +--
 11 files changed, 120 insertions(+), 95 deletions(-)

With full diff below.

James

---

diff --git a/drivers/scsi/qla2xxx/qla_def.h b/drivers/scsi/qla2xxx/qla_def.h
index df5e5b7fdcfe..84aa3571be6d 100644
--- a/drivers/scsi/qla2xxx/qla_def.h
+++ b/drivers/scsi/qla2xxx/qla_def.h
@@ -3796,6 +3796,7 @@ struct qla_qpair {
 	uint64_t retry_term_jiff;
 	struct qla_tgt_counters tgt_counters;
 	uint16_t cpuid;
+	bool cpu_mapped;
 	struct qla_fw_resources fwres ____cacheline_aligned;
 	struct  qla_buf_pool buf_pool;
 	u32	cmd_cnt;
diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index ec0423ec6681..1a955c3ff3d6 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -9426,6 +9426,9 @@ struct qla_qpair *qla2xxx_create_qpair(struct scsi_qla_host *vha, int qos,
 		qpair->rsp->req = qpair->req;
 		qpair->rsp->qpair = qpair;
 
+		if (!qpair->cpu_mapped)
+			qla_cpu_update(qpair, raw_smp_processor_id());
+
 		if (IS_T10_PI_CAPABLE(ha) && ql2xenabledif) {
 			if (ha->fw_attributes & BIT_4)
 				qpair->difdix_supported = 1;
diff --git a/drivers/scsi/qla2xxx/qla_inline.h b/drivers/scsi/qla2xxx/qla_inline.h
index cce6e425c121..7b42558a8839 100644
--- a/drivers/scsi/qla2xxx/qla_inline.h
+++ b/drivers/scsi/qla2xxx/qla_inline.h
@@ -539,11 +539,14 @@ qla_mapq_init_qp_cpu_map(struct qla_hw_data *ha,
 	if (!ha->qp_cpu_map)
 		return;
 	mask = pci_irq_get_affinity(ha->pdev, msix->vector_base0);
+	if (!mask)
+		return;
 	qpair->cpuid = cpumask_first(mask);
 	for_each_cpu(cpu, mask) {
 		ha->qp_cpu_map[cpu] = qpair;
 	}
 	msix->cpuid = qpair->cpuid;
+	qpair->cpu_mapped = true;
 }
 
 static inline void
diff --git a/drivers/scsi/qla2xxx/qla_isr.c b/drivers/scsi/qla2xxx/qla_isr.c
index 71feda2cdb63..245e3a5d81fd 100644
--- a/drivers/scsi/qla2xxx/qla_isr.c
+++ b/drivers/scsi/qla2xxx/qla_isr.c
@@ -3770,6 +3770,9 @@ void qla24xx_process_response_queue(struct scsi_qla_host *vha,
 
 	if (rsp->qpair->cpuid != smp_processor_id() || !rsp->qpair->rcv_intr) {
 		rsp->qpair->rcv_intr = 1;
+
+		if (!rsp->qpair->cpu_mapped)
+			qla_cpu_update(rsp->qpair, raw_smp_processor_id());
 	}
 
 #define __update_rsp_in(_is_shadow_hba, _rsp, _rsp_in)			\
diff --git a/drivers/scsi/stex.c b/drivers/scsi/stex.c
index 5b230e149c3d..8ffb75be99bc 100644
--- a/drivers/scsi/stex.c
+++ b/drivers/scsi/stex.c
@@ -109,7 +109,9 @@ enum {
 	TASK_ATTRIBUTE_HEADOFQUEUE		= 0x1,
 	TASK_ATTRIBUTE_ORDERED			= 0x2,
 	TASK_ATTRIBUTE_ACA			= 0x4,
+};
 
+enum {
 	SS_STS_NORMAL				= 0x80000000,
 	SS_STS_DONE				= 0x40000000,
 	SS_STS_HANDSHAKE			= 0x20000000,
@@ -121,7 +123,9 @@ enum {
 	SS_I2H_REQUEST_RESET			= 0x2000,
 
 	SS_MU_OPERATIONAL			= 0x80000000,
+};
 
+enum {
 	STEX_CDB_LENGTH				= 16,
 	STATUS_VAR_LEN				= 128,
 
diff --git a/drivers/target/iscsi/iscsi_target.c b/drivers/target/iscsi/iscsi_target.c
index 834cce50f9b0..b516c2893420 100644
--- a/drivers/target/iscsi/iscsi_target.c
+++ b/drivers/target/iscsi/iscsi_target.c
@@ -364,8 +364,6 @@ struct iscsi_np *iscsit_add_np(
 	init_completion(&np->np_restart_comp);
 	INIT_LIST_HEAD(&np->np_list);
 
-	timer_setup(&np->np_login_timer, iscsi_handle_login_thread_timeout, 0);
-
 	ret = iscsi_target_setup_login_socket(np, sockaddr);
 	if (ret != 0) {
 		kfree(np);
diff --git a/drivers/target/iscsi/iscsi_target_login.c b/drivers/target/iscsi/iscsi_target_login.c
index 274bdd7845ca..90b870f234f0 100644
--- a/drivers/target/iscsi/iscsi_target_login.c
+++ b/drivers/target/iscsi/iscsi_target_login.c
@@ -811,59 +811,6 @@ void iscsi_post_login_handler(
 	iscsit_dec_conn_usage_count(conn);
 }
 
-void iscsi_handle_login_thread_timeout(struct timer_list *t)
-{
-	struct iscsi_np *np = from_timer(np, t, np_login_timer);
-
-	spin_lock_bh(&np->np_thread_lock);
-	pr_err("iSCSI Login timeout on Network Portal %pISpc\n",
-			&np->np_sockaddr);
-
-	if (np->np_login_timer_flags & ISCSI_TF_STOP) {
-		spin_unlock_bh(&np->np_thread_lock);
-		return;
-	}
-
-	if (np->np_thread)
-		send_sig(SIGINT, np->np_thread, 1);
-
-	np->np_login_timer_flags &= ~ISCSI_TF_RUNNING;
-	spin_unlock_bh(&np->np_thread_lock);
-}
-
-static void iscsi_start_login_thread_timer(struct iscsi_np *np)
-{
-	/*
-	 * This used the TA_LOGIN_TIMEOUT constant because at this
-	 * point we do not have access to ISCSI_TPG_ATTRIB(tpg)->login_timeout
-	 */
-	spin_lock_bh(&np->np_thread_lock);
-	np->np_login_timer_flags &= ~ISCSI_TF_STOP;
-	np->np_login_timer_flags |= ISCSI_TF_RUNNING;
-	mod_timer(&np->np_login_timer, jiffies + TA_LOGIN_TIMEOUT * HZ);
-
-	pr_debug("Added timeout timer to iSCSI login request for"
-			" %u seconds.\n", TA_LOGIN_TIMEOUT);
-	spin_unlock_bh(&np->np_thread_lock);
-}
-
-static void iscsi_stop_login_thread_timer(struct iscsi_np *np)
-{
-	spin_lock_bh(&np->np_thread_lock);
-	if (!(np->np_login_timer_flags & ISCSI_TF_RUNNING)) {
-		spin_unlock_bh(&np->np_thread_lock);
-		return;
-	}
-	np->np_login_timer_flags |= ISCSI_TF_STOP;
-	spin_unlock_bh(&np->np_thread_lock);
-
-	del_timer_sync(&np->np_login_timer);
-
-	spin_lock_bh(&np->np_thread_lock);
-	np->np_login_timer_flags &= ~ISCSI_TF_RUNNING;
-	spin_unlock_bh(&np->np_thread_lock);
-}
-
 int iscsit_setup_np(
 	struct iscsi_np *np,
 	struct sockaddr_storage *sockaddr)
@@ -1123,10 +1070,13 @@ static struct iscsit_conn *iscsit_alloc_conn(struct iscsi_np *np)
 	spin_lock_init(&conn->nopin_timer_lock);
 	spin_lock_init(&conn->response_queue_lock);
 	spin_lock_init(&conn->state_lock);
+	spin_lock_init(&conn->login_worker_lock);
+	spin_lock_init(&conn->login_timer_lock);
 
 	timer_setup(&conn->nopin_response_timer,
 		    iscsit_handle_nopin_response_timeout, 0);
 	timer_setup(&conn->nopin_timer, iscsit_handle_nopin_timeout, 0);
+	timer_setup(&conn->login_timer, iscsit_login_timeout, 0);
 
 	if (iscsit_conn_set_transport(conn, np->np_transport) < 0)
 		goto free_conn;
@@ -1304,7 +1254,7 @@ static int __iscsi_target_login_thread(struct iscsi_np *np)
 		goto new_sess_out;
 	}
 
-	iscsi_start_login_thread_timer(np);
+	iscsit_start_login_timer(conn, current);
 
 	pr_debug("Moving to TARG_CONN_STATE_XPT_UP.\n");
 	conn->conn_state = TARG_CONN_STATE_XPT_UP;
@@ -1417,8 +1367,6 @@ static int __iscsi_target_login_thread(struct iscsi_np *np)
 	if (ret < 0)
 		goto new_sess_out;
 
-	iscsi_stop_login_thread_timer(np);
-
 	if (ret == 1) {
 		tpg_np = conn->tpg_np;
 
@@ -1434,7 +1382,7 @@ static int __iscsi_target_login_thread(struct iscsi_np *np)
 new_sess_out:
 	new_sess = true;
 old_sess_out:
-	iscsi_stop_login_thread_timer(np);
+	iscsit_stop_login_timer(conn);
 	tpg_np = conn->tpg_np;
 	iscsi_target_login_sess_out(conn, zero_tsih, new_sess);
 	new_sess = false;
@@ -1448,7 +1396,6 @@ static int __iscsi_target_login_thread(struct iscsi_np *np)
 	return 1;
 
 exit:
-	iscsi_stop_login_thread_timer(np);
 	spin_lock_bh(&np->np_thread_lock);
 	np->np_thread_state = ISCSI_NP_THREAD_EXIT;
 	spin_unlock_bh(&np->np_thread_lock);
diff --git a/drivers/target/iscsi/iscsi_target_nego.c b/drivers/target/iscsi/iscsi_target_nego.c
index 24040c118e49..fa3fb5f4e6bc 100644
--- a/drivers/target/iscsi/iscsi_target_nego.c
+++ b/drivers/target/iscsi/iscsi_target_nego.c
@@ -535,25 +535,6 @@ static void iscsi_target_login_drop(struct iscsit_conn *conn, struct iscsi_login
 	iscsi_target_login_sess_out(conn, zero_tsih, true);
 }
 
-struct conn_timeout {
-	struct timer_list timer;
-	struct iscsit_conn *conn;
-};
-
-static void iscsi_target_login_timeout(struct timer_list *t)
-{
-	struct conn_timeout *timeout = from_timer(timeout, t, timer);
-	struct iscsit_conn *conn = timeout->conn;
-
-	pr_debug("Entering iscsi_target_login_timeout >>>>>>>>>>>>>>>>>>>\n");
-
-	if (conn->login_kworker) {
-		pr_debug("Sending SIGINT to conn->login_kworker %s/%d\n",
-			 conn->login_kworker->comm, conn->login_kworker->pid);
-		send_sig(SIGINT, conn->login_kworker, 1);
-	}
-}
-
 static void iscsi_target_do_login_rx(struct work_struct *work)
 {
 	struct iscsit_conn *conn = container_of(work,
@@ -562,12 +543,15 @@ static void iscsi_target_do_login_rx(struct work_struct *work)
 	struct iscsi_np *np = login->np;
 	struct iscsi_portal_group *tpg = conn->tpg;
 	struct iscsi_tpg_np *tpg_np = conn->tpg_np;
-	struct conn_timeout timeout;
 	int rc, zero_tsih = login->zero_tsih;
 	bool state;
 
 	pr_debug("entering iscsi_target_do_login_rx, conn: %p, %s:%d\n",
 			conn, current->comm, current->pid);
+
+	spin_lock(&conn->login_worker_lock);
+	set_bit(LOGIN_FLAGS_WORKER_RUNNING, &conn->login_flags);
+	spin_unlock(&conn->login_worker_lock);
 	/*
 	 * If iscsi_target_do_login_rx() has been invoked by ->sk_data_ready()
 	 * before initial PDU processing in iscsi_target_start_negotiation()
@@ -597,19 +581,16 @@ static void iscsi_target_do_login_rx(struct work_struct *work)
 		goto err;
 	}
 
-	conn->login_kworker = current;
 	allow_signal(SIGINT);
-
-	timeout.conn = conn;
-	timer_setup_on_stack(&timeout.timer, iscsi_target_login_timeout, 0);
-	mod_timer(&timeout.timer, jiffies + TA_LOGIN_TIMEOUT * HZ);
-	pr_debug("Starting login timer for %s/%d\n", current->comm, current->pid);
+	rc = iscsit_set_login_timer_kworker(conn, current);
+	if (rc < 0) {
+		/* The login timer has already expired */
+		pr_debug("iscsi_target_do_login_rx, login failed\n");
+		goto err;
+	}
 
 	rc = conn->conn_transport->iscsit_get_login_rx(conn, login);
-	del_timer_sync(&timeout.timer);
-	destroy_timer_on_stack(&timeout.timer);
 	flush_signals(current);
-	conn->login_kworker = NULL;
 
 	if (rc < 0)
 		goto err;
@@ -646,7 +627,17 @@ static void iscsi_target_do_login_rx(struct work_struct *work)
 		if (iscsi_target_sk_check_and_clear(conn,
 						    LOGIN_FLAGS_WRITE_ACTIVE))
 			goto err;
+
+		/*
+		 * Set the login timer thread pointer to NULL to prevent the
+		 * login process from getting stuck if the initiator
+		 * stops sending data.
+		 */
+		rc = iscsit_set_login_timer_kworker(conn, NULL);
+		if (rc < 0)
+			goto err;
 	} else if (rc == 1) {
+		iscsit_stop_login_timer(conn);
 		cancel_delayed_work(&conn->login_work);
 		iscsi_target_nego_release(conn);
 		iscsi_post_login_handler(np, conn, zero_tsih);
@@ -656,6 +647,7 @@ static void iscsi_target_do_login_rx(struct work_struct *work)
 
 err:
 	iscsi_target_restore_sock_callbacks(conn);
+	iscsit_stop_login_timer(conn);
 	cancel_delayed_work(&conn->login_work);
 	iscsi_target_login_drop(conn, login);
 	iscsit_deaccess_np(np, tpg, tpg_np);
@@ -1130,6 +1122,7 @@ int iscsi_target_locate_portal(
 	iscsi_target_set_sock_callbacks(conn);
 
 	login->np = np;
+	conn->tpg = NULL;
 
 	login_req = (struct iscsi_login_req *) login->req;
 	payload_length = ntoh24(login_req->dlength);
@@ -1197,7 +1190,6 @@ int iscsi_target_locate_portal(
 	 */
 	sessiontype = strncmp(s_buf, DISCOVERY, 9);
 	if (!sessiontype) {
-		conn->tpg = iscsit_global->discovery_tpg;
 		if (!login->leading_connection)
 			goto get_target;
 
@@ -1214,9 +1206,11 @@ int iscsi_target_locate_portal(
 		 * Serialize access across the discovery struct iscsi_portal_group to
 		 * process login attempt.
 		 */
+		conn->tpg = iscsit_global->discovery_tpg;
 		if (iscsit_access_np(np, conn->tpg) < 0) {
 			iscsit_tx_login_rsp(conn, ISCSI_STATUS_CLS_TARGET_ERR,
 				ISCSI_LOGIN_STATUS_SVC_UNAVAILABLE);
+			conn->tpg = NULL;
 			ret = -1;
 			goto out;
 		}
@@ -1368,14 +1362,30 @@ int iscsi_target_start_negotiation(
 	 * and perform connection cleanup now.
 	 */
 	ret = iscsi_target_do_login(conn, login);
-	if (!ret && iscsi_target_sk_check_and_clear(conn, LOGIN_FLAGS_INITIAL_PDU))
-		ret = -1;
+	if (!ret) {
+		spin_lock(&conn->login_worker_lock);
+
+		if (iscsi_target_sk_check_and_clear(conn, LOGIN_FLAGS_INITIAL_PDU))
+			ret = -1;
+		else if (!test_bit(LOGIN_FLAGS_WORKER_RUNNING, &conn->login_flags)) {
+			if (iscsit_set_login_timer_kworker(conn, NULL) < 0) {
+				/*
+				 * The timeout has expired already.
+				 * Schedule login_work to perform the cleanup.
+				 */
+				schedule_delayed_work(&conn->login_work, 0);
+			}
+		}
+
+		spin_unlock(&conn->login_worker_lock);
+	}
 
 	if (ret < 0) {
 		iscsi_target_restore_sock_callbacks(conn);
 		iscsi_remove_failed_auth_entry(conn);
 	}
 	if (ret != 0) {
+		iscsit_stop_login_timer(conn);
 		cancel_delayed_work_sync(&conn->login_work);
 		iscsi_target_nego_release(conn);
 	}
diff --git a/drivers/target/iscsi/iscsi_target_util.c b/drivers/target/iscsi/iscsi_target_util.c
index 26dc8ed3045b..b14835fcb033 100644
--- a/drivers/target/iscsi/iscsi_target_util.c
+++ b/drivers/target/iscsi/iscsi_target_util.c
@@ -1040,6 +1040,57 @@ void iscsit_stop_nopin_timer(struct iscsit_conn *conn)
 	spin_unlock_bh(&conn->nopin_timer_lock);
 }
 
+void iscsit_login_timeout(struct timer_list *t)
+{
+	struct iscsit_conn *conn = from_timer(conn, t, login_timer);
+	struct iscsi_login *login = conn->login;
+
+	pr_debug("Entering iscsi_target_login_timeout >>>>>>>>>>>>>>>>>>>\n");
+
+	spin_lock_bh(&conn->login_timer_lock);
+	login->login_failed = 1;
+
+	if (conn->login_kworker) {
+		pr_debug("Sending SIGINT to conn->login_kworker %s/%d\n",
+			 conn->login_kworker->comm, conn->login_kworker->pid);
+		send_sig(SIGINT, conn->login_kworker, 1);
+	} else {
+		schedule_delayed_work(&conn->login_work, 0);
+	}
+	spin_unlock_bh(&conn->login_timer_lock);
+}
+
+void iscsit_start_login_timer(struct iscsit_conn *conn, struct task_struct *kthr)
+{
+	pr_debug("Login timer started\n");
+
+	conn->login_kworker = kthr;
+	mod_timer(&conn->login_timer, jiffies + TA_LOGIN_TIMEOUT * HZ);
+}
+
+int iscsit_set_login_timer_kworker(struct iscsit_conn *conn, struct task_struct *kthr)
+{
+	struct iscsi_login *login = conn->login;
+	int ret = 0;
+
+	spin_lock_bh(&conn->login_timer_lock);
+	if (login->login_failed) {
+		/* The timer has already expired */
+		ret = -1;
+	} else {
+		conn->login_kworker = kthr;
+	}
+	spin_unlock_bh(&conn->login_timer_lock);
+
+	return ret;
+}
+
+void iscsit_stop_login_timer(struct iscsit_conn *conn)
+{
+	pr_debug("Login timer stopped\n");
+	timer_delete_sync(&conn->login_timer);
+}
+
 int iscsit_send_tx_data(
 	struct iscsit_cmd *cmd,
 	struct iscsit_conn *conn,
diff --git a/drivers/target/iscsi/iscsi_target_util.h b/drivers/target/iscsi/iscsi_target_util.h
index 33ea799a0850..24b8e577575a 100644
--- a/drivers/target/iscsi/iscsi_target_util.h
+++ b/drivers/target/iscsi/iscsi_target_util.h
@@ -56,6 +56,10 @@ extern void iscsit_handle_nopin_timeout(struct timer_list *t);
 extern void __iscsit_start_nopin_timer(struct iscsit_conn *);
 extern void iscsit_start_nopin_timer(struct iscsit_conn *);
 extern void iscsit_stop_nopin_timer(struct iscsit_conn *);
+extern void iscsit_login_timeout(struct timer_list *t);
+extern void iscsit_start_login_timer(struct iscsit_conn *, struct task_struct *kthr);
+extern void iscsit_stop_login_timer(struct iscsit_conn *);
+extern int iscsit_set_login_timer_kworker(struct iscsit_conn *, struct task_struct *kthr);
 extern int iscsit_send_tx_data(struct iscsit_cmd *, struct iscsit_conn *, int);
 extern int iscsit_fe_sendpage_sg(struct iscsit_cmd *, struct iscsit_conn *);
 extern int iscsit_tx_login_rsp(struct iscsit_conn *, u8, u8);
diff --git a/include/target/iscsi/iscsi_target_core.h b/include/target/iscsi/iscsi_target_core.h
index 229118156a1f..4c15420e8965 100644
--- a/include/target/iscsi/iscsi_target_core.h
+++ b/include/target/iscsi/iscsi_target_core.h
@@ -562,12 +562,13 @@ struct iscsit_conn {
 #define LOGIN_FLAGS_READ_ACTIVE		2
 #define LOGIN_FLAGS_WRITE_ACTIVE	3
 #define LOGIN_FLAGS_CLOSED		4
+#define LOGIN_FLAGS_WORKER_RUNNING	5
 	unsigned long		login_flags;
 	struct delayed_work	login_work;
 	struct iscsi_login	*login;
 	struct timer_list	nopin_timer;
 	struct timer_list	nopin_response_timer;
-	struct timer_list	transport_timer;
+	struct timer_list	login_timer;
 	struct task_struct	*login_kworker;
 	/* Spinlock used for add/deleting cmd's from conn_cmd_list */
 	spinlock_t		cmd_lock;
@@ -576,6 +577,8 @@ struct iscsit_conn {
 	spinlock_t		nopin_timer_lock;
 	spinlock_t		response_queue_lock;
 	spinlock_t		state_lock;
+	spinlock_t		login_timer_lock;
+	spinlock_t		login_worker_lock;
 	/* libcrypto RX and TX contexts for crc32c */
 	struct ahash_request	*conn_rx_hash;
 	struct ahash_request	*conn_tx_hash;
@@ -792,7 +795,6 @@ struct iscsi_np {
 	enum np_thread_state_table np_thread_state;
 	bool                    enabled;
 	atomic_t		np_reset_count;
-	enum iscsi_timer_flags_table np_login_timer_flags;
 	u32			np_exports;
 	enum np_flags_table	np_flags;
 	spinlock_t		np_thread_lock;
@@ -800,7 +802,6 @@ struct iscsi_np {
 	struct socket		*np_socket;
 	struct sockaddr_storage np_sockaddr;
 	struct task_struct	*np_thread;
-	struct timer_list	np_login_timer;
 	void			*np_context;
 	struct iscsit_transport *np_transport;
 	struct list_head	np_list;


