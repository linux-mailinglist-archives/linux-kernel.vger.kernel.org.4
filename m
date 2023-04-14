Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA0176E1BB8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 07:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbjDNF3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 01:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjDNF3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 01:29:18 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5617F1FFE;
        Thu, 13 Apr 2023 22:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=iHqXveUS6IchndxGgVtwZgcMZJ63gxl6r7jEFf+BmmQ=; b=pyZpQs+2xUZDAnoUe91m55tZ9q
        kcL7s7vIi+nON6Qz7z6OecQophFoBQ/0SkX1pNpLz4trrf2w/feIZd+VfsAVN+ZV0O/xJzjhaZR4b
        VaIMJHAYptwtfbcf8Ui0qNGgQ/XCgwu/OM0sA7PtnI2J0kK/UtJ++8WzTKOpK5dtERQievV63UQkg
        lbYYuEiB9vd/qfXl58xqd7G28Y8QO17HxGr79uEpA9XuaOJG+3DK+Fa3YhHEQqdeB8Znji1Uhnb4s
        8+MK1f7MkPtDth6H6pQ6smxGuoM/mUFf7Dg4DrANgOgaPOfoxupyKUr9kfIdAnED7La6RhoP17+nP
        3hZPX9Jw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pnBzK-008Msj-0u;
        Fri, 14 Apr 2023 05:28:46 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     david@redhat.com, patches@lists.linux.dev,
        linux-modules@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, pmladek@suse.com,
        petr.pavlu@suse.com, prarit@redhat.com,
        torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        rafael@kernel.org
Cc:     christophe.leroy@csgroup.eu, tglx@linutronix.de,
        peterz@infradead.org, song@kernel.org, rppt@kernel.org,
        dave@stgolabs.net, willy@infradead.org, vbabka@suse.cz,
        mhocko@suse.com, dave.hansen@linux.intel.com,
        colin.i.king@gmail.com, jim.cromie@gmail.com,
        catalin.marinas@arm.com, jbaron@akamai.com,
        rick.p.edgecombe@intel.com, mcgrof@kernel.org
Subject: [RFC 2/2] kread: avoid duplicates
Date:   Thu, 13 Apr 2023 22:28:40 -0700
Message-Id: <20230414052840.1994456-3-mcgrof@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230414052840.1994456-1-mcgrof@kernel.org>
References: <20230414052840.1994456-1-mcgrof@kernel.org>
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

With this we run into 0 wasted virtual memory bytes.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 fs/kernel_read_file.c | 150 ++++++++++++++++++++++++++++++++++++++++++
 kernel/module/main.c  |   6 +-
 2 files changed, 154 insertions(+), 2 deletions(-)

diff --git a/fs/kernel_read_file.c b/fs/kernel_read_file.c
index 5d826274570c..209c56764442 100644
--- a/fs/kernel_read_file.c
+++ b/fs/kernel_read_file.c
@@ -4,6 +4,7 @@
 #include <linux/kernel_read_file.h>
 #include <linux/security.h>
 #include <linux/vmalloc.h>
