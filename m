Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7338A6CD19D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 07:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjC2FcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 01:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbjC2FcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 01:32:05 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 536603C29;
        Tue, 28 Mar 2023 22:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=9aCwO6lydcYrtyg5yPLXnIQyE+LoOte6FX6HU5bmimM=; b=wRqNpi2g15Ano4d7S1D1Se8pFe
        rx5M2O1Oylzh0O3wIDwg5BZf5hYJHEZ4wPOlQT1a/cw9WGV4lbuzzH3WstC9eh95IXhDd/nqi7S+S
        SFQFG/EjhJzTx7CJXXzo8zx4qEijzU2qxBpNccJBe709o2dplGwgg3D94qIg+svDQ1qh/h/Qv4HuW
        VxbOuAJqab03K+uJZLBZZzHPknX+5nXLKzGD7VI9droyfDnQ8ZfZ5YS/sPGgUYNx6lCil+4rNyXfd
        5PlNA67XBZ4kedjsm+pbkJ7idlMJ0AYK1mNpQyGKJNfsQhIm3llHEAfEAMvgImFfmCkuNtHVzGrJh
        NWs6awpQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1phOPW-00GgRq-2i;
        Wed, 29 Mar 2023 05:31:50 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     david@redhat.com, patches@lists.linux.dev,
        linux-modules@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, pmladek@suse.com,
        petr.pavlu@suse.com, prarit@redhat.com,
        torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        rafael@kernel.org
Cc:     christophe.leroy@csgroup.eu, tglx@linutronix.de,
        peterz@infradead.org, song@kernel.org, rppt@kernel.org,
        willy@infradead.org, vbabka@suse.cz, mhocko@suse.com,
        dave.hansen@linux.intel.com, mcgrof@kernel.org
Subject: [PATCH 6/7] debugfs: add debugfs_create_atomic64_t for atomic64_t
Date:   Tue, 28 Mar 2023 22:31:48 -0700
Message-Id: <20230329053149.3976378-7-mcgrof@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230329053149.3976378-1-mcgrof@kernel.org>
References: <20230329053149.3976378-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes you want to add debugfs entries for atomic counters which
can be pretty large using atomic64_t. Add support for these.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 fs/debugfs/file.c       | 36 ++++++++++++++++++++++++++++++++++++
 include/linux/debugfs.h |  2 ++
 2 files changed, 38 insertions(+)

diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index 1f971c880dde..76d923503861 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -780,6 +780,42 @@ void debugfs_create_atomic_t(const char *name, umode_t mode,
 }
 EXPORT_SYMBOL_GPL(debugfs_create_atomic_t);
 
+static int debugfs_atomic64_t_set(void *data, u64 val)
+{
+	atomic64_set((atomic64_t *)data, val);
+	return 0;
+}
+static int debugfs_atomic64_t_get(void *data, u64 *val)
+{
+	*val = atomic64_read((atomic64_t *)data);
+	return 0;
+}
+DEFINE_DEBUGFS_ATTRIBUTE_SIGNED(fops_atomic64_t, debugfs_atomic64_t_get,
+			debugfs_atomic64_t_set, "%lld\n");
+DEFINE_DEBUGFS_ATTRIBUTE_SIGNED(fops_atomic64_t_ro, debugfs_atomic64_t_get, NULL,
+			"%lld\n");
+DEFINE_DEBUGFS_ATTRIBUTE_SIGNED(fops_atomic64_t_wo, NULL, debugfs_atomic64_t_set,
+			"%lld\n");
+
+/**
+ * debugfs_create_atomic64_t - create a debugfs file that is used to read and
+ * write an atomic64_t value
+ * @name: a pointer to a string containing the name of the file to create.
+ * @mode: the permission that the file should have
+ * @parent: a pointer to the parent dentry for this file.  This should be a
+ *          directory dentry if set.  If this parameter is %NULL, then the
+ *          file will be created in the root of the debugfs filesystem.
+ * @value: a pointer to the variable that the file should read to and write
+ *         from.
+ */
+void debugfs_create_atomic64_t(const char *name, umode_t mode,
+			     struct dentry *parent, atomic64_t *value)
+{
+	debugfs_create_mode_unsafe(name, mode, parent, value, &fops_atomic64_t,
+				   &fops_atomic64_t_ro, &fops_atomic64_t_wo);
+}
+EXPORT_SYMBOL_GPL(debugfs_create_atomic64_t);
+
 ssize_t debugfs_read_file_bool(struct file *file, char __user *user_buf,
 			       size_t count, loff_t *ppos)
 {
diff --git a/include/linux/debugfs.h b/include/linux/debugfs.h
index ea2d919fd9c7..f5cc613a545e 100644
--- a/include/linux/debugfs.h
+++ b/include/linux/debugfs.h
@@ -136,6 +136,8 @@ void debugfs_create_size_t(const char *name, umode_t mode,
 			   struct dentry *parent, size_t *value);
 void debugfs_create_atomic_t(const char *name, umode_t mode,
 			     struct dentry *parent, atomic_t *value);
+void debugfs_create_atomic64_t(const char *name, umode_t mode,
+			       struct dentry *parent, atomic64_t *value);
 void debugfs_create_bool(const char *name, umode_t mode, struct dentry *parent,
 			 bool *value);
 void debugfs_create_str(const char *name, umode_t mode,
-- 
2.39.2

