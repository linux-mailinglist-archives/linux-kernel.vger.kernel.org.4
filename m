Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D233B5B642F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 01:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbiILXb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 19:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiILXby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 19:31:54 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB6D183B5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 16:31:54 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id o70-20020a17090a0a4c00b00202f898fa86so229999pjo.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 16:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=LKgMiQjrNEffOc0F7D5pywr8MsPGi/ZE2aFBT5y4M4s=;
        b=XqphzszXS/WRiRi7+OUvfWcAFBblm66v/XXlVivW/3dnsj3RwmB9X0EDb3IgADwYaV
         RlIyaUm2zeIxaWkToHa1lwz8BZBZa2ocPAb6UIpiQ2AObhZH6zE3iG0bq9OM9yLKtiDF
         C+G6wGM6sE5KExclwC33tSiZu12jxgezDY3Nk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=LKgMiQjrNEffOc0F7D5pywr8MsPGi/ZE2aFBT5y4M4s=;
        b=PFu6SsAwxeQIMnevWORc7pK9NzjtGg0HL71yp6P/bGLw7RCumUeH+E/FgYE0ekfXyB
         LkIb6LyrRcyL6ldh7CHjartwI4CYPEvxUcVrKIMGHRMBAw4NulSZBkXW7NCfAcv1N2N2
         4zJWs3v6RITezC1FgNNIGvdkmWGYqfJ0GY21FLtM2xMM6yGpPvfmOapsukzLG4YHjcCO
         /XP5XSDlRkjPThbHVGu/Iocb5NE2HSIBU+8tdzxmRNrw3t5v6Nvku2T5u2Q74OGaOcTF
         TDiuWpGOuEAUmG24/lggLqku6cixZa50Q12rrSVpRWt0itH4J3/g5s4ap+5x1BQqq/k8
         AQcQ==
X-Gm-Message-State: ACgBeo1MIBeFXpNb2eZQqAnv7huam/YFpTaeDCo3TE6hhdoJxD9xZpjL
        fiq4w+l9ss/J4Zr8sOrd70Isng==
X-Google-Smtp-Source: AA6agR4wuJ6mKwP1WPEvANwMtCI4WRJVy6lPN89IZ4P5/iaVOTT2AGVcHyg7/oKKhX4u33KNPYO1ew==
X-Received: by 2002:a17:902:f604:b0:172:75a4:33ea with SMTP id n4-20020a170902f60400b0017275a433eamr28728264plg.7.1663025513569;
        Mon, 12 Sep 2022 16:31:53 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:2243:15f6:8e1a:11ad])
        by smtp.gmail.com with UTF8SMTPSA id y9-20020a170902864900b00177ec9ee533sm6563839plt.151.2022.09.12.16.31.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Sep 2022 16:31:52 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH v3] debugfs: Only clobber mode/uid/gid on remount if asked
Date:   Mon, 12 Sep 2022 16:31:42 -0700
Message-Id: <20220912163042.v3.1.Icbd40fce59f55ad74b80e5d435ea233579348a78@changeid>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Users may have explicitly configured their debugfs permissions; we
shouldn't overwrite those just because a second mount appeared.

Only clobber if the options were provided at mount time.

Existing behavior:

  ## Pre-existing status: debugfs is 0755.
  # chmod 755 /sys/kernel/debug/
  # stat -c '%A' /sys/kernel/debug/
  drwxr-xr-x

  ## New mount sets kernel-default permissions:
  # mount -t debugfs none /mnt/foo
  # stat -c '%A' /mnt/foo
  drwx------

  ## Unexpected: the original mount changed permissions:
  # stat -c '%A' /sys/kernel/debug
  drwx------

New behavior:

  ## Pre-existing status: debugfs is 0755.
  # chmod 755 /sys/kernel/debug/
  # stat -c '%A' /sys/kernel/debug/
  drwxr-xr-x

  ## New mount inherits existing permissions:
  # mount -t debugfs none /mnt/foo
  # stat -c '%A' /mnt/foo
  drwxr-xr-x

  ## Expected: old mount is unchanged:
  # stat -c '%A' /sys/kernel/debug
  drwxr-xr-x

Full test cases are being submitted to LTP.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
Temporary LTP branch here:
https://github.com/computersforpeace/ltp/commits/debugfs

I'll put in an LTP pull request once the kernel tree actually contains
my patches.

Companion patch:
  tracefs: Only clobber mode/uid/gid on remount if asked
  https://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git/commit/?h=trace-v6.0-rc4&id=47311db8e8f33011d90dee76b39c8886120cdda4

Changes in v3:
* Factor out _debugfs_apply_options() to hide boolean arg
* Drop unused return value

Changes in v2:
* Update commit description
* Include LTP patch in notes
* Split from tracefs patch

 fs/debugfs/inode.c | 37 ++++++++++++++++++++++++++++++-------
 1 file changed, 30 insertions(+), 7 deletions(-)

diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index 3dcf0b8b4e93..83749cd67e0d 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -82,6 +82,8 @@ struct debugfs_mount_opts {
 	kuid_t uid;
 	kgid_t gid;
 	umode_t mode;
+	/* Opt_* bitfield. */
+	unsigned int opts;
 };
 
 enum {
@@ -111,6 +113,7 @@ static int debugfs_parse_options(char *data, struct debugfs_mount_opts *opts)
 	kgid_t gid;
 	char *p;
 
+	opts->opts = 0;
 	opts->mode = DEBUGFS_DEFAULT_MODE;
 
 	while ((p = strsep(&data, ",")) != NULL) {
@@ -145,24 +148,44 @@ static int debugfs_parse_options(char *data, struct debugfs_mount_opts *opts)
 		 * but traditionally debugfs has ignored all mount options
 		 */
 		}
+
+		opts->opts |= BIT(token);
 	}
 
 	return 0;
 }
 
-static int debugfs_apply_options(struct super_block *sb)
+static void _debugfs_apply_options(struct super_block *sb, bool remount)
 {
 	struct debugfs_fs_info *fsi = sb->s_fs_info;
 	struct inode *inode = d_inode(sb->s_root);
 	struct debugfs_mount_opts *opts = &fsi->mount_opts;
 
-	inode->i_mode &= ~S_IALLUGO;
-	inode->i_mode |= opts->mode;
+	/*
+	 * On remount, only reset mode/uid/gid if they were provided as mount
+	 * options.
+	 */
 
-	inode->i_uid = opts->uid;
-	inode->i_gid = opts->gid;
+	if (!remount || opts->opts & BIT(Opt_mode)) {
+		inode->i_mode &= ~S_IALLUGO;
+		inode->i_mode |= opts->mode;
+	}
 
-	return 0;
+	if (!remount || opts->opts & BIT(Opt_uid))
+		inode->i_uid = opts->uid;
+
+	if (!remount || opts->opts & BIT(Opt_gid))
+		inode->i_gid = opts->gid;
+}
+
+static void debugfs_apply_options(struct super_block *sb)
+{
+	_debugfs_apply_options(sb, false);
+}
+
+static void debugfs_apply_options_remount(struct super_block *sb)
+{
+	_debugfs_apply_options(sb, true);
 }
 
 static int debugfs_remount(struct super_block *sb, int *flags, char *data)
@@ -175,7 +198,7 @@ static int debugfs_remount(struct super_block *sb, int *flags, char *data)
 	if (err)
 		goto fail;
 
-	debugfs_apply_options(sb);
+	debugfs_apply_options_remount(sb);
 
 fail:
 	return err;
-- 
2.37.2.789.g6183377224-goog

