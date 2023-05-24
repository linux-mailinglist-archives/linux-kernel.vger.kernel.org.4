Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8EA710017
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 23:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234033AbjEXVgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 17:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234659AbjEXVgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 17:36:37 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72546123;
        Wed, 24 May 2023 14:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=RrkUWbut98yR/Hf36f02z4xhJTDFlh9boXGuuIUOBdc=; b=JI86TZpQzeC3bG7KmsKZkbjk8G
        KSEq3nTtgdgdmj6zWF+bNIOhfUetX1zI2/UxJhH05DP7ep6N0Rf1Thg7MOKhEQg1RMxWKjIg7fkzK
        F1GjeWjLn921tDj23m3zW4XyfsHOIznSF29SUE3WoobhA3caf5D9FFlrXMNIH626/e/UgrWpK2dJR
        AIVQw4i0AC0pqRxEgjUmP/E+VzhNPrs6qSySaOwkODTiMP+GKK0AbMFTKSi0s2Y+RWiql/hbe+uqr
        3U/a/HpdFwQ5m2ZSJDfS81XDnLyifEcPnWk9QeZEcXOxyKb1qOrhBNOQpw541aB0jwmJ0IfcAiQ+4
        LoyCrI2g==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q1w9d-00EitH-0z;
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
Subject: [PATCH 1/2] fs/kernel_read_file: add support for duplicate detection
Date:   Wed, 24 May 2023 14:36:19 -0700
Message-Id: <20230524213620.3509138-2-mcgrof@kernel.org>
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

Add support for a new call which allows to detect duplicate requests
for each inode passed. This enables users to avoid having to incur
a whole vmalloc() for duplicates inodes with kernel_read_file().
Support to avoid duplicates is desirable in-kernel since changing
existing userspace or kernel users to account for these duplicates
would otherwise be difficult to implement, and the measured impact
of amount of wasted memory due to duplicates with vmalloc is observed
to be high.

This currently goes disabled because no user exists yet which wants
this enabled. Kernel code which needs this enabled should select the
new CONFIG_KREAD_UNIQ, otherwise the API falls back to the existing
kernel_read_file_from_fd().

If we later need to have some code enable CONFIG_KREAD_UNIQ but some
not we can have the feature be enabled per enum kernel_read_file_id id.
For now this should cover the main future use case with modules and
allow easily to disable / enable this feature with just one future
kconfig option.

Contrary to kernel_read_file_from_fd() users of thew new API will
use kread_uniq_fd(), keep track of the inode internally, and once
done use kread_uniq_fd_free() once the inode is no longer used.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 fs/Kconfig                       |   3 +
 fs/kernel_read_file.c            | 124 +++++++++++++++++++++++++++++++
 include/linux/kernel_read_file.h |  14 ++++
 3 files changed, 141 insertions(+)

diff --git a/fs/Kconfig b/fs/Kconfig
index cc07a0cd3172..0a78657b00d5 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -18,6 +18,9 @@ config VALIDATE_FS_PARSER
 config FS_IOMAP
 	bool
 
+config KREAD_UNIQ
+	bool
+
 # old blockdev_direct_IO implementation.  Use iomap for new code instead
 config LEGACY_DIRECT_IO
 	bool
diff --git a/fs/kernel_read_file.c b/fs/kernel_read_file.c
index 5d826274570c..a066e2f239e8 100644
--- a/fs/kernel_read_file.c
+++ b/fs/kernel_read_file.c
@@ -1,9 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0-only
+#define pr_fmt(fmt) "kread: " fmt
+
 #include <linux/fs.h>
 #include <linux/fs_struct.h>
 #include <linux/kernel_read_file.h>
 #include <linux/security.h>
 #include <linux/vmalloc.h>
