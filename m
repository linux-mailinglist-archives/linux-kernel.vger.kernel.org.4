Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E138B74CFF0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 10:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbjGJIb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 04:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbjGJIb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 04:31:27 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C07D91
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 01:31:25 -0700 (PDT)
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id DDCF63F1EE
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 08:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1688977883;
        bh=XBlNT+SJA1xULw0LphVVt+nl/FhzT+DOY2urbcNDsHQ=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=nuWOePSBOcrI0c6XqgbeFBNtfjsx4kd3SyIQJavIq10los2wP9233dyP4eT1yIwQg
         qjjzEwG2/4XC2+TtqIG9WYMQGi8yK4cu+UUsJarHOHQc3ozGxuLwT2QHsGD5y0d+gC
         3CxN3VkEjOfqvolWrOPEFWY3Ulr4W0UCC7m1mQ+kNMa9w8/PvD2yDTDVZjwAGa7AS/
         hKwsJHN3TmDyI/l7RIlEiba6xlPoCls3wwv4h2Fydnlrt48XRchjWPyze5CDQ9LBqY
         j/1WUkqnr306xtK1yikchoaCAPFPshpvXtJJYxkWi71pmK+AJvPlcQS9Lmre7EixPB
         j1dmV0WvrZiqQ==
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3a36b311b5cso3891025b6e.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 01:31:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688977882; x=1691569882;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XBlNT+SJA1xULw0LphVVt+nl/FhzT+DOY2urbcNDsHQ=;
        b=AEEMP8OnPuWMuWQiTGJZdthhMQ2cgIiycIqaYVK7hjOvR/6zOVzPSpbqEyOlc61NJG
         rVPRj4eddQoEDddVLSCUzFsMxks+K0ARrwH1592tovg9UzSdruJpUVW/JjVs3pHM7AlT
         5ytkl+9BBhuNvE9/nvX4JWDsy7A894B44djes2yWJVOOpENe5A5DjfTGm0tl66ISUe9N
         8/UGb20hntpxmjTyVyMTq95juxLwUs6R13jaqqkaktfNjhAgUqXCaglXz0U+76GtakTf
         Dro5XZXkXN/2Ledp9onn860M1QzpDeL+Bmom4nUutWgQx+v15CR/A1LVbRotPrQyuMb1
         yqhA==
X-Gm-Message-State: ABy/qLYjN9GsRQRKkkVUC1c5NqeviPRMHMUXit2R+qUznfNF9W/U+9BR
        fMXaSub+0zojwIkzVuq/SAHmfdVj7ttxumBEJBxqvLKAQ1WTeic37UV4OyPlo1b8zrnP9FTK3Ef
        +xodS1q2g+sR/IFFBsS53vnXzRnl5cSgu6tmkc/orDOXtob36HA==
X-Received: by 2002:a05:6808:120e:b0:397:ec35:f5a6 with SMTP id a14-20020a056808120e00b00397ec35f5a6mr9131285oil.57.1688977882671;
        Mon, 10 Jul 2023 01:31:22 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHefWD72rEYVAQiyl4yBxr3VPbYNDJLEN8J1rR5xXQckToIh5Ptqd9eig8yz+jdS2DEpVw5FA==
X-Received: by 2002:a05:6808:120e:b0:397:ec35:f5a6 with SMTP id a14-20020a056808120e00b00397ec35f5a6mr9131280oil.57.1688977882410;
        Mon, 10 Jul 2023 01:31:22 -0700 (PDT)
Received: from chengendu.. (111-248-146-212.dynamic-ip.hinet.net. [111.248.146.212])
        by smtp.gmail.com with ESMTPSA id b65-20020a633444000000b0054fe6bae952sm6917527pga.4.2023.07.10.01.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 01:31:22 -0700 (PDT)
From:   Chengen Du <chengen.du@canonical.com>
To:     trond.myklebust@hammerspace.com
Cc:     anna@kernel.org, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chengen Du <chengen.du@canonical.com>
Subject: [PATCH v3] NFS: Add mount option 'fasc'
Date:   Mon, 10 Jul 2023 16:31:16 +0800
Message-Id: <20230710083116.73037-1-chengen.du@canonical.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In certain instances, users or applications switch to other privileged
users by executing commands like 'su' to carry out operations on NFS-
mounted folders. However, when this happens, the login time for the
privileged user is reset, and any NFS ACCESS operations must be resent,
which can result in a decrease in performance. In specific production
environments where the access cache can be trusted due to stable group
membership, there's no need to verify the cache stall situation.
To maintain the initial behavior and performance, a new mount option
called 'fasc' has been introduced. This option triggers the mechanism
of clearing the file access cache upon login.

Signed-off-by: Chengen Du <chengen.du@canonical.com>
---
 fs/nfs/dir.c              | 21 ++++++++++++---------
 fs/nfs/fs_context.c       |  5 +++++
 fs/nfs/super.c            |  1 +
 include/linux/nfs_fs_sb.h |  1 +
 4 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 8f3112e71a6a..cefdb23d4cd7 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -2951,12 +2951,14 @@ static struct nfs_access_entry *nfs_access_search_rbtree(struct inode *inode, co
 	return NULL;
 }
 
