Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35C686E4F52
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 19:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbjDQRfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 13:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjDQRfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 13:35:30 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96AE0BBBE;
        Mon, 17 Apr 2023 10:35:19 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1a667067275so10680745ad.1;
        Mon, 17 Apr 2023 10:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681752919; x=1684344919;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kKBqkldHay2ydjs9ABXeuxtcdI+nj2fd1RyBmIcAqMg=;
        b=HTyK6NDe5chPRopsL3ZuFt853JC1dQzM9r/S4i6agc4qQxedDGKHNQ7pfSeFHPuNRn
         9fUr56G76/laVqXz/FxXlMpC3P7hdee4wokzwRSUp9XcnH77vIrKa/He5dgkmMzUHoqX
         j5o6vspV6stz26v0WPLzA5KzMjSlRosGBeVbpwARY+jdb/zEvOo3u9EM4cxaHQSlkrFj
         TtKwQuT/zeuZ8BrglkO25FFlSwryfmMxwZ9Qp0bJR/ONRQ0c3zJCm1QGvwe1nHbe9/3G
         YnxnAbziCZ6sI+wlCY3Me/NYkn/Bvq0tq444lrkjikG/Pv0pfEC5OiOFXkcf3+KJe6Pe
         CMFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681752919; x=1684344919;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kKBqkldHay2ydjs9ABXeuxtcdI+nj2fd1RyBmIcAqMg=;
        b=CF+2KY+S+DD4S7asd0V4nPnSPlmFcNYl0hBw29GKAbbnB9BVDI6DLK+/CpMT3HLq12
         yHm3MjdbwZWYtZwhUwu8mpokugcg81/MyyefFdZ8gsMW1JSAJteCKIlog+VEcd3IMF8D
         aGzamRiPprzOKEOY3qxsUoLPfYvcCna1V+3bAGDvzbNI+IPj10fLcWfqdrXngsPLOBaP
         XRBS6xaW1srdw8xSwCaWzSbLPi7K7RnfE+VZ4z2cFsi8WQZ+b5ta1dvsU9ztKcWD3oCC
         D7KsXd568lGtSKdtszmWEGLi/fTTz0usjZ9fCEOzOJuRa7tDtxdLSQpnz3lfhEofcJjY
         QMnA==
X-Gm-Message-State: AAQBX9dNo9j6nFSLyp6eAFZkM/K6RjDr1JHflullHmjnkuVz9D2K5mUM
        94mNAA827P3mTJBC1eciNM3x2pbQStk=
X-Google-Smtp-Source: AKy350YF3pTMln2uLFQQmuOrQhev5UO7YUd1SQbfoop5nap0iMmEhUxWuYbT/KKdqC6KffLvzdD3kg==
X-Received: by 2002:a05:6a00:234a:b0:63b:2102:a068 with SMTP id j10-20020a056a00234a00b0063b2102a068mr23329841pfj.26.1681752918665;
        Mon, 17 Apr 2023 10:35:18 -0700 (PDT)
Received: from carrot.. (i223-217-34-84.s42.a014.ap.plala.or.jp. [223.217.34.84])
        by smtp.gmail.com with ESMTPSA id p22-20020aa78616000000b0063b675f01a2sm5980509pfn.26.2023.04.17.10.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 10:35:17 -0700 (PDT)
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-nilfs@vger.kernel.org,
        syzbot <syzbot+048585f3f4227bb2b49b@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org,
        glider@google.com
Subject: [PATCH] nilfs2: initialize unused bytes in segment summary blocks
Date:   Tue, 18 Apr 2023 02:35:13 +0900
Message-Id: <20230417173513.12598-1-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <0000000000000d710705f63f014c@google.com>
References: <0000000000000d710705f63f014c@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Syzbot still reports uninit-value in nilfs_add_checksums_on_logs() for
KMSAN enabled kernels after applying commit 7397031622e0 ("nilfs2:
initialize "struct nilfs_binfo_dat"->bi_pad field").

This is because the unused bytes at the end of each block in segment
summaries are not initialized.  So this fixes the issue by padding the
unused bytes with null bytes.

Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Reported-by: syzbot+048585f3f4227bb2b49b@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=048585f3f4227bb2b49b
Tested-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: stable@vger.kernel.org
---
 fs/nilfs2/segment.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
index 6ad41390fa74..228659612c0d 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -430,6 +430,23 @@ static int nilfs_segctor_reset_segment_buffer(struct nilfs_sc_info *sci)
 	return 0;
 }
 
+/**
+ * nilfs_segctor_zeropad_segsum - zero pad the rest of the segment summary area
+ * @sci: segment constructor object
+ *
+ * nilfs_segctor_zeropad_segsum() zero-fills unallocated space at the end of
+ * the current segment summary block.
+ */
+static void nilfs_segctor_zeropad_segsum(struct nilfs_sc_info *sci)
+{
+	struct nilfs_segsum_pointer *ssp;
+
+	ssp = sci->sc_blk_cnt > 0 ? &sci->sc_binfo_ptr : &sci->sc_finfo_ptr;
+	if (ssp->offset < ssp->bh->b_size)
+		memset(ssp->bh->b_data + ssp->offset, 0,
+		       ssp->bh->b_size - ssp->offset);
+}
+
 static int nilfs_segctor_feed_segment(struct nilfs_sc_info *sci)
 {
 	sci->sc_nblk_this_inc += sci->sc_curseg->sb_sum.nblocks;
@@ -438,6 +455,7 @@ static int nilfs_segctor_feed_segment(struct nilfs_sc_info *sci)
 				* The current segment is filled up
 				* (internal code)
 				*/
+	nilfs_segctor_zeropad_segsum(sci);
 	sci->sc_curseg = NILFS_NEXT_SEGBUF(sci->sc_curseg);
 	return nilfs_segctor_reset_segment_buffer(sci);
 }
@@ -542,6 +560,7 @@ static int nilfs_segctor_add_file_block(struct nilfs_sc_info *sci,
 		goto retry;
 	}
 	if (unlikely(required)) {
+		nilfs_segctor_zeropad_segsum(sci);
 		err = nilfs_segbuf_extend_segsum(segbuf);
 		if (unlikely(err))
 			goto failed;
@@ -1533,6 +1552,7 @@ static int nilfs_segctor_collect(struct nilfs_sc_info *sci,
 		nadd = min_t(int, nadd << 1, SC_MAX_SEGDELTA);
 		sci->sc_stage = prev_stage;
 	}
+	nilfs_segctor_zeropad_segsum(sci);
 	nilfs_segctor_truncate_segments(sci, sci->sc_curseg, nilfs->ns_sufile);
 	return 0;
 
-- 
2.34.1

