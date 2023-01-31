Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 469EB682257
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 03:45:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbjAaCo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 21:44:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjAaCo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 21:44:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D202636084
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 18:44:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7EAC9B81699
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 02:44:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC720C433EF;
        Tue, 31 Jan 2023 02:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675133094;
        bh=QVFjJoLFmdtkQW9NmgxPlTz8Uuo3RJOYGK+UZbncgoA=;
        h=From:To:Cc:Subject:Date:From;
        b=quOLHE1Y+ks7/vYDxb7hs9Zj8dE5XPFvuo/BRqJ87MxTDGiv0nbotwot9o+p5upDY
         XscFJCwFwNRe6AZfd7qequBekTTiL/B+a1uHW0yh8GHyCUJvgubjqjofZrmAS+NMYT
         5y8XVJkTJeX9jLSgFOiP4euJl+6wc8iXmsQiGyo45tooBZuL9PnFSDAzY8eoUj8f5J
         u2+iWtTct+JsyyMuCf36dKkorzyyhrImEBfZvVheGlYEtlXKN1nN0kKjkMkJcrUYuo
         Lhh7cgINqe2nsrwgpv1+99aG4qvSL2HCkiZv93WirZLupeOq/fMXRd4h2GmdmJvquF
         RHnHUwxycA65g==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: clean up parameters of iostat_update_and_unbind_ctx()
Date:   Tue, 31 Jan 2023 10:44:44 +0800
Message-Id: <20230131024444.2598081-1-chao@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Parsing sync/rw type from bio inside iostat_update_and_unbind_ctx()
to avoid unnecessary parameters.

Signed-off-by: Chao Yu <chao@kernel.org>
---
- this patch is based on
[PATCH v3] f2fs: use iostat_lat_type directly as a parameter in the iostat_update_and_unbind_ctx()
 fs/f2fs/data.c   |  4 ++--
 fs/f2fs/iostat.c | 14 ++++++++++----
 fs/f2fs/iostat.h |  4 ++--
 3 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 89299efae812..fa83f1774048 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -292,7 +292,7 @@ static void f2fs_read_end_io(struct bio *bio)
 	struct bio_post_read_ctx *ctx;
 	bool intask = in_task();
 
-	iostat_update_and_unbind_ctx(bio, READ_IO);
+	iostat_update_and_unbind_ctx(bio);
 	ctx = bio->bi_private;
 
 	if (time_to_inject(sbi, FAULT_READ_IO))
@@ -330,7 +330,7 @@ static void f2fs_write_end_io(struct bio *bio)
 	struct bio_vec *bvec;
 	struct bvec_iter_all iter_all;
 
-	iostat_update_and_unbind_ctx(bio, bio->bi_opf & REQ_SYNC ? WRITE_SYNC_IO : WRITE_ASYNC_IO);
+	iostat_update_and_unbind_ctx(bio);
 	sbi = bio->bi_private;
 
 	if (time_to_inject(sbi, FAULT_WRITE_IO))
diff --git a/fs/f2fs/iostat.c b/fs/f2fs/iostat.c
index c767a2e7d5a9..14c8f1ec8c12 100644
--- a/fs/f2fs/iostat.c
+++ b/fs/f2fs/iostat.c
@@ -241,14 +241,20 @@ static inline void __update_iostat_latency(struct bio_iostat_ctx *iostat_ctx,
 	spin_unlock_irqrestore(&sbi->iostat_lat_lock, flags);
 }
 
-void iostat_update_and_unbind_ctx(struct bio *bio, enum iostat_lat_type lat_type)
+void iostat_update_and_unbind_ctx(struct bio *bio)
 {
 	struct bio_iostat_ctx *iostat_ctx = bio->bi_private;
+	enum iostat_lat_type lat_type;
 
-	if (lat_type == READ_IO)
-		bio->bi_private = iostat_ctx->post_read_ctx;
-	else
+	if (op_is_write(bio_op(bio))) {
+		lat_type = bio->bi_opf & REQ_SYNC ?
+				WRITE_SYNC_IO : WRITE_ASYNC_IO;
 		bio->bi_private = iostat_ctx->sbi;
+	} else {
+		lat_type = READ_IO;
+		bio->bi_private = iostat_ctx->post_read_ctx;
+	}
+
 	__update_iostat_latency(iostat_ctx, lat_type);
 	mempool_free(iostat_ctx, bio_iostat_ctx_pool);
 }
diff --git a/fs/f2fs/iostat.h b/fs/f2fs/iostat.h
index 1f827a2fe6b2..eb99d05cf272 100644
--- a/fs/f2fs/iostat.h
+++ b/fs/f2fs/iostat.h
@@ -58,7 +58,7 @@ static inline struct bio_post_read_ctx *get_post_read_ctx(struct bio *bio)
 	return iostat_ctx->post_read_ctx;
 }
 
-extern void iostat_update_and_unbind_ctx(struct bio *bio, enum iostat_lat_type type);
+extern void iostat_update_and_unbind_ctx(struct bio *bio);
 extern void iostat_alloc_and_bind_ctx(struct f2fs_sb_info *sbi,
 		struct bio *bio, struct bio_post_read_ctx *ctx);
 extern int f2fs_init_iostat_processing(void);
@@ -68,7 +68,7 @@ extern void f2fs_destroy_iostat(struct f2fs_sb_info *sbi);
 #else
 static inline void f2fs_update_iostat(struct f2fs_sb_info *sbi, struct inode *inode,
 		enum iostat_type type, unsigned long long io_bytes) {}
-static inline void iostat_update_and_unbind_ctx(struct bio *bio, enum iostat_lat_type type) {}
+static inline void iostat_update_and_unbind_ctx(struct bio *bio) {}
 static inline void iostat_alloc_and_bind_ctx(struct f2fs_sb_info *sbi,
 		struct bio *bio, struct bio_post_read_ctx *ctx) {}
 static inline void iostat_update_submit_ctx(struct bio *bio,
-- 
2.25.1

