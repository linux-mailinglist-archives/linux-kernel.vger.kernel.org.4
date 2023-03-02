Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D94AB6A8D04
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 00:28:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbjCBX2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 18:28:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbjCBX2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 18:28:11 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA90011E94
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 15:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=aVGWGg28pehMWy6o19l/TsZGWBXxeVmCZNXdGLwnZq4=; b=TlDiW9om0AtjuznlGSshw1b4sC
        ghR2WXi7V+f5PZ1jG/o45vCIdVVPAervPRo0lvMQJdxtcovf9IN60XRQyXJ1TOSoZDYvbKBXbI/Wi
        kuqHDamMQIx8Oh2hC1RmvcgDdngdxl8vCJelPxKnPdI6sZqCLJP7oKLTX7HCNfOVjJ+oJWhrHo56l
        jIjCnoGvXoEsBAierza5C+Z0oTy0fXnLWb9sfdDC4drisylwEXR0+Vwcjgn7AYvnMbzbxgtrQjiQg
        eoDfsRFufkoQ6AunUMT7LpC6d+FMUW/ESv6NhPIS/cqtmkwozQFqphCo+anHmfRTZfKqu4eV620Lr
        q5ku9HZg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pXsL9-003j3S-Gf; Thu, 02 Mar 2023 23:27:59 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     hughd@google.com, akpm@linux-foundation.org, willy@infradead.org,
        brauner@kernel.org
Cc:     linux-mm@kvack.org, p.raghav@samsung.com, da.gomez@samsung.com,
        a.manzanares@samsung.com, dave@stgolabs.net, yosryahmed@google.com,
        keescook@chromium.org, mcgrof@kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] shmem: add support to ignore swap
Date:   Thu,  2 Mar 2023 15:27:58 -0800
Message-Id: <20230302232758.888157-7-mcgrof@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230302232758.888157-1-mcgrof@kernel.org>
References: <20230302232758.888157-1-mcgrof@kernel.org>
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

In doing experimentations with shmem having the option to avoid swap
becomes a useful mechanism. One of the *raves* about brd over shmem is
you can avoid swap, but that's not really a good reason to use brd if
we can instead use shmem. Using brd has its own good reasons to exist,
but just because "tmpfs" doesn't let you do that is not a great reason
to avoid it if we can easily add support for it.

I don't add support for reconfiguring incompatible options, but if
we really wanted to we can add support for that.

To avoid swap we use mapping_set_unevictable() upon inode creation,
and put a WARN_ON_ONCE() stop-gap on writepages() for reclaim.

Acked-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 Documentation/filesystems/tmpfs.rst  |  9 ++++++---
 Documentation/mm/unevictable-lru.rst |  2 ++
 include/linux/shmem_fs.h             |  1 +
 mm/shmem.c                           | 28 +++++++++++++++++++++++++++-
 4 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/Documentation/filesystems/tmpfs.rst b/Documentation/filesystems/tmpfs.rst
index e77ebdacadd0..551b621f34d9 100644
--- a/Documentation/filesystems/tmpfs.rst
+++ b/Documentation/filesystems/tmpfs.rst
@@ -13,7 +13,8 @@ everything stored therein is lost.
 
 tmpfs puts everything into the kernel internal caches and grows and
 shrinks to accommodate the files it contains and is able to swap
-unneeded pages out to swap space.
+unneeded pages out to swap space, if swap was enabled for the tmpfs
+filesystem.
 
 tmpfs extends ramfs with a few userspace configurable options listed and
 explained further below, some of which can be reconfigured dynamically on the
@@ -33,8 +34,8 @@ configured in size at initialization and you cannot dynamically resize them.
 Contrary to brd ramdisks, tmpfs has its own filesystem, it does not rely on the
 block layer at all.
 
-Since tmpfs lives completely in the page cache and on swap, all tmpfs
-pages will be shown as "Shmem" in /proc/meminfo and "Shared" in
+Since tmpfs lives completely in the page cache and on optionally on swap,
+all tmpfs pages will be shown as "Shmem" in /proc/meminfo and "Shared" in
 free(1). Notice that these counters also include shared memory
 (shmem, see ipcs(1)). The most reliable way to get the count is
 using df(1) and du(1).
@@ -83,6 +84,8 @@ nr_inodes  The maximum number of inodes for this instance. The default
            is half of the number of your physical RAM pages, or (on a
            machine with highmem) the number of lowmem RAM pages,
            whichever is the lower.
+noswap     Disables swap. Remounts must respect the original settings.
+           By default swap is enabled.
 =========  ============================================================
 
 These parameters accept a suffix k, m or g for kilo, mega and giga and
