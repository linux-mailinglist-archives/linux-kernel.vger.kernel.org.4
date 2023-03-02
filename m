Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54D3A6A82E5
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 13:56:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjCBM4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 07:56:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbjCBMzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 07:55:41 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFCFF4ECC1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 04:55:33 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id u9so17692482edd.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 04:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112; t=1677761733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WEZrr2qFQW9ERuryd/Xa3HES4vMXDyS6kRQIukpjsyc=;
        b=VDDEtLVT6VUv+puMjrWVIxVPND7Xs7qc07Qzwt5O5zUEdmbOcM5yfDHKAXW2vhIRl1
         NYp1OwgHks7M1pz3k7Iqx8HzXHhroBWxqyJPduxpChbNyUXUGJI4CMICykcMo9STJ/OK
         8F3IQJbJII57p0ynsdHj1z0UXz1WiVdKGgK4FMAgSZurin6Qqor2a2w40YCeHIw8UZUv
         rqA9Dpj5oN8hKvfhEye4gCDwEc7dLiYaEF/QHCOPPggVdMOwYeRDy4drRyxt36L9I6RQ
         vjFRhL+FAZE4TIoL1s+koEMwp/KnwYO2tdobSXdea/j8HWs4wZa2IdSxqpVutVZeOaKN
         n/QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677761733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WEZrr2qFQW9ERuryd/Xa3HES4vMXDyS6kRQIukpjsyc=;
        b=PIxcTmmSNtas1oR9FVSFbuMNlAngbQYmlHr81eMtcYgJosx09ZUlIlzXua4FEDI3kJ
         R0cYUSKfzyLloYllXSHQwBIBXSq4lHD2sEkyMhODECdSNJBRvLnfPxqn18v+qLuQY5aE
         RwHOJAjz7cHpd+AOG0Ono7fQufEG5GQo0QKSjf+1txAmS48wetbNz7PC4kS61wFNhc68
         ffAXKZYLacevvHlpq45Ui+QjHdwyqXDN0+ETySdd23Jrx34N6CahQl9SdKuqaCO7kIIc
         P4qqLey6hFiUxlpanrTDtP86xYvlQscomF37eCYaVbsprjZUJDSryO33bbFW+XvmF9hX
         80qw==
X-Gm-Message-State: AO0yUKXG8cs/6Ox7PifhNPTGW/scd1zwpsLdfzMVnTBJ2mPrug9bpjCd
        yIxSX7ME4xTLOtyPy4E/8usSeoBNgLWB2tfviwbDjw==
X-Google-Smtp-Source: AK7set+jyIsEmuqMcnYK7Il5vwmMGkHoN9vkuvyZeZfuFO8JMbBL6MBN3wSsnijIv4JyfRzQ289SGg==
X-Received: by 2002:a17:907:11d1:b0:8b1:304e:589e with SMTP id va17-20020a17090711d100b008b1304e589emr10555759ejb.53.1677761733246;
        Thu, 02 Mar 2023 04:55:33 -0800 (PST)
