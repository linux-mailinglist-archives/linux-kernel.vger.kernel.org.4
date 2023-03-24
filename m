Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6571E6C7E74
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 14:08:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbjCXNIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 09:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231902AbjCXNID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 09:08:03 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A592321A0F
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 06:07:56 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id q206so1031939pgq.9
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 06:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679663275;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ML7VBv7XlyCu7FAut6rRzjQeV7yr72fXHIIMk8RclWk=;
        b=mfWseLTSCbOBB+sSAr5vN/irU+vs2TOjW9ljyOFopToQR18sDQigO4UZdXn97oJ8go
         ISTlF4ZuIFAel06Z0s5OfTSRpczkqKdIKyM8gV8MSLOH0PZm28F3dnpv2uMM94BknmUM
         FkcIfDkztBDpDruWEpdjixZle3KoeViAXyAet+Ges4nwUPXYKECPr6tUj8L9e4xr2Krq
         x8GyItMO8NafsYSSrerh1tVtoPrVhsg5x9yuqT9KOpB0OpzUDvnIcxpru/qZfSZq7C7p
         yhMaXfeXYGYMKU7M5w9qPPkGBUrh8RtP/PLwYkXMIWfj+aXyLAY7Ut3Nb8hbLkapVigR
         QlcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679663275;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ML7VBv7XlyCu7FAut6rRzjQeV7yr72fXHIIMk8RclWk=;
        b=6aLxhmnZpykk9QNzQErrRb3vDbEzazyQ72d29ADo96PYzlh9Xy20Awa6J5+jF+sAtk
         ZeQeWp6/r+QmOrLtf0L2oUtd6EFwZCOngnUmqPy78vxJXo1VXHF6wZ+9jAWkQaCLWkP9
         qb9p+ocJ+cDEs+hp9bCpa3/v9wlVWY+9s3iuyPPOa2P71tAuWaG2hAzslM45Xdn/xCzK
         9wOpF1KKLxvIxyem55FmZpJWuRE+bC5hiqBLpcf5dvJkac3C8Al4jaK7MRvQpQZiomMe
         NlqQ7efRwrLZC5L9MxSetjtn4OorVGdyT7guzaZfAkrIZfZNsDG1xnHZfuFatbnROZNm
         aDqQ==
X-Gm-Message-State: AAQBX9f6+xRB4l4NsutY13Lvh59bDG8wGXF2PNY9DS1Z/cTRF71J7hK+
        e3JyMBcEq5Anl7GbgaAKkhs=
X-Google-Smtp-Source: AKy350awoE/Mfx31AyNqUQ0MW8ZHQLZjcZ9TVqVIFJQa3De1zZ/eJqj8JlErfsgbbcmpb23ogieGNA==
X-Received: by 2002:aa7:9908:0:b0:5a8:a0df:a624 with SMTP id z8-20020aa79908000000b005a8a0dfa624mr2604869pff.22.1679663275065;
        Fri, 24 Mar 2023 06:07:55 -0700 (PDT)
Received: from DESKTOP-B5TBVBT.localdomain ([175.117.51.71])
        by smtp.gmail.com with ESMTPSA id p18-20020a62ab12000000b005809d382016sm4141966pff.74.2023.03.24.06.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 06:07:54 -0700 (PDT)
From:   Yohan Joung <jyh429@gmail.com>
To:     jaegeuk@kernel.org
Cc:     jyh429@gmail.com, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, lkp@intel.com,
        oe-kbuild-all@lists.linux.dev, Yohan Joung <yohan.joung@sk.com>
Subject: [PATCH] f2fs: fix align check for npo2
Date:   Fri, 24 Mar 2023 22:07:47 +0900
Message-Id: <20230324130747.523-1-jyh429@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <ZBzlJ36kO5KvxODB@google.com>
References: <ZBzlJ36kO5KvxODB@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix alignment check to be correct in npo2 as well

Signed-off-by: Yohan Joung <yohan.joung@sk.com>
---
 fs/f2fs/segment.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 055e70e77aa2..f4a22a065277 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1842,6 +1842,7 @@ static int __f2fs_issue_discard_zone(struct f2fs_sb_info *sbi,
 	sector_t sector, nr_sects;
 	block_t lblkstart = blkstart;
 	int devi = 0;
+	u32 remainder = 0;
 
 	if (f2fs_is_multi_device(sbi)) {
 		devi = f2fs_target_device_index(sbi, blkstart);
@@ -1857,9 +1858,9 @@ static int __f2fs_issue_discard_zone(struct f2fs_sb_info *sbi,
 	if (f2fs_blkz_is_seq(sbi, devi, blkstart)) {
 		sector = SECTOR_FROM_BLOCK(blkstart);
 		nr_sects = SECTOR_FROM_BLOCK(blklen);
+		div_u64_rem(sector, bdev_zone_sectors(bdev), &remainder);
 
-		if (sector & (bdev_zone_sectors(bdev) - 1) ||
-				nr_sects != bdev_zone_sectors(bdev)) {
+		if (remainder || nr_sects != bdev_zone_sectors(bdev)) {
 			f2fs_err(sbi, "(%d) %s: Unaligned zone reset attempted (block %x + %x)",
 				 devi, sbi->s_ndevs ? FDEV(devi).path : "",
 				 blkstart, blklen);
-- 
2.25.1

