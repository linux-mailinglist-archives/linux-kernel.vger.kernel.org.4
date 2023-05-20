Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90CDA70AA57
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 20:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232315AbjETS1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 14:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232090AbjETS1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 14:27:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB1F31BD3;
        Sat, 20 May 2023 11:26:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F5B2616E8;
        Sat, 20 May 2023 18:23:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02813C4339C;
        Sat, 20 May 2023 18:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684607026;
        bh=xh7iFClTNrBmUWKlMC42PsRuhE+xIlxos9/fPlQff7Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A3Ps8pI/qL3EKiL6QiACca5CKA7vR6JMgLpnIz1pqtV5YZgyhx65HRlM0fz7CHoiK
         6jwIWw/jyyRMTEZTSlEpO04wVvY3usaWuBNFEJ+ZAjw0PAOp+CFPiWTOKUNlFyLALi
         9jZlIRDYHLEKmQ5InaovpOX6qPPSKUqNe3tK+Z/2JMOCnb8tLz0NWOl7m4WwoqVIch
         1ZGUxA5juDPwkOWV6y/mL5ivy4DN9GVlxEcDIKrSBv3+g+7UaW7tE4RH8ag+CPdAJx
         ObTAW4flMgTiblJKHXhWrKNsRYxGrib5Zo7NiDL8pLtcYVkzbGHM/WOsfaV1quFZPn
         7U8pPdeMHd+5A==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Guoqing Jiang <guoqing.jiang@linux.dev>,
        Christoph Hellwig <hch@lst.de>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 8/8] block/rnbd: replace REQ_OP_FLUSH with REQ_OP_WRITE
Date:   Sat, 20 May 2023 14:23:12 -0400
Message-Id: <20230520182312.851751-8-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230520182312.851751-1-sashal@kernel.org>
References: <20230520182312.851751-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guoqing Jiang <guoqing.jiang@linux.dev>

[ Upstream commit 5e6e08087a4acb4ee3574cea32dbff0f63c7f608 ]

Since flush bios are implemented as writes with no data and
the preflush flag per Christoph's comment [1].

And we need to change it in rnbd accordingly. Otherwise, I
got splatting when create fs from rnbd client.

[  464.028545] ------------[ cut here ]------------
[  464.028553] WARNING: CPU: 0 PID: 65 at block/blk-core.c:751 submit_bio_noacct+0x32c/0x5d0
[ ... ]
[  464.028668] CPU: 0 PID: 65 Comm: kworker/0:1H Tainted: G           OE      6.4.0-rc1 #9
[  464.028671] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.15.0-0-g2dd4b9b-rebuilt.opensuse.org 04/01/2014
[  464.028673] Workqueue: ib-comp-wq ib_cq_poll_work [ib_core]
[  464.028717] RIP: 0010:submit_bio_noacct+0x32c/0x5d0
[  464.028720] Code: 03 0f 85 51 fe ff ff 48 8b 43 18 8b 88 04 03 00 00 85 c9 0f 85 3f fe ff ff e9 be fd ff ff 0f b6 d0 3c 0d 74 26 83 fa 01 74 21 <0f> 0b b8 0a 00 00 00 e9 56 fd ff ff 4c 89 e7 e8 70 a1 03 00 84 c0
[  464.028722] RSP: 0018:ffffaf3680b57c68 EFLAGS: 00010202
[  464.028724] RAX: 0000000000060802 RBX: ffffa09dcc18bf00 RCX: 0000000000000000
[  464.028726] RDX: 0000000000000002 RSI: 0000000000000000 RDI: ffffa09dde081d00
[  464.028727] RBP: ffffaf3680b57c98 R08: ffffa09dde081d00 R09: ffffa09e38327200
[  464.028729] R10: 0000000000000000 R11: 0000000000000000 R12: ffffa09dde081d00
[  464.028730] R13: ffffa09dcb06e1e8 R14: 0000000000000000 R15: 0000000000200000
[  464.028733] FS:  0000000000000000(0000) GS:ffffa09e3bc00000(0000) knlGS:0000000000000000
[  464.028735] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  464.028736] CR2: 000055a4e8206c40 CR3: 0000000119f06000 CR4: 00000000003506f0
[  464.028738] Call Trace:
[  464.028740]  <TASK>
[  464.028746]  submit_bio+0x1b/0x80
[  464.028748]  rnbd_srv_rdma_ev+0x50d/0x10c0 [rnbd_server]
[  464.028754]  ? percpu_ref_get_many.constprop.0+0x55/0x140 [rtrs_server]
[  464.028760]  ? __this_cpu_preempt_check+0x13/0x20
[  464.028769]  process_io_req+0x1dc/0x450 [rtrs_server]
[  464.028775]  rtrs_srv_inv_rkey_done+0x67/0xb0 [rtrs_server]
[  464.028780]  __ib_process_cq+0xbc/0x1f0 [ib_core]
[  464.028793]  ib_cq_poll_work+0x2b/0xa0 [ib_core]
[  464.028804]  process_one_work+0x2a9/0x580

[1]. https://lore.kernel.org/all/ZFHgefWofVt24tRl@infradead.org/

Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Link: https://lore.kernel.org/r/20230512034631.28686-1-guoqing.jiang@linux.dev
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/rnbd/rnbd-proto.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/rnbd/rnbd-proto.h b/drivers/block/rnbd/rnbd-proto.h
index ca166241452c2..cb11855455dde 100644
--- a/drivers/block/rnbd/rnbd-proto.h
+++ b/drivers/block/rnbd/rnbd-proto.h
@@ -234,7 +234,7 @@ static inline u32 rnbd_to_bio_flags(u32 rnbd_opf)
 		bio_opf = REQ_OP_WRITE;
 		break;
 	case RNBD_OP_FLUSH:
-		bio_opf = REQ_OP_FLUSH | REQ_PREFLUSH;
+		bio_opf = REQ_OP_WRITE | REQ_PREFLUSH;
 		break;
 	case RNBD_OP_DISCARD:
 		bio_opf = REQ_OP_DISCARD;
-- 
2.39.2

