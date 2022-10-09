Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8809C5F8A49
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 11:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbiJIJIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 05:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbiJIJH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 05:07:57 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B31D931358
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 02:07:44 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id b2so8041736plc.7
        for <linux-kernel@vger.kernel.org>; Sun, 09 Oct 2022 02:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5N+idb9Meu8bPgxV55r58/HUuOBKJs8gG9ElyKqtXIc=;
        b=Y9iTT0+zRaa4UXFiqtUyNe+GZMNhwGfWFvD2qw8EcyhN30/JkANHqh6exb6Tvly/D2
         ozVLLGVefoQfieaWnBXFVKNSFSvVNfgcfNpFVTyp0JuWTvz3d6lhQytCAr0PB0S/K1Gr
         xjkMHUwZuSW9W4NSn0+pi1i4T6+rRDN/i8bH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5N+idb9Meu8bPgxV55r58/HUuOBKJs8gG9ElyKqtXIc=;
        b=3JPDCnL/u1v0vqyuCDsoDTYol3PrARL020rWlhGRFM3wI7VNkQ70arYR8kevJH6c87
         LgAmhtVdnl+SXGGBNe+7J8sz7xMkTQ38e/Rv9V+i266/1BmytTudfXrzHoKMeAlOkK6Q
         aDrBE86SJELtJdmvscnwNeslHYaF48Jb730NtdFqX8x1gySEo27O4nCLAsgkGJhp5HEt
         fBtxTyfZ2wZz+B9TMxh6HTOY8GEiQ9gypG13ZAPs2jTSffwrsb4RKndjbAE9nt2Ml/te
         0K6XFeH1UtMPTi1Bkglmeaj+RqFjD5YVK9PYvb7Gx956LdaZ2ntmzWyILu5cKBtpqD54
         BVTw==
X-Gm-Message-State: ACrzQf0Q4+HeVJH07fw2W0FHHeNAr+lVU98T/WTOtubC7PF7lKgcFsZG
        zu/C+s3/VGVt9Bn++quZzmzWOA==
X-Google-Smtp-Source: AMsMyM4wsiBlX1NkUhAfcaouRhXX8PAS3oIjVVHLWLI0PncP5Tf5uAod8RAj/q7gd5Nan0SlLp2qHg==
X-Received: by 2002:a17:902:ec8d:b0:178:2914:b5a0 with SMTP id x13-20020a170902ec8d00b001782914b5a0mr13430611plg.17.1665306463751;
        Sun, 09 Oct 2022 02:07:43 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:8517:d51e:5fe9:9be7])
        by smtp.gmail.com with ESMTPSA id q194-20020a632acb000000b00439d071c110sm4335148pgq.43.2022.10.09.02.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Oct 2022 02:07:43 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv3 7/8] zram: Add recompress flag to read_block_state()
Date:   Sun,  9 Oct 2022 18:07:19 +0900
Message-Id: <20221009090720.1040633-8-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
In-Reply-To: <20221009090720.1040633-1-senozhatsky@chromium.org>
References: <20221009090720.1040633-1-senozhatsky@chromium.org>
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
index 7285a85b4054..34bb21691cee 100644
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

