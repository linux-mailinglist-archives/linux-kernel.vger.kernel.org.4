Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF60E5F2277
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 12:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbiJBKAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 06:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiJBJ75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 05:59:57 -0400
Received: from smtp.smtpout.orange.fr (smtp05.smtpout.orange.fr [80.12.242.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F6F5DE81
        for <linux-kernel@vger.kernel.org>; Sun,  2 Oct 2022 02:59:54 -0700 (PDT)
Received: from pop-os.home ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id evlFoljJdC5LCevlFowjLR; Sun, 02 Oct 2022 11:59:51 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 02 Oct 2022 11:59:51 +0200
X-ME-IP: 86.243.100.34
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     James Smart <james.smart@broadcom.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-nvme@lists.infradead.org
Subject: [PATCH] nvme-fc: Improve memory usage in nvme_fc_rcv_ls_req()
Date:   Sun,  2 Oct 2022 11:59:45 +0200
Message-Id: <87a93f5fadd6e3cba2bb263b8853a5d33f589287.1664704751.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sizeof( struct nvmefc_ls_rcv_op ) = 64
sizeof( union nvmefc_ls_requests ) = 1024
sizeof( union nvmefc_ls_responses ) = 128

So, in nvme_fc_rcv_ls_req(), 1216 bytes of memory are requested when
kzalloc() is called.

Because of the way memory allocations are performed, 2048 bytes are
allocated. So about 800 bytes are wasted for each request.

Switch to 3 distinct memory allocations, in order to:
   - save these 800 bytes
   - avoid zeroing this extra memory
   - make sure that memory is properly aligned in case of DMA access
    ("fc_dma_map_single(lsop->rspbuf)" just a few lines below)

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
This patch is only a RFC to see if this kind of approach makes sense or
not.
I've not checked all paths, so it is likely that it is incomplete.

Anyway, it is just a trade-of between memory footprint and CPU usage (3
kzalloc() instead of 1)

I don't know if it is a slow path or not, nor if the "rport->ls_rcv_list"
list can get big (each item overuses these 800 bytes of memory)

3 kzalloc is more than just 1 (sic!), but with this patch, 800 bytes are
not zeroed anymore. Moreover, maybe the zeroing of rqstbuf and/or rspbuf
can be saved as well.
So, it could balance the impact of the 3 kzalloc().

So, if it looks promising, s.o. with the corresponding hardware should
make some measurements on memory and CPU usage.
---
 drivers/nvme/host/fc.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 5d57a042dbca..2d3c54838496 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -1475,6 +1475,8 @@ nvme_fc_xmt_ls_rsp_done(struct nvmefc_ls_rsp *lsrsp)
 	fc_dma_unmap_single(lport->dev, lsop->rspdma,
 			sizeof(*lsop->rspbuf), DMA_TO_DEVICE);
 
+	kfree(lsop->rspbuf);
+	kfree(lsop->rqstbuf);
 	kfree(lsop);
 
 	nvme_fc_rport_put(rport);
@@ -1751,20 +1753,17 @@ nvme_fc_rcv_ls_req(struct nvme_fc_remote_port *portptr,
 		goto out_put;
 	}
 
-	lsop = kzalloc(sizeof(*lsop) +
-			sizeof(union nvmefc_ls_requests) +
-			sizeof(union nvmefc_ls_responses),
-			GFP_KERNEL);
-	if (!lsop) {
+	lsop = kzalloc(sizeof(*lsop), GFP_KERNEL);
+	lsop->rqstbuf = kzalloc(sizeof(*lsop->rqstbuf), GFP_KERNEL);
+	lsop->rspbuf = kzalloc(sizeof(*lsop->rspbuf), GFP_KERNEL);
+	if (!lsop || !lsop->rqstbuf || !lsop->rspbuf) {
 		dev_info(lport->dev,
 			"RCV %s LS failed: No memory\n",
 			(w0->ls_cmd <= NVME_FC_LAST_LS_CMD_VALUE) ?
 				nvmefc_ls_names[w0->ls_cmd] : "");
 		ret = -ENOMEM;
-		goto out_put;
+		goto out_free;
 	}
-	lsop->rqstbuf = (union nvmefc_ls_requests *)&lsop[1];
-	lsop->rspbuf = (union nvmefc_ls_responses *)&lsop->rqstbuf[1];
 
 	lsop->rspdma = fc_dma_map_single(lport->dev, lsop->rspbuf,
 					sizeof(*lsop->rspbuf),
@@ -1801,6 +1800,8 @@ nvme_fc_rcv_ls_req(struct nvme_fc_remote_port *portptr,
 	fc_dma_unmap_single(lport->dev, lsop->rspdma,
 			sizeof(*lsop->rspbuf), DMA_TO_DEVICE);
 out_free:
+	kfree(lsop->rspbuf);
+	kfree(lsop->rqstbuf);
 	kfree(lsop);
 out_put:
 	nvme_fc_rport_put(rport);
-- 
2.34.1

