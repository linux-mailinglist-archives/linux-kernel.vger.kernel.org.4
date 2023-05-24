Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 444FF710016
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 23:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235516AbjEXVgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 17:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbjEXVgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 17:36:37 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A05FC;
        Wed, 24 May 2023 14:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=h6efk8Ysq6YvdHmIiWzptWXcpmBWI4dNRo/RHrF21d0=; b=3gNDO0Wg64hic2BkgNJQhT8uEE
        vXe/WFB4JJNHZqRPduj24Av8RrkczfBwIjceOGIkKu/H2TuNiWkmWdwRgQ1mHBn37QqCCRJsKNPbo
        xoKeNHkwQbNwUVnRZWtftS2KwDwwjPlbHm36QyNR2G3G/YZrOhQHGvpbWPEQfzCAc/VOMMdYwt8Aj
        5R1qjrHtBVEnchbIwMQQqPKuHr9pOROwPTuvKwV4iwoocqcmY2z5HasmNInfcAXDD6acGh/I0qZ6B
        p6JJGXhwtzWz5we3JQqlO/sSDYSuHsJW2Qw1iabSfCLW2V52Z+vspH7fm/NPsIHibZOMMQTuZKH+E
        mNxmi1gA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q1w9d-00EitJ-19;
        Wed, 24 May 2023 21:36:21 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     david@redhat.com, tglx@linutronix.de, hch@lst.de,
        patches@lists.linux.dev, linux-modules@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, pmladek@suse.com,
        petr.pavlu@suse.com, prarit@redhat.com,
        torvalds@linux-foundation.org, lennart@poettering.net
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org, song@kernel.org,
        lucas.de.marchi@gmail.com, lucas.demarchi@intel.com,
        christophe.leroy@csgroup.eu, peterz@infradead.org, rppt@kernel.org,
        dave@stgolabs.net, willy@infradead.org, vbabka@suse.cz,
        mhocko@suse.com, dave.hansen@linux.intel.com,
        colin.i.king@gmail.com, jim.cromie@gmail.com,
        catalin.marinas@arm.com, jbaron@akamai.com,
        rick.p.edgecombe@intel.com, yujie.liu@intel.com, mcgrof@kernel.org
Subject: [PATCH 2/2] module: add support to avoid duplicates early on load
Date:   Wed, 24 May 2023 14:36:20 -0700
Message-Id: <20230524213620.3509138-3-mcgrof@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230524213620.3509138-1-mcgrof@kernel.org>
References: <20230524213620.3509138-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to use the new kread_uniq_fd() to avoid duplicate kernel
reads on modules. At the cost of about ~945 bytes to your kernel size,
enabling this on a 255 CPU x86_64 qemu guest this saves about ~1.8 GiB
of memory during boot which would otherwise be free'd, and reduces boot
time by about ~11 seconds.

Userspace loads modules through finit_module(), this in turn will
use vmalloc space up to 3 times:

  a) The kernel_read_file() call
  b) Optional module decompression
  c) Our final copy of the module

Commit 064f4536d139 ("module: avoid allocation if module is already
present and ready") shows a graph of the amount of vmalloc space
observed allocated but freed for duplicate module request which end
up in the trash bin. Since there is a linear relationship with the
number of CPUs eventually this will bite us and you end up not being
able to boot. That commit put a stop gap for c) but to avoid the
vmalloc() space wasted on a) and b) we need to detect duplicates
earlier.

We could just have userspace fix this, but as reviewed at LSFMM 2023
this year in Vancouver, fixing this in userspace can be complex and we
also can't know when userpace is fixed. Fixing this in kernel turned
out to be easy with the inode and with a simple kconfig option we can
let users / distros decide if this full stop gap is worthy to enable.

With this enabled I'm now able to see 0 bytes wasted on vmalloc space
due to duplicates.

Before:
 # sudo systemd-analyze
 Startup finished in 41.653s (kernel) + 44.305s (userspace) = 1min 25.958s
 graphical.target reached after 44.178s in userspace.

 # grep "Virtual mem wasted bytes" /sys/kernel/debug/modules/stats
 Virtual mem wasted bytes       1949006968

So ~1.8 GiB... of vmalloc space wasted during boot.

After:

 # sudo systemd-analyze
 Startup finished in 29.883s (kernel) + 45.817s (userspace) = 1min 15.700s
 graphical.target reached after 45.682s in userspace.

 # grep "Virtual mem wasted bytes" /sys/kernel/debug/modules/stats
 Virtual mem wasted bytes       0

