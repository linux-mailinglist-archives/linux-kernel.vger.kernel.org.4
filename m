Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E01727290F2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 09:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238681AbjFIH2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 03:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbjFIH2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 03:28:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C8EF2D7C
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 00:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686295651;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=k8uL9RB2TZeMZAUxmhUna0m1Gfo0R9DVnwUW3ywqZ+c=;
        b=SGkpVqx6vB4Q+F2tMmXgHhmILPkKC1bl4n3lPHov+CkAPFBDJklG6oRxNYK9FbT5lsN2Om
        u9k69Hv4s43Lbyi0/wyFpJjz3GMVBJtR9xenh51FRsZQRzcLew655RFoJ3xRDeo4B9h4FN
        nfAuxOFETkUpwuU4cA9I5C/kIHkwrik=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-rIo2R1KvPmeD3875NVveGw-1; Fri, 09 Jun 2023 03:27:30 -0400
X-MC-Unique: rIo2R1KvPmeD3875NVveGw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3f7eb414fcbso6696705e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 00:27:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686295648; x=1688887648;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k8uL9RB2TZeMZAUxmhUna0m1Gfo0R9DVnwUW3ywqZ+c=;
        b=NY5IbSATK0CTUyatypCwHkg6TaaK+GTC2k+q4ca5dlJ+JKzNbwq6uEjIdC1038N6cD
         P0w5m+AhgjSsShIYThKPYixY/aujFIjGazV+apfTt9aEypi+caNR/X4HL6DGhO/8FVEj
         fVT3x3+QbrvoRhpl21yra+6b6uZXciEEDbarnsOlmZjjKBVW9PTebx6OpeGoHtcWN5SH
         sXA1YPNSbmjHPdh8ULo/DRXzgLGg4MXa0Jh6E9URaucyuEqOZbmFNsffOIZEKN1L9ahX
         Fiz1Jz6XBoOE+z0AtjNBQvCjBD9jxh137hktiKWIS2Hc+BAPC4aRoGHLYbkrySw3jceb
         RqZw==
X-Gm-Message-State: AC+VfDwcF8XQtceSR2jCC3DEff4NTjTAQtdKBhpMpaIS78IA5bJSlfoV
        2eoE9lSBCWipPktx5NmUPxxNiEcGFpXAthLEbiC3NdutPL9dSNEj82EH4Euuah7/8q7tpApiGH+
        tPy+4KYz1CKsIBC+5tgu8a2yx25fCQx+T0EOiFP57tX9v60ZZaPA3/kxgvjD3Nrr0Io7uIPFrmH
        B2Qg==
X-Received: by 2002:a1c:4b09:0:b0:3f7:f2a1:482f with SMTP id y9-20020a1c4b09000000b003f7f2a1482fmr230028wma.11.1686295648269;
        Fri, 09 Jun 2023 00:27:28 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4QrxmXCtI9za5XfR+IvU75+9yMq+VNOhenv+q0gG491TweVM4s+/FuocFYUmW+BenHFGmOXg==
X-Received: by 2002:a1c:4b09:0:b0:3f7:f2a1:482f with SMTP id y9-20020a1c4b09000000b003f7f2a1482fmr230008wma.11.1686295647923;
        Fri, 09 Jun 2023 00:27:27 -0700 (PDT)
Received: from redhat.com ([2.55.4.169])
        by smtp.gmail.com with ESMTPSA id x17-20020a1c7c11000000b003f809461162sm103677wmc.16.2023.06.09.00.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 00:27:27 -0700 (PDT)
Date:   Fri, 9 Jun 2023 03:27:24 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel test robot <lkp@intel.com>,
        Suwan Kim <suwan.kim027@gmail.com>,
        "Roberts, Martin" <martin.roberts@intel.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Jens Axboe <axboe@kernel.dk>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org
Subject: [PATCH v2] Revert "virtio-blk: support completion batching for the
 IRQ path"
Message-ID: <336455b4f630f329380a8f53ee8cad3868764d5c.1686295549.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 07b679f70d73483930e8d3c293942416d9cd5c13.

This change appears to have broken things...
We now see applications hanging during disk accesses.
e.g.
multi-port virtio-blk device running in h/w (FPGA)
Host running a simple 'fio' test.
[global]
thread=1
direct=1
ioengine=libaio
norandommap=1
group_reporting=1
bs=4K
rw=read
iodepth=128
runtime=1
numjobs=4
time_based
[job0]
filename=/dev/vda
[job1]
filename=/dev/vdb
[job2]
filename=/dev/vdc
...
[job15]
filename=/dev/vdp

