Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70E236980EE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 17:32:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbjBOQcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 11:32:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjBOQcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 11:32:13 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B2E23B0F3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 08:32:10 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id o15so16448083wrc.9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 08:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eJdWsIdQgJHO6HdUyEE19gIWuWTne8BQ3dqwrIDRKE0=;
        b=ci17wbX9A/gtzwgo0Q53lieyCiwFja1KZI6b6s8DhtoGmWLR3GBtRJg94XL94+bWVV
         XL6bCmWOsccmojD1Byu3b6/axp2abaIzCDltiCqzxEwB4Qtsiegb5pyqk00omW/b7OSr
         EnyHVGynyCzJAwzMZUiQ+B8e4qOcxjbIQmdqY4FcgBTVv/U82tcFXD+I1PmoiMPngHzg
         edleicWocHZsfuACzVQHIleCy8W4AwKwCq4kNQ6U94vVaurE/KU6yoOR03ZFM/1RrCSb
         yxLcmu4hFuaDXutIveIfd5vwJQSU8uk1RECYfgYFzepxp+6kRSCzHJdqcalK32SuPUmo
         cQoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eJdWsIdQgJHO6HdUyEE19gIWuWTne8BQ3dqwrIDRKE0=;
        b=GXTqcw5fdMXk2H4l8DDV1UoXDeEFGV72P7FPdvj1gXX2M2FrYFJX8WM+cCI4InCUXV
         lKc/+Z4GfMhJ6mL4SZBoRuA5sqzb6aA+QF07IsLMdNZsj+N/y2/PgCfG2W0wv96VYpc4
         DL4TMn6VT7cSPTzOOGct7Cbj9824flLcuH3Ia4EEtf49IFeLO7RLaCi0r2NWI0vz2O5l
         n63t4YEElY6XrR418PvfxODrXPVSpUxZk5u+aH8qedS8fw/sbHKsfMtSXjMQXdiAl+Q7
         CvgYcbbZMSaS5oTxS5aLwuTxPrt9QeZ6rLSCNeplaY1SjJkWnZAjFIrjYqJKNhn03ijf
         cJRw==
X-Gm-Message-State: AO0yUKXyMXukjsCwz/zrMr52CIu2FsKy4OcANp01Kl3Iq/WEVYQVQjPK
        RfpglL56WrM3tQfQMkEqK3rwbw==
X-Google-Smtp-Source: AK7set8mGmfDuKlWZkF6amwaYf6u4qhZ9xfRiU7g1bc+XOenOzfq38s545+lfbRANp1R11aa+iiPSw==
X-Received: by 2002:a5d:58e3:0:b0:2c5:4de4:bcd8 with SMTP id f3-20020a5d58e3000000b002c54de4bcd8mr2340687wrd.36.1676478729138;
        Wed, 15 Feb 2023 08:32:09 -0800 (PST)
