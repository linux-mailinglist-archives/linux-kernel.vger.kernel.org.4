Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AAE461A34C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 22:25:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbiKDVZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 17:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbiKDVZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 17:25:36 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E93E4384D
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 14:25:35 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id m200-20020a25d4d1000000b006cb7e26b93cso5981402ybf.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 14:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZMzbEeAq/WBS4iwvB8bBgtIMvjV4CPxHl4/ZDJnosVw=;
        b=ZrK+ebo6lUDd9raxHtPZNseJQ/MOuileQPeRTp4FqpnqL0PiBei0t3rlsIuGVkcSLe
         XEDJC+IYxG3reEa/CtJkBvLhItgY1jvFfy3GuJ+ZEKv5HEGpNrUnjfNPy88NIBi1Hj9T
         migd7LYzNVulF8C/ji8OMzcXpYeEG5xHIioY8v/c1JWgn9sPzmNVN/p201g8/u+imUxM
         4QNvk8nFy7QDPLIu6OItVQClzrdd4NntORcBuLPRO5B+GncFefpH8PoMbfJaaX2r+2Rg
         8zZHpVttHLQGuvbnJo+t3LKSkaxbqielNnURCipoejdspuUUJ98WPGImxS/b+GrBeY9X
         /YPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZMzbEeAq/WBS4iwvB8bBgtIMvjV4CPxHl4/ZDJnosVw=;
        b=Em4bjDoZvBwsbZ8/9ruRXUxylYupyfiEecI6TlNw5WLJnDrIIWrgdGPYMhsP+8UEEP
         tGVODIx3URvUJxFpcCyRXoPq6ciW7/b6x6Wy4s1XV2AqfkZf39hFnhqJDBMuZlK6OsMT
         m/mHwH3cHA8RodIR1b1l9T71OeQS3tjfRzUkNXCYXtudArZ3ZUD2iJOhR0IBSRigj0Rm
         e/BEmDaGGLKocoE67sDP0irlgZG2lzOXNeuHUlQCCk2Rve6tS7GJBbq5sTJO/7GUsM/n
         34rM3pWA8NQ5gpVH2imXxvPRXB97sjhnLNfswOC+zZRwyBCl3mlt1JgoF68qvq2GFSoO
         DBww==
X-Gm-Message-State: ACrzQf2rAHJg0geV2N3idcAZY4np7jjkpSBN53mAstNHD7bsR5VTYRta
        e3lhBs3wjl/fN1SOhUt/uLlkMakNtv9+9iM9KA==
X-Google-Smtp-Source: AMsMyM6jYvgmQ0dGg901njBI8YTBH+yqg5uTvJfXKDJ/PvHypkHSyES9/YTnaGT1+uHsuq+9g+l3pGRe6ZlOTtYStA==
X-Received: from roguebantha-cloud.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:1eee])
 (user=sethjenkins job=sendgmr) by 2002:a05:6902:8d:b0:6bc:47ea:42da with SMTP
 id h13-20020a056902008d00b006bc47ea42damr34014092ybs.529.1667597134725; Fri,
 04 Nov 2022 14:25:34 -0700 (PDT)
Date:   Fri,  4 Nov 2022 17:25:19 -0400
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221104212519.538108-1-sethjenkins@google.com>
Subject: [PATCH] aio: fix mremap after fork null-deref
From:   Seth Jenkins <sethjenkins@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Benjamin LaHaise <bcrl@kvack.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>,
        Pavel Emelyanov <xemul@parallels.com>,
        Seth Jenkins <sethjenkins@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit e4a0d3e720e7 ("aio: Make it possible to remap aio ring") introduced
a null-deref if mremap is called on an old aio mapping after fork as
mm->ioctx_table will be set to NULL.

Fixes: e4a0d3e720e7 ("aio: Make it possible to remap aio ring")
Cc: stable@vger.kernel.org
Signed-off-by: Seth Jenkins <sethjenkins@google.com>
---
 fs/aio.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 5b2ff20ad322..74eae7de7323 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -361,16 +361,18 @@ static int aio_ring_mremap(struct vm_area_struct *vma)
 	spin_lock(&mm->ioctx_lock);
 	rcu_read_lock();
 	table = rcu_dereference(mm->ioctx_table);
-	for (i = 0; i < table->nr; i++) {
-		struct kioctx *ctx;
-
-		ctx = rcu_dereference(table->table[i]);
-		if (ctx && ctx->aio_ring_file == file) {
-			if (!atomic_read(&ctx->dead)) {
-				ctx->user_id = ctx->mmap_base = vma->vm_start;
-				res = 0;
+	if (table) {
+		for (i = 0; i < table->nr; i++) {
+			struct kioctx *ctx;
+
+			ctx = rcu_dereference(table->table[i]);
+			if (ctx && ctx->aio_ring_file == file) {
+				if (!atomic_read(&ctx->dead)) {
+					ctx->user_id = ctx->mmap_base = vma->vm_start;
+					res = 0;
+				}
+				break;
 			}
-			break;
 		}
 	}
 
-- 
2.38.1.431.g37b22c650d-goog

