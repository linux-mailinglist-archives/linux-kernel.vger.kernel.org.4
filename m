Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A63462BF1C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 14:11:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236982AbiKPNLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 08:11:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233944AbiKPNLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 08:11:10 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 039F13FBA9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 05:11:09 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id io19so16363105plb.8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 05:11:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k8y+muBM2qZTT2X8qCBej0zg9DiU1t7btSSNdv1jtiM=;
        b=KidMbbgSXbx3gh559UeogeA/gGen/Rrnwwla1QMugK8+MpsG3wMqJyOXCme0WRJqMz
         SZaFPwchzImkqspY1mBZw/6Z16gFAfwvL8YBMTEKsSy33rMtgCPkRovb3wsxZhvacMix
         X56N16KJwmMWZKQbsk4sjA4pnOGbybriUIjgbua0IMdfNBUvngIDfYYuM2zYBQMoxIQd
         XgN5RchxhAVatW/zUtHUGna0vNP7FCKkftGxIkyAhyjZN7+f5u/urBo71Ty0G2hEyutX
         0h1jA2gHK8AGjxF5eH6vr20F0ZZmdt4tY8+HH9h3v7bgoEVOcrpG+EmtmIqZknByXv5U
         BFRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k8y+muBM2qZTT2X8qCBej0zg9DiU1t7btSSNdv1jtiM=;
        b=P0AoubutZRUVSxw4PCh3hfmVbkMff2pmGo8+YJxys7zC8qEdRgTWhosZK3J+5aqs4v
         3w0y8TmIrO6kpTAQPgrxrRlDbkJBrkFefDHUuNYkPImpdSFabw4Vh3N/w/JyYQhQ8Lr2
         yK+x2LmmmmX4Jhg/PXIW6Bhn2Mz0GTPb/Z7Oj1Qit13smyGuxQB1Vk0wKkj788WJVs28
         AUlUF8xGxFlhfwlIjkn1DHW7j2gx+Zkrdjz9UFAyP1QsoDPQq5BTbRWxDk9JVbXjvI3V
         iAqmfjfsqKzLzguNMwtSsoDEPxPBRrQ0A7qVxHQK3quchwlq6ig6oizh1JhcfXbuB3v5
         DjUg==
X-Gm-Message-State: ANoB5pk/t+DA6KdHjhIUkJFKqyQJ8+T10qkttDiOo6kZog2gAcehGQSA
        c5cUUtz0gdmPpfZ3fzLrMok=
X-Google-Smtp-Source: AA0mqf4AVUd3D4YNlaUpOzwpvqGSSBpVjQ51zX/gSYZPV/tgpr9u82+j4bVx9FgZyYvOyhUaVrvepw==
X-Received: by 2002:a17:902:9b84:b0:188:e255:39af with SMTP id y4-20020a1709029b8400b00188e25539afmr1263637plp.86.1668604268517;
        Wed, 16 Nov 2022 05:11:08 -0800 (PST)
Received: from VirtualBox.. ([222.71.102.99])
        by smtp.gmail.com with ESMTPSA id rj6-20020a17090b3e8600b00217cdc4b0a5sm1519491pjb.16.2022.11.16.05.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 05:11:07 -0800 (PST)
From:   Yuwei Guan <ssawgyw@gmail.com>
X-Google-Original-From: Yuwei Guan <Yuwei.Guan@zeekrlife.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yuwei.Guan@zeekrlife.com
Subject: [PATCH] f2fs: remove useless io_aware_gran variable
Date:   Wed, 16 Nov 2022 21:10:35 +0800
Message-Id: <20221116131035.1056523-1-Yuwei.Guan@zeekrlife.com>
X-Mailer: git-send-email 2.34.1
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

This 'io_aware_gran' is initialized as MAX_PLIST_NUM in
__init_discard_policy(), and use as 'i < dpolicy->io_aware_gran'
in __issue_discard_cmd(), but 'i < dpolicy->io_aware_gran' is
true always, so remvoe this variable.

Signed-off-by: Yuwei Guan <Yuwei.Guan@zeekrlife.com>
---
 fs/f2fs/f2fs.h    | 1 -
 fs/f2fs/segment.c | 4 +---
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index dedac413bf64..ced8a5b226b5 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -388,7 +388,6 @@ struct discard_policy {
 	unsigned int mid_interval;	/* used for device busy */
 	unsigned int max_interval;	/* used for candidates not exist */
 	unsigned int max_requests;	/* # of discards issued per round */
-	unsigned int io_aware_gran;	/* minimum granularity discard not be aware of I/O */
 	bool io_aware;			/* issue discard in idle time */
 	bool sync;			/* submit discard with REQ_SYNC flag */
 	bool ordered;			/* issue discard by lba order */
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 8b0b76550578..1cc41a65a645 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1059,7 +1059,6 @@ static void __init_discard_policy(struct f2fs_sb_info *sbi,
 	dpolicy->granularity = granularity;
 
 	dpolicy->max_requests = dcc->max_discard_request;
-	dpolicy->io_aware_gran = MAX_PLIST_NUM;
 	dpolicy->timeout = false;
 
 	if (discard_type == DPOLICY_BG) {
@@ -1483,8 +1482,7 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
 				f2fs_time_over(sbi, UMOUNT_DISCARD_TIMEOUT))
 				break;
 
-			if (dpolicy->io_aware && i < dpolicy->io_aware_gran &&
-						!is_idle(sbi, DISCARD_TIME)) {
+			if (dpolicy->io_aware && !is_idle(sbi, DISCARD_TIME)) {
 				io_interrupted = true;
 				break;
 			}
-- 
2.34.1

