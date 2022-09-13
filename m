Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2BFE5B7BF3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 22:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbiIMUD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 16:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbiIMUDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 16:03:38 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 095F57D1D2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 13:02:12 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id w20so861112ply.12
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 13:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=l0dj+3Ovsh72VR8b6mpYEl1GpUZxqOUo2nBqMYtEBic=;
        b=kChLMXOqqc7WCWiLVcJa1JWTY08tfdxz0/Ixko4KoqoY1MYfUL5PIXyApOvWsnXFU7
         HqnpalKAtCvVQ+e+N1XPkTGVjhVNEa6FQQU+nwbkYN8SlWdfAk4CdONWjAn8ivzjuZpN
         4GFjO/DuyaJhp1YI7feesSfmRhccxOmBG6F60=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=l0dj+3Ovsh72VR8b6mpYEl1GpUZxqOUo2nBqMYtEBic=;
        b=KJmbXNMMG2qZQHmJDQ1D5qkPvfR4o2lWeDHl0imE85GPpE1UXHQeS+IrCZ1zYHHCuw
         kEG5hpXKlOeztaVB0ckC+kxIe7ez8aSRTDet9qkQsJDrF4BfbJVHX/tAru7AWyeq4Qwi
         ZuMh5B7ZhHbYcQnyGiGnQ7K0/jnJ1hO3No/DfjBSrIvJDiA5tfzEmnbKxp3DPuisr/Aa
         rt7Z/d/kfO+O3HAlE7Jv2o2+2b9C+ohUXdfn68UKgaMrywsC3cx8kvx5NL/G+fhmmkWO
         NzhVIaBK5gZxV0hgudsa2mAapkq4RonSsjSXJIcnGKFdnMISZG9PBrhCa+ZFcn23Vx9b
         mWGA==
X-Gm-Message-State: ACgBeo2auIM851qpisVRBtWbtyxRnGiEE3QF1sUhHflu2KWbzWvhFOlz
        sYLwh05iOHglhzc8HlKAz8GjGQ==
X-Google-Smtp-Source: AA6agR4U//ZGs2+QixqZoI/oDBd0iR3oAAy9naUwBqzrTmd9Z2eOdUZf1FqwB/GeKszauOMZtDs3LA==
X-Received: by 2002:a17:902:e54e:b0:178:5371:5199 with SMTP id n14-20020a170902e54e00b0017853715199mr1786201plf.59.1663099303178;
        Tue, 13 Sep 2022 13:01:43 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:c6e2:a019:5c54:fb4c])
        by smtp.gmail.com with UTF8SMTPSA id z129-20020a626587000000b00537e1b30793sm8550660pfb.11.2022.09.13.13.01.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Sep 2022 13:01:42 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     stable@vger.kernel.org
Cc:     "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        <linux-kernel@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH 5.15.y] tracefs: Only clobber mode/uid/gid on remount if asked
Date:   Tue, 13 Sep 2022 12:44:33 -0700
Message-Id: <20220913194433.3628619-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 47311db8e8f33011d90dee76b39c8886120cdda4 upstream.

Users may have explicitly configured their tracefs permissions; we
shouldn't overwrite those just because a second mount appeared.

Only clobber if the options were provided at mount time.

Note: the previous behavior was especially surprising in the presence of
automounted /sys/kernel/debug/tracing/.

Existing behavior:

  ## Pre-existing status: tracefs is 0755.
  # stat -c '%A' /sys/kernel/tracing/
  drwxr-xr-x

  ## (Re)trigger the automount.
  # umount /sys/kernel/debug/tracing
  # stat -c '%A' /sys/kernel/debug/tracing/.
  drwx------

  ## Unexpected: the automount changed mode for other mount instances.
  # stat -c '%A' /sys/kernel/tracing/
  drwx------

New behavior (after this change):

  ## Pre-existing status: tracefs is 0755.
  # stat -c '%A' /sys/kernel/tracing/
  drwxr-xr-x

  ## (Re)trigger the automount.
  # umount /sys/kernel/debug/tracing
  # stat -c '%A' /sys/kernel/debug/tracing/.
  drwxr-xr-x

  ## Expected: the automount does not change other mount instances.
  # stat -c '%A' /sys/kernel/tracing/
  drwxr-xr-x

Link: https://lkml.kernel.org/r/20220826174353.2.Iab6e5ea57963d6deca5311b27fb7226790d44406@changeid

Cc: stable@vger.kernel.org
Fixes: 4282d60689d4f ("tracefs: Add new tracefs file system")
Signed-off-by: Brian Norris <briannorris@chromium.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
This fixes a single line of context that makes the "clean" cherry-pick
not work.

This patch also applies to 5.10, 5.4, and probably others, if I tested
correctly.

 fs/tracefs/inode.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index f2625a372a3a..066e8344934d 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -141,6 +141,8 @@ struct tracefs_mount_opts {
 	kuid_t uid;
 	kgid_t gid;
 	umode_t mode;
+	/* Opt_* bitfield. */
+	unsigned int opts;
 };
 
 enum {
@@ -241,6 +243,7 @@ static int tracefs_parse_options(char *data, struct tracefs_mount_opts *opts)
 	kgid_t gid;
 	char *p;
 
+	opts->opts = 0;
 	opts->mode = TRACEFS_DEFAULT_MODE;
 
 	while ((p = strsep(&data, ",")) != NULL) {
@@ -275,24 +278,36 @@ static int tracefs_parse_options(char *data, struct tracefs_mount_opts *opts)
 		 * but traditionally tracefs has ignored all mount options
 		 */
 		}
+
+		opts->opts |= BIT(token);
 	}
 
 	return 0;
 }
 
-static int tracefs_apply_options(struct super_block *sb)
+static int tracefs_apply_options(struct super_block *sb, bool remount)
 {
 	struct tracefs_fs_info *fsi = sb->s_fs_info;
 	struct inode *inode = sb->s_root->d_inode;
 	struct tracefs_mount_opts *opts = &fsi->mount_opts;
 
-	inode->i_mode &= ~S_IALLUGO;
-	inode->i_mode |= opts->mode;
+	/*
+	 * On remount, only reset mode/uid/gid if they were provided as mount
+	 * options.
+	 */
+
+	if (!remount || opts->opts & BIT(Opt_mode)) {
+		inode->i_mode &= ~S_IALLUGO;
+		inode->i_mode |= opts->mode;
+	}
 
-	inode->i_uid = opts->uid;
+	if (!remount || opts->opts & BIT(Opt_uid))
+		inode->i_uid = opts->uid;
 
-	/* Set all the group ids to the mount option */
-	set_gid(sb->s_root, opts->gid);
+	if (!remount || opts->opts & BIT(Opt_gid)) {
+		/* Set all the group ids to the mount option */
+		set_gid(sb->s_root, opts->gid);
+	}
 
 	return 0;
 }
@@ -307,7 +322,7 @@ static int tracefs_remount(struct super_block *sb, int *flags, char *data)
 	if (err)
 		goto fail;
 
-	tracefs_apply_options(sb);
+	tracefs_apply_options(sb, true);
 
 fail:
 	return err;
@@ -359,7 +374,7 @@ static int trace_fill_super(struct super_block *sb, void *data, int silent)
 
 	sb->s_op = &tracefs_super_operations;
 
-	tracefs_apply_options(sb);
+	tracefs_apply_options(sb, false);
 
 	return 0;
 
-- 
2.37.2.789.g6183377224-goog