Received: from localhost.localdomain (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id a98-20020a509eeb000000b004ad601533a3sm6955034edf.55.2023.03.02.04.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 04:55:31 -0800 (PST)
From:   =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        linux-block@vger.kernel.org,
        =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
Subject: [PATCH v2 6/7] drbd: pass drbd_peer_device to __req_mod
Date:   Thu,  2 Mar 2023 13:54:44 +0100
Message-Id: <20230302125445.2653493-7-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230302125445.2653493-1-christoph.boehmwalder@linbit.com>
References: <20230302125445.2653493-1-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to support multiple connections, we need to know which
one we need to modify the request state for.

Originally-from: Lars Ellenberg <lars.ellenberg@linbit.com>
Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/drbd_main.c     | 13 +++++++++----
 drivers/block/drbd/drbd_receiver.c | 18 ++++++++++--------
 drivers/block/drbd/drbd_req.c      | 21 +++++++++++++--------
 drivers/block/drbd/drbd_req.h      | 11 +++++++----
 drivers/block/drbd/drbd_worker.c   | 14 +++++++-------
 5 files changed, 46 insertions(+), 31 deletions(-)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 6647f84f3879..83987e7a5ef2 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -231,9 +231,11 @@ void tl_release(struct drbd_connection *connection, unsigned int barrier_nr,
 		}
 	req = list_prepare_entry(tmp, &connection->transfer_log, tl_requests);
 	list_for_each_entry_safe_from(req, r, &connection->transfer_log, tl_requests) {
+		struct drbd_peer_device *peer_device;
 		if (req->epoch != expect_epoch)
 			break;
-		_req_mod(req, BARRIER_ACKED);
+		peer_device = conn_peer_device(connection, req->device->vnr);
+		_req_mod(req, BARRIER_ACKED, peer_device);
 	}
 	spin_unlock_irq(&connection->resource->req_lock);
 
@@ -256,10 +258,13 @@ void tl_release(struct drbd_connection *connection, unsigned int barrier_nr,
 /* must hold resource->req_lock */
 void _tl_restart(struct drbd_connection *connection, enum drbd_req_event what)
 {
+	struct drbd_peer_device *peer_device;
 	struct drbd_request *req, *r;
 
-	list_for_each_entry_safe(req, r, &connection->transfer_log, tl_requests)
-		_req_mod(req, what);
+	list_for_each_entry_safe(req, r, &connection->transfer_log, tl_requests) {
+		peer_device = conn_peer_device(connection, req->device->vnr);
+		_req_mod(req, what, peer_device);
+	}
 }
 
 void tl_restart(struct drbd_connection *connection, enum drbd_req_event what)
@@ -297,7 +302,7 @@ void tl_abort_disk_io(struct drbd_device *device)
 			continue;
 		if (req->device != device)
 			continue;
-		_req_mod(req, ABORT_DISK_IO);
+		_req_mod(req, ABORT_DISK_IO, NULL);
 	}
 	spin_unlock_irq(&connection->resource->req_lock);
 }
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index e352880c70b5..856c0e3a6630 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -2138,7 +2138,7 @@ static int receive_DataReply(struct drbd_connection *connection, struct packet_i
 
 	err = recv_dless_read(peer_device, req, sector, pi->size);
 	if (!err)
-		req_mod(req, DATA_RECEIVED);
+		req_mod(req, DATA_RECEIVED, peer_device);
 	/* else: nothing. handled from drbd_disconnect...
 	 * I don't think we may complete this just yet
 	 * in case we are "on-disconnect: freeze" */
@@ -2196,7 +2196,7 @@ static void restart_conflicting_writes(struct drbd_device *device,
 			continue;
 		/* as it is RQ_POSTPONED, this will cause it to
 		 * be queued on the retry workqueue. */
-		__req_mod(req, CONFLICT_RESOLVED, NULL);
+		__req_mod(req, CONFLICT_RESOLVED, NULL, NULL);
 	}
 }
 
