Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1910F626825
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 09:33:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234624AbiKLId0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 03:33:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbiKLIdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 03:33:24 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04EFEC78
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 00:33:23 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id b29so6748558pfp.13
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 00:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4DOeqJ5SMCOeWwnjErWXkoh3b+hyZguii3t6dQS8YmY=;
        b=IBxyvjZzoJn3lNx52hSdWnd8nch0DPIteXYXXv2nCFcZaF5Vj+cURGaTaeBSQ6OoR7
         BUZv7yYyLphZeilhFjf7hRJ3QjCSt4azIF5y3KIh0MEgBpz7j/DwmtJBUUeDlXSEDTzk
         wmDKnPkt4mwZCRX43AwaY3Tg/5iXPAyZZkjjv482i2mk5iic/sEx1GglPugfioauNr7I
         6saBXb/MioFSWS1ltk1EGI5YcIYrBJz3B1tlTosE9zuZUUp5PiXnHmV7NXHlNcr6IcAh
         97ilLSggyCO1JAKfDTyNLdsvbIRA3y40zHHVQPWkRynv0GbRx4tqZaKLXa2dSQumi1mS
         rjLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4DOeqJ5SMCOeWwnjErWXkoh3b+hyZguii3t6dQS8YmY=;
        b=S66uZZnL8IluBuSISOyfYVwIXAtzVGXpk8Yg434SXPrN95rbGQqSuD1OEyOrOvU/Wh
         t3nF+6asZM9Cpnk9QJB9nlcXb76KTp9zRB2zWBOEv4pg8i/E+p3qxMs9mW9IXhGja8Ew
         CsHwhfEvWlaMSsL2UxDDminYdqZlR3jk3GsqQaOC94zRqC3n1UogFNe5dS5bbeo3IW/d
         8otZ2Z4Hfj7vSxxueQNLyEAZqzM/h6HJM41Dmc3ZClKKKmdcIX7220lmQwKXoWXDVxPJ
         ResnYSszI6Fxt4qTsd7Cnw4HMKp8BLDKoLVm32a0m4YMpF+ZubfgR6ePK3AX78R57dCs
         B+TQ==
X-Gm-Message-State: ANoB5pljqkl1SyVggEPsIDIK0vW90i1iEmVIdxIUWlE2cHDcyYs5OCQL
        H3l6BK2BeWc0OHFVpNdZDoQ=
X-Google-Smtp-Source: AA0mqf6nLlSW5VpkbWvYJgYo7AZz395SuqNmwQNWgO0iRN0u/qGstxBxkjaN7nkV7UaRRPRReey3gw==
X-Received: by 2002:a63:1c61:0:b0:464:45f3:8272 with SMTP id c33-20020a631c61000000b0046445f38272mr4755995pgm.610.1668242002513;
        Sat, 12 Nov 2022 00:33:22 -0800 (PST)
Received: from VirtualBox.. ([129.227.152.6])
        by smtp.gmail.com with ESMTPSA id i11-20020a1709026acb00b001870533c443sm3066927plt.236.2022.11.12.00.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Nov 2022 00:33:22 -0800 (PST)
From:   Yuwei Guan <ssawgyw@gmail.com>
X-Google-Original-From: Yuwei Guan <Yuwei.Guan@zeekrlife.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yuwei.Guan@zeekrlife.com
Subject: [PATCH 1/3] f2fs: fix to alloc_mode changed after remount on a small volume device
Date:   Sat, 12 Nov 2022 16:32:48 +0800
Message-Id: <20221112083250.295700-2-Yuwei.Guan@zeekrlife.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221112083250.295700-1-Yuwei.Guan@zeekrlife.com>
References: <20221112083250.295700-1-Yuwei.Guan@zeekrlife.com>
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

The commit 84b89e5d943d8 ("f2fs: add auto tuning for small devices") add
tuning for small volume device, now support to tune alloce_mode to 'reuse'
if it's small size. But the alloc_mode will change to 'default' when do
remount on this small size dievce.

The commit 4cac90d5491c9 ("f2fs: relocate readdir_ra configure
initialization") relocates readdir_ra variable to tuning process.

This patch fo fix alloc_mode changed when do remount for a small volume
device.

For a small device,
- alloc_mode will keep 'reuse', if no alloc_mode option in remount
  command,
- alloc_mode will be set as remount command, if it has 'alloc_mode='.

Signed-off-by: Yuwei Guan <Yuwei.Guan@zeekrlife.com>
---
 fs/f2fs/super.c | 37 ++++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 3834ead04620..2f36824ff84b 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2190,6 +2190,23 @@ static void f2fs_enable_checkpoint(struct f2fs_sb_info *sbi)
 	f2fs_flush_ckpt_thread(sbi);
 }
 
+static void f2fs_tuning_parameters(struct f2fs_sb_info *sbi, bool is_remount)
+{
+	struct f2fs_sm_info *sm_i = SM_I(sbi);
+
+	/* adjust parameters according to the volume size */
+	if (sm_i->main_segments <= SMALL_VOLUME_SEGMENTS) {
+		F2FS_OPTION(sbi).alloc_mode = ALLOC_MODE_REUSE;
+		if (f2fs_block_unit_discard(sbi))
+			sm_i->dcc_info->discard_granularity = 1;
+		sm_i->ipu_policy = 1 << F2FS_IPU_FORCE |
+					1 << F2FS_IPU_HONOR_OPU_WRITE;
+	}
+
+	if (!is_remount)
+		sbi->readdir_ra = 1;
+}
+
 static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 {
 	struct f2fs_sb_info *sbi = F2FS_SB(sb);
@@ -2248,6 +2265,8 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 
 	default_options(sbi);
 
+	f2fs_tuning_parameters(sbi, true);
+
 	/* parse mount options */
 	err = parse_options(sb, data, true);
 	if (err)
@@ -4054,22 +4073,6 @@ static int f2fs_setup_casefold(struct f2fs_sb_info *sbi)
 	return 0;
 }
 
-static void f2fs_tuning_parameters(struct f2fs_sb_info *sbi)
-{
-	struct f2fs_sm_info *sm_i = SM_I(sbi);
-
-	/* adjust parameters according to the volume size */
-	if (sm_i->main_segments <= SMALL_VOLUME_SEGMENTS) {
-		F2FS_OPTION(sbi).alloc_mode = ALLOC_MODE_REUSE;
-		if (f2fs_block_unit_discard(sbi))
-			sm_i->dcc_info->discard_granularity = 1;
-		sm_i->ipu_policy = 1 << F2FS_IPU_FORCE |
-					1 << F2FS_IPU_HONOR_OPU_WRITE;
-	}
-
-	sbi->readdir_ra = 1;
-}
-
 static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 {
 	struct f2fs_sb_info *sbi;
@@ -4475,7 +4478,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 
 	f2fs_join_shrinker(sbi);
 
-	f2fs_tuning_parameters(sbi);
+	f2fs_tuning_parameters(sbi, false);
 
 	f2fs_notice(sbi, "Mounted with checkpoint version = %llx",
 		    cur_cp_version(F2FS_CKPT(sbi)));
-- 
2.34.1

