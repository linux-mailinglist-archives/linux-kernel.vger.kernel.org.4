Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09D0E5B6529
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 03:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbiIMBni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 21:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiIMBnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 21:43:33 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A151C46DBB
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 18:43:32 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id l10so10293797plb.10
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 18:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=W1+rGJXezdjE5xTzHT7G7hG7lga2nwqlOvArvmEf7lk=;
        b=6/pUsOap8ZPq78Eo8xRWvuplUzvjy6qXfWyIu89tQSHmAtY7fNAgHDqZD3HlmL9TJo
         g5NQ3s4SIy68sPk6skfsXmFz3cOtg6A9yKEH8TIFgWiW185FzIReHW7JScrlhmKfmg94
         wK/M5kBdXX7GzPretMFho5Xiu8W42ZfEWaS/CYy9F9KzWlEmBx0QhdtHEp1tYdE+/Cpw
         OZI/VGSVzsBLhWv9KqrCbozIUSJp2POeZ3nwIfoRBJYCxC8i41fNyC1YYC35SPd/XGBo
         mr8ShCaMSzGnltrhvsIoWeHkdAY7tMS/eW1WkwnBY9w4n6mRb/zpQbvv3YGMA4t9BBsI
         aQbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=W1+rGJXezdjE5xTzHT7G7hG7lga2nwqlOvArvmEf7lk=;
        b=CvrgZyyA5o3tj4OP00ZLYCZ+NKMIKlCfvzU+p0E2upPn/7zXhCG3lvYAnW38vBwypv
         FO/rDEjMEcNTT3uSEkK8Oz9VzxbgtH9KWtwPAFGSaNVqKico526PPlnWO72w2l5HmgPZ
         dVaHDAMvXvtcGxoMZzMS8pZ+/v4tTnjw9ShvQa8ozdu8M0CQ28ngp6y/h1rnUx1m3pvk
         JLWBqYcE5PVGcipldUhbvQmD3Ko4V8wcNJ6UPDVolMrDGrOTIIk5wsmpyAY0nfCs2GS6
         Jnlz5wHYs46Pxnnq7zryTGhNCzPouh3NFA6mEKn+/SGqxJ6pAXI2JxlLo2/AXnNjlGJA
         dyGA==
X-Gm-Message-State: ACgBeo1gZXKOI530dMjzssw2zumbruJYYWWLB9CBuVYfgjSTY16qypk1
        Xo30FIykjHNgWMWxC0wRceXJQQ==
X-Google-Smtp-Source: AA6agR7TEC/mgifrrq284fugvdRmBPx1x6zEoh6osBQXFhERHBT1x8trlGZ3S762x15jAPIut9n0cA==
X-Received: by 2002:a17:90b:4c0a:b0:202:54cc:6d5 with SMTP id na10-20020a17090b4c0a00b0020254cc06d5mr1326909pjb.121.1663033412201;
        Mon, 12 Sep 2022 18:43:32 -0700 (PDT)
Received: from always-x1.bytedance.net ([61.213.176.6])
        by smtp.gmail.com with ESMTPSA id pg2-20020a17090b1e0200b001fd7fe7d369sm5885452pjb.54.2022.09.12.18.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 18:43:31 -0700 (PDT)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     hch@lst.de, sagi@grimberg.me
Cc:     kch@nvidia.com, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, fmdefrancesco@gmail.com,
        zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH v4 1/1] nvmet-tcp: Fix NULL pointer dereference during release
