Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64F646F3110
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 14:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232617AbjEAMl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 08:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232602AbjEAMls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 08:41:48 -0400
Received: from smtp.smtpout.orange.fr (smtp-25.smtpout.orange.fr [80.12.242.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE92A10FF
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 05:41:13 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id tSpZpM6hwpwRItSplpInbJ; Mon, 01 May 2023 14:40:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1682944849;
        bh=EHhwOOQJhYG1zhAhvZ6TNtxRY+Z65siR69ZTkVbLHsk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=I8VtBR0KIkrJ450/GNdjOJGydw0hy4+xO//IkaI1yGpXbnf3Tovs0FaycrPclQVBI
         Mcj/QX4e2oQwrnLtNZmgRtP2IfUpq4SZukQvd1zR8+uqWaRmy9ktr/n02SaBnf9VIO
         WAqCN8Kpm97D/BtiSkfSdDbnwb/6GwquDKI7oREPAUSFkSKUT7VEcom3dB2LMvTl3K
         R2xRIO+dBG8xlk6G/KW1YoBKABK2sQBVxl/xJZPdEh1allWpmA4y7OglEMcGP0bKjw
         Cgi027/7+vx6zKr9fR/yhImPxy4nbRJ7JoXMaLpNtMQtDa8rOTho5LFg+CdDLk9bqH
         EbpX3PWvO7PQQ==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 01 May 2023 14:40:49 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     hch@lst.de, sagi@grimberg.me, kch@nvidia.com
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 4/5] nvmet: Reorder fields in 'struct nvme_dhchap_queue_context'
Date:   Mon,  1 May 2023 14:40:28 +0200
Message-Id: <829091a6a1d5e20112f8e6b0b3d44b384dc7ae98.1682941568.git.christophe.jaillet@wanadoo.fr>
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
On x86_64, this shrinks the size of 'struct nvme_dhchap_queue_context' from
416 to 400 bytes.

This structure is kvcalloc()'ed in nvme_auth_init_ctrl(), so it is likely
that the allocation can be relatively big. Saving 16 bytes per structure
may might a slight difference.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Using pahole

Before:
======
struct nvme_dhchap_queue_context {
	struct list_head           entry;                /*     0    16 */
	struct work_struct         auth_work;            /*    16    80 */
	/* --- cacheline 1 boundary (64 bytes) was 32 bytes ago --- */
	struct nvme_ctrl *         ctrl;                 /*    96     8 */
	struct crypto_shash *      shash_tfm;            /*   104     8 */
	struct crypto_kpp *        dh_tfm;               /*   112     8 */
	void *                     buf;                  /*   120     8 */
	/* --- cacheline 2 boundary (128 bytes) --- */
	int                        qid;                  /*   128     4 */
	int                        error;                /*   132     4 */
	u32                        s1;                   /*   136     4 */
	u32                        s2;                   /*   140     4 */
	u16                        transaction;          /*   144     2 */
	u8                         status;               /*   146     1 */
	u8                         hash_id;              /*   147     1 */

	/* XXX 4 bytes hole, try to pack */

	size_t                     hash_len;             /*   152     8 */
	u8                         dhgroup_id;           /*   160     1 */
	u8                         c1[64];               /*   161    64 */
	/* --- cacheline 3 boundary (192 bytes) was 33 bytes ago --- */
	u8                         c2[64];               /*   225    64 */
	/* --- cacheline 4 boundary (256 bytes) was 33 bytes ago --- */
	u8                         response[64];         /*   289    64 */

	/* XXX 7 bytes hole, try to pack */

	/* --- cacheline 5 boundary (320 bytes) was 40 bytes ago --- */
	u8 *                       host_response;        /*   360     8 */
	u8 *                       ctrl_key;             /*   368     8 */
	int                        ctrl_key_len;         /*   376     4 */

	/* XXX 4 bytes hole, try to pack */

	/* --- cacheline 6 boundary (384 bytes) --- */
	u8 *                       host_key;             /*   384     8 */
	int                        host_key_len;         /*   392     4 */

	/* XXX 4 bytes hole, try to pack */

	u8 *                       sess_key;             /*   400     8 */
	int                        sess_key_len;         /*   408     4 */

	/* size: 416, cachelines: 7, members: 25 */
	/* sum members: 393, holes: 4, sum holes: 19 */
	/* padding: 4 */
	/* last cacheline: 32 bytes */
};


After:
=====
struct nvme_dhchap_queue_context {
	struct list_head           entry;                /*     0    16 */
	struct work_struct         auth_work;            /*    16    80 */
	/* --- cacheline 1 boundary (64 bytes) was 32 bytes ago --- */
	struct nvme_ctrl *         ctrl;                 /*    96     8 */
	struct crypto_shash *      shash_tfm;            /*   104     8 */
	struct crypto_kpp *        dh_tfm;               /*   112     8 */
	void *                     buf;                  /*   120     8 */
	/* --- cacheline 2 boundary (128 bytes) --- */
	int                        qid;                  /*   128     4 */
	int                        error;                /*   132     4 */
	u32                        s1;                   /*   136     4 */
	u32                        s2;                   /*   140     4 */
	u16                        transaction;          /*   144     2 */
	u8                         status;               /*   146     1 */
	u8                         dhgroup_id;           /*   147     1 */
	u8                         hash_id;              /*   148     1 */

	/* XXX 3 bytes hole, try to pack */

	size_t                     hash_len;             /*   152     8 */
	u8                         c1[64];               /*   160    64 */
	/* --- cacheline 3 boundary (192 bytes) was 32 bytes ago --- */
	u8                         c2[64];               /*   224    64 */
	/* --- cacheline 4 boundary (256 bytes) was 32 bytes ago --- */
	u8                         response[64];         /*   288    64 */
	/* --- cacheline 5 boundary (320 bytes) was 32 bytes ago --- */
	u8 *                       host_response;        /*   352     8 */
	u8 *                       ctrl_key;             /*   360     8 */
	u8 *                       host_key;             /*   368     8 */
	u8 *                       sess_key;             /*   376     8 */
	/* --- cacheline 6 boundary (384 bytes) --- */
	int                        ctrl_key_len;         /*   384     4 */
	int                        host_key_len;         /*   388     4 */
	int                        sess_key_len;         /*   392     4 */

	/* size: 400, cachelines: 7, members: 25 */
	/* sum members: 393, holes: 1, sum holes: 3 */
	/* padding: 4 */
	/* last cacheline: 16 bytes */
};
---
 drivers/nvme/host/auth.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index ea16a0aba679..daf5d144a8ea 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -30,18 +30,18 @@ struct nvme_dhchap_queue_context {
 	u32 s2;
 	u16 transaction;
 	u8 status;
+	u8 dhgroup_id;
 	u8 hash_id;
 	size_t hash_len;
-	u8 dhgroup_id;
 	u8 c1[64];
 	u8 c2[64];
 	u8 response[64];
 	u8 *host_response;
 	u8 *ctrl_key;
-	int ctrl_key_len;
 	u8 *host_key;
-	int host_key_len;
 	u8 *sess_key;
+	int ctrl_key_len;
+	int host_key_len;
 	int sess_key_len;
 };
 
-- 
2.34.1

