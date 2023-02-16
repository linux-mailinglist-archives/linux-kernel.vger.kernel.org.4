Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D40A698B23
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 04:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjBPDXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 22:23:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjBPDXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 22:23:08 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F494209
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 19:23:01 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id d13-20020a17090ad3cd00b0023127b2d602so849578pjw.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 19:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wSAq29/mCiPpKWHkZynEgD7uMUv36BUxMUrUtzUBeEU=;
        b=wppkv/odYVwj0FnhjFJohR0ecllKQVhktGGqxY5UjCmC1Vrn9USsrLoIDeUPs6qOWM
         d1EgMMgXYYmhWVBXaU7H3ZgBlW60EZiqJRvBhhsaqp4eGUeDNTiE8upY7WJmUFkrU8og
         gCY7DDfLcRpSivtqZEplFB2ZNcJWI0NeQDZ3MtLLuMYtPamVB27a9tfddkwj8EbHs/6P
         nrsUSEbNEX6Zv1Z4Qg8zK/3hsygxW7Be6zqvuhVPNPHpQcfn5eisc7bRH979/YXgAae+
         Fmj2k5jJRP9YRb0kgt/h5KA9qgDb5ya1rwfYamq5lzrTTkpySK+9pSqMaFjNzHY3UGYN
         Af1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wSAq29/mCiPpKWHkZynEgD7uMUv36BUxMUrUtzUBeEU=;
        b=s60J0cBGjo87nC3VdXnPaQRpFbkgi7yIzqu7ggySEh1beZScimv9UtRdMpg2EZjCe0
         fm9CrCdNDiIjvnRw1in/SkYKChHA1Zv1IZsZAvlai0/gV7MaF2bG/0lMQlriufppf7mI
         +xo8Rdmv61gdxYBSDyOPK5UBswC+2H0hnpiNF5d+4QxuCETsw0TQTrz37rE9L0qlR6mO
         ATggUslSHqWb/PigMEVta3E9CbdYrXxuwdgv+JAYHwAg+05Y/50owadrNkNVjCBi57D0
         c9sMiKNR9dcf8MzHUuXLtrg0qaO691n/ILqTqiAjVCoAFjXtLES6EU3holD6pnRr45uM
         PCbg==
X-Gm-Message-State: AO0yUKUkvsT75mOohs0Wux0pgUWgDtKnGmZsjDqLVqfOhto8Bxtaawtk
        ovnbHMNZSTVyQPihh2uJkdetog==
X-Google-Smtp-Source: AK7set/y4uOnGOjN61uhNUj3p7NepqLJY1qEmi0+cAKryf4NPqQfCWi53c/3ygr+6Unpw+bIJoAPJw==
X-Received: by 2002:a05:6a20:938e:b0:bf:1662:b2f4 with SMTP id x14-20020a056a20938e00b000bf1662b2f4mr5054907pzh.49.1676517780651;
        Wed, 15 Feb 2023 19:23:00 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.240])
        by smtp.gmail.com with ESMTPSA id c21-20020aa781d5000000b005a84ef49c63sm68930pfn.214.2023.02.15.19.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 19:23:00 -0800 (PST)
From:   Jinke Han <hanjinke.666@bytedance.com>
X-Google-Original-From: Jinke Han <hnajinke.666@bytedance>
To:     axboe@kernel.dk, ming.lei@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        muchun.song@linux.dev, Jinke Han <hanjinke.666@bytedance.com>
Subject: [PATCH] block: Fix io statistics for cgroup in throttle path
Date:   Thu, 16 Feb 2023 11:22:50 +0800
Message-Id: <20230216032250.74230-1-hanjinke.666@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jinke Han <hanjinke.666@bytedance.com>

In the current code, io statistics are missing for cgroup when bio
was throttled by blk-throttle. Fix it by moving the unreaching code
to submit_bio_noacct_nocheck.

Fixes: 3f98c753717c ("block: don't check bio in blk_throtl_dispatch_work_fn")
Signed-off-by: Jinke Han <hanjinke.666@bytedance.com>
---
 block/blk-core.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 46d12b3344c9..82b5b2c53f1e 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -684,6 +684,18 @@ static void __submit_bio_noacct_mq(struct bio *bio)
 
 void submit_bio_noacct_nocheck(struct bio *bio)
 {
+	blk_cgroup_bio_start(bio);
+	blkcg_bio_issue_init(bio);
+
+	if (!bio_flagged(bio, BIO_TRACE_COMPLETION)) {
+		trace_block_bio_queue(bio);
+		/*
+		 * Now that enqueuing has been traced, we need to trace
+		 * completion as well.
+		 */
+		bio_set_flag(bio, BIO_TRACE_COMPLETION);
+	}
+
 	/*
 	 * We only want one ->submit_bio to be active at a time, else stack
 	 * usage with stacked devices could be a problem.  Use current->bio_list
@@ -792,17 +804,6 @@ void submit_bio_noacct(struct bio *bio)
 
 	if (blk_throtl_bio(bio))
 		return;
-
-	blk_cgroup_bio_start(bio);
-	blkcg_bio_issue_init(bio);
-
-	if (!bio_flagged(bio, BIO_TRACE_COMPLETION)) {
-		trace_block_bio_queue(bio);
-		/* Now that enqueuing has been traced, we need to trace
-		 * completion as well.
-		 */
-		bio_set_flag(bio, BIO_TRACE_COMPLETION);
-	}
 	submit_bio_noacct_nocheck(bio);
 	return;
 
-- 
2.20.1