@@ -2420,6 +2420,7 @@ static blk_opf_t wire_flags_to_bio(struct drbd_connection *connection, u32 dpf)
 static void fail_postponed_requests(struct drbd_device *device, sector_t sector,
 				    unsigned int size)
 {
+	struct drbd_peer_device *peer_device = first_peer_device(device);
 	struct drbd_interval *i;
 
     repeat:
@@ -2433,7 +2434,7 @@ static void fail_postponed_requests(struct drbd_device *device, sector_t sector,
 		if (!(req->rq_state & RQ_POSTPONED))
 			continue;
 		req->rq_state &= ~RQ_POSTPONED;
-		__req_mod(req, NEG_ACKED, &m);
+		__req_mod(req, NEG_ACKED, peer_device, &m);
 		spin_unlock_irq(&device->resource->req_lock);
 		if (m.bio)
 			complete_master_bio(device, &m);
@@ -5661,10 +5662,11 @@ static int got_IsInSync(struct drbd_connection *connection, struct packet_info *
 }
 
 static int
-validate_req_change_req_state(struct drbd_device *device, u64 id, sector_t sector,
+validate_req_change_req_state(struct drbd_peer_device *peer_device, u64 id, sector_t sector,
 			      struct rb_root *root, const char *func,
 			      enum drbd_req_event what, bool missing_ok)
 {
+	struct drbd_device *device = peer_device->device;
 	struct drbd_request *req;
 	struct bio_and_error m;
 
@@ -5674,7 +5676,7 @@ validate_req_change_req_state(struct drbd_device *device, u64 id, sector_t secto
 		spin_unlock_irq(&device->resource->req_lock);
 		return -EIO;
 	}
-	__req_mod(req, what, &m);
+	__req_mod(req, what, peer_device, &m);
 	spin_unlock_irq(&device->resource->req_lock);
 
 	if (m.bio)
@@ -5723,7 +5725,7 @@ static int got_BlockAck(struct drbd_connection *connection, struct packet_info *
 		BUG();
 	}
 
-	return validate_req_change_req_state(device, p->block_id, sector,
+	return validate_req_change_req_state(peer_device, p->block_id, sector,
 					     &device->write_requests, __func__,
 					     what, false);
 }
@@ -5750,7 +5752,7 @@ static int got_NegAck(struct drbd_connection *connection, struct packet_info *pi
 		return 0;
 	}
 
-	err = validate_req_change_req_state(device, p->block_id, sector,
+	err = validate_req_change_req_state(peer_device, p->block_id, sector,
 					    &device->write_requests, __func__,
 					    NEG_ACKED, true);
 	if (err) {
@@ -5781,7 +5783,7 @@ static int got_NegDReply(struct drbd_connection *connection, struct packet_info
 	drbd_err(device, "Got NegDReply; Sector %llus, len %u.\n",
 	    (unsigned long long)sector, be32_to_cpu(p->blksize));
 
-	return validate_req_change_req_state(device, p->block_id, sector,
+	return validate_req_change_req_state(peer_device, p->block_id, sector,
 					     &device->read_requests, __func__,
 					     NEG_ACKED, false);
 }
diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
index e36216d50753..528f29ebf369 100644
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -552,12 +552,15 @@ static inline bool is_pending_write_protocol_A(struct drbd_request *req)
  *  happen "atomically" within the req_lock,
  *  and it enforces that we have to think in a very structured manner
  *  about the "events" that may happen to a request during its life time ...
+ *
+ *
+ * peer_device == NULL means local disk
  */
 int __req_mod(struct drbd_request *req, enum drbd_req_event what,
+		struct drbd_peer_device *peer_device,
 		struct bio_and_error *m)
 {
 	struct drbd_device *const device = req->device;
-	struct drbd_peer_device *const peer_device = first_peer_device(device);
 	struct drbd_connection *const connection = peer_device ? peer_device->connection : NULL;
 	struct net_conf *nc;
 	int p, rv = 0;
@@ -1100,6 +1103,7 @@ static bool drbd_should_send_out_of_sync(union drbd_dev_state s)
 static int drbd_process_write_request(struct drbd_request *req)
 {
 	struct drbd_device *device = req->device;
+	struct drbd_peer_device *peer_device = first_peer_device(device);
 	int remote, send_oos;
 
 	remote = drbd_should_do_remote(device->state);
@@ -1115,7 +1119,7 @@ static int drbd_process_write_request(struct drbd_request *req)
 		/* The only size==0 bios we expect are empty flushes. */
 		D_ASSERT(device, req->master_bio->bi_opf & REQ_PREFLUSH);
 		if (remote)
-			_req_mod(req, QUEUE_AS_DRBD_BARRIER);
+			_req_mod(req, QUEUE_AS_DRBD_BARRIER, peer_device);
 		return remote;
 	}
 
@@ -1125,10 +1129,10 @@ static int drbd_process_write_request(struct drbd_request *req)
 	D_ASSERT(device, !(remote && send_oos));
 
 	if (remote) {
-		_req_mod(req, TO_BE_SENT);
-		_req_mod(req, QUEUE_FOR_NET_WRITE);
+		_req_mod(req, TO_BE_SENT, peer_device);
+		_req_mod(req, QUEUE_FOR_NET_WRITE, peer_device);
 	} else if (drbd_set_out_of_sync(device, req->i.sector, req->i.size))
-		_req_mod(req, QUEUE_FOR_SEND_OOS);
+		_req_mod(req, QUEUE_FOR_SEND_OOS, peer_device);
 
 	return remote;
 }
@@ -1312,6 +1316,7 @@ static void drbd_update_plug(struct drbd_plug_cb *plug, struct drbd_request *req
 static void drbd_send_and_submit(struct drbd_device *device, struct drbd_request *req)
 {
 	struct drbd_resource *resource = device->resource;
+	struct drbd_peer_device *peer_device = first_peer_device(device);
 	const int rw = bio_data_dir(req->master_bio);
 	struct bio_and_error m = { NULL, };
 	bool no_remote = false;
@@ -1375,8 +1380,8 @@ static void drbd_send_and_submit(struct drbd_device *device, struct drbd_request
 		/* We either have a private_bio, or we can read from remote.
 		 * Otherwise we had done the goto nodata above. */
 		if (req->private_bio == NULL) {
-			_req_mod(req, TO_BE_SENT);
-			_req_mod(req, QUEUE_FOR_NET_READ);
+			_req_mod(req, TO_BE_SENT, peer_device);
+			_req_mod(req, QUEUE_FOR_NET_READ, peer_device);
 		} else
 			no_remote = true;
 	}
@@ -1397,7 +1402,7 @@ static void drbd_send_and_submit(struct drbd_device *device, struct drbd_request
 		req->pre_submit_jif = jiffies;
 		list_add_tail(&req->req_pending_local,
 			&device->pending_completion[rw == WRITE]);
-		_req_mod(req, TO_BE_SUBMITTED);
+		_req_mod(req, TO_BE_SUBMITTED, NULL);
 		/* but we need to give up the spinlock to submit */
 		submit_private_bio = true;
 	} else if (no_remote) {
diff --git a/drivers/block/drbd/drbd_req.h b/drivers/block/drbd/drbd_req.h
index b4017b5c3fbc..9ae860e7591b 100644
--- a/drivers/block/drbd/drbd_req.h
+++ b/drivers/block/drbd/drbd_req.h
@@ -267,6 +267,7 @@ struct bio_and_error {
 extern void start_new_tl_epoch(struct drbd_connection *connection);
 extern void drbd_req_destroy(struct kref *kref);
 extern int __req_mod(struct drbd_request *req, enum drbd_req_event what,
+		struct drbd_peer_device *peer_device,
 		struct bio_and_error *m);
 extern void complete_master_bio(struct drbd_device *device,
 		struct bio_and_error *m);
@@ -280,14 +281,15 @@ extern void drbd_restart_request(struct drbd_request *req);
 
 /* use this if you don't want to deal with calling complete_master_bio()
  * outside the spinlock, e.g. when walking some list on cleanup. */
-static inline int _req_mod(struct drbd_request *req, enum drbd_req_event what)
+static inline int _req_mod(struct drbd_request *req, enum drbd_req_event what,
+		struct drbd_peer_device *peer_device)
 {
 	struct drbd_device *device = req->device;
 	struct bio_and_error m;
 	int rv;
 
 	/* __req_mod possibly frees req, do not touch req after that! */
-	rv = __req_mod(req, what, &m);
+	rv = __req_mod(req, what, peer_device, &m);
 	if (m.bio)
 		complete_master_bio(device, &m);
 
@@ -299,7 +301,8 @@ static inline int _req_mod(struct drbd_request *req, enum drbd_req_event what)
  * of the lower level driver completion callback, so we need to
  * spin_lock_irqsave here. */
 static inline int req_mod(struct drbd_request *req,
-		enum drbd_req_event what)
+		enum drbd_req_event what,
+		struct drbd_peer_device *peer_device)
 {
 	unsigned long flags;
 	struct drbd_device *device = req->device;
@@ -307,7 +310,7 @@ static inline int req_mod(struct drbd_request *req,
 	int rv;
 
 	spin_lock_irqsave(&device->resource->req_lock, flags);
-	rv = __req_mod(req, what, &m);
+	rv = __req_mod(req, what, peer_device, &m);
 	spin_unlock_irqrestore(&device->resource->req_lock, flags);
 
 	if (m.bio)
diff --git a/drivers/block/drbd/drbd_worker.c b/drivers/block/drbd/drbd_worker.c
index 68d5ba4af17d..6455edca7aa9 100644
--- a/drivers/block/drbd/drbd_worker.c
+++ b/drivers/block/drbd/drbd_worker.c
@@ -276,7 +276,7 @@ void drbd_request_endio(struct bio *bio)
 
 	/* not req_mod(), we need irqsave here! */
 	spin_lock_irqsave(&device->resource->req_lock, flags);
-	__req_mod(req, what, &m);
+	__req_mod(req, what, NULL, &m);
 	spin_unlock_irqrestore(&device->resource->req_lock, flags);
 	put_ldev(device);
 
@@ -1425,7 +1425,7 @@ int w_send_out_of_sync(struct drbd_work *w, int cancel)
 	int err;
 
 	if (unlikely(cancel)) {
-		req_mod(req, SEND_CANCELED);
+		req_mod(req, SEND_CANCELED, peer_device);
 		return 0;
 	}
 	req->pre_send_jif = jiffies;
@@ -1437,7 +1437,7 @@ int w_send_out_of_sync(struct drbd_work *w, int cancel)
 	maybe_send_barrier(connection, req->epoch);
 
 	err = drbd_send_out_of_sync(peer_device, req);
-	req_mod(req, OOS_HANDED_TO_NETWORK);
+	req_mod(req, OOS_HANDED_TO_NETWORK, peer_device);
 
 	return err;
 }
@@ -1457,7 +1457,7 @@ int w_send_dblock(struct drbd_work *w, int cancel)
 	int err;
 
 	if (unlikely(cancel)) {
-		req_mod(req, SEND_CANCELED);
+		req_mod(req, SEND_CANCELED, peer_device);
 		return 0;
 	}
 	req->pre_send_jif = jiffies;
@@ -1467,7 +1467,7 @@ int w_send_dblock(struct drbd_work *w, int cancel)
 	connection->send.current_epoch_writes++;
 
 	err = drbd_send_dblock(peer_device, req);
-	req_mod(req, err ? SEND_FAILED : HANDED_OVER_TO_NETWORK);
+	req_mod(req, err ? SEND_FAILED : HANDED_OVER_TO_NETWORK, peer_device);
 
 	if (do_send_unplug && !err)
 		pd_send_unplug_remote(peer_device);
@@ -1490,7 +1490,7 @@ int w_send_read_req(struct drbd_work *w, int cancel)
 	int err;
 
 	if (unlikely(cancel)) {
-		req_mod(req, SEND_CANCELED);
+		req_mod(req, SEND_CANCELED, peer_device);
 		return 0;
 	}
 	req->pre_send_jif = jiffies;
@@ -1502,7 +1502,7 @@ int w_send_read_req(struct drbd_work *w, int cancel)
 	err = drbd_send_drequest(peer_device, P_DATA_REQUEST, req->i.sector, req->i.size,
 				 (unsigned long)req);
 
-	req_mod(req, err ? SEND_FAILED : HANDED_OVER_TO_NETWORK);
+	req_mod(req, err ? SEND_FAILED : HANDED_OVER_TO_NETWORK, peer_device);
 
 	if (do_send_unplug && !err)
 		pd_send_unplug_remote(peer_device);
-- 
2.39.1

