Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA24E72D4F7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 01:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231867AbjFLXcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 19:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbjFLXcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 19:32:12 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D609122
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 16:32:08 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-65311774e52so3852551b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 16:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686612728; x=1689204728;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TPeia39v+EiP9jqTHQk/tojPH+ZLqHSXGdrzE/iakQw=;
        b=N7Yvf4tWx5Db4/mAHrlIvxz1qBlk7NKGCqgpGfNtFkeJ69P3pddmrjYym+OrioqC/w
         dF6prjJKse2fnS0Ww4z2vI7OXq2uL4hTcmtuPPoNTjbSByTZU5c5MjnfSFL3ATOPzxPW
         7T2LSeAYIyy1SeMpg3fcbRV8zHwA5U74Wau166T7Aa78wR41FAIAVG4aFznWaoHzHaZA
         ue5wVMcqMEkf6WCUGYrDMOv+mcAlxHfoQTAJ+P8D7FNSVr6jNHeO1MohNh4S3M4wE/gh
         SRhqxVrzftmCqBI2CyLgl/Zrkcfs8OKu98fg5rUDEJCSWsx1j8PrUSC7MtheUIKYF9gZ
         biUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686612728; x=1689204728;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TPeia39v+EiP9jqTHQk/tojPH+ZLqHSXGdrzE/iakQw=;
        b=EqGmaTdzkS3p4hjyAs4FgokGr+2E4tZr/b58ecLo/XuhfirVFP2M0D97ArxiC5Rm+8
         PPPc+IV1rdhoCdHyd5wLxd+3zlk9VlXNJ6zSDvlgOIfRbpTFjI8ixsfV5T7XoeFiOsqj
         RLEdo58ZgrRFFlxn21F02W61veiBHLQ8QBzUh8KokpMZs0CQ1UsJCRswprKQVgJ4kJlc
         qVfsR8BHzlPehfgzrNwKpn5lxobgP16sjigJzh7VHNbdGIpdV7usy9izcr/3U6hGsHjW
         TqAAoFSI/3qWU+R/RhKeLEV+t1Bee8YY+UHP7nWAqjD9pQGQG6gCsW1lxU18ysJMPGDN
         m97Q==
X-Gm-Message-State: AC+VfDzYxTQMqw+L6YMg9VRL7zuysJJRQqClAg2tdsjUTa8LSDmiQkxi
        +EZLgkoCVIrCXHkXAFpMdQxB6RR3nmU=
X-Google-Smtp-Source: ACHHUZ730IisPrEKiU6v+rRJWAEGp8A/xLA/4fYUsjQNLB7j4DZenY5JNBrWImQPt/Fs9D2hcLEOmQ==
X-Received: by 2002:a05:6a00:80e:b0:64a:2dd6:4f18 with SMTP id m14-20020a056a00080e00b0064a2dd64f18mr13417925pfk.13.1686612727701;
        Mon, 12 Jun 2023 16:32:07 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2620:15c:211:201:b77c:cb6:36fb:d85b])
        by smtp.gmail.com with ESMTPSA id c9-20020a62e809000000b0064d48d98260sm7388267pfi.156.2023.06.12.16.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 16:32:07 -0700 (PDT)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
Subject: [PATCH] f2fs: check zone write pointer points to the end of zone
Date:   Mon, 12 Jun 2023 16:32:03 -0700
Message-ID: <20230612233203.1571983-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daeho Jeong <daehojeong@google.com>

We don't need to report an issue, when the zone write pointer already
points to the end of the zone, since the zone mismatch is already taken
care.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/segment.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 0c0c033c4bdd..8c7af8b4fc47 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -4888,8 +4888,12 @@ static int check_zone_write_pointer(struct f2fs_sb_info *sbi,
 			break;
 	}
 
-	// The write pointer matches with the valid blocks
-	if (last_valid_block + 1 == wp_block)
+	/*
+	 * The write pointer matches with the valid blocks or
+	 * already points to the end of the zone.
+	 */
+	if ((last_valid_block + 1 == wp_block) ||
+			(zone->wp == zone->start + zone->len))
 		return 0;
 
 	if (last_valid_block + 1 == zone_block) {
-- 
2.41.0.162.gfafddb0af9-goog