Received: from localhost.localdomain (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id n4-20020a5d67c4000000b002c56287bd2csm4865055wrw.114.2023.02.15.08.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 08:32:08 -0800 (PST)
From:   =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        linux-block@vger.kernel.org,
        Andreas Gruenbacher <agruen@kernel.org>,
        =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
Subject: [PATCH 2/7] drbd: Add peer device parameter to whole-bitmap I/O handlers
Date:   Wed, 15 Feb 2023 17:31:59 +0100
Message-Id: <20230215163204.2856631-3-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230215163204.2856631-1-christoph.boehmwalder@linbit.com>
References: <20230215163204.2856631-1-christoph.boehmwalder@linbit.com>
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

From: Andreas Gruenbacher <agruen@kernel.org>

Pass a peer device parameter through the bitmap I/O functions to the I/O
handlers.  In after_state_ch(), set that parameter when queuing the
drbd_send_bitmap operation so that this operation knows where to send the
bitmap.

Signed-off-by: Andreas Gruenbacher <agruen@kernel.org>
Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/drbd_bitmap.c   |  7 ++--
 drivers/block/drbd/drbd_int.h      | 23 ++++++++-----
 drivers/block/drbd/drbd_main.c     | 55 ++++++++++++++++++------------
 drivers/block/drbd/drbd_nl.c       | 14 ++++----
 drivers/block/drbd/drbd_receiver.c |  6 ++--
 drivers/block/drbd/drbd_state.c    |  7 ++--
 6 files changed, 67 insertions(+), 45 deletions(-)

diff --git a/drivers/block/drbd/drbd_bitmap.c b/drivers/block/drbd/drbd_bitmap.c
index 289876ffbc31..7d8e3b02a1da 100644
--- a/drivers/block/drbd/drbd_bitmap.c
+++ b/drivers/block/drbd/drbd_bitmap.c
@@ -1216,7 +1216,9 @@ static int bm_rw(struct drbd_device *device, const unsigned int flags, unsigned
  * drbd_bm_read() - Read the whole bitmap from its on disk location.
  * @device:	DRBD device.
  */
-int drbd_bm_read(struct drbd_device *device) __must_hold(local)
+int drbd_bm_read(struct drbd_device *device,
+		 struct drbd_peer_device *peer_device) __must_hold(local)
+
 {
 	return bm_rw(device, BM_AIO_READ, 0);
 }
@@ -1227,7 +1229,8 @@ int drbd_bm_read(struct drbd_device *device) __must_hold(local)
  *
  * Will only write pages that have changed since last IO.
  */
-int drbd_bm_write(struct drbd_device *device) __must_hold(local)
+int drbd_bm_write(struct drbd_device *device,
+		 struct drbd_peer_device *peer_device) __must_hold(local)
 {
 	return bm_rw(device, 0, 0);
 }
diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index 772023ace749..63919781fe30 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -541,9 +541,10 @@ struct drbd_md_io {
 
 struct bm_io_work {
 	struct drbd_work w;
+	struct drbd_peer_device *peer_device;
 	char *why;
 	enum bm_flag flags;
-	int (*io_fn)(struct drbd_device *device);
+	int (*io_fn)(struct drbd_device *device, struct drbd_peer_device *peer_device);
 	void (*done)(struct drbd_device *device, int rv);
 };
 
@@ -1041,7 +1042,7 @@ extern int drbd_send_drequest_csum(struct drbd_peer_device *, sector_t sector,
 				   enum drbd_packet cmd);
 extern int drbd_send_ov_request(struct drbd_peer_device *, sector_t sector, int size);
 
-extern int drbd_send_bitmap(struct drbd_device *device);
+extern int drbd_send_bitmap(struct drbd_device *device, struct drbd_peer_device *peer_device);
 extern void drbd_send_sr_reply(struct drbd_peer_device *, enum drbd_state_rv retcode);
 extern void conn_send_sr_reply(struct drbd_connection *connection, enum drbd_state_rv retcode);
 extern int drbd_send_rs_deallocated(struct drbd_peer_device *, struct drbd_peer_request *);
@@ -1065,17 +1066,19 @@ extern void drbd_md_clear_flag(struct drbd_device *device, int flags)__must_hold
 extern int drbd_md_test_flag(struct drbd_backing_dev *, int);
 extern void drbd_md_mark_dirty(struct drbd_device *device);
 extern void drbd_queue_bitmap_io(struct drbd_device *device,
-				 int (*io_fn)(struct drbd_device *),
+				 int (*io_fn)(struct drbd_device *, struct drbd_peer_device *),
 				 void (*done)(struct drbd_device *, int),
 				 char *why, enum bm_flag flags);
 extern int drbd_bitmap_io(struct drbd_device *device,
-		int (*io_fn)(struct drbd_device *),
+		int (*io_fn)(struct drbd_device *, struct drbd_peer_device *),
 		char *why, enum bm_flag flags);
 extern int drbd_bitmap_io_from_worker(struct drbd_device *device,
-		int (*io_fn)(struct drbd_device *),
+		int (*io_fn)(struct drbd_device *, struct drbd_peer_device *),
 		char *why, enum bm_flag flags);
-extern int drbd_bmio_set_n_write(struct drbd_device *device) __must_hold(local);
-extern int drbd_bmio_clear_n_write(struct drbd_device *device) __must_hold(local);
+extern int drbd_bmio_set_n_write(struct drbd_device *device,
+		struct drbd_peer_device *peer_device) __must_hold(local);
+extern int drbd_bmio_clear_n_write(struct drbd_device *device,
+		struct drbd_peer_device *peer_device) __must_hold(local);
 
 /* Meta data layout
  *
@@ -1284,9 +1287,11 @@ extern void _drbd_bm_set_bits(struct drbd_device *device,
 		const unsigned long s, const unsigned long e);
 extern int  drbd_bm_test_bit(struct drbd_device *device, unsigned long bitnr);
 extern int  drbd_bm_e_weight(struct drbd_device *device, unsigned long enr);
-extern int  drbd_bm_read(struct drbd_device *device) __must_hold(local);
+extern int  drbd_bm_read(struct drbd_device *device,
+		struct drbd_peer_device *peer_device) __must_hold(local);
 extern void drbd_bm_mark_for_writeout(struct drbd_device *device, int page_nr);
-extern int  drbd_bm_write(struct drbd_device *device) __must_hold(local);
+extern int  drbd_bm_write(struct drbd_device *device,
+		struct drbd_peer_device *peer_device) __must_hold(local);
 extern void drbd_bm_reset_al_hints(struct drbd_device *device) __must_hold(local);
 extern int  drbd_bm_write_hinted(struct drbd_device *device) __must_hold(local);
 extern int  drbd_bm_write_lazy(struct drbd_device *device, unsigned upper_idx) __must_hold(local);
diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 2c764f7ee4a7..5d98017497e4 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -1198,10 +1198,11 @@ static int fill_bitmap_rle_bits(struct drbd_device *device,
  * code upon failure.
  */
 static int
-send_bitmap_rle_or_plain(struct drbd_device *device, struct bm_xfer_ctx *c)
+send_bitmap_rle_or_plain(struct drbd_peer_device *device, struct bm_xfer_ctx *c)
 {
-	struct drbd_socket *sock = &first_peer_device(device)->connection->data;
-	unsigned int header_size = drbd_header_size(first_peer_device(device)->connection);
+	struct drbd_device *device = peer_device->device;
+	struct drbd_socket *sock = &peer_device->connection->data;
+	unsigned int header_size = drbd_header_size(peer_device->connection);
 	struct p_compressed_bm *p = sock->sbuf + header_size;
 	int len, err;
 
@@ -1212,7 +1213,7 @@ send_bitmap_rle_or_plain(struct drbd_device *device, struct bm_xfer_ctx *c)
 
 	if (len) {
 		dcbp_set_code(p, RLE_VLI_Bits);
-		err = __send_command(first_peer_device(device)->connection, device->vnr, sock,
+		err = __send_command(peer_device->connection, device->vnr, sock,
 				     P_COMPRESSED_BITMAP, sizeof(*p) + len,
 				     NULL, 0);
 		c->packets[0]++;
@@ -1233,7 +1234,8 @@ send_bitmap_rle_or_plain(struct drbd_device *device, struct bm_xfer_ctx *c)
 		len = num_words * sizeof(*p);
 		if (len)
 			drbd_bm_get_lel(device, c->word_offset, num_words, p);
-		err = __send_command(first_peer_device(device)->connection, device->vnr, sock, P_BITMAP, len, NULL, 0);
+		err = __send_command(peer_device->connection, device->vnr, sock, P_BITMAP,
+				     len, NULL, 0);
 		c->word_offset += num_words;
 		c->bit_offset = c->word_offset * BITS_PER_LONG;
 
@@ -1254,7 +1256,8 @@ send_bitmap_rle_or_plain(struct drbd_device *device, struct bm_xfer_ctx *c)
 }
 
 /* See the comment at receive_bitmap() */
-static int _drbd_send_bitmap(struct drbd_device *device)
+static int _drbd_send_bitmap(struct drbd_device *device,
+			    struct drbd_peer_device *peer_device)
 {
 	struct bm_xfer_ctx c;
 	int err;
@@ -1285,20 +1288,20 @@ static int _drbd_send_bitmap(struct drbd_device *device)
 	};
 
 	do {
-		err = send_bitmap_rle_or_plain(device, &c);
+		err = send_bitmap_rle_or_plain(peer_device, &c);
 	} while (err > 0);
 
 	return err == 0;
 }
 
-int drbd_send_bitmap(struct drbd_device *device)
+int drbd_send_bitmap(struct drbd_device *device, struct drbd_peer_device *peer_device)
 {
-	struct drbd_socket *sock = &first_peer_device(device)->connection->data;
+	struct drbd_socket *sock = &peer_device->connection->data;
 	int err = -1;
 
 	mutex_lock(&sock->mutex);
 	if (sock->socket)
-		err = !_drbd_send_bitmap(device);
+		err = !_drbd_send_bitmap(device, peer_device);
 	mutex_unlock(&sock->mutex);
 	return err;
 }
@@ -3406,7 +3409,9 @@ void drbd_uuid_set_bm(struct drbd_device *device, u64 val) __must_hold(local)
  *
  * Sets all bits in the bitmap and writes the whole bitmap to stable storage.
  */
-int drbd_bmio_set_n_write(struct drbd_device *device) __must_hold(local)
+int drbd_bmio_set_n_write(struct drbd_device *device,
+			  struct drbd_peer_device *peer_device) __must_hold(local)
+
 {
 	int rv = -EIO;
 
@@ -3414,7 +3419,7 @@ int drbd_bmio_set_n_write(struct drbd_device *device) __must_hold(local)
 	drbd_md_sync(device);
 	drbd_bm_set_all(device);
 
-	rv = drbd_bm_write(device);
+	rv = drbd_bm_write(device, peer_device);
 
 	if (!rv) {
 		drbd_md_clear_flag(device, MDF_FULL_SYNC);
@@ -3430,11 +3435,13 @@ int drbd_bmio_set_n_write(struct drbd_device *device) __must_hold(local)
  *
  * Clears all bits in the bitmap and writes the whole bitmap to stable storage.
  */
-int drbd_bmio_clear_n_write(struct drbd_device *device) __must_hold(local)
+int drbd_bmio_clear_n_write(struct drbd_device *device,
+			  struct drbd_peer_device *peer_device) __must_hold(local)
+
 {
 	drbd_resume_al(device);
 	drbd_bm_clear_all(device);
-	return drbd_bm_write(device);
+	return drbd_bm_write(device, peer_device);
 }
 
 static int w_bitmap_io(struct drbd_work *w, int unused)
@@ -3453,7 +3460,7 @@ static int w_bitmap_io(struct drbd_work *w, int unused)
 
 	if (get_ldev(device)) {
 		drbd_bm_lock(device, work->why, work->flags);
-		rv = work->io_fn(device);
+		rv = work->io_fn(device, work->peer_device);
 		drbd_bm_unlock(device);
 		put_ldev(device);
 	}
@@ -3488,11 +3495,12 @@ static int w_bitmap_io(struct drbd_work *w, int unused)
  * put_ldev().
  */
 void drbd_queue_bitmap_io(struct drbd_device *device,
-			  int (*io_fn)(struct drbd_device *),
+			  int (*io_fn)(struct drbd_device *, struct drbd_peer_device *),
 			  void (*done)(struct drbd_device *, int),
-			  char *why, enum bm_flag flags)
+			  char *why, enum bm_flag flags,
+			  struct drbd_peer_device *peer_device)
 {
-	D_ASSERT(device, current == first_peer_device(device)->connection->worker.task);
+	D_ASSERT(device, current == peer_device->connection->worker.task);
 
 	D_ASSERT(device, !test_bit(BITMAP_IO_QUEUED, &device->flags));
 	D_ASSERT(device, !test_bit(BITMAP_IO, &device->flags));
@@ -3501,6 +3509,7 @@ void drbd_queue_bitmap_io(struct drbd_device *device,
 		drbd_err(device, "FIXME going to queue '%s' but '%s' still pending?\n",
 			why, device->bm_io_work.why);
 
+	device->bm_io_work.peer_device = peer_device;
 	device->bm_io_work.io_fn = io_fn;
 	device->bm_io_work.done = done;
 	device->bm_io_work.why = why;
@@ -3512,7 +3521,7 @@ void drbd_queue_bitmap_io(struct drbd_device *device,
 	 * application IO does not conflict anyways. */
 	if (flags == BM_LOCKED_CHANGE_ALLOWED || atomic_read(&device->ap_bio_cnt) == 0) {
 		if (!test_and_set_bit(BITMAP_IO_QUEUED, &device->flags))
-			drbd_queue_work(&first_peer_device(device)->connection->sender_work,
+			drbd_queue_work(&peer_device->connection->sender_work,
 					&device->bm_io_work.w);
 	}
 	spin_unlock_irq(&device->resource->req_lock);
@@ -3528,8 +3537,10 @@ void drbd_queue_bitmap_io(struct drbd_device *device,
  * freezes application IO while that the actual IO operations runs. This
  * functions MAY NOT be called from worker context.
  */
-int drbd_bitmap_io(struct drbd_device *device, int (*io_fn)(struct drbd_device *),
-		char *why, enum bm_flag flags)
+int drbd_bitmap_io(struct drbd_device *device,
+		int (*io_fn)(struct drbd_device *, struct drbd_peer_device *),
+		char *why, enum bm_flag flags,
+		struct drbd_peer_device *peer_device)
 {
 	/* Only suspend io, if some operation is supposed to be locked out */
 	const bool do_suspend_io = flags & (BM_DONT_CLEAR|BM_DONT_SET|BM_DONT_TEST);
@@ -3541,7 +3552,7 @@ int drbd_bitmap_io(struct drbd_device *device, int (*io_fn)(struct drbd_device *
 		drbd_suspend_io(device);
 
 	drbd_bm_lock(device, why, flags);
-	rv = io_fn(device);
+	rv = io_fn(device, peer_device);
 	drbd_bm_unlock(device);
 
 	if (do_suspend_io)
diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index 60757ac31701..07a52c5a2989 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -1053,7 +1053,7 @@ drbd_determine_dev_size(struct drbd_device *device, enum dds_flags flags, struct
 			 la_size_changed ? "size changed" : "md moved");
 		/* next line implicitly does drbd_suspend_io()+drbd_resume_io() */
 		drbd_bitmap_io(device, md_moved ? &drbd_bm_write_all : &drbd_bm_write,
-			       "size changed", BM_LOCKED_MASK);
+			       "size changed", BM_LOCKED_MASK, NULL);
 
 		/* on-disk bitmap and activity log is authoritative again
 		 * (unless there was an IO error meanwhile...) */
@@ -2027,13 +2027,15 @@ int drbd_adm_attach(struct sk_buff *skb, struct genl_info *info)
 		drbd_info(device, "Assuming that all blocks are out of sync "
 		     "(aka FullSync)\n");
 		if (drbd_bitmap_io(device, &drbd_bmio_set_n_write,
-			"set_n_write from attaching", BM_LOCKED_MASK)) {
+			"set_n_write from attaching", BM_LOCKED_MASK,
+			NULL)) {
 			retcode = ERR_IO_MD_DISK;
 			goto force_diskless_dec;
 		}
 	} else {
 		if (drbd_bitmap_io(device, &drbd_bm_read,
-			"read from attaching", BM_LOCKED_MASK)) {
+			"read from attaching", BM_LOCKED_MASK,
+			NULL)) {
 			retcode = ERR_IO_MD_DISK;
 			goto force_diskless_dec;
 		}
@@ -2972,7 +2974,7 @@ int drbd_adm_invalidate(struct sk_buff *skb, struct genl_info *info)
 		retcode = drbd_request_state(device, NS(disk, D_INCONSISTENT));
 		if (retcode >= SS_SUCCESS) {
 			if (drbd_bitmap_io(device, &drbd_bmio_set_n_write,
-				"set_n_write from invalidate", BM_LOCKED_MASK))
+				"set_n_write from invalidate", BM_LOCKED_MASK, NULL))
 				retcode = ERR_IO_MD_DISK;
 		}
 	} else
@@ -3052,7 +3054,7 @@ int drbd_adm_invalidate_peer(struct sk_buff *skb, struct genl_info *info)
 		if (retcode >= SS_SUCCESS) {
 			if (drbd_bitmap_io(device, &drbd_bmio_set_susp_al,
 				"set_n_write from invalidate_peer",
-				BM_LOCKED_SET_ALLOWED))
+				BM_LOCKED_SET_ALLOWED, NULL))
 				retcode = ERR_IO_MD_DISK;
 		}
 	} else
@@ -4148,7 +4150,7 @@ int drbd_adm_new_c_uuid(struct sk_buff *skb, struct genl_info *info)
 
 	if (args.clear_bm) {
 		err = drbd_bitmap_io(device, &drbd_bmio_clear_n_write,
-			"clear_n_write from new_c_uuid", BM_LOCKED_MASK);
+			"clear_n_write from new_c_uuid", BM_LOCKED_MASK, NULL);
 		if (err) {
 			drbd_err(device, "Writing bitmap failed with %d\n", err);
 			retcode = ERR_IO_MD_DISK;
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 757f4692b5bd..424748f6e4fa 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -3591,7 +3591,7 @@ static enum drbd_conns drbd_sync_handshake(struct drbd_peer_device *peer_device,
 	if (abs(hg) >= 2) {
 		drbd_info(device, "Writing the whole bitmap, full sync required after drbd_sync_handshake.\n");
 		if (drbd_bitmap_io(device, &drbd_bmio_set_n_write, "set_n_write from sync_handshake",
-					BM_LOCKED_SET_ALLOWED))
+					BM_LOCKED_SET_ALLOWED, NULL))
 			return C_MASK;
 	}
 
@@ -4270,7 +4270,7 @@ static int receive_uuids(struct drbd_connection *connection, struct packet_info
 			drbd_info(device, "Accepted new current UUID, preparing to skip initial sync\n");
 			drbd_bitmap_io(device, &drbd_bmio_clear_n_write,
 					"clear_n_write from receive_uuids",
-					BM_LOCKED_TEST_ALLOWED);
+					BM_LOCKED_TEST_ALLOWED, NULL);
 			_drbd_uuid_set(device, UI_CURRENT, p_uuid[UI_CURRENT]);
 			_drbd_uuid_set(device, UI_BITMAP, 0);
 			_drbd_set_state(_NS2(device, disk, D_UP_TO_DATE, pdsk, D_UP_TO_DATE),
@@ -5214,7 +5214,7 @@ static int drbd_disconnected(struct drbd_peer_device *peer_device)
 
 	if (get_ldev(device)) {
 		drbd_bitmap_io(device, &drbd_bm_write_copy_pages,
-				"write from disconnected", BM_LOCKED_CHANGE_ALLOWED);
+				"write from disconnected", BM_LOCKED_CHANGE_ALLOWED, NULL);
 		put_ldev(device);
 	}
 
diff --git a/drivers/block/drbd/drbd_state.c b/drivers/block/drbd/drbd_state.c
index 75d13ea0024f..0b335ddd6d12 100644
--- a/drivers/block/drbd/drbd_state.c
+++ b/drivers/block/drbd/drbd_state.c
@@ -1518,8 +1518,9 @@ static void abw_start_sync(struct drbd_device *device, int rv)
 }
 
 int drbd_bitmap_io_from_worker(struct drbd_device *device,
-		int (*io_fn)(struct drbd_device *),
-		char *why, enum bm_flag flags)
+		int (*io_fn)(struct drbd_device *, struct drbd_peer_device *),
+		char *why, enum bm_flag flags,
+		struct drbd_peer_device *peer_device)
 {
 	int rv;
 
@@ -1529,7 +1530,7 @@ int drbd_bitmap_io_from_worker(struct drbd_device *device,
 	atomic_inc(&device->suspend_cnt);
 
 	drbd_bm_lock(device, why, flags);
-	rv = io_fn(device);
+	rv = io_fn(device, peer_device);
 	drbd_bm_unlock(device);
 
 	drbd_resume_io(device);
-- 
2.39.1

