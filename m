Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFBA86917B2
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 05:49:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbjBJEtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 23:49:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbjBJEsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 23:48:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9541A6D8E7
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 20:48:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 34607B823BE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 04:48:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 786BEC433A1;
        Fri, 10 Feb 2023 04:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676004527;
        bh=GHjXtEXAs/907P6A+4MUMIxpIxGv/uFwCu4RPtNwvv4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=osoBk/p5fti365hKvBevvfZpAfFjjBuRvv90yf+hbzGZGnr44zGzfMzevZBF1G5W+
         0cZp6p4OTOl29Rq8NHb+4yhgbo8Dduwr/YXYSUYSaJfAIuLSRgmDs6O0hUYP3PvxqA
         lnnI3TiTC1gQpj6NnQM4FpQwlGgEiexU4MJHePwMijo+PLyb1i04CdpxtINd6AHV+t
         iDshdB/9WNtDhnYuAiB7CBh1adRpmRDEgHAOFRS5ChWfCZGD0kOJAV2osSEbuacspk
         /OtFQ0ujR1NeVbbBb8i0JhTrOBz2jn7zCDH/hnK7mivL/KBsapzZBsQf3lecRBPt1G
         cR/odiYu7eU/g==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 3/3] mm/damon/dbgfs: print DAMON debugfs interface deprecation message
Date:   Fri, 10 Feb 2023 04:48:38 +0000
Message-Id: <20230210044838.63723-4-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230210044838.63723-1-sj@kernel.org>
References: <20230210044838.63723-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DAMON debugfs interface has announced to be deprecated after >v5.15 LTS
kernel is released.  And, v6.1.y has announced to be an LTS[1].

Though the announcement was there for a while, some people might not
noticed that so far.  Also, some users could depend on it and have
problems at  movng to the alternative (DAMON sysfs interface).

For such cases, warn DAMON debugfs interface deprecation with contacts
to ask helps when any DAMON debugfs interface file is opened.

[1] https://git.kernel.org/pub/scm/docs/kernel/website.git/commit/?id=332e9121320bc7461b2d3a79665caf153e51732c

Link: https://lkml.kernel.org/r/20230209192009.7885-4-sj@kernel.org
Signed-off-by: SeongJae Park <sj@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 mm/damon/dbgfs.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/mm/damon/dbgfs.c b/mm/damon/dbgfs.c
index b3f454a5c682..124f0f8c97b7 100644
--- a/mm/damon/dbgfs.c
+++ b/mm/damon/dbgfs.c
@@ -20,6 +20,14 @@ static int dbgfs_nr_ctxs;
 static struct dentry **dbgfs_dirs;
 static DEFINE_MUTEX(damon_dbgfs_lock);
 
+static void damon_dbgfs_warn_deprecation(void)
+{
+	pr_warn_once("DAMON debugfs interface is deprecated, "
+		     "so users should move to DAMON_SYSFS. If you cannot, "
+		     "please report your usecase to damon@lists.linux.dev and "
+		     "linux-mm@kvack.org.\n");
+}
+
 /*
  * Returns non-empty string on success, negative error code otherwise.
  */
@@ -711,6 +719,8 @@ static ssize_t dbgfs_kdamond_pid_read(struct file *file,
 
 static int damon_dbgfs_open(struct inode *inode, struct file *file)
 {
+	damon_dbgfs_warn_deprecation();
+
 	file->private_data = inode->i_private;
 
 	return nonseekable_open(inode, file);
@@ -1039,15 +1049,24 @@ static ssize_t dbgfs_monitor_on_write(struct file *file,
 	return ret;
 }
 
+static int damon_dbgfs_static_file_open(struct inode *inode, struct file *file)
+{
+	damon_dbgfs_warn_deprecation();
+	return nonseekable_open(inode, file);
+}
+
 static const struct file_operations mk_contexts_fops = {
+	.open = damon_dbgfs_static_file_open,
 	.write = dbgfs_mk_context_write,
 };
 
 static const struct file_operations rm_contexts_fops = {
+	.open = damon_dbgfs_static_file_open,
 	.write = dbgfs_rm_context_write,
 };
 
 static const struct file_operations monitor_on_fops = {
+	.open = damon_dbgfs_static_file_open,
 	.read = dbgfs_monitor_on_read,
 	.write = dbgfs_monitor_on_write,
 };
-- 
2.25.1