-static u64 nfs_access_login_time(const struct task_struct *task,
-				 const struct cred *cred)
+static inline
+bool nfs_check_access_stale(const struct task_struct *task,
+			    const struct cred *cred,
+			    const struct nfs_access_entry *cache)
 {
 	const struct task_struct *parent;
 	const struct cred *pcred;
-	u64 ret;
+	u64 login_time;
 
 	rcu_read_lock();
 	for (;;) {
@@ -2966,15 +2968,15 @@ static u64 nfs_access_login_time(const struct task_struct *task,
 			break;
 		task = parent;
 	}
-	ret = task->start_time;
+	login_time = task->start_time;
 	rcu_read_unlock();
-	return ret;
+
+	return ((s64)(login_time - cache->timestamp) > 0);
 }
 
 static int nfs_access_get_cached_locked(struct inode *inode, const struct cred *cred, u32 *mask, bool may_block)
 {
 	struct nfs_inode *nfsi = NFS_I(inode);
-	u64 login_time = nfs_access_login_time(current, cred);
 	struct nfs_access_entry *cache;
 	bool retry = true;
 	int err;
@@ -3003,7 +3005,8 @@ static int nfs_access_get_cached_locked(struct inode *inode, const struct cred *
 		retry = false;
 	}
 	err = -ENOENT;
-	if ((s64)(login_time - cache->timestamp) > 0)
+	if ((NFS_SERVER(inode)->flags & NFS_MOUNT_FASC) &&
+	    nfs_check_access_stale(current, cred, cache))
 		goto out;
 	*mask = cache->mask;
 	list_move_tail(&cache->lru, &nfsi->access_cache_entry_lru);
@@ -3023,7 +3026,6 @@ static int nfs_access_get_cached_rcu(struct inode *inode, const struct cred *cre
 	 * but do it without locking.
 	 */
 	struct nfs_inode *nfsi = NFS_I(inode);
-	u64 login_time = nfs_access_login_time(current, cred);
 	struct nfs_access_entry *cache;
 	int err = -ECHILD;
 	struct list_head *lh;
@@ -3038,7 +3040,8 @@ static int nfs_access_get_cached_rcu(struct inode *inode, const struct cred *cre
 		cache = NULL;
 	if (cache == NULL)
 		goto out;
-	if ((s64)(login_time - cache->timestamp) > 0)
+	if ((NFS_SERVER(inode)->flags & NFS_MOUNT_FASC) &&
+	    nfs_check_access_stale(current, cred, cache))
 		goto out;
 	if (nfs_check_cache_invalid(inode, NFS_INO_INVALID_ACCESS))
 		goto out;
diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
index 853e8d609bb3..2fbc2d1bd775 100644
--- a/fs/nfs/fs_context.c
+++ b/fs/nfs/fs_context.c
@@ -92,6 +92,7 @@ enum nfs_param {
 	Opt_wsize,
 	Opt_write,
 	Opt_xprtsec,
+	Opt_fasc,
 };
 
 enum {
@@ -199,6 +200,7 @@ static const struct fs_parameter_spec nfs_fs_parameters[] = {
 	fsparam_enum  ("write",		Opt_write, nfs_param_enums_write),
 	fsparam_u32   ("wsize",		Opt_wsize),
 	fsparam_string("xprtsec",	Opt_xprtsec),
+	fsparam_flag  ("fasc",		Opt_fasc),
 	{}
 };
 
@@ -925,6 +927,9 @@ static int nfs_fs_context_parse_param(struct fs_context *fc,
 	case Opt_sloppy:
 		ctx->sloppy = true;
 		break;
+	case Opt_fasc:
+		ctx->flags |= NFS_MOUNT_FASC;
+		break;
 	}
 
 	return 0;
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 2284f749d892..7a0c5280e388 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -448,6 +448,7 @@ static void nfs_show_mount_options(struct seq_file *m, struct nfs_server *nfss,
 		{ NFS_MOUNT_NORDIRPLUS, ",nordirplus", "" },
 		{ NFS_MOUNT_UNSHARED, ",nosharecache", "" },
 		{ NFS_MOUNT_NORESVPORT, ",noresvport", "" },
+		{ NFS_MOUNT_FASC, ",fasc", "" },
 		{ 0, NULL, NULL }
 	};
 	const struct proc_nfs_info *nfs_infop;
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index 20eeba8b009d..6a88ba36f7a8 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -155,6 +155,7 @@ struct nfs_server {
 #define NFS_MOUNT_WRITE_WAIT		0x02000000
 #define NFS_MOUNT_TRUNK_DISCOVERY	0x04000000
 #define NFS_MOUNT_SHUTDOWN			0x08000000
+#define NFS_MOUNT_FASC			0x10000000
 
 	unsigned int		fattr_valid;	/* Valid attributes */
 	unsigned int		caps;		/* server capabilities */
-- 
2.39.2

