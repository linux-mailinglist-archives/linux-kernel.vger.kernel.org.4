Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF7016D012B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 12:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbjC3K2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 06:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231354AbjC3K2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 06:28:06 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67273FA
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 03:27:55 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id q19so15460854wrc.5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 03:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112; t=1680172074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4St6uh24Awbc1qjjC/ZMcIQgdiCS0eIqEjOw+n8uQes=;
        b=peDYg6Q3wPpho2zvp0HnZ/LabPkIkTsZ9tW51NCM/EZ01zpT4Hba4hcggCIrIEquJM
         bWapFlQuA3L7BLNEU3UVWKxBKNuxNzAuA/RC+6mtS3sJPwAacuavJKd1f5VV+NNP3m51
         Y7jSQ5QhggllaY/ajE3pkLp8TwOsl9OsstoPoZASBZseYAEYQwb1SHczTQwdRiF2UjhC
         FIaJdPCDI8Ac1rZDzxPkbl82NG53K7B3oYzlEdNX2huzNVAxwDEmPlF9mUi/eSoCA8hz
         J9w9ssi8taITspVjgZJxAwn6AVc6jjOrLau9sBUo30Ac4rpbCr1UIfriGfWABnu+KjMC
         DbAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680172074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4St6uh24Awbc1qjjC/ZMcIQgdiCS0eIqEjOw+n8uQes=;
        b=ZSyEhSbtf2wu/t6MWkiDmDwRJLYP+YIsKkE+HAKkLz3AoaqyGwZmKU6Us/8ntbLgtd
         hgqEMiOGsVqcrlib1WyqpYsEpryj4C8ApZtC5CfUhtVse6WfyVXqPKiFjuO9pTuPgC9k
         yFTxn/w3BvOlBReb7ys45t8uBaVtpWcK7P0IJ6o/kouXV2bD4Sc3WZ+Rq4Wan6QbS0a6
         PEdZstciDRU/56M5W5gXB2hDeXBdeTxeq1ohSc3mXg2wQqv8YjvJKTqhthj35zACJYM1
         6O3f8BfUhW/JqNRZH4nyUc3mtU2E7Q9cPhXK+tIMpcDD9QPlbBZIWSEPQFt/yoXLsG2o
         /c5w==
X-Gm-Message-State: AAQBX9cAbtjOT1fb/hkQgdF1CZNXxKp3A5F1lZp32FIcBhsCbV8ZkTRA
        8hopH+lpTONmiwC5K4CrhHwA2g==
X-Google-Smtp-Source: AKy350YeO2Et5fCmxTA9MiUNUPF5CXNl6QzihU6fLHVyRe7mo25Hcj+djdJkrX/5k6Pc0szusA2vDA==
X-Received: by 2002:adf:f7cc:0:b0:2d6:405f:8b16 with SMTP id a12-20020adff7cc000000b002d6405f8b16mr19255838wrq.66.1680172073758;
        Thu, 30 Mar 2023 03:27:53 -0700 (PDT)
