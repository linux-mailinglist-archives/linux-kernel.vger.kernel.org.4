Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 258186A0146
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 03:44:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232166AbjBWCoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 21:44:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbjBWCo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 21:44:27 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC79E27D42
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 18:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=wt4p/r9ymCcnGEqY87sHknk0U2eY7wcxJejPwvb0Ylo=; b=TrDfJdxVZcws00Hj9FGWVMTTCL
        LfcxodfOiVzFwmzhWMsfva7J5bIJGP2E7QgIGmqqfo0DOX04NoMNtbtNomLSuHaXzr0rQJ8uBJCPI
        llX7IWzs7lCHCrQRtkGRVdkzf6Wj9qUR7dRDXpKE8czsLpuellL8pHfWdJLVatBbwk7uRCU3k8RLP
        tH5N9MsQXVK3OPjAO672R0qfraGFGCGc5hq8V5GARE9bDCNt5yr0aFIUrtNVR8Txu6e8QOcsB1HBw
        OOyzrDPA419O0WyksHMacOMnEMt9/aWoLIr4DUUWS29M99FQ9baEFP4R0ZkbDchM4BVFJH0OqqpIR
        7yC1G3EA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pV1ah-00EmNH-BN; Thu, 23 Feb 2023 02:44:15 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     hughd@google.com, akpm@linux-foundation.org, willy@infradead.org
Cc:     linux-mm@kvack.org, p.raghav@samsung.com, dave@stgolabs.net,
        a.manzanares@samsung.com, yosryahmed@google.com, mcgrof@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC v2 5/5] shmem: add support to ignore swap
Date:   Wed, 22 Feb 2023 18:44:12 -0800
Message-Id: <20230223024412.3522465-6-mcgrof@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230223024412.3522465-1-mcgrof@kernel.org>
References: <20230223024412.3522465-1-mcgrof@kernel.org>
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

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 Documentation/mm/unevictable-lru.rst |  2 ++
 include/linux/shmem_fs.h             |  1 +
 mm/shmem.c                           | 26 +++++++++++++++++++++++++-
 3 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/Documentation/mm/unevictable-lru.rst b/Documentation/mm/unevictable-lru.rst
index 53e59433497a..d7e11f492289 100644
--- a/Documentation/mm/unevictable-lru.rst
+++ b/Documentation/mm/unevictable-lru.rst
@@ -44,6 +44,8 @@ The unevictable list addresses the following classes of unevictable pages:
 
  * Those owned by ramfs.
 
+ * Those owned by tmpfs with the noswap option.
+
  * Those mapped into SHM_LOCK'd shared memory regions.
 
  * Those mapped into VM_LOCKED [mlock()ed] VMAs.
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
index a49b31d38627..d2f34147fc66 100644
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
@@ -1334,6 +1336,7 @@ static int shmem_writepage(struct page *page, struct writeback_control *wbc)
 	struct address_space *mapping = folio->mapping;
 	struct inode *inode = mapping->host;
 	struct shmem_inode_info *info = SHMEM_I(inode);
+	struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
 	swp_entry_t swap;
 	pgoff_t index;
 
@@ -1349,7 +1352,7 @@ static int shmem_writepage(struct page *page, struct writeback_control *wbc)
 		goto redirty;
 	}
 
-	if (WARN_ON_ONCE(info->flags & VM_LOCKED))
+	if (WARN_ON_ONCE((info->flags & VM_LOCKED) || sbinfo->noswap))
 		goto redirty;
 
 	if (!total_swap_pages)
@@ -2374,6 +2377,8 @@ static struct inode *shmem_get_inode(struct mnt_idmap *idmap, struct super_block
 			shmem_set_inode_flags(inode, info->fsflags);
 		INIT_LIST_HEAD(&info->shrinklist);
 		INIT_LIST_HEAD(&info->swaplist);
+		if (sbinfo->noswap)
+			mapping_set_unevictable(inode->i_mapping);
 		simple_xattrs_init(&info->xattrs);
 		cache_no_acl(inode);
 		mapping_set_large_folios(inode->i_mapping);
@@ -3461,6 +3466,7 @@ enum shmem_param {
 	Opt_uid,
 	Opt_inode32,
 	Opt_inode64,
+	Opt_noswap,
 };
 
 static const struct constant_table shmem_param_enums_huge[] = {
@@ -3482,6 +3488,7 @@ const struct fs_parameter_spec shmem_fs_parameters[] = {
 	fsparam_u32   ("uid",		Opt_uid),
 	fsparam_flag  ("inode32",	Opt_inode32),
 	fsparam_flag  ("inode64",	Opt_inode64),
+	fsparam_flag  ("noswap",	Opt_noswap),
 	{}
 };
 
@@ -3565,6 +3572,10 @@ static int shmem_parse_one(struct fs_context *fc, struct fs_parameter *param)
 		ctx->full_inums = true;
 		ctx->seen |= SHMEM_SEEN_INUMS;
 		break;
+	case Opt_noswap:
+		ctx->noswap = true;
+		ctx->seen |= SHMEM_SEEN_NOSWAP;
+		break;
 	}
 	return 0;
 
@@ -3663,6 +3674,14 @@ static int shmem_reconfigure(struct fs_context *fc)
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
@@ -3683,6 +3702,10 @@ static int shmem_reconfigure(struct fs_context *fc)
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
@@ -3780,6 +3803,7 @@ static int shmem_fill_super(struct super_block *sb, struct fs_context *fc)
 			ctx->inodes = shmem_default_max_inodes();
 		if (!(ctx->seen & SHMEM_SEEN_INUMS))
 			ctx->full_inums = IS_ENABLED(CONFIG_TMPFS_INODE64);
+		sbinfo->noswap = ctx->noswap;
 	} else {
 		sb->s_flags |= SB_NOUSER;
 	}
-- 
2.39.1

