Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7489B70EDAA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 08:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239322AbjEXGM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 02:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbjEXGMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 02:12:24 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D98A9132
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 23:12:22 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1ae3ed1b08eso6104415ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 23:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684908742; x=1687500742;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KOVKLuGqVN69XgbPeaETaxXfZXKBDKqsHEKUgXSsZg8=;
        b=oW6UQkDp7sDQt+D9l37f5agGwNIoBn05xl8aBcROKDTTkbeupLIOOhkXsaqe5bCppM
         IOC6TqZWsR8IYm/lTX8R1Rl8F3QgDLXHS/wQZP/z6+2QpBZyGNWSIFJyv2UkH71+Kq0b
         6X+CfhQ1RdhAIPUT4uXvA47gDP8czM76Q2UruSHZRDVoDcn5qpBFBERjBT3Qc5+HLfzU
         TyxMhWf4DNUW5OnadUI0QGrnCYyVAd1OgjF2BUmugeY4G5uDmYRzVDBI6BsKb+P/jemw
         vcSxDntVQP96ourPZXH24F4tvA+NNG3Cte7ZVOe4rhtrv3hiYxC9B7L1h2E0Ly9ol3vL
         aT1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684908742; x=1687500742;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KOVKLuGqVN69XgbPeaETaxXfZXKBDKqsHEKUgXSsZg8=;
        b=Egjz3d1r4Fv2J6JC7VOhq/ESdplRnvPPLZraF6FAR8rgfhl5dPR5VV+Gj+SQk7w7tc
         sfH3TP4ZQsBeMc04Z+oOsjaBcZahnUQZ83FZSoQC6iaSk9dbGM89zdJ20DVyP2Mv0QOw
         EIUPYGd1oXncCiT4zFKJJD4aZ81b7hnwhyZXJw0rsY5fnOADfBw6h56Y/861JrSvlqhT
         8GEWr65rjSuBanP8SZb+NEW9Ej0F11oBQ3tmHRpZrxII9kCg7zA2Ft6tTEZ46sxDoHZZ
         7pK2k5Itk7osxgqXkh8AQZ5BDJPOmWQaQZZ/mQXZyic2qXduXqkgjrU/x5ApD5Lbe0AK
         i37Q==
X-Gm-Message-State: AC+VfDz5TKYfFeec6efP6xibpvhKv/3F/viatChcMZXeLtH/SbWUB7rv
        1rt87tlFIK4SD/X0UHHMmqU=
X-Google-Smtp-Source: ACHHUZ45NNZvSMLWmEYRleXqZUCQ87n55rxUV0oABz4atHoPuFDfB+ExOHK1PaB5qJD/ISht+WdnaA==
X-Received: by 2002:a17:902:d50e:b0:1aa:dd14:da98 with SMTP id b14-20020a170902d50e00b001aadd14da98mr18352516plg.50.1684908742277;
        Tue, 23 May 2023 23:12:22 -0700 (PDT)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id y19-20020a170902ed5300b001a9873495f2sm7772980plb.233.2023.05.23.23.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 23:12:21 -0700 (PDT)
From:   Yue Hu <zbestahu@gmail.com>
To:     xiang@kernel.org, chao@kernel.org, jefflexu@linux.alibaba.com,
        linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, huyue2@coolpad.com,
        zhangwen@coolpad.com
Subject: [PATCH] erofs: remove the member readahead from struct z_erofs_decompress_frontend
Date:   Wed, 24 May 2023 14:11:52 +0800
Message-Id: <20230524061152.30155-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yue Hu <huyue2@coolpad.com>

The struct member is only used to add REQ_RAHEAD during I/O submission.
So it is cleaner to pass it as a parameter than keep it in the struct.

Also, rename function z_erofs_get_sync_decompress_policy() to
z_erofs_is_sync_decompress() for better clarity and conciseness.

