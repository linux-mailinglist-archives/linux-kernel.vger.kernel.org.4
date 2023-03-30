Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01B4C6D012F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 12:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbjC3K2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 06:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231332AbjC3K14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 06:27:56 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 623BE9009
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 03:27:52 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id l12so18512792wrm.10
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 03:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112; t=1680172070;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dHMmSLWYuv9gD66MT1Hb13wFciVVvweSeH4fFjFWdJU=;
        b=gKCWNt6SyQJpMKJPztssxJ+NcBn+4S/lrpCEMIyZLHh2CX66Zr7CWEueyyqm93bHyf
         NZh70gBDwEFjwD5Nxs7rTYNWK+DaM0x24dVVHI16a5GcrfGTYnVvj6x+A7TrnM6szXoc
         3wLSHprtKQum6bOnVUjP6S7TVEYD9nnymy9TvK4VsSHkHHkY47ft3nNPbYE8k1y2bPCi
         6WEAOkPiXhkO6PCuhgZwCQv1ZMgtvbZzBP3hAtScPP5/XMKhNPjiUTKMFQ7bRcXhmrPM
         JVRCqgckI+6FTfuDlNkgWQCdiYBYRTRr7vFU6pD16+Q23HEAzXlx4WC25cZMYWdx/fGA
         3JaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680172070;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dHMmSLWYuv9gD66MT1Hb13wFciVVvweSeH4fFjFWdJU=;
        b=swFQVtmFYZOp8vfVsDHwSTOqgb7dTn4Cpopy11yIUcBNIqPybEKbSWjbmKbUlzy72d
         Xn4QhLqfs0mhYi73d5tWUEmItq4aeXoxi90yxSQXenqCz660LZTOuqu4I+vf3utf1hG/
         V6lU/rpk/i8YIMWJtfoyG4qxmlzA69Kto/01B5KlLoOtcxwvjCvNANtshn7gV1onhnGx
         LbiAOucObcLAF7Y9D8DgrmxHAf/wLchb4NLdMpplgrbb0P7YOjiJ5JLy82ngjeY/x3cp
         aSlixMxPdLHeVE3zLGwcNFe7pnot5EmqPMbutjMboATFPUeHS8Tbxq9mz9B+yJP2RJHl
         N7dg==
X-Gm-Message-State: AAQBX9eFyaLHFn3PCsQOtNhtI+CjVDNjtQThYXt2bhpzao73qWF0LofY
        pSyzW9n/UDfICNNnU8dIkosEjg==
X-Google-Smtp-Source: AKy350Y132XgUHS7EMVUzJDK7N0MXOMWLExhI8iCBO3HD2/mpGJkhD4Fg6q7n6KrE7yY7XHdcgiMuA==
X-Received: by 2002:adf:cd0b:0:b0:2e4:fe3e:85ae with SMTP id w11-20020adfcd0b000000b002e4fe3e85aemr887091wrm.56.1680172070341;
        Thu, 30 Mar 2023 03:27:50 -0700 (PDT)
