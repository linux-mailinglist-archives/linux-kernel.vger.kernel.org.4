Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D88DB6F3108
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 14:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232518AbjEAMli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 08:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232540AbjEAMlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 08:41:35 -0400
Received: from smtp.smtpout.orange.fr (smtp-25.smtpout.orange.fr [80.12.242.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA8C619A2
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 05:41:06 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id tSpZpM6hwpwRItSphpInat; Mon, 01 May 2023 14:40:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1682944846;
        bh=QDh3dDPZUR9lwcq90WRl6vCV6llx9SiFdI20B6fyPHs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=LMXMGdujWEzj0tnyZphahhdqBGzQr/fbX/JBdsW+3+ua2l3IopaC+8U7k4vgBcdMM
         XDVMlwba+gB+JVSj4TbiqF4Opi8TxRaMhRu/iE7Z1wP1/aSiQmdZ6AT9i9KkbWhHJX
         Z5kPhJJDiW78EMgrMhj1DWsvWk1paOG73+NUMV4nPbB49S7kTjlBTO/ZckEShOWt/D
         aJTnvwIbsNP+P00fCznQxoqzLk4qG9CrCU1XQL63pnGH3qZ2wer5vAYK6cCMwLJeRY
         SaJF071jLecexhzYRQmZTXHO9AbAmXBDy4o3Xh+Hxks8XNcx2UxMdRspphrAz54xRo
         YEI/gUH9xvO6g==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 01 May 2023 14:40:46 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     hch@lst.de, sagi@grimberg.me, kch@nvidia.com
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 1/5] nvmet: Reorder fields in 'struct nvmet_sq'
Date:   Mon,  1 May 2023 14:40:25 +0200
Message-Id: <2b87bc1e2168a79be02706411e874e9fce26d1e9.1682941568.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1682941568.git.christophe.jaillet@wanadoo.fr>
References: <cover.1682941568.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Group some variables based on their sizes to reduce holes.
On x86_64, this shrinks the size of 'struct nvmet_sq' from 472 to 464
bytes when CONFIG_NVME_TARGET_AUTH is defined.

This structure is embedded into some other structures, so it helps reducing
their sizes as well.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Using pahole

Before:
======
struct nvmet_sq {
	struct nvmet_ctrl *        ctrl;                 /*     0     8 */
	struct percpu_ref          ref;                  /*     8    16 */
	u16                        qid;                  /*    24     2 */
	u16                        size;                 /*    26     2 */
	u32                        sqhd;                 /*    28     4 */
	bool                       sqhd_disabled;        /*    32     1 */

	/* XXX 7 bytes hole, try to pack */

	struct delayed_work        auth_expired_work;    /*    40   184 */

	/* XXX last struct has 4 bytes of padding */

	/* --- cacheline 3 boundary (192 bytes) was 32 bytes ago --- */
	bool                       authenticated;        /*   224     1 */

	/* XXX 1 byte hole, try to pack */

	u16                        dhchap_tid;           /*   226     2 */
	u16                        dhchap_status;        /*   228     2 */

	/* XXX 2 bytes hole, try to pack */

	int                        dhchap_step;          /*   232     4 */

	/* XXX 4 bytes hole, try to pack */

	u8 *                       dhchap_c1;            /*   240     8 */
	u8 *                       dhchap_c2;            /*   248     8 */
	/* --- cacheline 4 boundary (256 bytes) --- */
	u32                        dhchap_s1;            /*   256     4 */
	u32                        dhchap_s2;            /*   260     4 */
	u8 *                       dhchap_skey;          /*   264     8 */
	int                        dhchap_skey_len;      /*   272     4 */

	/* XXX 4 bytes hole, try to pack */

	struct completion          free_done;            /*   280    96 */
	/* --- cacheline 5 boundary (320 bytes) was 56 bytes ago --- */
	struct completion          confirm_done;         /*   376    96 */

	/* size: 472, cachelines: 8, members: 19 */
	/* sum members: 454, holes: 5, sum holes: 18 */
	/* paddings: 1, sum paddings: 4 */
	/* last cacheline: 24 bytes */
};

After:
=====
struct nvmet_sq {
	struct nvmet_ctrl *        ctrl;                 /*     0     8 */
	struct percpu_ref          ref;                  /*     8    16 */
	u16                        qid;                  /*    24     2 */
	u16                        size;                 /*    26     2 */
	u32                        sqhd;                 /*    28     4 */
	bool                       sqhd_disabled;        /*    32     1 */
	bool                       authenticated;        /*    33     1 */

	/* XXX 6 bytes hole, try to pack */

	struct delayed_work        auth_expired_work;    /*    40   184 */

	/* XXX last struct has 4 bytes of padding */

	/* --- cacheline 3 boundary (192 bytes) was 32 bytes ago --- */
	u16                        dhchap_tid;           /*   224     2 */
	u16                        dhchap_status;        /*   226     2 */
	int                        dhchap_step;          /*   228     4 */
	u8 *                       dhchap_c1;            /*   232     8 */
	u8 *                       dhchap_c2;            /*   240     8 */
	u32                        dhchap_s1;            /*   248     4 */
	u32                        dhchap_s2;            /*   252     4 */
	/* --- cacheline 4 boundary (256 bytes) --- */
	u8 *                       dhchap_skey;          /*   256     8 */
	int                        dhchap_skey_len;      /*   264     4 */

	/* XXX 4 bytes hole, try to pack */

	struct completion          free_done;            /*   272    96 */
	/* --- cacheline 5 boundary (320 bytes) was 48 bytes ago --- */
	struct completion          confirm_done;         /*   368    96 */

	/* size: 464, cachelines: 8, members: 19 */
	/* sum members: 454, holes: 2, sum holes: 10 */
	/* paddings: 1, sum paddings: 4 */
	/* last cacheline: 16 bytes */
};
---
 drivers/nvme/target/nvmet.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index c50146085fb5..8cfd60f3b564 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -109,8 +109,8 @@ struct nvmet_sq {
 	u32			sqhd;
 	bool			sqhd_disabled;
 #ifdef CONFIG_NVME_TARGET_AUTH
-	struct delayed_work	auth_expired_work;
 	bool			authenticated;
+	struct delayed_work	auth_expired_work;
 	u16			dhchap_tid;
 	u16			dhchap_status;
 	int			dhchap_step;
-- 
2.34.1