diff --git a/Documentation/mm/unevictable-lru.rst b/Documentation/mm/unevictable-lru.rst
index 92ac5dca420c..3cdcbb6e00a0 100644
--- a/Documentation/mm/unevictable-lru.rst
+++ b/Documentation/mm/unevictable-lru.rst
@@ -42,6 +42,8 @@ The unevictable list addresses the following classes of unevictable pages:
 
  * Those owned by ramfs.
 
+ * Those owned by tmpfs with the noswap option.
+
  * Those mapped into SHM_LOCK'd shared memory regions.
 
  * Those mapped into VM_LOCKED [mlock()ed] VMAs.
diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index 103d1000a5a2..21989d4f8cbe 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -45,6 +45,7 @@ struct shmem_sb_info {
 	kuid_t uid;		    /* Mount uid for root directory */
 	kgid_t gid;		    /* Mount gid for root directory */
 	bool full_inums;	    /* If i_ino should be uint or ino_t */
+	bool noswap;		    /* ingores VM relcaim / swap requests */
 	ino_t next_ino;		    /* The next per-sb inode number to use */
 	ino_t __percpu *ino_batch;  /* The next per-cpu inode number to use */
 	struct mempolicy *mpol;     /* default memory policy for mappings */
diff --git a/mm/shmem.c b/mm/shmem.c
index 6006dbb7dbcb..cd36cb3d974c 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -119,10 +119,12 @@ struct shmem_options {
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
@@ -1337,6 +1339,7 @@ static int shmem_writepage(struct page *page, struct writeback_control *wbc)
 	struct address_space *mapping = folio->mapping;
 	struct inode *inode = mapping->host;
 	struct shmem_inode_info *info = SHMEM_I(inode);
+	struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
 	swp_entry_t swap;
 	pgoff_t index;
 
@@ -1352,7 +1355,7 @@ static int shmem_writepage(struct page *page, struct writeback_control *wbc)
 		goto redirty;
 	}
 
-	if (WARN_ON_ONCE(info->flags & VM_LOCKED))
+	if (WARN_ON_ONCE((info->flags & VM_LOCKED) || sbinfo->noswap))
 		goto redirty;
 
 	if (!total_swap_pages)
@@ -2489,6 +2492,8 @@ static struct inode *shmem_get_inode(struct mnt_idmap *idmap, struct super_block
 			shmem_set_inode_flags(inode, info->fsflags);
 		INIT_LIST_HEAD(&info->shrinklist);
 		INIT_LIST_HEAD(&info->swaplist);
+		if (sbinfo->noswap)
+			mapping_set_unevictable(inode->i_mapping);
 		simple_xattrs_init(&info->xattrs);
 		cache_no_acl(inode);
 		mapping_set_large_folios(inode->i_mapping);
@@ -3576,6 +3581,7 @@ enum shmem_param {
 	Opt_uid,
 	Opt_inode32,
 	Opt_inode64,
+	Opt_noswap,
 };
 
 static const struct constant_table shmem_param_enums_huge[] = {
@@ -3597,6 +3603,7 @@ const struct fs_parameter_spec shmem_fs_parameters[] = {
 	fsparam_u32   ("uid",		Opt_uid),
 	fsparam_flag  ("inode32",	Opt_inode32),
 	fsparam_flag  ("inode64",	Opt_inode64),
+	fsparam_flag  ("noswap",	Opt_noswap),
 	{}
 };
 
@@ -3680,6 +3687,10 @@ static int shmem_parse_one(struct fs_context *fc, struct fs_parameter *param)
 		ctx->full_inums = true;
 		ctx->seen |= SHMEM_SEEN_INUMS;
 		break;
+	case Opt_noswap:
+		ctx->noswap = true;
+		ctx->seen |= SHMEM_SEEN_NOSWAP;
+		break;
 	}
 	return 0;
 
@@ -3778,6 +3789,14 @@ static int shmem_reconfigure(struct fs_context *fc)
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
@@ -3798,6 +3817,10 @@ static int shmem_reconfigure(struct fs_context *fc)
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
@@ -3852,6 +3875,8 @@ static int shmem_show_options(struct seq_file *seq, struct dentry *root)
 		seq_printf(seq, ",huge=%s", shmem_format_huge(sbinfo->huge));
 #endif
 	shmem_show_mpol(seq, sbinfo->mpol);
+	if (sbinfo->noswap)
+		seq_printf(seq, ",noswap");
 	return 0;
 }
 
@@ -3895,6 +3920,7 @@ static int shmem_fill_super(struct super_block *sb, struct fs_context *fc)
 			ctx->inodes = shmem_default_max_inodes();
 		if (!(ctx->seen & SHMEM_SEEN_INUMS))
 			ctx->full_inums = IS_ENABLED(CONFIG_TMPFS_INODE64);
+		sbinfo->noswap = ctx->noswap;
 	} else {
 		sb->s_flags |= SB_NOUSER;
 	}
-- 
2.39.1

