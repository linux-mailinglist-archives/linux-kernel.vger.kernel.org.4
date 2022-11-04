Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06814619A01
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 15:32:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbiKDOcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 10:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232226AbiKDOcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 10:32:00 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB71303C4;
        Fri,  4 Nov 2022 07:30:05 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id r18so4496134pgr.12;
        Fri, 04 Nov 2022 07:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/INqBg29xQCVOPRWt/oM9Rh3Qb0O2X04nJrvWO+N8bM=;
        b=PgZOfSV6WxTknTAGZqM5mLnrHQ/5stWVVX+nX4veVTwHIhzkcpwuJBpvkEqGyMfxrf
         sIPMCAPNkvOKBvfYVUO72QYWR1zYWHwjGpOkPeCZqEVX22SV1t3k5P8eNP9XZLZjaIxs
         d4m3+4gO7WHRf1ODVNNg4smpChMmIlRQxEqPIGfo+wwQq67GXWEcH6HviDe11556yrVx
         RmYyagpZaslh1vT9Bm6Alf6Gfk4B1uKIq0TrnIccUEUWQDxP9lieYhtfPtEW9/T3QT5H
         HCw/hfZwIATRfX042YM43wMROExOZfnyTb45OgGx8EJrN8Ns8Trb1HVjqW226jECOo8n
         xRDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/INqBg29xQCVOPRWt/oM9Rh3Qb0O2X04nJrvWO+N8bM=;
        b=zZD007dcDQJJv86AwufAU4lE5sLz0+Whtwr1YoSlVX7YHJghhDEGcGeaunoS/nYQKA
         OwEv2a6JI0RpbOY7IUgHP6wjR8n7QebU36IJlkZmfy1PuTyv5vBWNoIVHVsBqGfFUXaC
         qX8L05AH6gERpQWjk94k+mh3UISG1CRm3oMSgoV28uJdSJtRBz5c8EqrdY2W7sl7ZAoK
         hJdc6Fgjv/RhMYbFlsFUOZNBCRuyDH4pe7pGtv8QbzYF1C+9OxHVfY3N3sNxGYwXxfhR
         uUxdCYY/aCu+AFk1vzDG5KaMEvlZ/bkK5cbLxjoT7Dk2iU7/aF/Sg3jSHa1JOII2JBxr
         xlOg==
X-Gm-Message-State: ACrzQf3IEskw/cDuZ9KQhz6AOOzzGcYndVzbKfQUgisIvQlWETCH12Cs
        +9xlpfh/f0oHpSreG8D5Q8+/ugPJ+r1a8A==
X-Google-Smtp-Source: AMsMyM5F2vKDdAhgcRALVlqq22pNf7AaxOrvgmvPfhYKCw1219lJ/5P4s1Rigp8R6gG1EIhw7SV0gw==
X-Received: by 2002:a05:6a00:22d3:b0:56d:6ff5:21d7 with SMTP id f19-20020a056a0022d300b0056d6ff521d7mr27476751pfj.3.1667572204370;
        Fri, 04 Nov 2022 07:30:04 -0700 (PDT)
Received: from carrot.. (i220-108-44-211.s42.a014.ap.plala.or.jp. [220.108.44.211])
        by smtp.gmail.com with ESMTPSA id x126-20020a626384000000b0056ded8d5918sm2806996pfb.134.2022.11.04.07.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 07:30:03 -0700 (PDT)
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-nilfs <linux-nilfs@vger.kernel.org>,
        syzbot <syzbot+f816fa82f8783f7a02bb@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com,
        LKML <linux-kernel@vger.kernel.org>,
        Shigeru Yoshida <syoshida@redhat.com>
Subject: [PATCH] nilfs2: fix use-after-free bug of ns_writer on remount
Date:   Fri,  4 Nov 2022 23:29:59 +0900
Message-Id: <20221104142959.28296-1-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <00000000000065986a05ec569d46@google.com>
References: <00000000000065986a05ec569d46@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a nilfs2 filesystem is downgraded to read-only due to metadata
corruption on disk and is remounted read/write, or if emergency
read-only remount is performed, detaching a log writer and
synchronizing the filesystem can be done at the same time.