Received: from localhost.localdomain (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id s11-20020adff80b000000b002d6f285c0a2sm26352514wrp.42.2023.03.30.03.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 03:27:49 -0700 (PDT)
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
Subject: [PATCH v3 3/7] drbd: Add peer device parameter to whole-bitmap I/O handlers
Date:   Thu, 30 Mar 2023 12:27:40 +0200
Message-Id: <20230330102744.2128122-4-christoph.boehmwalder@linbit.com>
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

From: Andreas Gruenbacher <agruen@kernel.org>

Pass a peer device parameter through the bitmap I/O functions to the I/O
handlers.  In after_state_ch(), set that parameter when queuing the
drbd_send_bitmap operation so that this operation knows where to send the
bitmap.

Signed-off-by: Andreas Gruenbacher <agruen@kernel.org>
Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/drbd_bitmap.c   | 13 ++++---
 drivers/block/drbd/drbd_int.h      | 39 ++++++++++++--------
 drivers/block/drbd/drbd_main.c     | 57 ++++++++++++++++++------------
 drivers/block/drbd/drbd_nl.c       | 19 +++++-----
 drivers/block/drbd/drbd_receiver.c |  8 ++---
 drivers/block/drbd/drbd_state.c    | 19 +++++-----
 drivers/block/drbd/drbd_worker.c   |  3 +-
 7 files changed, 96 insertions(+), 62 deletions(-)

diff --git a/drivers/block/drbd/drbd_bitmap.c b/drivers/block/drbd/drbd_bitmap.c
index 289876ffbc31..6ac8c54b44c7 100644
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
@@ -1238,7 +1241,8 @@ int drbd_bm_write(struct drbd_device *device) __must_hold(local)
  *
  * Will write all pages.
  */
-int drbd_bm_write_all(struct drbd_device *device) __must_hold(local)
+int drbd_bm_write_all(struct drbd_device *device,
+		struct drbd_peer_device *peer_device) __must_hold(local)
 {
 	return bm_rw(device, BM_AIO_WRITE_ALL_PAGES, 0);
 }
@@ -1264,7 +1268,8 @@ int drbd_bm_write_lazy(struct drbd_device *device, unsigned upper_idx) __must_ho
  * verify is aborted due to a failed peer disk, while local IO continues, or
  * pending resync acks are still being processed.
  */
-int drbd_bm_write_copy_pages(struct drbd_device *device) __must_hold(local)
+int drbd_bm_write_copy_pages(struct drbd_device *device,
+		struct drbd_peer_device *peer_device) __must_hold(local)
 {
 	return bm_rw(device, BM_AIO_COPY_PAGES, 0);
 }
diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index 772023ace749..7bd10089bfc9 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -66,6 +66,7 @@ extern int drbd_proc_details;
 
 struct drbd_device;
 struct drbd_connection;
+struct drbd_peer_device;
 
 /* Defines to control fault insertion */
 enum {
@@ -541,9 +542,10 @@ struct drbd_md_io {
 
 struct bm_io_work {
 	struct drbd_work w;
+	struct drbd_peer_device *peer_device;
 	char *why;
 	enum bm_flag flags;
-	int (*io_fn)(struct drbd_device *device);
+	int (*io_fn)(struct drbd_device *device, struct drbd_peer_device *peer_device);
 	void (*done)(struct drbd_device *device, int rv);
 };
 
@@ -1041,7 +1043,7 @@ extern int drbd_send_drequest_csum(struct drbd_peer_device *, sector_t sector,
 				   enum drbd_packet cmd);
 extern int drbd_send_ov_request(struct drbd_peer_device *, sector_t sector, int size);
 
-extern int drbd_send_bitmap(struct drbd_device *device);
+extern int drbd_send_bitmap(struct drbd_device *device, struct drbd_peer_device *peer_device);
 extern void drbd_send_sr_reply(struct drbd_peer_device *, enum drbd_state_rv retcode);
 extern void conn_send_sr_reply(struct drbd_connection *connection, enum drbd_state_rv retcode);
 extern int drbd_send_rs_deallocated(struct drbd_peer_device *, struct drbd_peer_request *);
@@ -1065,17 +1067,22 @@ extern void drbd_md_clear_flag(struct drbd_device *device, int flags)__must_hold
 extern int drbd_md_test_flag(struct drbd_backing_dev *, int);
 extern void drbd_md_mark_dirty(struct drbd_device *device);
 extern void drbd_queue_bitmap_io(struct drbd_device *device,
-				 int (*io_fn)(struct drbd_device *),
+				 int (*io_fn)(struct drbd_device *, struct drbd_peer_device *),
 				 void (*done)(struct drbd_device *, int),
-				 char *why, enum bm_flag flags);
+				 char *why, enum bm_flag flags,
+				 struct drbd_peer_device *peer_device);
 extern int drbd_bitmap_io(struct drbd_device *device,
-		int (*io_fn)(struct drbd_device *),
-		char *why, enum bm_flag flags);
+		int (*io_fn)(struct drbd_device *, struct drbd_peer_device *),
+		char *why, enum bm_flag flags,
+		struct drbd_peer_device *peer_device);
 extern int drbd_bitmap_io_from_worker(struct drbd_device *device,
-		int (*io_fn)(struct drbd_device *),
-		char *why, enum bm_flag flags);
-extern int drbd_bmio_set_n_write(struct drbd_device *device) __must_hold(local);
-extern int drbd_bmio_clear_n_write(struct drbd_device *device) __must_hold(local);
+		int (*io_fn)(struct drbd_device *, struct drbd_peer_device *),
+		char *why, enum bm_flag flags,
+		struct drbd_peer_device *peer_device);
+extern int drbd_bmio_set_n_write(struct drbd_device *device,
+		struct drbd_peer_device *peer_device) __must_hold(local);
+extern int drbd_bmio_clear_n_write(struct drbd_device *device,
+		struct drbd_peer_device *peer_device) __must_hold(local);
 
 /* Meta data layout
  *
@@ -1284,14 +1291,18 @@ extern void _drbd_bm_set_bits(struct drbd_device *device,
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
-extern int drbd_bm_write_all(struct drbd_device *device) __must_hold(local);
-extern int  drbd_bm_write_copy_pages(struct drbd_device *device) __must_hold(local);
+extern int drbd_bm_write_all(struct drbd_device *device,
+		struct drbd_peer_device *peer_device) __must_hold(local);
+extern int  drbd_bm_write_copy_pages(struct drbd_device *device,
+		struct drbd_peer_device *peer_device) __must_hold(local);
 extern size_t	     drbd_bm_words(struct drbd_device *device);
 extern unsigned long drbd_bm_bits(struct drbd_device *device);
 extern sector_t      drbd_bm_capacity(struct drbd_device *device);
diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 2c764f7ee4a7..178a7ae40af8 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -1198,10 +1198,11 @@ static int fill_bitmap_rle_bits(struct drbd_device *device,
  * code upon failure.
  */
 static int
