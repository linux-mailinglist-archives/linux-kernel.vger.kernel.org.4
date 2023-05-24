Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0CA70EE4E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 08:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239071AbjEXGmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 02:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239561AbjEXGlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 02:41:52 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E35E41BFD
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 23:40:08 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-2532d6c7ef2so4271613a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 23:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684910402; x=1687502402;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zn7OMSsYSCX/rc9bjAKI2reLL+5RLLeTJ6anC4INbJ0=;
        b=Blwwm5MxBGo/l24/gdA8zXS9W/9IYhXx34COU9v3rz8YFOVDy2GHAXNVZcNMzpSnIK
         Mv272aeEWdy1CQnzZq5279bTNcxPbDD7p4vzgxuS8yectKxfFvkGhGTT3kSTG8IrLjrK
         4fsl2Nzo070iVYcV/5Mjga7zFtuVO9F+nI9bHPFoCKststHCwHycrcjphZm2Tw4zXSaT
         vYHPlJ1Ab77O6sRhciRy7X6TBmixbxj5TKEpdil8L4LfgdslllMPXhM/iU4v/iBOqjeg
         28Jz3qeU354e8vdzhp4k8zq80LVv8t1O8XqMTMV1XfVGlx5wquzllD824PHLsBKYYxa8
         2YOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684910402; x=1687502402;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zn7OMSsYSCX/rc9bjAKI2reLL+5RLLeTJ6anC4INbJ0=;
        b=Cyd9ANN/Pu6AgNKEwt2VII15b9GOnv54TxljPky/pazUr0pYJgUkuipRy1IgjgmJx1
         dV9D52XOqE0I92Om1Wnkaadg5+hm2aYdZIxGmTCYBR21WRx2bpHgIIZktx1H27xXD33P
         95AVvgJSrMNh3Lx7gMsv15l/s0ACvgYHy76NXMX5P/kNzcCGnEagE6gP0yr1xzlcfClh
         hHz2+vdSVxOwiHYSUe/JB8J+FdqSEguX7JDR/mXfbQ8McsSj0Pwz7fMUHVM/J7uTZiGD
         +583FikSXBSMWgHxMBsuDT1Dg4tdAu7OeEODOczGsY1/Phyj++2WO0dLY7LyW7GQsN4q
         wuMQ==
X-Gm-Message-State: AC+VfDzW2wxnhjrITd3kLEXkLoArsGXAWGVhZR2ovIwJpOHxuIbnszSL
        b+x+t/ppa6TiDKAt3Nb906K3WCHBnes=
X-Google-Smtp-Source: ACHHUZ54QbswgzWqbpMWpc5kcmKJu0sCpoDIcGaCEWvL6mfDinJ4GzW4yBfgfVCjieyPrS/gupcpTA==
X-Received: by 2002:a17:90a:1b2b:b0:24e:2759:8dbe with SMTP id q40-20020a17090a1b2b00b0024e27598dbemr18040657pjq.7.1684910402282;
        Tue, 23 May 2023 23:40:02 -0700 (PDT)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id 4-20020a630904000000b00534514bc08bsm6947515pgj.64.2023.05.23.23.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 23:40:01 -0700 (PDT)
From:   Yue Hu <zbestahu@gmail.com>
To:     xiang@kernel.org, chao@kernel.org, jefflexu@linux.alibaba.com,
        linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, huyue2@coolpad.com,
        zhangwen@coolpad.com
Subject: [PATCH v2] erofs: remove the member readahead from struct z_erofs_decompress_frontend
Date:   Wed, 24 May 2023 14:39:44 +0800
Message-Id: <20230524063944.1655-1-zbestahu@gmail.com>
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
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
v2: readahead -> ra in z_erofs_runqueue()

 fs/erofs/zdata.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 45f21db2303a..5cd971bcf95e 100644
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
@@ -1799,13 +1798,13 @@ static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
 }
 
 static void z_erofs_runqueue(struct z_erofs_decompress_frontend *f,
-			     struct page **pagepool, bool force_fg)
+			     struct page **pagepool, bool force_fg, bool ra)
 {
 	struct z_erofs_decompressqueue io[NR_JOBQUEUES];
 
 	if (f->owned_head == Z_EROFS_PCLUSTER_TAIL)
 		return;
-	z_erofs_submit_queue(f, pagepool, io, &force_fg);
+	z_erofs_submit_queue(f, pagepool, io, &force_fg, ra);
 
 	/* handle bypass queue (no i/o pclusters) immediately */
 	z_erofs_decompress_queue(&io[JQ_BYPASS], pagepool);
@@ -1903,8 +1902,8 @@ static int z_erofs_read_folio(struct file *file, struct folio *folio)
 	(void)z_erofs_collector_end(&f);
 
 	/* if some compressed cluster ready, need submit them anyway */
-	z_erofs_runqueue(&f, &pagepool,
-			 z_erofs_get_sync_decompress_policy(sbi, 0));
+	z_erofs_runqueue(&f, &pagepool, z_erofs_is_sync_decompress(sbi, 0),
+			 false);
 
 	if (err)
 		erofs_err(inode->i_sb, "failed to read, err [%d]", err);
@@ -1922,7 +1921,6 @@ static void z_erofs_readahead(struct readahead_control *rac)
 	struct page *pagepool = NULL, *head = NULL, *page;
 	unsigned int nr_pages;
 
-	f.readahead = true;
 	f.headoffset = readahead_pos(rac);
 
 	z_erofs_pcluster_readmore(&f, rac, f.headoffset +
@@ -1953,7 +1951,7 @@ static void z_erofs_readahead(struct readahead_control *rac)
 	(void)z_erofs_collector_end(&f);
 
 	z_erofs_runqueue(&f, &pagepool,
-			 z_erofs_get_sync_decompress_policy(sbi, nr_pages));
+			 z_erofs_is_sync_decompress(sbi, nr_pages), true);
 	erofs_put_metabuf(&f.map.buf);
 	erofs_release_pages(&pagepool);
 }
-- 
2.17.1