Received: from localhost.localdomain (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id s11-20020adff80b000000b002d6f285c0a2sm26352514wrp.42.2023.03.30.03.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 03:27:53 -0700 (PDT)
From:   =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        linux-block@vger.kernel.org,
        =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
Subject: [PATCH v3 7/7] drbd: Pass a peer device to the resync and online verify functions
Date:   Thu, 30 Mar 2023 12:27:44 +0200
Message-Id: <20230330102744.2128122-8-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230330102744.2128122-1-christoph.boehmwalder@linbit.com>
References: <20230330102744.2128122-1-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Originally-from: Andreas Grünbacher <agruen@linbit.com>
Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/drbd_actlog.c   | 13 ++--
 drivers/block/drbd/drbd_int.h      | 46 +++++++-------
 drivers/block/drbd/drbd_receiver.c | 59 +++++++++---------
 drivers/block/drbd/drbd_req.c      |  9 +--
 drivers/block/drbd/drbd_state.c    | 10 +--
 drivers/block/drbd/drbd_worker.c   | 97 ++++++++++++++++--------------
 6 files changed, 126 insertions(+), 108 deletions(-)

diff --git a/drivers/block/drbd/drbd_actlog.c b/drivers/block/drbd/drbd_actlog.c
index 429255876800..64b3a1c76f03 100644
--- a/drivers/block/drbd/drbd_actlog.c
+++ b/drivers/block/drbd/drbd_actlog.c
@@ -735,8 +735,9 @@ static bool update_rs_extent(struct drbd_device *device,
 	return false;
 }
 
-void drbd_advance_rs_marks(struct drbd_device *device, unsigned long still_to_go)
+void drbd_advance_rs_marks(struct drbd_peer_device *peer_device, unsigned long still_to_go)
 {
+	struct drbd_device *device = peer_device->device;
 	unsigned long now = jiffies;
 	unsigned long last = device->rs_mark_time[device->rs_last_mark];
 	int next = (device->rs_last_mark + 1) % DRBD_SYNC_MARKS;
@@ -819,7 +820,7 @@ static int update_sync_bits(struct drbd_device *device,
 		if (mode == SET_IN_SYNC) {
 			unsigned long still_to_go = drbd_bm_total_weight(device);
 			bool rs_is_done = (still_to_go <= device->rs_failed);
-			drbd_advance_rs_marks(device, still_to_go);
+			drbd_advance_rs_marks(first_peer_device(device), still_to_go);
 			if (cleared || rs_is_done)
 				maybe_schedule_on_disk_bitmap_update(device, rs_is_done);
 		} else if (mode == RECORD_RS_FAILED)
@@ -843,10 +844,11 @@ static bool plausible_request_size(int size)
  * called by worker on C_SYNC_TARGET and receiver on SyncSource.
  *
  */
-int __drbd_change_sync(struct drbd_device *device, sector_t sector, int size,
+int __drbd_change_sync(struct drbd_peer_device *peer_device, sector_t sector, int size,
 		enum update_sync_bits_mode mode)
 {
 	/* Is called from worker and receiver context _only_ */
+	struct drbd_device *device = peer_device->device;
 	unsigned long sbnr, ebnr, lbnr;
 	unsigned long count = 0;
 	sector_t esector, nr_sectors;
@@ -1009,14 +1011,15 @@ int drbd_rs_begin_io(struct drbd_device *device, sector_t sector)
  * tries to set it to BME_LOCKED. Returns 0 upon success, and -EAGAIN
  * if there is still application IO going on in this area.
  */
-int drbd_try_rs_begin_io(struct drbd_device *device, sector_t sector)
+int drbd_try_rs_begin_io(struct drbd_peer_device *peer_device, sector_t sector)
 {
+	struct drbd_device *device = peer_device->device;
 	unsigned int enr = BM_SECT_TO_EXT(sector);
 	const unsigned int al_enr = enr*AL_EXT_PER_BM_SECT;
 	struct lc_element *e;
 	struct bm_extent *bm_ext;
 	int i;
-	bool throttle = drbd_rs_should_slow_down(device, sector, true);
+	bool throttle = drbd_rs_should_slow_down(peer_device, sector, true);
 
 	/* If we need to throttle, a half-locked (only marked BME_NO_WRITES,
 	 * not yet BME_LOCKED) extent needs to be kicked out explicitly if we
diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index 97c091990bf6..a30a5ed811be 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -1433,21 +1433,24 @@ void drbd_resync_after_changed(struct drbd_device *device);
 extern void drbd_start_resync(struct drbd_device *device, enum drbd_conns side);
 extern void resume_next_sg(struct drbd_device *device);
 extern void suspend_other_sg(struct drbd_device *device);
-extern int drbd_resync_finished(struct drbd_device *device);
+extern int drbd_resync_finished(struct drbd_peer_device *peer_device);
 /* maybe rather drbd_main.c ? */
 extern void *drbd_md_get_buffer(struct drbd_device *device, const char *intent);
 extern void drbd_md_put_buffer(struct drbd_device *device);
 extern int drbd_md_sync_page_io(struct drbd_device *device,
 		struct drbd_backing_dev *bdev, sector_t sector, enum req_op op);
-extern void drbd_ov_out_of_sync_found(struct drbd_device *, sector_t, int);
+extern void drbd_ov_out_of_sync_found(struct drbd_peer_device *peer_device,
+		sector_t sector, int size);
 extern void wait_until_done_or_force_detached(struct drbd_device *device,
 		struct drbd_backing_dev *bdev, unsigned int *done);
-extern void drbd_rs_controller_reset(struct drbd_device *device);
+extern void drbd_rs_controller_reset(struct drbd_peer_device *peer_device);
 
-static inline void ov_out_of_sync_print(struct drbd_device *device)
+static inline void ov_out_of_sync_print(struct drbd_peer_device *peer_device)
 {
+	struct drbd_device *device = peer_device->device;
+
 	if (device->ov_last_oos_size) {
-		drbd_err(device, "Out of sync: start=%llu, size=%lu (sectors)\n",
+		drbd_err(peer_device, "Out of sync: start=%llu, size=%lu (sectors)\n",
 		     (unsigned long long)device->ov_last_oos_start,
 		     (unsigned long)device->ov_last_oos_size);
 	}
@@ -1486,7 +1489,7 @@ extern int drbd_ack_receiver(struct drbd_thread *thi);
 extern void drbd_send_ping_wf(struct work_struct *ws);
 extern void drbd_send_acks_wf(struct work_struct *ws);
 extern bool drbd_rs_c_min_rate_throttle(struct drbd_device *device);
-extern bool drbd_rs_should_slow_down(struct drbd_device *device, sector_t sector,
+extern bool drbd_rs_should_slow_down(struct drbd_peer_device *peer_device, sector_t sector,
 		bool throttle_if_app_is_waiting);
 extern int drbd_submit_peer_request(struct drbd_peer_request *peer_req);
 extern int drbd_free_peer_reqs(struct drbd_device *, struct list_head *);
@@ -1542,22 +1545,22 @@ extern void drbd_al_begin_io(struct drbd_device *device, struct drbd_interval *i
 extern void drbd_al_complete_io(struct drbd_device *device, struct drbd_interval *i);
 extern void drbd_rs_complete_io(struct drbd_device *device, sector_t sector);
 extern int drbd_rs_begin_io(struct drbd_device *device, sector_t sector);
-extern int drbd_try_rs_begin_io(struct drbd_device *device, sector_t sector);
+extern int drbd_try_rs_begin_io(struct drbd_peer_device *peer_device, sector_t sector);
 extern void drbd_rs_cancel_all(struct drbd_device *device);
 extern int drbd_rs_del_all(struct drbd_device *device);
-extern void drbd_rs_failed_io(struct drbd_device *device,
+extern void drbd_rs_failed_io(struct drbd_peer_device *peer_device,
 		sector_t sector, int size);
-extern void drbd_advance_rs_marks(struct drbd_device *device, unsigned long still_to_go);
+extern void drbd_advance_rs_marks(struct drbd_peer_device *peer_device, unsigned long still_to_go);
 
 enum update_sync_bits_mode { RECORD_RS_FAILED, SET_OUT_OF_SYNC, SET_IN_SYNC };
-extern int __drbd_change_sync(struct drbd_device *device, sector_t sector, int size,
+extern int __drbd_change_sync(struct drbd_peer_device *peer_device, sector_t sector, int size,
 		enum update_sync_bits_mode mode);
-#define drbd_set_in_sync(device, sector, size) \
-	__drbd_change_sync(device, sector, size, SET_IN_SYNC)
-#define drbd_set_out_of_sync(device, sector, size) \
-	__drbd_change_sync(device, sector, size, SET_OUT_OF_SYNC)
-#define drbd_rs_failed_io(device, sector, size) \
-	__drbd_change_sync(device, sector, size, RECORD_RS_FAILED)
+#define drbd_set_in_sync(peer_device, sector, size) \
+	__drbd_change_sync(peer_device, sector, size, SET_IN_SYNC)
+#define drbd_set_out_of_sync(peer_device, sector, size) \
+	__drbd_change_sync(peer_device, sector, size, SET_OUT_OF_SYNC)
+#define drbd_rs_failed_io(peer_device, sector, size) \
+	__drbd_change_sync(peer_device, sector, size, RECORD_RS_FAILED)
 extern void drbd_al_shrink(struct drbd_device *device);
 extern int drbd_al_initialize(struct drbd_device *, void *);
 
@@ -1945,15 +1948,16 @@ static inline int __dec_ap_pending(struct drbd_device *device)
  * C_SYNC_SOURCE sends P_RS_DATA_REPLY   (and expects P_WRITE_ACK with ID_SYNCER)
  *					   (or P_NEG_ACK with ID_SYNCER)
  */
-static inline void inc_rs_pending(struct drbd_device *device)
+static inline void inc_rs_pending(struct drbd_peer_device *peer_device)
 {
-	atomic_inc(&device->rs_pending_cnt);
+	atomic_inc(&peer_device->device->rs_pending_cnt);
 }
 
-#define dec_rs_pending(device) ((void)expect((device), __dec_rs_pending(device) >= 0))
-static inline int __dec_rs_pending(struct drbd_device *device)
+#define dec_rs_pending(peer_device) \
+	((void)expect((peer_device), __dec_rs_pending(peer_device) >= 0))
+static inline int __dec_rs_pending(struct drbd_peer_device *peer_device)
 {
-	return atomic_dec_return(&device->rs_pending_cnt);
+	return atomic_dec_return(&peer_device->device->rs_pending_cnt);
 }
 
 /* counts how many answers we still need to send to the peer.
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 856c0e3a6630..e54404c632e7 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -2044,11 +2044,11 @@ static int e_end_resync_block(struct drbd_work *w, int unused)
 	D_ASSERT(device, drbd_interval_empty(&peer_req->i));
 
 	if (likely((peer_req->flags & EE_WAS_ERROR) == 0)) {
-		drbd_set_in_sync(device, sector, peer_req->i.size);
+		drbd_set_in_sync(peer_device, sector, peer_req->i.size);
 		err = drbd_send_ack(peer_device, P_RS_WRITE_ACK, peer_req);
 	} else {
 		/* Record failure to sync */
-		drbd_rs_failed_io(device, sector, peer_req->i.size);
+		drbd_rs_failed_io(peer_device, sector, peer_req->i.size);
 
 		err  = drbd_send_ack(peer_device, P_NEG_ACK, peer_req);
 	}
@@ -2067,7 +2067,7 @@ static int recv_resync_read(struct drbd_peer_device *peer_device, sector_t secto
 	if (!peer_req)
 		goto fail;
 
-	dec_rs_pending(device);
+	dec_rs_pending(peer_device);
 
 	inc_unacked(device);
 	/* corresponding dec_unacked() in e_end_resync_block()
@@ -2220,7 +2220,7 @@ static int e_end_block(struct drbd_work *w, int cancel)
 				P_RS_WRITE_ACK : P_WRITE_ACK;
 			err = drbd_send_ack(peer_device, pcmd, peer_req);
 			if (pcmd == P_RS_WRITE_ACK)
-				drbd_set_in_sync(device, sector, peer_req->i.size);
+				drbd_set_in_sync(peer_device, sector, peer_req->i.size);
 		} else {
 			err = drbd_send_ack(peer_device, P_NEG_ACK, peer_req);
 			/* we expect it to be marked out of sync anyways...
@@ -2691,7 +2691,7 @@ static int receive_Data(struct drbd_connection *connection, struct packet_info *
 
 	if (device->state.pdsk < D_INCONSISTENT) {
 		/* In case we have the only disk of the cluster, */
-		drbd_set_out_of_sync(device, peer_req->i.sector, peer_req->i.size);
+		drbd_set_out_of_sync(peer_device, peer_req->i.sector, peer_req->i.size);
 		peer_req->flags &= ~EE_MAY_SET_IN_SYNC;
 		drbd_al_begin_io(device, &peer_req->i);
 		peer_req->flags |= EE_CALL_AL_COMPLETE_IO;
@@ -2730,9 +2730,10 @@ static int receive_Data(struct drbd_connection *connection, struct packet_info *
  * The current sync rate used here uses only the most recent two step marks,
  * to have a short time average so we can react faster.
  */
-bool drbd_rs_should_slow_down(struct drbd_device *device, sector_t sector,
+bool drbd_rs_should_slow_down(struct drbd_peer_device *peer_device, sector_t sector,
 		bool throttle_if_app_is_waiting)
 {
+	struct drbd_device *device = peer_device->device;
 	struct lc_element *tmp;
 	bool throttle = drbd_rs_c_min_rate_throttle(device);
 
@@ -2844,7 +2845,7 @@ static int receive_DataRequest(struct drbd_connection *connection, struct packet
 			break;
 		case P_OV_REPLY:
 			verb = 0;
-			dec_rs_pending(device);
+			dec_rs_pending(peer_device);
 			drbd_send_ack_ex(peer_device, P_OV_RESULT, sector, size, ID_IN_SYNC);
 			break;
 		default:
@@ -2915,7 +2916,7 @@ static int receive_DataRequest(struct drbd_connection *connection, struct packet
 			/* track progress, we may need to throttle */
 			atomic_add(size >> 9, &device->rs_sect_in);
 			peer_req->w.cb = w_e_end_ov_reply;
-			dec_rs_pending(device);
+			dec_rs_pending(peer_device);
 			/* drbd_rs_begin_io done when we sent this request,
 			 * but accounting still needs to be done. */
 			goto submit_for_resync;
@@ -2978,7 +2979,7 @@ static int receive_DataRequest(struct drbd_connection *connection, struct packet
 
 	update_receiver_timing_details(connection, drbd_rs_should_slow_down);
 	if (device->state.peer != R_PRIMARY
-	&& drbd_rs_should_slow_down(device, sector, false))
+	&& drbd_rs_should_slow_down(peer_device, sector, false))
 		schedule_timeout_uninterruptible(HZ/10);
 	update_receiver_timing_details(connection, drbd_rs_begin_io);
 	if (drbd_rs_begin_io(device, sector))
@@ -4450,7 +4451,7 @@ static int receive_state(struct drbd_connection *connection, struct packet_info
 		else if (os.conn >= C_SYNC_SOURCE &&
 			 peer_state.conn == C_CONNECTED) {
 			if (drbd_bm_total_weight(device) <= device->rs_failed)
-				drbd_resync_finished(device);
+				drbd_resync_finished(peer_device);
 			return 0;
 		}
 	}
@@ -4458,8 +4459,8 @@ static int receive_state(struct drbd_connection *connection, struct packet_info
 	/* explicit verify finished notification, stop sector reached. */
 	if (os.conn == C_VERIFY_T && os.disk == D_UP_TO_DATE &&
 	    peer_state.conn == C_CONNECTED && real_peer_disk == D_UP_TO_DATE) {
-		ov_out_of_sync_print(device);
-		drbd_resync_finished(device);
+		ov_out_of_sync_print(peer_device);
+		drbd_resync_finished(peer_device);
 		return 0;
 	}
 
@@ -4937,7 +4938,7 @@ static int receive_out_of_sync(struct drbd_connection *connection, struct packet
 				drbd_conn_str(device->state.conn));
 	}
 
-	drbd_set_out_of_sync(device, be64_to_cpu(p->sector), be32_to_cpu(p->blksize));
+	drbd_set_out_of_sync(peer_device, be64_to_cpu(p->sector), be32_to_cpu(p->blksize));
 
 	return 0;
 }
@@ -4958,7 +4959,7 @@ static int receive_rs_deallocated(struct drbd_connection *connection, struct pac
 	sector = be64_to_cpu(p->sector);
 	size = be32_to_cpu(p->blksize);
 
-	dec_rs_pending(device);
+	dec_rs_pending(peer_device);
 
 	if (get_ldev(device)) {
 		struct drbd_peer_request *peer_req;
@@ -5650,12 +5651,12 @@ static int got_IsInSync(struct drbd_connection *connection, struct packet_info *
 
 	if (get_ldev(device)) {
 		drbd_rs_complete_io(device, sector);
-		drbd_set_in_sync(device, sector, blksize);
+		drbd_set_in_sync(peer_device, sector, blksize);
 		/* rs_same_csums is supposed to count in units of BM_BLOCK_SIZE */
 		device->rs_same_csum += (blksize >> BM_BLOCK_SHIFT);
 		put_ldev(device);
 	}
-	dec_rs_pending(device);
+	dec_rs_pending(peer_device);
 	atomic_add(blksize >> 9, &device->rs_sect_in);
 
 	return 0;
@@ -5701,8 +5702,8 @@ static int got_BlockAck(struct drbd_connection *connection, struct packet_info *
 	update_peer_seq(peer_device, be32_to_cpu(p->seq_num));
 
 	if (p->block_id == ID_SYNCER) {
-		drbd_set_in_sync(device, sector, blksize);
-		dec_rs_pending(device);
+		drbd_set_in_sync(peer_device, sector, blksize);
+		dec_rs_pending(peer_device);
 		return 0;
 	}
 	switch (pi->cmd) {
@@ -5747,8 +5748,8 @@ static int got_NegAck(struct drbd_connection *connection, struct packet_info *pi
 	update_peer_seq(peer_device, be32_to_cpu(p->seq_num));
 
 	if (p->block_id == ID_SYNCER) {
-		dec_rs_pending(device);
-		drbd_rs_failed_io(device, sector, size);
+		dec_rs_pending(peer_device);
+		drbd_rs_failed_io(peer_device, sector, size);
 		return 0;
 	}
 
@@ -5761,7 +5762,7 @@ static int got_NegAck(struct drbd_connection *connection, struct packet_info *pi
 		   request is no longer in the collision hash. */
 		/* In Protocol B we might already have got a P_RECV_ACK
 		   but then get a P_NEG_ACK afterwards. */
-		drbd_set_out_of_sync(device, sector, size);
+		drbd_set_out_of_sync(peer_device, sector, size);
 	}
 	return 0;
 }
@@ -5806,13 +5807,13 @@ static int got_NegRSDReply(struct drbd_connection *connection, struct packet_inf
 
 	update_peer_seq(peer_device, be32_to_cpu(p->seq_num));
 
-	dec_rs_pending(device);
+	dec_rs_pending(peer_device);
 
 	if (get_ldev_if_state(device, D_FAILED)) {
 		drbd_rs_complete_io(device, sector);
 		switch (pi->cmd) {
 		case P_NEG_RS_DREPLY:
-			drbd_rs_failed_io(device, sector, size);
+			drbd_rs_failed_io(peer_device, sector, size);
 			break;
 		case P_RS_CANCEL:
 			break;
@@ -5869,21 +5870,21 @@ static int got_OVResult(struct drbd_connection *connection, struct packet_info *
 	update_peer_seq(peer_device, be32_to_cpu(p->seq_num));
 
 	if (be64_to_cpu(p->block_id) == ID_OUT_OF_SYNC)
-		drbd_ov_out_of_sync_found(device, sector, size);
+		drbd_ov_out_of_sync_found(peer_device, sector, size);
 	else
-		ov_out_of_sync_print(device);
+		ov_out_of_sync_print(peer_device);
 
 	if (!get_ldev(device))
 		return 0;
 
 	drbd_rs_complete_io(device, sector);
-	dec_rs_pending(device);
+	dec_rs_pending(peer_device);
 
 	--device->ov_left;
 
 	/* let's advance progress step marks only for every other megabyte */
 	if ((device->ov_left & 0x200) == 0x200)
-		drbd_advance_rs_marks(device, device->ov_left);
+		drbd_advance_rs_marks(peer_device, device->ov_left);
 
 	if (device->ov_left == 0) {
 		dw = kmalloc(sizeof(*dw), GFP_NOIO);
@@ -5893,8 +5894,8 @@ static int got_OVResult(struct drbd_connection *connection, struct packet_info *
 			drbd_queue_work(&peer_device->connection->sender_work, &dw->w);
 		} else {
 			drbd_err(device, "kmalloc(dw) failed.");
-			ov_out_of_sync_print(device);
-			drbd_resync_finished(device);
+			ov_out_of_sync_print(peer_device);
+			drbd_resync_finished(peer_device);
 		}
 	}
 	put_ldev(device);
diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
index 528f29ebf369..380e6584a4ee 100644
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -122,12 +122,13 @@ void drbd_req_destroy(struct kref *kref)
 		 * before it even was submitted or sent.
 		 * In that case we do not want to touch the bitmap at all.
 		 */
+		struct drbd_peer_device *peer_device = first_peer_device(device);
 		if ((s & (RQ_POSTPONED|RQ_LOCAL_MASK|RQ_NET_MASK)) != RQ_POSTPONED) {
 			if (!(s & RQ_NET_OK) || !(s & RQ_LOCAL_OK))
-				drbd_set_out_of_sync(device, req->i.sector, req->i.size);
+				drbd_set_out_of_sync(peer_device, req->i.sector, req->i.size);
 
 			if ((s & RQ_NET_OK) && (s & RQ_LOCAL_OK) && (s & RQ_NET_SIS))
-				drbd_set_in_sync(device, req->i.sector, req->i.size);
+				drbd_set_in_sync(peer_device, req->i.sector, req->i.size);
 		}
 
 		/* one might be tempted to move the drbd_al_complete_io
@@ -620,7 +621,7 @@ int __req_mod(struct drbd_request *req, enum drbd_req_event what,
 		break;
 
 	case READ_COMPLETED_WITH_ERROR:
-		drbd_set_out_of_sync(device, req->i.sector, req->i.size);
+		drbd_set_out_of_sync(peer_device, req->i.sector, req->i.size);
 		drbd_report_io_error(device, req);
 		__drbd_chk_io_error(device, DRBD_READ_ERROR);
 		fallthrough;
@@ -1131,7 +1132,7 @@ static int drbd_process_write_request(struct drbd_request *req)
 	if (remote) {
 		_req_mod(req, TO_BE_SENT, peer_device);
 		_req_mod(req, QUEUE_FOR_NET_WRITE, peer_device);
-	} else if (drbd_set_out_of_sync(device, req->i.sector, req->i.size))
+	} else if (drbd_set_out_of_sync(peer_device, req->i.sector, req->i.size))
 		_req_mod(req, QUEUE_FOR_SEND_OOS, peer_device);
 
 	return remote;
diff --git a/drivers/block/drbd/drbd_state.c b/drivers/block/drbd/drbd_state.c
index c92dc6093b0a..563e67f1ead9 100644
--- a/drivers/block/drbd/drbd_state.c
+++ b/drivers/block/drbd/drbd_state.c
@@ -1222,9 +1222,11 @@ void drbd_resume_al(struct drbd_device *device)
 }
 
 /* helper for _drbd_set_state */
-static void set_ov_position(struct drbd_device *device, enum drbd_conns cs)
+static void set_ov_position(struct drbd_peer_device *peer_device, enum drbd_conns cs)
 {
-	if (first_peer_device(device)->connection->agreed_pro_version < 90)
+	struct drbd_device *device = peer_device->device;
+
+	if (peer_device->connection->agreed_pro_version < 90)
 		device->ov_start_sector = 0;
 	device->rs_total = drbd_bm_bits(device);
 	device->ov_position = 0;
@@ -1387,7 +1389,7 @@ _drbd_set_state(struct drbd_device *device, union drbd_state ns,
 		unsigned long now = jiffies;
 		int i;
 
-		set_ov_position(device, ns.conn);
+		set_ov_position(peer_device, ns.conn);
 		device->rs_start = now;
 		device->rs_last_sect_ev = 0;
 		device->ov_last_oos_size = 0;
@@ -1398,7 +1400,7 @@ _drbd_set_state(struct drbd_device *device, union drbd_state ns,
 			device->rs_mark_time[i] = now;
 		}
 
-		drbd_rs_controller_reset(device);
+		drbd_rs_controller_reset(peer_device);
 
 		if (ns.conn == C_VERIFY_S) {
 			drbd_info(device, "Starting Online Verify from sector %llu\n",
diff --git a/drivers/block/drbd/drbd_worker.c b/drivers/block/drbd/drbd_worker.c
index 6455edca7aa9..4352a50fbb3f 100644
--- a/drivers/block/drbd/drbd_worker.c
+++ b/drivers/block/drbd/drbd_worker.c
@@ -28,8 +28,8 @@
 #include "drbd_protocol.h"
 #include "drbd_req.h"
 
-static int make_ov_request(struct drbd_device *, int);
-static int make_resync_request(struct drbd_device *, int);
+static int make_ov_request(struct drbd_peer_device *, int);
+static int make_resync_request(struct drbd_peer_device *, int);
 
 /* endio handlers:
  *   drbd_md_endio (defined here)
@@ -124,7 +124,7 @@ void drbd_endio_write_sec_final(struct drbd_peer_request *peer_req) __releases(l
 		 * In case of a write error, send the neg ack anyways. */
 		if (!__test_and_set_bit(__EE_SEND_WRITE_ACK, &peer_req->flags))
 			inc_unacked(device);
-		drbd_set_out_of_sync(device, peer_req->i.sector, peer_req->i.size);
+		drbd_set_out_of_sync(peer_device, peer_req->i.sector, peer_req->i.size);
 	}
 
 	spin_lock_irqsave(&device->resource->req_lock, flags);
@@ -363,7 +363,7 @@ static int w_e_send_csum(struct drbd_work *w, int cancel)
 		 * drbd_alloc_pages due to pp_in_use > max_buffers. */
 		drbd_free_peer_req(device, peer_req);
 		peer_req = NULL;
-		inc_rs_pending(device);
+		inc_rs_pending(peer_device);
 		err = drbd_send_drequest_csum(peer_device, sector, size,
 					      digest, digest_size,
 					      P_CSUM_RS_REQUEST);
@@ -430,10 +430,10 @@ int w_resync_timer(struct drbd_work *w, int cancel)
 
 	switch (device->state.conn) {
 	case C_VERIFY_S:
-		make_ov_request(device, cancel);
+		make_ov_request(first_peer_device(device), cancel);
 		break;
 	case C_SYNC_TARGET:
-		make_resync_request(device, cancel);
+		make_resync_request(first_peer_device(device), cancel);
 		break;
 	}
 
@@ -493,8 +493,9 @@ struct fifo_buffer *fifo_alloc(unsigned int fifo_size)
 	return fb;
 }
 
-static int drbd_rs_controller(struct drbd_device *device, unsigned int sect_in)
+static int drbd_rs_controller(struct drbd_peer_device *peer_device, unsigned int sect_in)
 {
+	struct drbd_device *device = peer_device->device;
 	struct disk_conf *dc;
 	unsigned int want;     /* The number of sectors we want in-flight */
 	int req_sect; /* Number of sectors to request in this turn */
@@ -545,8 +546,9 @@ static int drbd_rs_controller(struct drbd_device *device, unsigned int sect_in)
 	return req_sect;
 }
 
-static int drbd_rs_number_requests(struct drbd_device *device)
+static int drbd_rs_number_requests(struct drbd_peer_device *peer_device)
 {
+	struct drbd_device *device = peer_device->device;
 	unsigned int sect_in;  /* Number of sectors that came in since the last turn */
 	int number, mxb;
 
@@ -556,7 +558,7 @@ static int drbd_rs_number_requests(struct drbd_device *device)
 	rcu_read_lock();
 	mxb = drbd_get_max_buffers(device) / 2;
 	if (rcu_dereference(device->rs_plan_s)->size) {
-		number = drbd_rs_controller(device, sect_in) >> (BM_BLOCK_SHIFT - 9);
+		number = drbd_rs_controller(peer_device, sect_in) >> (BM_BLOCK_SHIFT - 9);
 		device->c_sync_rate = number * HZ * (BM_BLOCK_SIZE / 1024) / SLEEP_TIME;
 	} else {
 		device->c_sync_rate = rcu_dereference(device->ldev->disk_conf)->resync_rate;
@@ -580,9 +582,9 @@ static int drbd_rs_number_requests(struct drbd_device *device)
 	return number;
 }
 
-static int make_resync_request(struct drbd_device *const device, int cancel)
+static int make_resync_request(struct drbd_peer_device *const peer_device, int cancel)
 {
-	struct drbd_peer_device *const peer_device = first_peer_device(device);
+	struct drbd_device *const device = peer_device->device;
 	struct drbd_connection *const connection = peer_device ? peer_device->connection : NULL;
 	unsigned long bit;
 	sector_t sector;
@@ -598,7 +600,7 @@ static int make_resync_request(struct drbd_device *const device, int cancel)
 
 	if (device->rs_total == 0) {
 		/* empty resync? */
-		drbd_resync_finished(device);
+		drbd_resync_finished(peer_device);
 		return 0;
 	}
 
@@ -618,7 +620,7 @@ static int make_resync_request(struct drbd_device *const device, int cancel)
 	}
 
 	max_bio_size = queue_max_hw_sectors(device->rq_queue) << 9;
-	number = drbd_rs_number_requests(device);
+	number = drbd_rs_number_requests(peer_device);
 	if (number <= 0)
 		goto requeue;
 
@@ -653,7 +655,7 @@ static int make_resync_request(struct drbd_device *const device, int cancel)
 
 		sector = BM_BIT_TO_SECT(bit);
 
-		if (drbd_try_rs_begin_io(device, sector)) {
+		if (drbd_try_rs_begin_io(peer_device, sector)) {
 			device->bm_resync_fo = bit;
 			goto requeue;
 		}
@@ -729,13 +731,13 @@ static int make_resync_request(struct drbd_device *const device, int cancel)
 		} else {
 			int err;
 
-			inc_rs_pending(device);
+			inc_rs_pending(peer_device);
 			err = drbd_send_drequest(peer_device,
 						 size == discard_granularity ? P_RS_THIN_REQ : P_RS_DATA_REQUEST,
 						 sector, size, ID_SYNCER);
 			if (err) {
 				drbd_err(device, "drbd_send_drequest() failed, aborting...\n");
-				dec_rs_pending(device);
+				dec_rs_pending(peer_device);
 				put_ldev(device);
 				return err;
 			}
@@ -760,8 +762,9 @@ static int make_resync_request(struct drbd_device *const device, int cancel)
 	return 0;
 }
 
-static int make_ov_request(struct drbd_device *device, int cancel)
+static int make_ov_request(struct drbd_peer_device *peer_device, int cancel)
 {
+	struct drbd_device *device = peer_device->device;
 	int number, i, size;
 	sector_t sector;
 	const sector_t capacity = get_capacity(device->vdisk);
@@ -770,7 +773,7 @@ static int make_ov_request(struct drbd_device *device, int cancel)
 	if (unlikely(cancel))
 		return 1;
 
-	number = drbd_rs_number_requests(device);
+	number = drbd_rs_number_requests(peer_device);
 
 	sector = device->ov_position;
 	for (i = 0; i < number; i++) {
@@ -788,7 +791,7 @@ static int make_ov_request(struct drbd_device *device, int cancel)
 
 		size = BM_BLOCK_SIZE;
 
-		if (drbd_try_rs_begin_io(device, sector)) {
+		if (drbd_try_rs_begin_io(peer_device, sector)) {
 			device->ov_position = sector;
 			goto requeue;
 		}
@@ -796,9 +799,9 @@ static int make_ov_request(struct drbd_device *device, int cancel)
 		if (sector + (size>>9) > capacity)
 			size = (capacity-sector)<<9;
 
-		inc_rs_pending(device);
+		inc_rs_pending(peer_device);
 		if (drbd_send_ov_request(first_peer_device(device), sector, size)) {
-			dec_rs_pending(device);
+			dec_rs_pending(peer_device);
 			return 0;
 		}
 		sector += BM_SECT_PER_BIT;
@@ -818,8 +821,8 @@ int w_ov_finished(struct drbd_work *w, int cancel)
 		container_of(w, struct drbd_device_work, w);
 	struct drbd_device *device = dw->device;
 	kfree(dw);
-	ov_out_of_sync_print(device);
-	drbd_resync_finished(device);
+	ov_out_of_sync_print(first_peer_device(device));
+	drbd_resync_finished(first_peer_device(device));
 
 	return 0;
 }
@@ -831,7 +834,7 @@ static int w_resync_finished(struct drbd_work *w, int cancel)
 	struct drbd_device *device = dw->device;
 	kfree(dw);
 
-	drbd_resync_finished(device);
+	drbd_resync_finished(first_peer_device(device));
 
 	return 0;
 }
@@ -846,9 +849,10 @@ static void ping_peer(struct drbd_device *device)
 		   test_bit(GOT_PING_ACK, &connection->flags) || device->state.conn < C_CONNECTED);
 }
 
-int drbd_resync_finished(struct drbd_device *device)
+int drbd_resync_finished(struct drbd_peer_device *peer_device)
 {
-	struct drbd_connection *connection = first_peer_device(device)->connection;
+	struct drbd_device *device = peer_device->device;
+	struct drbd_connection *connection = peer_device->connection;
 	unsigned long db, dt, dbdt;
 	unsigned long n_oos;
 	union drbd_state os, ns;
@@ -1129,7 +1133,7 @@ int w_e_end_rsdata_req(struct drbd_work *w, int cancel)
 		err = drbd_send_ack(peer_device, P_RS_CANCEL, peer_req);
 	} else if (likely((peer_req->flags & EE_WAS_ERROR) == 0)) {
 		if (likely(device->state.pdsk >= D_INCONSISTENT)) {
-			inc_rs_pending(device);
+			inc_rs_pending(peer_device);
 			if (peer_req->flags & EE_RS_THIN_REQ && all_zero(peer_req))
 				err = drbd_send_rs_deallocated(peer_device, peer_req);
 			else
@@ -1148,7 +1152,7 @@ int w_e_end_rsdata_req(struct drbd_work *w, int cancel)
 		err = drbd_send_ack(peer_device, P_NEG_RS_DREPLY, peer_req);
 
 		/* update resync data with failure */
-		drbd_rs_failed_io(device, peer_req->i.sector, peer_req->i.size);
+		drbd_rs_failed_io(peer_device, peer_req->i.sector, peer_req->i.size);
 	}
 
 	dec_unacked(device);
@@ -1199,12 +1203,12 @@ int w_e_end_csum_rs_req(struct drbd_work *w, int cancel)
 		}
 
 		if (eq) {
-			drbd_set_in_sync(device, peer_req->i.sector, peer_req->i.size);
+			drbd_set_in_sync(peer_device, peer_req->i.sector, peer_req->i.size);
 			/* rs_same_csums unit is BM_BLOCK_SIZE */
 			device->rs_same_csum += peer_req->i.size >> BM_BLOCK_SHIFT;
 			err = drbd_send_ack(peer_device, P_RS_IS_IN_SYNC, peer_req);
 		} else {
-			inc_rs_pending(device);
+			inc_rs_pending(peer_device);
 			peer_req->block_id = ID_SYNCER; /* By setting block_id, digest pointer becomes invalid! */
 			peer_req->flags &= ~EE_HAS_DIGEST; /* This peer request no longer has a digest pointer */
 			kfree(di);
@@ -1257,10 +1261,10 @@ int w_e_end_ov_req(struct drbd_work *w, int cancel)
 	 * drbd_alloc_pages due to pp_in_use > max_buffers. */
 	drbd_free_peer_req(device, peer_req);
 	peer_req = NULL;
-	inc_rs_pending(device);
+	inc_rs_pending(peer_device);
 	err = drbd_send_drequest_csum(peer_device, sector, size, digest, digest_size, P_OV_REPLY);
 	if (err)
-		dec_rs_pending(device);
+		dec_rs_pending(peer_device);
 	kfree(digest);
 
 out:
@@ -1270,15 +1274,16 @@ int w_e_end_ov_req(struct drbd_work *w, int cancel)
 	return err;
 }
 
-void drbd_ov_out_of_sync_found(struct drbd_device *device, sector_t sector, int size)
+void drbd_ov_out_of_sync_found(struct drbd_peer_device *peer_device, sector_t sector, int size)
 {
+	struct drbd_device *device = peer_device->device;
 	if (device->ov_last_oos_start + device->ov_last_oos_size == sector) {
 		device->ov_last_oos_size += size>>9;
 	} else {
 		device->ov_last_oos_start = sector;
 		device->ov_last_oos_size = size>>9;
 	}
-	drbd_set_out_of_sync(device, sector, size);
+	drbd_set_out_of_sync(peer_device, sector, size);
 }
 
 int w_e_end_ov_reply(struct drbd_work *w, int cancel)
@@ -1328,9 +1333,9 @@ int w_e_end_ov_reply(struct drbd_work *w, int cancel)
 	 * drbd_alloc_pages due to pp_in_use > max_buffers. */
 	drbd_free_peer_req(device, peer_req);
 	if (!eq)
-		drbd_ov_out_of_sync_found(device, sector, size);
+		drbd_ov_out_of_sync_found(peer_device, sector, size);
 	else
-		ov_out_of_sync_print(device);
+		ov_out_of_sync_print(peer_device);
 
 	err = drbd_send_ack_ex(peer_device, P_OV_RESULT, sector, size,
 			       eq ? ID_IN_SYNC : ID_OUT_OF_SYNC);
@@ -1341,14 +1346,14 @@ int w_e_end_ov_reply(struct drbd_work *w, int cancel)
 
 	/* let's advance progress step marks only for every other megabyte */
 	if ((device->ov_left & 0x200) == 0x200)
-		drbd_advance_rs_marks(device, device->ov_left);
+		drbd_advance_rs_marks(peer_device, device->ov_left);
 
 	stop_sector_reached = verify_can_do_stop_sector(device) &&
 		(sector + (size>>9)) >= device->ov_stop_sector;
 
 	if (device->ov_left == 0 || stop_sector_reached) {
-		ov_out_of_sync_print(device);
-		drbd_resync_finished(device);
+		ov_out_of_sync_print(peer_device);
+		drbd_resync_finished(peer_device);
 	}
 
 	return err;
@@ -1668,8 +1673,9 @@ void drbd_resync_after_changed(struct drbd_device *device)
 	} while (changed);
 }
 
-void drbd_rs_controller_reset(struct drbd_device *device)
+void drbd_rs_controller_reset(struct drbd_peer_device *peer_device)
 {
+	struct drbd_device *device = peer_device->device;
 	struct gendisk *disk = device->ldev->backing_bdev->bd_disk;
 	struct fifo_buffer *plan;
 
@@ -1891,10 +1897,10 @@ void drbd_start_resync(struct drbd_device *device, enum drbd_conns side)
 				rcu_read_unlock();
 				schedule_timeout_interruptible(timeo);
 			}
-			drbd_resync_finished(device);
+			drbd_resync_finished(peer_device);
 		}
 
-		drbd_rs_controller_reset(device);
+		drbd_rs_controller_reset(peer_device);
 		/* ns.conn may already be != device->state.conn,
 		 * we may have been paused in between, or become paused until
 		 * the timer triggers.
@@ -1909,8 +1915,9 @@ void drbd_start_resync(struct drbd_device *device, enum drbd_conns side)
 	mutex_unlock(device->state_mutex);
 }
 
-static void update_on_disk_bitmap(struct drbd_device *device, bool resync_done)
+static void update_on_disk_bitmap(struct drbd_peer_device *peer_device, bool resync_done)
 {
+	struct drbd_device *device = peer_device->device;
 	struct sib_info sib = { .sib_reason = SIB_SYNC_PROGRESS, };
 	device->rs_last_bcast = jiffies;
 
@@ -1919,7 +1926,7 @@ static void update_on_disk_bitmap(struct drbd_device *device, bool resync_done)
 
 	drbd_bm_write_lazy(device, 0);
 	if (resync_done && is_sync_state(device->state.conn))
-		drbd_resync_finished(device);
+		drbd_resync_finished(peer_device);
 
 	drbd_bcast_event(device, &sib);
 	/* update timestamp, in case it took a while to write out stuff */
@@ -2018,7 +2025,7 @@ static void do_device_work(struct drbd_device *device, const unsigned long todo)
 		do_md_sync(device);
 	if (test_bit(RS_DONE, &todo) ||
 	    test_bit(RS_PROGRESS, &todo))
-		update_on_disk_bitmap(device, test_bit(RS_DONE, &todo));
+		update_on_disk_bitmap(first_peer_device(device), test_bit(RS_DONE, &todo));
 	if (test_bit(GO_DISKLESS, &todo))
 		go_diskless(device);
 	if (test_bit(DESTROY_DISK, &todo))
-- 
2.39.2

