Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D501724A6E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 19:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238433AbjFFRkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 13:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238712AbjFFRjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 13:39:55 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 471F210F8
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 10:39:53 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6537d2a8c20so3015572b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 10:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686073192; x=1688665192;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FC01jxOBSLY7ZKXPg/UOaGu8vDRxRyeIgOBpQX22Jyc=;
        b=CAbk5mQi2P1KsDiLqmuh5rlEyijisBivA760hzTefSWQWlpw7TJLIzVvN5RklboRtr
         14WgBjG8JrA44rskY7oEjPRK+eM720JDUaRgRt/RHP1BfaikiT8inDBh8px4ddQV7PHV
         1FTrHIHe8fZ6jEvpRMymIi0PuyUvITmn4VgPfRYcYhqcn8H9/cDqPBOqAUuC7nZmtDXv
         7IV48/6OP5xb9YYNkDdmfpTuHeEnAIPtcHxLWkSHAoDuAweACUKWYIfA8MdYTysegZR9
         DiIzTKvdjwbzK9qpMp1ZUm1MwVspB91+FcsCnX3iYNDvOy17uBwn9Xu4H2NS+KVWsbqg
         oTgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686073192; x=1688665192;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FC01jxOBSLY7ZKXPg/UOaGu8vDRxRyeIgOBpQX22Jyc=;
        b=l30zxAZuPogR7hULSlRMZHS/p55j24cJTITMV7g6lGfd1RVP2ic/LmrgbznuhiaKhW
         4wCvmKinP6GJYWSmo0S35qEhhMVgnTAVRSobdTALvs3B3FrJYpuxnJftvj7QR/Br3l1R
         24FRUKmVn+UVkH9NrALmcy975Wrjq119SH00LL78vdYFGQ/OAav+43ZlxzLyqRaQk6jZ
         qg0Kbv3O8eYcir5Bj+XcUUpIoDtwuDS7HCEtrFbDXWJgeOgg7W2IB8lAnaTH5mg0qVfe
         F1YJRNJTJG+1WF0Ib9aayfPVBFskT60gkjJaAEpbpddaibJL9C2OOqfZYnE10R1H/hDU
         zwqA==
X-Gm-Message-State: AC+VfDzBYAIczCyiO7hDWM/hvclu/QM3pzKUNnRi5pRRfZaxlQ1UTrkq
        nM9gjL/PapmSnoNadC+RjPucp8T0IH0=
X-Google-Smtp-Source: ACHHUZ67KIg/Mm9NMPhjTlayFjlenoLJPI4NEBi4xLY/i14s1DBOxzAioMCWtn7d/RPKGoOH81NjfQ==
X-Received: by 2002:a05:6a20:3d93:b0:10c:34af:a469 with SMTP id s19-20020a056a203d9300b0010c34afa469mr425310pzi.16.1686073192178;
        Tue, 06 Jun 2023 10:39:52 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2620:15c:211:201:72aa:6329:65da:3ad3])
        by smtp.gmail.com with ESMTPSA id l6-20020a170902d34600b001ae7fad1598sm8818368plk.29.2023.06.06.10.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 10:39:51 -0700 (PDT)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
Subject: [PATCH] f2fs-tools: fix wrong write pointer check for non-zoned areas
Date:   Tue,  6 Jun 2023 10:39:48 -0700
Message-ID: <20230606173948.3390215-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
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

Do not check F2FS_ZONED_HM for the whole device. We need to do this for
each area of devices.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fsck/mount.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fsck/mount.c b/fsck/mount.c
index 851a62b..0ebbfcf 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -2868,9 +2868,6 @@ static bool write_pointer_at_zone_start(struct f2fs_sb_info *sbi,
 	int log_sectors_per_block = sbi->log_blocksize - SECTOR_SHIFT;
 	int ret, j;
 
-	if (c.zoned_model != F2FS_ZONED_HM)
-		return true;
-
 	for (j = 0; j < MAX_DEVICES; j++) {
 		if (!c.devices[j].path)
 			break;
@@ -2882,6 +2879,9 @@ static bool write_pointer_at_zone_start(struct f2fs_sb_info *sbi,
 	if (j >= MAX_DEVICES)
 		return false;
 
+	if (c.devices[j].zoned_model != F2FS_ZONED_HM)
+		return true;
+
 	sector = (block - c.devices[j].start_blkaddr) << log_sectors_per_block;
 	ret = f2fs_report_zone(j, sector, &blkz);
 	if (ret)
-- 
2.41.0.rc0.172.g3f132b7071-goog