i.e. 16 disks; 4 queues per disk; simple burst of 4KB reads
This is repeatedly run in a loop.

After a few, normally <10 seconds, fio hangs.
With 64 queues (16 disks), failure occurs within a few seconds; with 8 queues (2 disks) it may take ~hour before hanging.
Last message:
fio-3.19
Starting 8 threads
Jobs: 1 (f=1): [_(7),R(1)][68.3%][eta 03h:11m:06s]
I think this means at the end of the run 1 queue was left incomplete.

'diskstats' (run while fio is hung) shows no outstanding transactions.
e.g.
$ cat /proc/diskstats
...
252       0 vda 1843140071 0 14745120568 712568645 0 0 0 0 0 3117947 712568645 0 0 0 0 0 0
252      16 vdb 1816291511 0 14530332088 704905623 0 0 0 0 0 3117711 704905623 0 0 0 0 0 0
...

Other stats (in the h/w, and added to the virtio-blk driver ([a]virtio_queue_rq(), [b]virtblk_handle_req(), [c]virtblk_request_done()) all agree, and show every request had a completion, and that virtblk_request_done() never gets called.
e.g.
PF= 0                         vq=0           1           2           3
[a]request_count     -   839416590   813148916   105586179    84988123
[b]completion1_count -   839416590   813148916   105586179    84988123
[c]completion2_count -           0           0           0           0

PF= 1                         vq=0           1           2           3
[a]request_count     -   823335887   812516140   104582672    75856549
[b]completion1_count -   823335887   812516140   104582672    75856549
[c]completion2_count -           0           0           0           0

i.e. the issue is after the virtio-blk driver.

This change was introduced in kernel 6.3.0.
I am seeing this using 6.3.3.
If I run with an earlier kernel (5.15), it does not occur.
If I make a simple patch to the 6.3.3 virtio-blk driver, to skip the blk_mq_add_to_batch()call, it does not fail.
e.g.
kernel 5.15 - this is OK
virtio_blk.c,virtblk_done() [irq handler]
                 if (likely(!blk_should_fake_timeout(req->q))) {
                          blk_mq_complete_request(req);
                 }

kernel 6.3.3 - this fails
virtio_blk.c,virtblk_handle_req() [irq handler]
                 if (likely(!blk_should_fake_timeout(req->q))) {
                          if (!blk_mq_complete_request_remote(req)) {
                                  if (!blk_mq_add_to_batch(req, iob, virtblk_vbr_status(vbr), virtblk_complete_batch)) {
                                           virtblk_request_done(req);    //this never gets called... so blk_mq_add_to_batch() must always succeed
                                   }
                          }
                 }

If I do, kernel 6.3.3 - this is OK
virtio_blk.c,virtblk_handle_req() [irq handler]
                 if (likely(!blk_should_fake_timeout(req->q))) {
                          if (!blk_mq_complete_request_remote(req)) {
                                   virtblk_request_done(req); //force this here...
                                  if (!blk_mq_add_to_batch(req, iob, virtblk_vbr_status(vbr), virtblk_complete_batch)) {
                                           virtblk_request_done(req);    //this never gets called... so blk_mq_add_to_batch() must always succeed
                                   }
                          }
                 }

Perhaps you might like to fix/test/revert this change...
Martin

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202306090826.C1fZmdMe-lkp@intel.com/
Cc: Suwan Kim <suwan.kim027@gmail.com>
Reported-by: "Roberts, Martin" <martin.roberts@intel.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

Since v1:
	fix build error

Still completely untested as I'm traveling.
Martin, Suwan, could you please test and report?
Suwan if you have a better revert in mind pls post and
I will be happy to drop this.

Thanks!


 drivers/block/virtio_blk.c | 82 +++++++++++++++++---------------------
 1 file changed, 37 insertions(+), 45 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 2b918e28acaa..b47358da92a2 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -348,63 +348,33 @@ static inline void virtblk_request_done(struct request *req)
 	blk_mq_end_request(req, status);
 }
 
