Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93BF36D4A69
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 16:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234089AbjDCOqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 10:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234015AbjDCOqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 10:46:35 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A3F3503C
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 07:46:18 -0700 (PDT)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id A5DAB3F855
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 14:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1680533145;
        bh=Lg0DTuk088FU5MRineNk5kP+9dFQFrGExo9YX6St3wI=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=FYjtv+G8Z7RtbLghHZjhsQYgNo+31Ay7F2e+mURsYInPgE9643OAym4SOVt8v6Llu
         O0G8IKgHPDu/wEWnA2i1AAc3mJlpLPcvC5KytlR8IKfmxPCeuSdvOPzpyLhg4RflLH
         mZLJXvxQYegS7S6PsytEAX+/B8HH4ePnb+6s5wOrvOJBIFoPT4r2G18MUe2vTXt9Au
         rZMv9/lMEi9nPZ8icW+kT+y4dO0wV6PormQWSpLbwuWj24xaS+QT1I1LGXez7M4UKb
         4k5AjDW3o5Re5yMffPw4fZk0Pgw3bR1hziP2bQ9NjltjcXKAVKiQZgNQhVu+VpIlJW
         MK2IGjBQ+z6UQ==
Received: by mail-ed1-f70.google.com with SMTP id m18-20020a50d7d2000000b00501dfd867a4so41940087edj.20
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 07:45:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680533145;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lg0DTuk088FU5MRineNk5kP+9dFQFrGExo9YX6St3wI=;
        b=o4n9I2XuGkXV31ckQcCbv4IuYgqvmFoW0wNvYwPQBB5LA2PsUvyIRuOxnKjsBROQQb
         MFs6MA1o2Kg6L0r2nLMrjxJD9ajeXHIC/6Wrdiqq5gDiAv7FT3A3apef6VVt335Cdmb+
         QjZ8Y0m8RlFEvW3e/25D7WaVpnxGgO0VMLJZayXeaDCsE5w/VhBcyf5BmEGM+HSckwNT
         cBWWWfAirfxVg83ggkXndfA4FeIiZWu0TuWOC5GQcUO9DbpdrQnlaW4s1WJPO8WBpXBV
         51lQqGwWYCLKxqPKlZX0mkHUVNjWuHwS5V+wzyNCVAz3EpnKlrnv9EgLA+E2M1CqfXhR
         coVA==
X-Gm-Message-State: AAQBX9dXkIl1p4g0ms4zGz7bef9jBooDix/w2Nb409dJ+HiIlBfrlC9m
        iFOxxVQOA69mRQZ5nWP2XMCJybj0iwqTKwR+EQoSZlw4MVMmdxrECfqze2cYgDOkuCfuDN/PUy8
        AxG7MAeT8fZ8ojlnanOl4a1ZECpuubdl09DjfRhiTHQ==
X-Received: by 2002:a05:6402:1356:b0:4fb:1c02:8750 with SMTP id y22-20020a056402135600b004fb1c028750mr36144457edw.23.1680533145465;
        Mon, 03 Apr 2023 07:45:45 -0700 (PDT)
X-Google-Smtp-Source: AKy350Zq9NOfsIGTkMXthV8xuxQjLZrHkEdhyDX0z3mfVu+XCOoBZ37ngbNJ94dYxEkf7R02tDRqxg==
X-Received: by 2002:a05:6402:1356:b0:4fb:1c02:8750 with SMTP id y22-20020a056402135600b004fb1c028750mr36144442edw.23.1680533145306;
        Mon, 03 Apr 2023 07:45:45 -0700 (PDT)
Received: from amikhalitsyn.. (ip5f5bd076.dynamic.kabel-deutschland.de. [95.91.208.118])
        by smtp.gmail.com with ESMTPSA id i5-20020a50d745000000b004fa19f5ba99sm4735804edj.79.2023.04.03.07.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 07:45:44 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     mszeredi@redhat.com
Cc:     flyingpeng@tencent.com,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@ubuntu.com>,
        Seth Forshee <sforshee@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Andrei Vagin <avagin@gmail.com>,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        Bernd Schubert <bschubert@ddn.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        criu@openvz.org
Subject: [RFC PATCH v2 6/9] fuse: take fuse connection generation into account
Date:   Mon,  3 Apr 2023 16:45:14 +0200
Message-Id: <20230403144517.347517-7-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230403144517.347517-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230403144517.347517-1-aleksandr.mikhalitsyn@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- modify dentry revalidation algorithm to check inode/connection
generations. If them are not equal then perform revalidation.

