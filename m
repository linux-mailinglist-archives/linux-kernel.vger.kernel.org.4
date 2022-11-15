Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCBA76291E2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 07:36:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232253AbiKOGgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 01:36:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232254AbiKOGf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 01:35:58 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 615DC1EED8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 22:35:57 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id 130so13238075pfu.8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 22:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ddiJyfTyZKuawRH0HdAalthgL1Zu6o7Dm/cACdaVe8=;
        b=fbkTPJI6AdjhHDOAYjXNCRvWLJeS+4Nq2CAHj74eUDoT58ti3q7omrhHGT6kh9kPW/
         XzjFIkVr8Tn8MP9JmIjaP4QwFoVn8SLybhGUCBbshXXfu3QO7dNAH/c5UHbHVRjYDjVk
         eLWK+INryeHrOewUQ0vbC9CrqVVnZP2C6SkHF21q4rME3D99xtuRIYY6+OcGBFG6b8GE
         f4UyxTVdg71A+NJ0wDStJ1Y8oc1yZFKannJGbTc++xbcYfN2vrMvs4IPQ4DpIBajUD4J
         I6GfuPFaY17savOj4LdfTErn8YcC65VAbKJXF/Nq/HpRZzRzlNsaPSeE6kEiHTpRLTlQ
         Ks6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ddiJyfTyZKuawRH0HdAalthgL1Zu6o7Dm/cACdaVe8=;
        b=JAqafPaUQBtWm+WRY1WfGP968VS57K/uv3YNVTaKCx0WlHN01DeegaIM7sZDYYpA7q
         JoA0ZBzjqrw2GOwytXlRqoQUs21QWABqRETiFqRPTn9Tp5JqE9LAg1vZbM8t3QrpmbeT
         66F2luaBnENgoZlCab2YSOJJ2lDyQv/OKVB8fhgn9rsUGeEOgc4arUtsje80RcfjM0ru
         cbr3xI9ykVk7zU5rL4GCl4wtXiF8trRnsUuHfiUrIlDS8AFskk+G2CZ23UVh4a6KmlSr
         8UpTxo5ZXnB7wTnLXsvSUtcTnegL5NwdtSFnDCVCLSYCx4VIDu8QHFf6241bIqeeib8b
         3taw==
X-Gm-Message-State: ANoB5ploxJWmk6TbW4T4q1U82ze4FM/O+lX192XefD1akGN4cdZ3dYh9
        6J/Us8jnL90xyQPr8/QlYeI=
X-Google-Smtp-Source: AA0mqf5flZQzQWytBUUJAK3gX47rHhuDS851ql2atv78oKjWIOj8+6BzVhmY9A0Va0F7ogUwfKplqA==
X-Received: by 2002:a62:1a10:0:b0:572:6da6:218e with SMTP id a16-20020a621a10000000b005726da6218emr1986865pfa.1.1668494156965;
        Mon, 14 Nov 2022 22:35:56 -0800 (PST)
Received: from VirtualBox.. ([129.227.152.6])
        by smtp.gmail.com with ESMTPSA id e4-20020a170902d38400b001822121c45asm8767874pld.28.2022.11.14.22.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 22:35:56 -0800 (PST)
From:   Yuwei Guan <ssawgyw@gmail.com>
X-Google-Original-From: Yuwei Guan <Yuwei.Guan@zeekrlife.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yuwei.Guan@zeekrlife.com
Subject: [PATCH v2 1/3] f2fs: fix to alloc_mode changed after remount on a small volume device
Date:   Tue, 15 Nov 2022 14:35:35 +0800
Message-Id: <20221115063537.59023-2-Yuwei.Guan@zeekrlife.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221115063537.59023-1-Yuwei.Guan@zeekrlife.com>
References: <20221115063537.59023-1-Yuwei.Guan@zeekrlife.com>
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
remount on this small size dievce. This patch fo fix alloc_mode changed
when do remount for a small volume device.

Signed-off-by: Yuwei Guan <Yuwei.Guan@zeekrlife.com>
---
 fs/f2fs/super.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 3834ead04620..17b9e70b8f32 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2043,7 +2043,11 @@ static void default_options(struct f2fs_sb_info *sbi)
 		F2FS_OPTION(sbi).active_logs = NR_CURSEG_PERSIST_TYPE;
 
 	F2FS_OPTION(sbi).inline_xattr_size = DEFAULT_INLINE_XATTR_ADDRS;
-	F2FS_OPTION(sbi).alloc_mode = ALLOC_MODE_DEFAULT;
+	if (le32_to_cpu(F2FS_RAW_SUPER(sbi)->segment_count_main) <=
+							SMALL_VOLUME_SEGMENTS)
+		F2FS_OPTION(sbi).alloc_mode = ALLOC_MODE_REUSE;
+	else
+		F2FS_OPTION(sbi).alloc_mode = ALLOC_MODE_DEFAULT;
 	F2FS_OPTION(sbi).fsync_mode = FSYNC_MODE_POSIX;
 	F2FS_OPTION(sbi).s_resuid = make_kuid(&init_user_ns, F2FS_DEF_RESUID);
 	F2FS_OPTION(sbi).s_resgid = make_kgid(&init_user_ns, F2FS_DEF_RESGID);
@@ -4060,7 +4064,6 @@ static void f2fs_tuning_parameters(struct f2fs_sb_info *sbi)
 
 	/* adjust parameters according to the volume size */
 	if (sm_i->main_segments <= SMALL_VOLUME_SEGMENTS) {
-		F2FS_OPTION(sbi).alloc_mode = ALLOC_MODE_REUSE;
 		if (f2fs_block_unit_discard(sbi))
 			sm_i->dcc_info->discard_granularity = 1;
 		sm_i->ipu_policy = 1 << F2FS_IPU_FORCE |
-- 
2.34.1