-send_bitmap_rle_or_plain(struct drbd_device *device, struct bm_xfer_ctx *c)
+send_bitmap_rle_or_plain(struct drbd_peer_device *peer_device, struct bm_xfer_ctx *c)
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
@@ -1266,7 +1269,7 @@ static int _drbd_send_bitmap(struct drbd_device *device)
 		if (drbd_md_test_flag(device->ldev, MDF_FULL_SYNC)) {
 			drbd_info(device, "Writing the whole bitmap, MDF_FullSync was set.\n");
 			drbd_bm_set_all(device);
-			if (drbd_bm_write(device)) {
+			if (drbd_bm_write(device, peer_device)) {
 				/* write_bm did fail! Leave full sync flag set in Meta P_DATA
 				 * but otherwise process as per normal - need to tell other
 				 * side that a full resync is required! */
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
index 60757ac31701..8967298968f3 100644
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
@@ -3005,11 +3007,12 @@ static int drbd_adm_simple_request_state(struct sk_buff *skb, struct genl_info *
 	return 0;
 }
 
-static int drbd_bmio_set_susp_al(struct drbd_device *device) __must_hold(local)
+static int drbd_bmio_set_susp_al(struct drbd_device *device,
+		struct drbd_peer_device *peer_device) __must_hold(local)
 {
 	int rv;
 
-	rv = drbd_bmio_set_n_write(device);
+	rv = drbd_bmio_set_n_write(device, peer_device);
 	drbd_suspend_al(device);
 	return rv;
 }
@@ -3052,7 +3055,7 @@ int drbd_adm_invalidate_peer(struct sk_buff *skb, struct genl_info *info)
 		if (retcode >= SS_SUCCESS) {
 			if (drbd_bitmap_io(device, &drbd_bmio_set_susp_al,
 				"set_n_write from invalidate_peer",
-				BM_LOCKED_SET_ALLOWED))
+				BM_LOCKED_SET_ALLOWED, NULL))
 				retcode = ERR_IO_MD_DISK;
 		}
 	} else