Date:   Tue, 13 Sep 2022 09:42:53 +0800
Message-Id: <20220913014253.931724-2-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220913014253.931724-1-pizhenwei@bytedance.com>
References: <20220913014253.931724-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nvmet-tcp frees CMD buffers in nvmet_tcp_uninit_data_in_cmds(),
and waits the inflight IO requests in nvmet_sq_destroy(). During wait
the inflight IO requests, the callback nvmet_tcp_queue_response()
is called from backend after IO complete, this leads a typical
Use-After-Free issue like this:

 BUG: kernel NULL pointer dereference, address: 0000000000000008
 #PF: supervisor read access in kernel mode
 #PF: error_code(0x0000) - not-present page
 PGD 0 P4D 0
 Oops: 0000 [#1] PREEMPT SMP NOPTI
 CPU: 14 PID: 207 Comm: kworker/14:1H Kdump: loaded Tainted: G            E      6.0.0-rc2.bm.1-amd64 #12
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
 Workqueue: nvmet_tcp_wq nvmet_tcp_io_work [nvmet_tcp]
 RIP: 0010:shash_ahash_digest+0x2b/0x110
 Code: 1f 44 00 00 41 57 41 56 41 55 41 54 55 48 89 fd 53 48 89 f3 48 83 ec 08 44 8b 67 30 45 85 e4 74 1c 48 8b 57 38 b8 00 10 00 00 <44> 8b 7a 08 44 29 f8 39 42 0c 0f 46 42 0c 41 39 c4 76 43 48 8b 03
 RSP: 0018:ffffc900006e3dd8 EFLAGS: 00010206
 RAX: 0000000000001000 RBX: ffff888104ac1650 RCX: 0000000000000000
 RDX: 0000000000000000 RSI: ffff888104ac1650 RDI: ffff888104ac1600
 RBP: ffff888104ac1600 R08: ffff8881073980c8 R09: ffff8881057798b8
 R10: 8080808080808080 R11: 0000000000000000 R12: 0000000000001000
 R13: 0000000000000000 R14: ffff88810601a1cc R15: ffff888107398000
 FS:  0000000000000000(0000) GS:ffff88823fd80000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000000000000008 CR3: 000000010a8e8000 CR4: 0000000000350ee0
 Call Trace:
  <TASK>
  nvmet_tcp_io_work+0xa1c/0xb1c [nvmet_tcp]
  ? __switch_to+0x106/0x420
  process_one_work+0x1ae/0x380
  ? process_one_work+0x380/0x380
  worker_thread+0x30/0x360
  ? process_one_work+0x380/0x380
  kthread+0xe6/0x110
  ? kthread_complete_and_exit+0x20/0x20
  ret_from_fork+0x1f/0x30

Suggested by Sagi, separate nvmet_tcp_uninit_data_in_cmds() into two
steps:
  uninit data in cmds                  <- new step 1
  nvmet_sq_destroy();
  cancel_work_sync(&queue->io_work);
  free CMD buffers                     <- new step 2

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 drivers/nvme/target/tcp.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index a3694a32f6d5..3ac9750b41ad 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1423,14 +1423,29 @@ static void nvmet_tcp_uninit_data_in_cmds(struct nvmet_tcp_queue *queue)
 	for (i = 0; i < queue->nr_cmds; i++, cmd++) {
 		if (nvmet_tcp_need_data_in(cmd))
 			nvmet_req_uninit(&cmd->req);
+	}
+
+	if (!queue->nr_cmds && nvmet_tcp_need_data_in(&queue->connect)) {
+		/* failed in connect */
+		nvmet_req_uninit(&queue->connect.req);
+	}
+}
 
+static void nvmet_tcp_free_cmd_data_in_buffers(struct nvmet_tcp_queue *queue)
+{
+	struct nvmet_tcp_cmd *cmd = queue->cmds;
+	int i;
+
+	for (i = 0; i < queue->nr_cmds; i++, cmd++) {
+		if (!nvmet_tcp_need_data_in(cmd))
+			continue;
 		nvmet_tcp_unmap_pdu_iovec(cmd);
 		nvmet_tcp_free_cmd_buffers(cmd);
 	}
 
 	if (!queue->nr_cmds && nvmet_tcp_need_data_in(&queue->connect)) {
-		/* failed in connect */
-		nvmet_tcp_finish_cmd(&queue->connect);
+		nvmet_tcp_unmap_pdu_iovec(&queue->connect);
+		nvmet_tcp_free_cmd_buffers(&queue->connect);
 	}
 }
 
@@ -1452,6 +1467,7 @@ static void nvmet_tcp_release_queue_work(struct work_struct *w)
 	nvmet_tcp_uninit_data_in_cmds(queue);
 	nvmet_sq_destroy(&queue->nvme_sq);
 	cancel_work_sync(&queue->io_work);
+	nvmet_tcp_free_cmd_data_in_buffers(queue);
 	sock_release(queue->sock);
 	nvmet_tcp_free_cmds(queue);
 	if (queue->hdr_digest || queue->data_digest)
-- 
2.20.1