Signed-off-by: Yue Hu <huyue2@coolpad.com>
---
 fs/erofs/zdata.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 45f21db2303a..4522a3be2ce9 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -550,7 +550,6 @@ struct z_erofs_decompress_frontend {
 	z_erofs_next_pcluster_t owned_head;
 	enum z_erofs_pclustermode mode;
 
-	bool readahead;
 	/* used for applying cache strategy on the fly */
 	bool backmost;
 	erofs_off_t headoffset;
@@ -1106,7 +1105,7 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 	return err;
 }
 
-static bool z_erofs_get_sync_decompress_policy(struct erofs_sb_info *sbi,
+static bool z_erofs_is_sync_decompress(struct erofs_sb_info *sbi,
 				       unsigned int readahead_pages)
 {
 	/* auto: enable for read_folio, disable for readahead */
@@ -1672,7 +1671,7 @@ static void z_erofs_decompressqueue_endio(struct bio *bio)
 static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
 				 struct page **pagepool,
 				 struct z_erofs_decompressqueue *fgq,
-				 bool *force_fg)
+				 bool *force_fg, bool readahead)
 {
 	struct super_block *sb = f->inode->i_sb;
 	struct address_space *mc = MNGD_MAPPING(EROFS_SB(sb));
@@ -1763,7 +1762,7 @@ static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
 				bio->bi_iter.bi_sector = (sector_t)cur <<
 					(sb->s_blocksize_bits - 9);
 				bio->bi_private = q[JQ_SUBMIT];
-				if (f->readahead)
+				if (readahead)
 					bio->bi_opf |= REQ_RAHEAD;
 				++nr_bios;
 			}
@@ -1799,13 +1798,14 @@ static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
 }
 
 static void z_erofs_runqueue(struct z_erofs_decompress_frontend *f,
-			     struct page **pagepool, bool force_fg)
+			     struct page **pagepool, bool force_fg,
+			     bool readahead)
 {
 	struct z_erofs_decompressqueue io[NR_JOBQUEUES];
 
 	if (f->owned_head == Z_EROFS_PCLUSTER_TAIL)
 		return;
-	z_erofs_submit_queue(f, pagepool, io, &force_fg);
+	z_erofs_submit_queue(f, pagepool, io, &force_fg, readahead);
 
 	/* handle bypass queue (no i/o pclusters) immediately */
 	z_erofs_decompress_queue(&io[JQ_BYPASS], pagepool);
@@ -1903,8 +1903,8 @@ static int z_erofs_read_folio(struct file *file, struct folio *folio)
 	(void)z_erofs_collector_end(&f);
 
 	/* if some compressed cluster ready, need submit them anyway */
-	z_erofs_runqueue(&f, &pagepool,
-			 z_erofs_get_sync_decompress_policy(sbi, 0));
+	z_erofs_runqueue(&f, &pagepool, z_erofs_is_sync_decompress(sbi, 0),
+			 false);
 
 	if (err)
 		erofs_err(inode->i_sb, "failed to read, err [%d]", err);
@@ -1922,7 +1922,6 @@ static void z_erofs_readahead(struct readahead_control *rac)
 	struct page *pagepool = NULL, *head = NULL, *page;
 	unsigned int nr_pages;
 
-	f.readahead = true;
 	f.headoffset = readahead_pos(rac);
 
 	z_erofs_pcluster_readmore(&f, rac, f.headoffset +
@@ -1953,7 +1952,7 @@ static void z_erofs_readahead(struct readahead_control *rac)
 	(void)z_erofs_collector_end(&f);
 
 	z_erofs_runqueue(&f, &pagepool,
-			 z_erofs_get_sync_decompress_policy(sbi, nr_pages));
+			 z_erofs_is_sync_decompress(sbi, nr_pages), true);
 	erofs_put_metabuf(&f.map.buf);
 	erofs_release_pages(&pagepool);
 }
-- 
2.17.1