In these cases, use-after-free of the log writer (hereinafter
nilfs->ns_writer) can happen as shown in the scenario below:

 Task1                               Task2
 --------------------------------    ------------------------------
 nilfs_construct_segment
   nilfs_segctor_sync
     init_wait
     init_waitqueue_entry
     add_wait_queue
     schedule
                                     nilfs_remount (R/W remount case)
				       nilfs_attach_log_writer
                                         nilfs_detach_log_writer
                                           nilfs_segctor_destroy
                                             kfree
     finish_wait
       _raw_spin_lock_irqsave
         __raw_spin_lock_irqsave
           do_raw_spin_lock
             debug_spin_lock_before  <-- use-after-free

While Task1 is sleeping, nilfs->ns_writer is freed by Task2.  After
Task1 waked up, Task1 accesses nilfs->ns_writer which is already
freed.  This scenario diagram is based on the Shigeru Yoshida's post
[1].

This patch fixes the issue by not detaching nilfs->ns_writer on
remount so that this UAF race doesn't happen.  Along with this change,
this patch also inserts a few necessary read-only checks with
superblock instance where only the ns_writer pointer was used to check
if the filesystem is read-only.

Link: https://syzkaller.appspot.com/bug?id=79a4c002e960419ca173d55e863bd09e8112df8b
Link: https://lkml.kernel.org/r/20221103141759.1836312-1-syoshida@redhat.com [1]
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Reported-by: syzbot+f816fa82f8783f7a02bb@syzkaller.appspotmail.com
Reported-by: Shigeru Yoshida <syoshida@redhat.com>
Tested-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: stable@vger.kernel.org
---
 fs/nilfs2/segment.c | 15 ++++++++-------
 fs/nilfs2/super.c   |  2 --
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
index b4cebad21b48..3335ef352915 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -317,7 +317,7 @@ void nilfs_relax_pressure_in_lock(struct super_block *sb)
 	struct the_nilfs *nilfs = sb->s_fs_info;
 	struct nilfs_sc_info *sci = nilfs->ns_writer;
 
-	if (!sci || !sci->sc_flush_request)
+	if (sb_rdonly(sb) || unlikely(!sci) || !sci->sc_flush_request)
 		return;
 
 	set_bit(NILFS_SC_PRIOR_FLUSH, &sci->sc_flags);
@@ -2242,7 +2242,7 @@ int nilfs_construct_segment(struct super_block *sb)
 	struct nilfs_sc_info *sci = nilfs->ns_writer;
 	struct nilfs_transaction_info *ti;
 
-	if (!sci)
+	if (sb_rdonly(sb) || unlikely(!sci))
 		return -EROFS;
 
 	/* A call inside transactions causes a deadlock. */
@@ -2280,7 +2280,7 @@ int nilfs_construct_dsync_segment(struct super_block *sb, struct inode *inode,
 	struct nilfs_transaction_info ti;
 	int err = 0;
 
-	if (!sci)
+	if (sb_rdonly(sb) || unlikely(!sci))
 		return -EROFS;
 
 	nilfs_transaction_lock(sb, &ti, 0);
@@ -2776,11 +2776,12 @@ int nilfs_attach_log_writer(struct super_block *sb, struct nilfs_root *root)
 
 	if (nilfs->ns_writer) {
 		/*
-		 * This happens if the filesystem was remounted
-		 * read/write after nilfs_error degenerated it into a
-		 * read-only mount.
+		 * This happens if the filesystem is made read-only by
+		 * __nilfs_error or nilfs_remount and then remounted
+		 * read/write.  In these cases, reuse the existing
+		 * writer.
 		 */
-		nilfs_detach_log_writer(sb);
+		return 0;
 	}
 
 	nilfs->ns_writer = nilfs_segctor_new(sb, root);
diff --git a/fs/nilfs2/super.c b/fs/nilfs2/super.c
index ba108f915391..6edb6e0dd61f 100644
--- a/fs/nilfs2/super.c
+++ b/fs/nilfs2/super.c
@@ -1133,8 +1133,6 @@ static int nilfs_remount(struct super_block *sb, int *flags, char *data)
 	if ((bool)(*flags & SB_RDONLY) == sb_rdonly(sb))
 		goto out;
 	if (*flags & SB_RDONLY) {
-		/* Shutting down log writer */
-		nilfs_detach_log_writer(sb);
 		sb->s_flags |= SB_RDONLY;
 
 		/*
-- 
2.34.1