@@ -4148,7 +4151,7 @@ int drbd_adm_new_c_uuid(struct sk_buff *skb, struct genl_info *info)
 
 	if (args.clear_bm) {
 		err = drbd_bitmap_io(device, &drbd_bmio_clear_n_write,
-			"clear_n_write from new_c_uuid", BM_LOCKED_MASK);
+			"clear_n_write from new_c_uuid", BM_LOCKED_MASK, NULL);
 		if (err) {
 			drbd_err(device, "Writing bitmap failed with %d\n", err);
 			retcode = ERR_IO_MD_DISK;
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 757f4692b5bd..e70076fe1f2e 100644
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
@@ -4877,7 +4877,7 @@ static int receive_bitmap(struct drbd_connection *connection, struct packet_info
 	if (device->state.conn == C_WF_BITMAP_T) {
 		enum drbd_state_rv rv;
 
-		err = drbd_send_bitmap(device);
+		err = drbd_send_bitmap(device, peer_device);
 		if (err)
 			goto out;
 		/* Omit CS_ORDERED with this state transition to avoid deadlocks. */
@@ -5214,7 +5214,7 @@ static int drbd_disconnected(struct drbd_peer_device *peer_device)
 
 	if (get_ldev(device)) {
 		drbd_bitmap_io(device, &drbd_bm_write_copy_pages,
-				"write from disconnected", BM_LOCKED_CHANGE_ALLOWED);
+				"write from disconnected", BM_LOCKED_CHANGE_ALLOWED, NULL);
 		put_ldev(device);
 	}
 
diff --git a/drivers/block/drbd/drbd_state.c b/drivers/block/drbd/drbd_state.c
index 75d13ea0024f..c92dc6093b0a 100644
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
@@ -1809,7 +1810,7 @@ static void after_state_ch(struct drbd_device *device, union drbd_state os,
 	    device->state.conn == C_WF_BITMAP_S)
 		drbd_queue_bitmap_io(device, &drbd_send_bitmap, NULL,
 				"send_bitmap (WFBitMapS)",
-				BM_LOCKED_TEST_ALLOWED);
+				BM_LOCKED_TEST_ALLOWED, peer_device);
 
 	/* Lost contact to peer's copy of the data */
 	if (lost_contact_to_peer_data(os.pdsk, ns.pdsk)) {
@@ -1839,7 +1840,7 @@ static void after_state_ch(struct drbd_device *device, union drbd_state os,
 			 * No harm done if the bitmap still changes,
 			 * redirtied pages will follow later. */
 			drbd_bitmap_io_from_worker(device, &drbd_bm_write,
-				"demote diskless peer", BM_LOCKED_SET_ALLOWED);
+				"demote diskless peer", BM_LOCKED_SET_ALLOWED, peer_device);
 		put_ldev(device);
 	}
 
@@ -1851,7 +1852,7 @@ static void after_state_ch(struct drbd_device *device, union drbd_state os,
 		/* No changes to the bitmap expected this time, so assert that,
 		 * even though no harm was done if it did change. */
 		drbd_bitmap_io_from_worker(device, &drbd_bm_write,
-				"demote", BM_LOCKED_TEST_ALLOWED);
+				"demote", BM_LOCKED_TEST_ALLOWED, peer_device);
 		put_ldev(device);
 	}
 
@@ -1888,7 +1889,8 @@ static void after_state_ch(struct drbd_device *device, union drbd_state os,
 		/* no other bitmap changes expected during this phase */
 		drbd_queue_bitmap_io(device,
 			&drbd_bmio_set_n_write, &abw_start_sync,
-			"set_n_write from StartingSync", BM_LOCKED_TEST_ALLOWED);
+			"set_n_write from StartingSync", BM_LOCKED_TEST_ALLOWED,
+			peer_device);
 
 	/* first half of local IO error, failure to attach,
 	 * or administrative detach */
@@ -2011,7 +2013,8 @@ static void after_state_ch(struct drbd_device *device, union drbd_state os,
 	if ((os.conn > C_CONNECTED && os.conn < C_AHEAD) &&
 	    (ns.conn == C_CONNECTED || ns.conn >= C_AHEAD) && get_ldev(device)) {
 		drbd_queue_bitmap_io(device, &drbd_bm_write_copy_pages, NULL,
-			"write from resync_finished", BM_LOCKED_CHANGE_ALLOWED);
+			"write from resync_finished", BM_LOCKED_CHANGE_ALLOWED,
+			peer_device);
 		put_ldev(device);
 	}
 
diff --git a/drivers/block/drbd/drbd_worker.c b/drivers/block/drbd/drbd_worker.c
index f46738040d6b..68d5ba4af17d 100644
--- a/drivers/block/drbd/drbd_worker.c
+++ b/drivers/block/drbd/drbd_worker.c
@@ -1945,6 +1945,7 @@ static void drbd_ldev_destroy(struct drbd_device *device)
 
 static void go_diskless(struct drbd_device *device)
 {
+	struct drbd_peer_device *peer_device = first_peer_device(device);
 	D_ASSERT(device, device->state.disk == D_FAILED);
 	/* we cannot assert local_cnt == 0 here, as get_ldev_if_state will
 	 * inc/dec it frequently. Once we are D_DISKLESS, no one will touch
@@ -1970,7 +1971,7 @@ static void go_diskless(struct drbd_device *device)
 		 * Any modifications would not be expected anymore, though.
 		 */
 		if (drbd_bitmap_io_from_worker(device, drbd_bm_write,
-					"detach", BM_LOCKED_TEST_ALLOWED)) {
+					"detach", BM_LOCKED_TEST_ALLOWED, peer_device)) {
 			if (test_bit(WAS_READ_ERROR, &device->flags)) {
 				drbd_md_set_flag(device, MDF_FULL_SYNC);
 				drbd_md_sync(device);
-- 
2.39.2

