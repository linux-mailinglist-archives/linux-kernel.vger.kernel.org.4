Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B17B68CCDF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 03:53:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbjBGCxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 21:53:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbjBGCxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 21:53:13 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 459198F
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 18:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=tHEHYU6fwwSgYtD4IiT1K2TtAGYnTqD5ffLm2GBmZUI=; b=n3Xzbpwvi5oAiSo5zYlxk8sfdB
        7WVyFF3CjHjFDkGUujgYcbAC9WFOsz2K3HCPL7jlrhJ31kurxtDK2v/eYtMu0fq0FvLAq94pd/Yig
        Wr6906Jfnc0ktSQfgiH7WhxLuAV4eUFplQBu+1wf3jWeKpVUQg9ZvmUPN4v4OFeKp7DN1KsCYiAJl
        GCta8WSWj7WZ3mzcytPX2363rN5qT10QiCologeRtELY3PNjzb129tAoZ2K4byHBeFigqL3W9RdHS
        CGCkjCivYb/giDRn4a52UDQ+Quqb+J5lt8wR3OJJKI1gkKE2bVvyL4SZ66CKP2ebUSgLoDLkrjvGM
        ilnor7xQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pPE6U-00AaJC-4H; Tue, 07 Feb 2023 02:53:06 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     hughd@google.com, akpm@linux-foundation.org, willy@infradead.org
Cc:     linux-mm@kvack.org, p.raghav@samsung.com, dave@stgolabs.net,
        a.manzanares@samsung.com, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [RFC 2/2] shmem: add support to ignore swap
Date:   Mon,  6 Feb 2023 18:52:59 -0800
Message-Id: <20230207025259.2522793-3-mcgrof@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230207025259.2522793-1-mcgrof@kernel.org>
References: <20230207025259.2522793-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In doing experimentations with shmem having the option to avoid becomes
a useful mechanism. One of the *raves* about brd over shmem is you can
avoid swap, but that's not really a good reason to use brd if we can
instead use shmem. Using brd has its own good reasons to exist, but
just because "tmpfs" doesn't let you do that is not a great reason
to avoid it if we can easily add support for it.

I don't add support for reconfiguring incompatible options, but if
we really wanted to we can add support for that.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 include/linux/shmem_fs.h |  1 +
 mm/shmem.c               | 25 +++++++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index d09d54be4ffd..98a7d53f6cc5 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -45,6 +45,7 @@ struct shmem_sb_info {
 	kuid_t uid;		    /* Mount uid for root directory */
 	kgid_t gid;		    /* Mount gid for root directory */
 	bool full_inums;	    /* If i_ino should be uint or ino_t */
+	bool noswap;	    	    /* ingores VM relcaim / swap requests */
 	ino_t next_ino;		    /* The next per-sb inode number to use */
 	ino_t __percpu *ino_batch;  /* The next per-cpu inode number to use */
 	struct mempolicy *mpol;     /* default memory policy for mappings */
diff --git a/mm/shmem.c b/mm/shmem.c
index a2c6aa11aab8..92aa927cf569 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -116,10 +116,12 @@ struct shmem_options {
 	bool full_inums;
 	int huge;
 	int seen;
+	bool noswap;
 #define SHMEM_SEEN_BLOCKS 1
 #define SHMEM_SEEN_INODES 2
 #define SHMEM_SEEN_HUGE 4
 #define SHMEM_SEEN_INUMS 8
+#define SHMEM_SEEN_NOSWAP 16
 };
 
 #ifdef CONFIG_TMPFS
@@ -1334,11 +1336,15 @@ static int shmem_writepage(struct page *page, struct writeback_control *wbc)
 	struct shmem_inode_info *info;
 	struct address_space *mapping = folio->mapping;
 	struct inode *inode = mapping->host;
+	struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
 	swp_entry_t swap;
 	pgoff_t index;
 
 	BUG_ON(!folio_test_locked(folio));
 
+	if (wbc->for_reclaim && unlikely(sbinfo->noswap))
+		return AOP_WRITEPAGE_ACTIVATE;
+
 	/*
 	 * If /sys/kernel/mm/transparent_hugepage/shmem_enabled is "always" or
 	 * "force", drivers/gpu/drm/i915/gem/i915_gem_shmem.c gets huge pages,
@@ -3465,6 +3471,7 @@ enum shmem_param {
 	Opt_uid,
 	Opt_inode32,
 	Opt_inode64,
+	Opt_noswap,
 };
 
 static const struct constant_table shmem_param_enums_huge[] = {
@@ -3486,6 +3493,7 @@ const struct fs_parameter_spec shmem_fs_parameters[] = {
 	fsparam_u32   ("uid",		Opt_uid),
 	fsparam_flag  ("inode32",	Opt_inode32),
 	fsparam_flag  ("inode64",	Opt_inode64),
+	fsparam_flag  ("noswap",	Opt_noswap),
 	{}
 };
 
@@ -3569,6 +3577,10 @@ static int shmem_parse_one(struct fs_context *fc, struct fs_parameter *param)
 		ctx->full_inums = true;
 		ctx->seen |= SHMEM_SEEN_INUMS;
 		break;
+	case Opt_noswap:
+		ctx->noswap = true;
+		ctx->seen |= SHMEM_SEEN_NOSWAP;
+		break;
 	}
 	return 0;
 
@@ -3667,6 +3679,14 @@ static int shmem_reconfigure(struct fs_context *fc)
 		err = "Current inum too high to switch to 32-bit inums";
 		goto out;
 	}
+	if ((ctx->seen & SHMEM_SEEN_NOSWAP) && ctx->noswap && !sbinfo->noswap) {
+		err = "Cannot disable swap on remount";
+		goto out;
+	}
+	if (!(ctx->seen & SHMEM_SEEN_NOSWAP) && !ctx->noswap && sbinfo->noswap) {
+		err = "Cannot enable swap on remount if it was disabled on first mount";
+		goto out;
+	}
 
 	if (ctx->seen & SHMEM_SEEN_HUGE)
 		sbinfo->huge = ctx->huge;
@@ -3687,6 +3707,10 @@ static int shmem_reconfigure(struct fs_context *fc)
 		sbinfo->mpol = ctx->mpol;	/* transfers initial ref */
 		ctx->mpol = NULL;
 	}
+
+	if (ctx->noswap)
+		sbinfo->noswap = true;
+
 	raw_spin_unlock(&sbinfo->stat_lock);
 	mpol_put(mpol);
 	return 0;
@@ -3784,6 +3808,7 @@ static int shmem_fill_super(struct super_block *sb, struct fs_context *fc)
 			ctx->inodes = shmem_default_max_inodes();
 		if (!(ctx->seen & SHMEM_SEEN_INUMS))
 			ctx->full_inums = IS_ENABLED(CONFIG_TMPFS_INODE64);
+		sbinfo->noswap = ctx->noswap;
 	} else {
 		sb->s_flags |= SB_NOUSER;
 	}
-- 
2.39.0