+#include <linux/fdtable.h>
 
 /**
  * kernel_read_file() - read file contents into a kernel buffer
@@ -187,3 +190,124 @@ ssize_t kernel_read_file_from_fd(int fd, loff_t offset, void **buf,
 	return ret;
 }
 EXPORT_SYMBOL_GPL(kernel_read_file_from_fd);
+
+#ifdef CONFIG_KREAD_UNIQ
+static DEFINE_MUTEX(kread_dup_mutex);
+static LIST_HEAD(kread_dup_reqs);
+
+struct kread_dup_req {
+	struct list_head list;
+	unsigned long i_ino;
+};
+
+static struct kread_dup_req *kread_dup_request_lookup(unsigned long i_ino)
+{
+	struct kread_dup_req *kread_req;
+
+	list_for_each_entry_rcu(kread_req, &kread_dup_reqs, list,
+				lockdep_is_held(&kread_dup_mutex)) {
+		if (kread_req->i_ino == i_ino)
+			return kread_req;
+        }
+
+	return NULL;
+}
+
+static struct kread_dup_req *kread_dup_request_new(char *name, unsigned long i_ino)
+{
+	struct kread_dup_req *kread_req, *new_kread_req;
+
+	/*
+	 * Pre-allocate the entry in case we have to use it later
+	 * to avoid contention with the mutex.
+	 */
+	new_kread_req = kzalloc(sizeof(*new_kread_req), GFP_KERNEL);
+	if (!new_kread_req)
+		return false;
+
+	new_kread_req->i_ino = i_ino;
+
+	kread_req = kread_dup_request_lookup(i_ino);
+	if (!kread_req) {
+		/*
+		 * There was no duplicate, just add the request so we can
+		 * keep tab on duplicates later.
+		 */
+		pr_debug("accepted request for i_ino %lu for: %s\n", i_ino, name);
+		return new_kread_req;
+	}
+
+	/* We are dealing with a duplicate request now */
+
+	kfree(new_kread_req);
+
+	pr_debug("duplicate request on i_ino %lu for: %s\n", i_ino, name);
+
+	return NULL;
+}
+
+ssize_t kread_uniq_fd(int fd, loff_t offset, void **buf, unsigned long *i_ino,
+		      size_t buf_size, size_t *file_size, enum kernel_read_file_id id)
+{
+	struct fd f = fdget(fd);
+	ssize_t ret = -EBADF;
+	char *name, *path;
+	struct kread_dup_req *req;
+
+	if (!f.file || !(f.file->f_mode & FMODE_READ))
+		goto out;
+
+	path = kzalloc(PATH_MAX, GFP_KERNEL);
+	if (!path)
+		return -ENOMEM;
+
+	name = file_path(f.file, path, PATH_MAX);
+	if (IS_ERR(name)) {
+		ret = PTR_ERR(name);
+		goto out_mem;
+	}
+
+	*i_ino = file_inode(f.file)->i_ino;
+
+	mutex_lock(&kread_dup_mutex);
+	req = kread_dup_request_new(name, *i_ino);
+	if (!req) {
+		mutex_unlock(&kread_dup_mutex);
+		ret = -EBUSY;
+		goto out_mem;
+	}
+
+	ret = kernel_read_file(f.file, offset, buf, buf_size, file_size, id);
+	if (ret < 0)
+		kfree(req);
+	else
+		list_add_rcu(&req->list, &kread_dup_reqs);
+	mutex_unlock(&kread_dup_mutex);
+out_mem:
+	kfree(path);
+out:
+	fdput(f);
+	return ret;
+}
+
+void kread_uniq_fd_free(unsigned long i_ino)
+{
+	struct kread_dup_req *kread_req;
+
+	if (!i_ino)
+		return;
+
+	mutex_lock(&kread_dup_mutex);
+
+	kread_req = kread_dup_request_lookup(i_ino);
+	if (!kread_req)
+		goto out;
+
+	list_del_rcu(&kread_req->list);
+	synchronize_rcu();
+
+out:
+	mutex_unlock(&kread_dup_mutex);
+	kfree(kread_req);
+}
+#endif /* CONFIG_KREAD_UNIQ */
diff --git a/include/linux/kernel_read_file.h b/include/linux/kernel_read_file.h
index 90451e2e12bd..884985b0dc88 100644
--- a/include/linux/kernel_read_file.h
+++ b/include/linux/kernel_read_file.h
@@ -51,5 +51,19 @@ ssize_t kernel_read_file_from_fd(int fd, loff_t offset,
 				 void **buf, size_t buf_size,
 				 size_t *file_size,
 				 enum kernel_read_file_id id);
+#ifdef CONFIG_KREAD_UNIQ
+ssize_t kread_uniq_fd(int fd, loff_t offset, void **buf, unsigned long *i_ino,
+		      size_t buf_size, size_t *file_size, enum kernel_read_file_id id);
+void kread_uniq_fd_free(unsigned long i_ino);
+#else
+static inline ssize_t kread_uniq_fd(int fd, loff_t offset, void **buf, unsigned long *i_ino,
+				    size_t buf_size, size_t *file_size, enum kernel_read_file_id id)
+{
+	return kernel_read_file_from_fd(fd, offset, buf, buf_size, file_size, id);
+}
+static inline void kread_uniq_fd_free(unsigned long i_ino)
+{
+}
+#endif /* CONFIG_KREAD_UNIQ */
 
 #endif /* _LINUX_KERNEL_READ_FILE_H */
-- 
2.39.2

