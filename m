Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB866C97E0
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 22:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbjCZUqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 16:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjCZUqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 16:46:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 537805FFD
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 13:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679863509;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=7IOcXTh9I7uiQA9WNwWCeWSt6lyYLrODB3Q4jVF7TuE=;
        b=Q3K1uMNS/U7BrfffwNBnP7S0vPGqBrv3fiy8W0zhayYQidTsBGFndMY1SC3OE01JtZytIF
        PFbypRn4fTppU5l4cJpDLg8Z/QXR+G4Rxl4Lt29a9gJas7hWC5Zj/ETj8Uq9MCAerFsFGE
        3Xrwoj3Of2mTpdGY7mcQ7OwSxoTqjcg=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-454-Sxcz-yhmOhmHKZyvL8JI3A-1; Sun, 26 Mar 2023 16:45:07 -0400
X-MC-Unique: Sxcz-yhmOhmHKZyvL8JI3A-1
Received: by mail-qk1-f198.google.com with SMTP id q143-20020a374395000000b0074690a17414so3133696qka.7
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 13:45:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679863507;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7IOcXTh9I7uiQA9WNwWCeWSt6lyYLrODB3Q4jVF7TuE=;
        b=rZOQoACm70vqxS6BRbA0LIyfCQLmhVqq0OQtjjdRnUXwkRgQl4+1DdK4m2e7ZUEzgf
         fFdjyyifkrhmLv9OBdomv0mJYo0weXsbnZ+AXcZKOMj1Hytrbig6luJubwX1MIuf+4WK
         UxqL0NW3pfH/UiIq4sMgvDLTTJGI/ZON25zFyxJuZFKyNHwrlgrWs6KNnA2j5Tl0oCDa
         +UIez7sQXzH6FUekrqHt3kKxG58RZrXW78BTjh/xlZlO94KDIOdjUC8JFsVYtf7A8LJa
         ze/SEMo/WH9S0HL4ek3+Q8a6URZ7sRW0SRSrmVNaluhPP/QBgHRSQd9TDhQMCQb3yK5K
         9MHg==
X-Gm-Message-State: AAQBX9c15yTMdASch/SyTaW2TJ/PzV5l5BsH8Ep3sBPMPM3rSboLPc5W
        tsJ+tn/f3VUSPsaF8M0Mm0cZBsWcnXTyUxCLVn6zZh9en1vwzU7T3aW7UR6juAv4YITGHj6Qkm+
        E+bBg/Cg4N5B+09Tb/p3VNouH
X-Received: by 2002:ad4:5c61:0:b0:5c9:422e:c7b9 with SMTP id i1-20020ad45c61000000b005c9422ec7b9mr17854422qvh.19.1679863507219;
        Sun, 26 Mar 2023 13:45:07 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZjsPhfI22krBSpVeD7ukHBFaXleij2uEqfBoP4AArai+Rx/kYQO2keYf2S6wktYrRJ1jJg/g==
X-Received: by 2002:ad4:5c61:0:b0:5c9:422e:c7b9 with SMTP id i1-20020ad45c61000000b005c9422ec7b9mr17854402qvh.19.1679863507008;
        Sun, 26 Mar 2023 13:45:07 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id z83-20020a376556000000b007468ed0160csm9877770qkb.128.2023.03.26.13.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Mar 2023 13:45:06 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     nathan@kernel.org, ndesaulniers@google.com, willy@infradead.org,
        akpm@linux-foundation.org, jack@suse.cz, jlayton@kernel.org,
        song@kernel.org, yi.zhang@huawei.com, bvanassche@acm.org
Cc:     reiserfs-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Tom Rix <trix@redhat.com>
Subject: [PATCH] reiserfs: remove unused sched_count variable
Date:   Sun, 26 Mar 2023 16:44:59 -0400
Message-Id: <20230326204459.1358553-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang with W=1 reports
fs/reiserfs/journal.c:3034:6: error: variable
  'sched_count' set but not used [-Werror,-Wunused-but-set-variable]
        int sched_count = 0;
            ^
This variable is not used so remove it.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 fs/reiserfs/journal.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/reiserfs/journal.c b/fs/reiserfs/journal.c
index 9ce4ec296b74..4d11d60f493c 100644
--- a/fs/reiserfs/journal.c
+++ b/fs/reiserfs/journal.c
@@ -3031,7 +3031,6 @@ static int do_journal_begin_r(struct reiserfs_transaction_handle *th,
 	unsigned int old_trans_id;
 	struct reiserfs_journal *journal = SB_JOURNAL(sb);
 	struct reiserfs_transaction_handle myth;
-	int sched_count = 0;
 	int retval;
 	int depth;
 
@@ -3088,7 +3087,6 @@ static int do_journal_begin_r(struct reiserfs_transaction_handle *th,
 		    ((journal->j_len + nblocks + 2) * 100) <
 		    (journal->j_len_alloc * 75)) {
 			if (atomic_read(&journal->j_wcount) > 10) {
-				sched_count++;
 				queue_log_writer(sb);
 				goto relock;
 			}
-- 
2.27.0