remark: during forced dentry revalidation we are sending FUSE_LOOKUP
request to the userspace daemon and if it return the same inode after
lookup then we can "upgrade" inode connection generation without
invalidating it.

- don't send FUSE_FSYNC, FUSE_RELEASE, etc requests to the userspace
daemon about stale inodes (this can confuse libfuse)

Cc: Miklos Szeredi <mszeredi@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Stéphane Graber <stgraber@ubuntu.com>
Cc: Seth Forshee <sforshee@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Andrei Vagin <avagin@gmail.com>
Cc: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Cc: Bernd Schubert <bschubert@ddn.com>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: criu@openvz.org
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 fs/fuse/dir.c    |  4 +++-
 fs/fuse/file.c   | 13 ++++++++++---
 fs/fuse/fuse_i.h |  3 ++-
 fs/fuse/inode.c  |  2 +-
 4 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index bfbe59e8fce2..d0fdf7289d56 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -213,7 +213,8 @@ static int fuse_dentry_revalidate(struct dentry *entry, unsigned int flags)
 	inode = d_inode_rcu(entry);
 	if (inode && fuse_is_bad(inode))
 		goto invalid;
-	else if (time_before64(fuse_dentry_time(entry), get_jiffies_64()) ||
+	else if ((inode && fuse_stale_inode_conn(inode)) ||
+		 time_before64(fuse_dentry_time(entry), get_jiffies_64()) ||
 		 (flags & (LOOKUP_EXCL | LOOKUP_REVAL | LOOKUP_RENAME_TARGET))) {
 		struct fuse_entry_out outarg;
 		FUSE_ARGS(args);
@@ -255,6 +256,7 @@ static int fuse_dentry_revalidate(struct dentry *entry, unsigned int flags)
 			}
 			spin_lock(&fi->lock);
 			fi->nlookup++;
+			fi->conn_gen = READ_ONCE(get_fuse_conn(inode)->conn_gen);
 			spin_unlock(&fi->lock);
 		}
 		kfree(forget);
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 742f90b4e638..b977d087b925 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -111,8 +111,14 @@ static void fuse_file_put(struct fuse_file *ff, bool sync, bool isdir)
 	if (refcount_dec_and_test(&ff->count)) {
 		struct fuse_args *args = &ff->release_args->args;
 
-		if (isdir ? ff->fm->fc->flags.no_opendir : ff->fm->fc->flags.no_open) {
-			/* Do nothing when client does not implement 'open' */
+		if (fuse_stale_ff(ff) ||
+		    (isdir ? ff->fm->fc->flags.no_opendir : ff->fm->fc->flags.no_open)) {
+			/*
+			 * Do nothing when client does not implement 'open' OR
+			 * file descriptor was opened in the previous connection generation,
+			 * so, current daemon likely not aware of this FD, let's just skip
+			 * FUSE_RELEASE(DIR) request.
+			 */
 			fuse_release_end(ff->fm, args, 0);
 		} else if (sync) {
 			fuse_simple_request(ff->fm, args);
@@ -598,9 +604,10 @@ static int fuse_fsync(struct file *file, loff_t start, loff_t end,
 {
 	struct inode *inode = file->f_mapping->host;
 	struct fuse_conn *fc = get_fuse_conn(inode);
+	struct fuse_file *ff = file->private_data;
 	int err;
 
-	if (fuse_is_bad(inode))
+	if (fuse_stale_ff(ff) || fuse_is_bad(inode))
 		return -EIO;
 
 	inode_lock(inode);
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 943d5011dfa0..90c5b3459864 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -957,7 +957,8 @@ static inline bool fuse_stale_inode(const struct inode *inode, int generation,
 				    struct fuse_attr *attr)
 {
 	return inode->i_generation != generation ||
-		inode_wrong_type(inode, attr->mode);
+		inode_wrong_type(inode, attr->mode) ||
+		fuse_stale_inode_conn(inode);
 }
 
 static inline void fuse_make_bad(struct inode *inode)
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 389bea6e4a69..26a4149f6db7 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -124,7 +124,7 @@ static void fuse_evict_inode(struct inode *inode)
 			fuse_dax_inode_cleanup(inode);
 		if (fi->nlookup) {
 			fuse_queue_forget(fc, fi->forget, fi->nodeid,
-					  fi->nlookup, false);
+					  fi->nlookup, fuse_stale_inode_conn(inode));
 			fi->forget = NULL;
 		}
 	}
-- 
2.34.1

