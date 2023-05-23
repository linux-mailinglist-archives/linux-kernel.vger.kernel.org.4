Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD1D570D5A5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 09:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235665AbjEWHq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 03:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232707AbjEWHqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 03:46:02 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15815FD;
        Tue, 23 May 2023 00:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=yNfxLrWSKMQ1L/coufSFF/AHaRvjvn5eGandAFcc5MM=; b=gNeHAhTpuwBzma+5J2gptdvAL+
        X+mjBvIwpCNtK8mshwCsbgCLXylDOdYyqNxJ3ZIHA4Rw9uXlqgvX5QBtFp48zBVw1woLM6WwTVPw4
        aPbNPk3jq7Kudwon+STFo3G+811fuw6EPiji7enynVj8+l5KoQjHu/g47iCly9TIlrNoSwQJsfMsJ
        mB9PgzdzZm5ahAais8NTi0QAK1IdZQsniSyqgCs5FA5RT7UF1ID5HNngxg+zx0eQ1TmjWFlSwbDBd
        Q1geRhKlO089vBZK5i7Fe9tDEBZ0Y8HAnActNdlz4KHIaltMSGWIjzkuI6T487Kd2X5MNQqTrlU4Z
        cLD9ftWQ==;
Received: from [2001:4bb8:188:23b2:6ade:85c9:530f:6eb0] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q1MiQ-009GZc-0j;
        Tue, 23 May 2023 07:45:54 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Mike Snitzer <snitzer@kernel.org>,
        Joern Engel <joern@lazybastard.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Pavel Machek <pavel@ucw.cz>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-pm@vger.kernel.org
Subject: [PATCH 06/24] init: rename mount_block_root to mount_root_generic
Date:   Tue, 23 May 2023 09:45:17 +0200
Message-Id: <20230523074535.249802-7-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230523074535.249802-1-hch@lst.de>
References: <20230523074535.249802-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mount_block_root is also used to mount non-block file systems, so give
it a better name.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 init/do_mounts.c        | 6 +++---
 init/do_mounts.h        | 2 +-
 init/do_mounts_initrd.c | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/init/do_mounts.c b/init/do_mounts.c
index 2fe7901b5bcfaf..a2c0baace0992c 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -391,7 +391,7 @@ static int __init do_mount_root(const char *name, const char *fs,
 	return ret;
 }
 
-void __init mount_block_root(char *name, int flags)
+void __init mount_root_generic(char *name, int flags)
 {
 	struct page *page = alloc_page(GFP_KERNEL);
 	char *fs_names = page_address(page);
@@ -589,7 +589,7 @@ void __init mount_root(void)
 
 		if (err < 0)
 			pr_emerg("Failed to create /dev/root: %d\n", err);
-		mount_block_root("/dev/root", root_mountflags);
+		mount_root_generic("/dev/root", root_mountflags);
 	}
 #endif
 }
@@ -620,7 +620,7 @@ void __init prepare_namespace(void)
 		root_device_name = saved_root_name;
 		if (!strncmp(root_device_name, "mtd", 3) ||
 		    !strncmp(root_device_name, "ubi", 3)) {
-			mount_block_root(root_device_name, root_mountflags);
+			mount_root_generic(root_device_name, root_mountflags);
 			goto out;
 		}
 		ROOT_DEV = name_to_dev_t(root_device_name);
diff --git a/init/do_mounts.h b/init/do_mounts.h
index 7a29ac3e427bab..33623025f6951a 100644
--- a/init/do_mounts.h
+++ b/init/do_mounts.h
@@ -10,7 +10,7 @@
 #include <linux/root_dev.h>
 #include <linux/init_syscalls.h>
 
-void  mount_block_root(char *name, int flags);
+void  mount_root_generic(char *name, int flags);
 void  mount_root(void);
 extern int root_mountflags;
 
diff --git a/init/do_mounts_initrd.c b/init/do_mounts_initrd.c
index 34731241377d30..686d1ff3af4bb1 100644
--- a/init/do_mounts_initrd.c
+++ b/init/do_mounts_initrd.c
@@ -95,7 +95,7 @@ static void __init handle_initrd(void)
 	real_root_dev = new_encode_dev(ROOT_DEV);
 	create_dev("/dev/root.old", Root_RAM0);
 	/* mount initrd on rootfs' /root */
-	mount_block_root("/dev/root.old", root_mountflags & ~MS_RDONLY);
+	mount_root_generic("/dev/root.old", root_mountflags & ~MS_RDONLY);
 	init_mkdir("/old", 0700);
 	init_chdir("/old");
 
-- 
2.39.2

