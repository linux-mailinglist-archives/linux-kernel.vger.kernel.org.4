Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 971CA5F4DD8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 04:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbiJEClQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 22:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbiJECkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 22:40:51 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E494472844
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 19:40:40 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id fw14so7422339pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 19:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=UiMX+a/n3KparVTc03/3zOVAcxR5tnQKucP/xxLwQns=;
        b=RYDcpGwT8/kxYv0Gsha/XvT0x9/1XAcaUZ9pG1TRfNQLtLFe4bvDwRSYILJ5osgUwk
         y6Zsku43KObROnjD7CJgNi1RySn4Zaccyjr7YmbyL6JTKrxIYBwbH0sC7NxC4UXvIAmm
         VjziRJojHHa5UumFdZ7/roPTRpuGH1rIN86Ho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=UiMX+a/n3KparVTc03/3zOVAcxR5tnQKucP/xxLwQns=;
        b=idrFfOciyybU29KzDQYCnEn9Ql6I7ANM/fevpw5OqhRT2bUNttaQFnapyCz1aWw65v
         MNQpy79vOGir23IWT1nlfbfbWqjqZfOYYQlTGBgtgbz42vA7m2kHKZqPSAAYrXShAWmJ
         NY7ZHFjiAwT7xLlZCwf5fMys0B1pe9NNAlgbUrLrBnTbx/L8CDMw05z7ABGklUV5qSJ/
         JKwd2XusEkL6NIBjdwhOpE3Pvk8cyFfPrhkxAIeu9FRSJLPITmPH+ctj+M1XHNG8LR9O
         atld/OWk4SKFZ8X+hcTYU6XImoOSGRZOygp7F42IthdFBJgrVhprXITOfooVXZnyPX5+
         362w==
X-Gm-Message-State: ACrzQf2IJElwVFOz9nC2zjOqlBsW92fGUfYD7aoPHKvneLvCE5BW4RNr
        H3Aycr9eO7Yo6Ja156Emiw3BCg==
X-Google-Smtp-Source: AMsMyM6yf6VBk7LFFaROXCkL0h1+X6GqbusXc4YobK7Ck5Pu0fYLuRSJkHP/UIYXXG44c1pXIcGSMw==
X-Received: by 2002:a17:90b:4c0b:b0:203:6d81:bb53 with SMTP id na11-20020a17090b4c0b00b002036d81bb53mr2744972pjb.3.1664937639678;
        Tue, 04 Oct 2022 19:40:39 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:a9d9:6396:ee12:8be8])
        by smtp.gmail.com with ESMTPSA id a14-20020aa794ae000000b00561e010a309sm1673579pfl.19.2022.10.04.19.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 19:40:39 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv2 7/8] zram: Add recompress flag to read_block_state()
Date:   Wed,  5 Oct 2022 11:40:13 +0900
Message-Id: <20221005024014.22914-8-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
In-Reply-To: <20221005024014.22914-1-senozhatsky@chromium.org>
References: <20221005024014.22914-1-senozhatsky@chromium.org>
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
was recompressed (using alternative compression algorithm).

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 Documentation/admin-guide/blockdev/zram.rst | 9 ++++++---
 drivers/block/zram/zram_drv.c               | 5 +++--
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/blockdev/zram.rst b/Documentation/admin-guide/blockdev/zram.rst
index 88957fcb6ad7..70a3d0243b45 100644
--- a/Documentation/admin-guide/blockdev/zram.rst
+++ b/Documentation/admin-guide/blockdev/zram.rst
@@ -466,9 +466,10 @@ pages of the process with*pagemap.
 If you enable the feature, you could see block state via
 /sys/kernel/debug/zram/zram0/block_state". The output is as follows::
 
-	  300    75.033841 .wh.
-	  301    63.806904 s...
-	  302    63.806919 ..hi
+	  300    75.033841 .wh..
+	  301    63.806904 s....
+	  302    63.806919 ..hi.
+	  303    62.801919 ....r
 
 First column
 	zram's block index.
@@ -485,6 +486,8 @@ Third column
 		huge page
 	i:
 		idle page
+	r:
+		recompressed page (secondary compression algorithm)
 
 First line of above example says 300th block is accessed at 75.033841sec
 and the block's state is huge so it is written back to the backing
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 75fc89de21e3..ce9413040ad4 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -925,13 +925,14 @@ static ssize_t read_block_state(struct file *file, char __user *buf,
 
 		ts = ktime_to_timespec64(zram->table[index].ac_time);
 		copied = snprintf(kbuf + written, count,
-			"%12zd %12lld.%06lu %c%c%c%c\n",
+			"%12zd %12lld.%06lu %c%c%c%c%c\n",
 			index, (s64)ts.tv_sec,
 			ts.tv_nsec / NSEC_PER_USEC,
 			zram_test_flag(zram, index, ZRAM_SAME) ? 's' : '.',
 			zram_test_flag(zram, index, ZRAM_WB) ? 'w' : '.',
 			zram_test_flag(zram, index, ZRAM_HUGE) ? 'h' : '.',
-			zram_test_flag(zram, index, ZRAM_IDLE) ? 'i' : '.');
+			zram_test_flag(zram, index, ZRAM_IDLE) ? 'i' : '.',
+			zram_test_flag(zram, index, ZRAM_RECOMP) ? 'r' : '.');
 
 		if (count <= copied) {
 			zram_slot_unlock(zram, index);
-- 
2.38.0.rc1.362.ged0d419d3c-goog