-static void virtblk_complete_batch(struct io_comp_batch *iob)
-{
-	struct request *req;
-
-	rq_list_for_each(&iob->req_list, req) {
-		virtblk_unmap_data(req, blk_mq_rq_to_pdu(req));
-		virtblk_cleanup_cmd(req);
-	}
-	blk_mq_end_request_batch(iob);
-}
-
-static int virtblk_handle_req(struct virtio_blk_vq *vq,
-			      struct io_comp_batch *iob)
-{
-	struct virtblk_req *vbr;
-	int req_done = 0;
-	unsigned int len;
-
-	while ((vbr = virtqueue_get_buf(vq->vq, &len)) != NULL) {
-		struct request *req = blk_mq_rq_from_pdu(vbr);
-
-		if (likely(!blk_should_fake_timeout(req->q)) &&
-		    !blk_mq_complete_request_remote(req) &&
-		    !blk_mq_add_to_batch(req, iob, virtblk_vbr_status(vbr),
-					 virtblk_complete_batch))
-			virtblk_request_done(req);
-		req_done++;
-	}
-
-	return req_done;
-}
-
 static void virtblk_done(struct virtqueue *vq)
 {
 	struct virtio_blk *vblk = vq->vdev->priv;
-	struct virtio_blk_vq *vblk_vq = &vblk->vqs[vq->index];
-	int req_done = 0;
+	bool req_done = false;
+	int qid = vq->index;
+	struct virtblk_req *vbr;
 	unsigned long flags;
-	DEFINE_IO_COMP_BATCH(iob);
+	unsigned int len;
 
-	spin_lock_irqsave(&vblk_vq->lock, flags);
+	spin_lock_irqsave(&vblk->vqs[qid].lock, flags);
 	do {
 		virtqueue_disable_cb(vq);
-		req_done += virtblk_handle_req(vblk_vq, &iob);
+		while ((vbr = virtqueue_get_buf(vblk->vqs[qid].vq, &len)) != NULL) {
+			struct request *req = blk_mq_rq_from_pdu(vbr);
 
+			if (likely(!blk_should_fake_timeout(req->q)))
+				blk_mq_complete_request(req);
+			req_done = true;
+		}
 		if (unlikely(virtqueue_is_broken(vq)))
 			break;
 	} while (!virtqueue_enable_cb(vq));
 
-	if (req_done) {
-		if (!rq_list_empty(iob.req_list))
-			iob.complete(&iob);
-
-		/* In case queue is stopped waiting for more buffers. */
+	/* In case queue is stopped waiting for more buffers. */
+	if (req_done)
 		blk_mq_start_stopped_hw_queues(vblk->disk->queue, true);
-	}
-	spin_unlock_irqrestore(&vblk_vq->lock, flags);
+	spin_unlock_irqrestore(&vblk->vqs[qid].lock, flags);
 }
 
 static void virtio_commit_rqs(struct blk_mq_hw_ctx *hctx)
@@ -1283,15 +1253,37 @@ static void virtblk_map_queues(struct blk_mq_tag_set *set)
 	}
 }
 
+static void virtblk_complete_batch(struct io_comp_batch *iob)
+{
+	struct request *req;
+
+	rq_list_for_each(&iob->req_list, req) {
+		virtblk_unmap_data(req, blk_mq_rq_to_pdu(req));
+		virtblk_cleanup_cmd(req);
+	}
+	blk_mq_end_request_batch(iob);
+}
+
 static int virtblk_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)
 {
 	struct virtio_blk *vblk = hctx->queue->queuedata;
 	struct virtio_blk_vq *vq = get_virtio_blk_vq(hctx);
+	struct virtblk_req *vbr;
 	unsigned long flags;
+	unsigned int len;
 	int found = 0;
 
 	spin_lock_irqsave(&vq->lock, flags);
-	found = virtblk_handle_req(vq, iob);
+
+	while ((vbr = virtqueue_get_buf(vq->vq, &len)) != NULL) {
+		struct request *req = blk_mq_rq_from_pdu(vbr);
+
+		found++;
+		if (!blk_mq_complete_request_remote(req) &&
+		    !blk_mq_add_to_batch(req, iob, virtblk_vbr_status(vbr),
+						virtblk_complete_batch))
+			virtblk_request_done(req);
+	}
 
 	if (found)
 		blk_mq_start_stopped_hw_queues(vblk->disk->queue, true);
-- 
MST