Suggested-by: Lennart Poettering <lennart@poettering.net>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 include/linux/module.h   |  1 +
 kernel/module/Kconfig    | 20 ++++++++++++++++++++
 kernel/module/internal.h |  1 +
 kernel/module/main.c     | 19 ++++++++++++-------
 4 files changed, 34 insertions(+), 7 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index 9e56763dff81..afc44df96278 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -557,6 +557,7 @@ struct module {
 	unsigned int printk_index_size;
 	struct pi_entry **printk_index_start;
 #endif
+	unsigned long i_ino;
 
 #ifdef CONFIG_MODULE_UNLOAD
 	/* What modules depend on me? */
diff --git a/kernel/module/Kconfig b/kernel/module/Kconfig
index 33a2e991f608..85a6c7c5ddc0 100644
--- a/kernel/module/Kconfig
+++ b/kernel/module/Kconfig
@@ -157,6 +157,26 @@ config MODULE_UNLOAD_TAINT_TRACKING
 	  page (see bad_page()), the aforementioned details are also
 	  shown. If unsure, say N.
 
+config MODULE_KREAD_UNIQ
+	bool "Avoid duplicate module kernel reads"
+	select KREAD_UNIQ
+	help
+	  Enable this option to avoid vmalloc() space for duplicate module
+	  requests early before we can even check for the module name. This
+	  is useful to avoid duplicate module requests which userspace or kernel
+	  can issue. On some architectures such as x86_64 there is only 128 MiB
+	  of virtual memory space and since in the worst case we can end up
+	  allocating up to 3 times the module size in vmalloc space, avoiding
+	  duplicates can save virtual memory on boot.
+
+	  Enabling this will incrase your kernel by about 945 bytes, but can
+	  save considerable memory during bootup which would otherwise be freed
+	  and this in turn can help speed up kernel boot time.
+
+	  Disable this if you have enabled CONFIG_MODULE_STATS and have
+	  verified you see no duplicates or virtual memory being freed on
+	  bootup.
+
 config MODVERSIONS
 	bool "Module versioning support"
 	help
diff --git a/kernel/module/internal.h b/kernel/module/internal.h
index dc7b0160c480..7ea7f177f907 100644
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -67,6 +67,7 @@ struct load_info {
 	unsigned int max_pages;
 	unsigned int used_pages;
 #endif
+	unsigned long i_ino;
 	struct {
 		unsigned int sym, str, mod, vers, info, pcpu;
 	} index;
diff --git a/kernel/module/main.c b/kernel/module/main.c
index ea7d0c7f3e60..e35900ee616a 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -1283,6 +1283,7 @@ static void free_module(struct module *mod)
 	kfree(mod->args);
 	percpu_modfree(mod);
 
+	kread_uniq_fd_free(mod->i_ino);
 	free_mod_mem(mod);
 }
 
@@ -1964,12 +1965,14 @@ static int copy_module_from_user(const void __user *umod, unsigned long len,
 	return err;
 }
 
-static void free_copy(struct load_info *info, int flags)
+static void free_copy(struct load_info *info, int flags, bool error)
 {
 	if (flags & MODULE_INIT_COMPRESSED_FILE)
 		module_decompress_cleanup(info);
 	else
 		vfree(info->hdr);
+	if (error)
+		kread_uniq_fd_free(info->i_ino);
 }
 
 static int rewrite_section_headers(struct load_info *info, int flags)
@@ -2965,7 +2968,7 @@ static int load_module(struct load_info *info, const char __user *uargs,
 	}
 
 	/* Get rid of temporary copy. */
-	free_copy(info, flags);
+	free_copy(info, flags, false);
 
 	/* Done! */
 	trace_module_load(mod);
@@ -3023,7 +3026,7 @@ static int load_module(struct load_info *info, const char __user *uargs,
 	 */
 	if (!module_allocated)
 		mod_stat_bump_becoming(info, flags);
-	free_copy(info, flags);
+	free_copy(info, flags, true);
 	return err;
 }
 
@@ -3068,11 +3071,12 @@ SYSCALL_DEFINE3(finit_module, int, fd, const char __user *, uargs, int, flags)
 		      |MODULE_INIT_COMPRESSED_FILE))
 		return -EINVAL;
 
-	len = kernel_read_file_from_fd(fd, 0, &buf, INT_MAX, NULL,
-				       READING_MODULE);
+	len = kread_uniq_fd(fd, 0, &buf, &info.i_ino, INT_MAX, NULL, READING_MODULE);
 	if (len < 0) {
-		mod_stat_inc(&failed_kreads);
-		mod_stat_add_long(len, &invalid_kread_bytes);
+		if (len != -EBUSY) {
+			mod_stat_inc(&failed_kreads);
+			mod_stat_add_long(len, &invalid_kread_bytes);
+		}
 		return len;
 	}
 
@@ -3082,6 +3086,7 @@ SYSCALL_DEFINE3(finit_module, int, fd, const char __user *, uargs, int, flags)
 		if (err) {
 			mod_stat_inc(&failed_decompress);
 			mod_stat_add_long(len, &invalid_decompress_bytes);
+			kread_uniq_fd_free(info.i_ino);
 			return err;
 		}
 	} else {
-- 
2.39.2