+#include <linux/fdtable.h>
 
 /**
  * kernel_read_file() - read file contents into a kernel buffer
@@ -171,17 +172,166 @@ ssize_t kernel_read_file_from_path_initns(const char *path, loff_t offset,
 }
 EXPORT_SYMBOL_GPL(kernel_read_file_from_path_initns);
 
+DEFINE_MUTEX(kread_dup_mutex);
+static LIST_HEAD(kread_dup_reqs);
+
+struct kread_dup_req {
+	struct list_head list;
+	char name[PATH_MAX];
+	struct completion first_req_done;
+	struct work_struct complete_work;
+	struct delayed_work delete_work;
+	int dup_ret;
+};
+
+static struct kread_dup_req *kread_dup_request_lookup(char *name)
+{
+	struct kread_dup_req *kread_req;
+
+	list_for_each_entry_rcu(kread_req, &kread_dup_reqs, list,
+				lockdep_is_held(&kread_dup_mutex)) {
+		if (strlen(kread_req->name) == strlen(name) &&
+		    !memcmp(kread_req->name, name, strlen(name))) {
+			return kread_req;
+                }
+        }
+
+	return NULL;
+}
+
+static void kread_dup_request_delete(struct work_struct *work)
+{
+	struct kread_dup_req *kread_req;
+	kread_req = container_of(to_delayed_work(work), struct kread_dup_req, delete_work);
+
+	mutex_lock(&kread_dup_mutex);
+	list_del_rcu(&kread_req->list);
+	synchronize_rcu();
+	mutex_unlock(&kread_dup_mutex);
+	kfree(kread_req);
+}
+
+static void kread_dup_request_complete(struct work_struct *work)
+{
+	struct kread_dup_req *kread_req;
+
+	kread_req = container_of(work, struct kread_dup_req, complete_work);
+
+	complete_all(&kread_req->first_req_done);
+	queue_delayed_work(system_wq, &kread_req->delete_work, 60 * HZ);
+}
+
+static bool kread_dup_request_exists_wait(char *name, int *dup_ret)
+{
+	struct kread_dup_req *kread_req, *new_kread_req;
+	int ret;
+
+	/*
+	 * Pre-allocate the entry in case we have to use it later
+	 * to avoid contention with the mutex.
+	 */
+	new_kread_req = kzalloc(sizeof(*new_kread_req), GFP_KERNEL);
+	if (!new_kread_req)
+		return false;
+
+	memcpy(new_kread_req->name, name, strlen(name));
+	INIT_WORK(&new_kread_req->complete_work, kread_dup_request_complete);
+	INIT_DELAYED_WORK(&new_kread_req->delete_work, kread_dup_request_delete);
+	init_completion(&new_kread_req->first_req_done);
+
+	mutex_lock(&kread_dup_mutex);
+
+	kread_req = kread_dup_request_lookup(name);
+	if (!kread_req) {
+		/*
+		 * There was no duplicate, just add the request so we can
+		 * keep tab on duplicates later.
+		 */
+		//pr_info("New kread request for %s\n", name);
+		list_add_rcu(&new_kread_req->list, &kread_dup_reqs);
+		mutex_unlock(&kread_dup_mutex);
+		return false;
+	}
+	mutex_unlock(&kread_dup_mutex);
+
+	/* We are dealing with a duplicate request now */
+
+	kfree(new_kread_req);
+
+	//pr_warn("kread: duplicate request for file %s\n", name);
+
+	ret = wait_for_completion_state(&kread_req->first_req_done,
+					TASK_UNINTERRUPTIBLE | TASK_KILLABLE);
+	if (ret) {
+		*dup_ret = ret;
+		return true;
+	}
+
+	/* breath */
+	schedule_timeout(2*HZ);
+
+	*dup_ret = kread_req->dup_ret;
+
+	return true;
+}
+
+void kread_dup_request_announce(char *name, int ret)
+{
+	struct kread_dup_req *kread_req;
+
+	mutex_lock(&kread_dup_mutex);
+
+	kread_req = kread_dup_request_lookup(name);
+	if (!kread_req)
+		goto out;
+
+	kread_req->dup_ret = ret;
+
+	/*
+	 * If we complete() here we may allow duplicate threads
+	 * to continue before the first one that submitted the
+	 * request. We're in no rush but avoid boot delays caused
+	 * by these threads waiting too long.
+	 */
+	queue_work(system_wq, &kread_req->complete_work);
+
+out:
+	mutex_unlock(&kread_dup_mutex);
+}
+
 ssize_t kernel_read_file_from_fd(int fd, loff_t offset, void **buf,
 				 size_t buf_size, size_t *file_size,
 				 enum kernel_read_file_id id)
 {
 	struct fd f = fdget(fd);
 	ssize_t ret = -EBADF;
+	char *name, *path;
+	int dup_ret;
 
 	if (!f.file || !(f.file->f_mode & FMODE_READ))
 		goto out;
 
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
+	if (kread_dup_request_exists_wait(name, &dup_ret)) {
+		ret = -EBUSY;
+		goto out_mem;
+	}
+
 	ret = kernel_read_file(f.file, offset, buf, buf_size, file_size, id);
+
+	kread_dup_request_announce(name, ret);
+
+out_mem:
+	kfree(path);
 out:
 	fdput(f);
 	return ret;
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 1ed373145278..e99419b4d85c 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -3080,8 +3080,10 @@ SYSCALL_DEFINE3(finit_module, int, fd, const char __user *, uargs, int, flags)
 	len = kernel_read_file_from_fd(fd, 0, &buf, INT_MAX, NULL,
 				       READING_MODULE);
 	if (len < 0) {
-		mod_stat_inc(&failed_kreads);
-		mod_stat_add_long(len, &invalid_kread_bytes);
+		if (len != -EBUSY) {
+			mod_stat_inc(&failed_kreads);
+			mod_stat_add_long(len, &invalid_kread_bytes);
+		}
 		return len;
 	}
 
-- 
2.39.2

