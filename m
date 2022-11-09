Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD94622AF9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 12:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbiKILw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 06:52:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbiKILve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 06:51:34 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D243C6C0
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 03:51:28 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id y203so16466393pfb.4
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 03:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0dJwSSVWle5wAKsSMx0YgyDVQ6OL2lYtX7lIC3B32aM=;
        b=HPHG6Yl1KI8mjO7OGpNfDk9YjeU3vICc9sLqJbjbfAmOJLAc5WywPSQFJB18fJuCwG
         7+L+GS+xMO9FXwYZsNZrYXG+YjRzsXJIVihSbtuJ/zBxUltuJrhH3vDMFNUNPYo4NYGb
         4jwiks5wtyeCwT4bKKf8lTT4cLaN0kL0Hrfnc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0dJwSSVWle5wAKsSMx0YgyDVQ6OL2lYtX7lIC3B32aM=;
        b=uYwzmr6F9g/Ebk0PvuK0cW0or9RLB4R+ytUZjyxQDABSJqsIb3z9OIOqbF0bE18cza
         hiQDIjN3dLz28A63BZ1Wn6VajKBQ3W6H+7f6UpKK+7xNPKGfyA5CqfFrLQBGZ4dV4Kao
         dUs9W8jsC/FNufGEyo0sMdFAuZu6o4gfDY/STS1I3HcPndX4ysneE7tXVCF9OS+ZpdeA
         kN3032R/WNgyLVidgCH++jRObmfTMQ1UYY6Sfsk6rgN9MHWnlGWI4ifdq0eWJ1lz0SVB
         BUOFPusIFMWT4UMOjpJ1I3NM6eZVn8uPq7Gm/c5Hco7GpcGWXGHUYCpfMwtPDkCg+evE
         DVvA==
X-Gm-Message-State: ACrzQf3EpIdJ60CKqP5ADZMLPgmdjjjOoxNkWNUEagWPdKM4x/js+60r
        Wfx+ifkgmWszTheeEfi6GohIpg==
X-Google-Smtp-Source: AMsMyM4qP0VAZ/9g6k/1c2ELzDcyARTP25CtfOUKLGpwh2OuBRIs5q2CH788dxqVBNgKjab/wWnGJg==
X-Received: by 2002:a63:5a63:0:b0:42f:e143:80d4 with SMTP id k35-20020a635a63000000b0042fe14380d4mr53000571pgm.456.1667994688240;
        Wed, 09 Nov 2022 03:51:28 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:61f1:44d3:3f47:2cdb])
        by smtp.gmail.com with ESMTPSA id f5-20020a655505000000b00434760ee36asm7292311pgr.16.2022.11.09.03.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 03:51:27 -0800 (PST)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Nitin Gupta <ngupta@vflare.org>,
        Suleiman Souhlal <suleiman@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv5 13/13] zram: Add incompressible flag to read_block_state()
Date:   Wed,  9 Nov 2022 20:50:47 +0900
Message-Id: <20221109115047.2921851-14-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
In-Reply-To: <20221109115047.2921851-1-senozhatsky@chromium.org>
References: <20221109115047.2921851-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new flag to zram block state that shows if the page
is incompressible: that none of the algorithm (including
secondary ones) could compress it.

Suggested-by: Minchan Kim <minchan@kernel.org>
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 Documentation/admin-guide/blockdev/zram.rst | 11 +++++++----
 drivers/block/zram/zram_drv.c               |  6 ++++--
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/blockdev/zram.rst b/Documentation/admin-guide/blockdev/zram.rst
index f14c8c2e42f3..e4551579cb12 100644
--- a/Documentation/admin-guide/blockdev/zram.rst
+++ b/Documentation/admin-guide/blockdev/zram.rst
@@ -497,10 +497,11 @@ pages of the process with*pagemap.
 If you enable the feature, you could see block state via
 /sys/kernel/debug/zram/zram0/block_state". The output is as follows::
 
-	  300    75.033841 .wh..
-	  301    63.806904 s....
-	  302    63.806919 ..hi.
-	  303    62.801919 ....r
+	  300    75.033841 .wh...
+	  301    63.806904 s.....
+	  302    63.806919 ..hi..
+	  303    62.801919 ....r.
+	  304   146.781902 ..hi.n
 
 First column
 	zram's block index.
@@ -519,6 +520,8 @@ Third column
 		idle page
 	r:
 		recompressed page (secondary compression algorithm)
+	n:
+		none (including secondary) of algorithms could compress it
 
 First line of above example says 300th block is accessed at 75.033841sec
 and the block's state is huge so it is written back to the backing
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 2e4ef1ba1973..3447df3ca75e 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -949,14 +949,16 @@ static ssize_t read_block_state(struct file *file, char __user *buf,
 
 		ts = ktime_to_timespec64(zram->table[index].ac_time);
 		copied = snprintf(kbuf + written, count,
-			"%12zd %12lld.%06lu %c%c%c%c%c\n",
+			"%12zd %12lld.%06lu %c%c%c%c%c%c\n",
 			index, (s64)ts.tv_sec,
 			ts.tv_nsec / NSEC_PER_USEC,
 			zram_test_flag(zram, index, ZRAM_SAME) ? 's' : '.',
 			zram_test_flag(zram, index, ZRAM_WB) ? 'w' : '.',
 			zram_test_flag(zram, index, ZRAM_HUGE) ? 'h' : '.',
 			zram_test_flag(zram, index, ZRAM_IDLE) ? 'i' : '.',
-			zram_get_priority(zram, index) ? 'r' : '.');
+			zram_get_priority(zram, index) ? 'r' : '.',
+			zram_test_flag(zram, index,
+				       ZRAM_INCOMPRESSIBLE) ? 'n' : '.');
 
 		if (count <= copied) {
 			zram_slot_unlock(zram, index);
-- 
2.38.1.431.g37b22c650d-goog

