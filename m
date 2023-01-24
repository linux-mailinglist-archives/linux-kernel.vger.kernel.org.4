Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C992E67A03B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 18:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234634AbjAXRcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 12:32:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234840AbjAXRb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 12:31:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E23964DCE8
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 09:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674581456;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=iCX8ACgA8mSZYk1RCojrOQrvNa0BSEmait8aWC/biBA=;
        b=W+l2KEgsa4cJTw9yBAPuzgs7gv/QI30XmD6bYyhGzaylbNNXCcS8+4HM+37jwss6d/7O7o
        XjiEJqVKwBTRbgjOa3kSRvFE/kbBNYLSodTcIxiKN44VMiNMl7o9XUvB1MinWPqTqGQYJl
        uLYxfEJDck3ZxvPT6pjWECOLy+1lyMU=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-591-zrSjHbk6PEu2RHZn-q50Lw-1; Tue, 24 Jan 2023 12:30:55 -0500
X-MC-Unique: zrSjHbk6PEu2RHZn-q50Lw-1
Received: by mail-pg1-f198.google.com with SMTP id e11-20020a63d94b000000b0048988ed9a6cso7125125pgj.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 09:30:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iCX8ACgA8mSZYk1RCojrOQrvNa0BSEmait8aWC/biBA=;
        b=HjVhotmEiIaFASip3OVvNX48JVQ50PrrbpKSFBx7AThRb8xv98V665FooWffbbvWmC
         1nXDo2l9jyvpjahAi9VgQZEQqcZyakLbfmRTsYIZ2HitcTAExBmuNbBOICcz+OViZqG/
         NUb8RIiobEgELHzR1S/GwAPEG83B8WByqZmZPiWZi49pZQ041dlQ+vdBVo8xovBXgaoG
         D+GWqp5flZ/Y4CZwVORwG/KGGbkI6dPRvkkZcZs9D2Pn7OjzzAMbZVsumS4BubT3bMkj
         7lNWxG0c6qtmd9pJY7JKPqbvG4ONMBfnTKcAshlCiDmkYtgjYoBkBAIuSv3ooUiK5G+D
         obWg==
X-Gm-Message-State: AFqh2kqVrUD4VsuUsG1hp0A8wgiC1Bc1jl1ZiwO9i/WmMe71WiGgECWF
        Whd/2zzBKBJ7eh+e90bN090evXyvUrOeMHoXwTsDDokVd5GG+qsJAZsh94JfgupNaDro1fIeMZm
        VNqhQPgYtsZkDTrjFPq/nD6Sc
X-Received: by 2002:a62:1901:0:b0:582:5b8e:533 with SMTP id 1-20020a621901000000b005825b8e0533mr49134895pfz.16.1674581454356;
        Tue, 24 Jan 2023 09:30:54 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsJWh0gu6I1ocrVd6WVdgQra3HZiqmhNhWhfKbp0Y8o+WTg+8eYRh2qDV7t3ksCylSiEuknAA==
X-Received: by 2002:a62:1901:0:b0:582:5b8e:533 with SMTP id 1-20020a621901000000b005825b8e0533mr49134880pfz.16.1674581454076;
        Tue, 24 Jan 2023 09:30:54 -0800 (PST)
Received: from localhost.localdomain ([240d:1a:c0d:9f00:ca6:1aff:fead:cef4])
        by smtp.gmail.com with ESMTPSA id j10-20020aa783ca000000b00581ad007a9fsm1847416pfn.153.2023.01.24.09.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 09:30:53 -0800 (PST)
From:   Shigeru Yoshida <syoshida@redhat.com>
To:     jack@suse.com
Cc:     linux-kernel@vger.kernel.org,
        Shigeru Yoshida <syoshida@redhat.com>,
        syzbot+aebf90eea2671c43112a@syzkaller.appspotmail.com
Subject: [PATCH -next] udf: Fix a race condition between udf_rename() and udf_expand_dir_adinicb()
Date:   Wed, 25 Jan 2023 02:30:15 +0900
Message-Id: <20230124173015.3213309-1-syoshida@redhat.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot reported a general fault in udf_filter_write_fi() [1].  This
causes a stack trace like below:

general protection fault, probably for non-canonical address 0xdffffc0000000005: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000028-0x000000000000002f]
CPU: 0 PID: 5127 Comm: syz-executor298 Not tainted 6.2.0-rc3-next-20230112-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:udf_fiiter_write_fi+0x14e/0x9d0 fs/udf/directory.c:402
...
Call Trace:
 <TASK>
 udf_rename+0x69d/0xb80 fs/udf/namei.c:874
 vfs_rename+0x1162/0x1a90 fs/namei.c:4780
 do_renameat2+0xb22/0xc30 fs/namei.c:4931
 __do_sys_rename fs/namei.c:4977 [inline]
 __se_sys_rename fs/namei.c:4975 [inline]
 __x64_sys_rename+0x81/0xa0 fs/namei.c:4975
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The cause of this issue is a race condition between udf_rename() and
udf_expand_dir_adinicb().

If udf_rename() and udf_expand_dir_adinicb() run concurrently,
iinfo->i_alloc_type can be changed by udf_expand_dir_adinicb() while
udf_rename() is running.  This causes NULL pointer dereference for
iter->bh[0]->b_data in udf_fiiter_write_fi().

Link: https://syzkaller.appspot.com/bug?id=2811e6cdd35ea1df1fa2ef31b8d92c6408aa15d2 [1]
Reported-by: syzbot+aebf90eea2671c43112a@syzkaller.appspotmail.com
Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
---
 fs/udf/namei.c | 35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/fs/udf/namei.c b/fs/udf/namei.c
index 06f066ba3072..5048652c6cd4 100644
--- a/fs/udf/namei.c
+++ b/fs/udf/namei.c
@@ -149,6 +149,8 @@ static struct buffer_head *udf_expand_dir_adinicb(struct inode *inode,
 	uint8_t *impuse;
 	int ret;
 
+	down_write(&iinfo->i_data_sem);
+
 	if (UDF_QUERY_FLAG(inode->i_sb, UDF_FLAG_USE_SHORT_AD))
 		alloctype = ICBTAG_FLAG_AD_SHORT;
 	else
@@ -157,7 +159,7 @@ static struct buffer_head *udf_expand_dir_adinicb(struct inode *inode,
 	if (!inode->i_size) {
 		iinfo->i_alloc_type = alloctype;
 		mark_inode_dirty(inode);
-		return NULL;
+		goto out;
 	}
 
 	/* alloc block, and copy data to it */
@@ -165,15 +167,15 @@ static struct buffer_head *udf_expand_dir_adinicb(struct inode *inode,
 			       iinfo->i_location.partitionReferenceNum,
 			       iinfo->i_location.logicalBlockNum, err);
 	if (!(*block))
-		return NULL;
+		goto out;
 	newblock = udf_get_pblock(inode->i_sb, *block,
 				  iinfo->i_location.partitionReferenceNum,
 				0);
 	if (!newblock)
-		return NULL;
+		goto out;
 	dbh = udf_tgetblk(inode->i_sb, newblock);
 	if (!dbh)
-		return NULL;
+		goto out;
 	lock_buffer(dbh);
 	memcpy(dbh->b_data, iinfo->i_data, inode->i_size);
 	memset(dbh->b_data + inode->i_size, 0,
@@ -197,7 +199,7 @@ static struct buffer_head *udf_expand_dir_adinicb(struct inode *inode,
 	if (ret < 0) {
 		*err = ret;
 		udf_free_blocks(inode->i_sb, inode, &eloc, 0, 1);
-		return NULL;
+		goto out;
 	}
 	mark_inode_dirty(inode);
 
@@ -213,6 +215,8 @@ static struct buffer_head *udf_expand_dir_adinicb(struct inode *inode,
 			impuse = NULL;
 		udf_fiiter_write_fi(&iter, impuse);
 	}
+	up_write(&iinfo->i_data_sem);
+
 	/*
 	 * We don't expect the iteration to fail as the directory has been
 	 * already verified to be correct
@@ -221,6 +225,9 @@ static struct buffer_head *udf_expand_dir_adinicb(struct inode *inode,
 	udf_fiiter_release(&iter);
 
 	return dbh;
+out:
+	up_write(&iinfo->i_data_sem);
+	return NULL;
 }
 
 static int udf_fiiter_add_entry(struct inode *dir, struct dentry *dentry,
@@ -766,6 +773,7 @@ static int udf_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 	bool has_diriter = false;
 	int retval;
 	struct kernel_lb_addr tloc;
+	struct udf_inode_info *old_iinfo = UDF_I(old_inode);
 
 	if (flags & ~RENAME_NOREPLACE)
 		return -EINVAL;
@@ -780,11 +788,13 @@ static int udf_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 		goto out_oiter;
 	}
 
+	down_read(&old_iinfo->i_data_sem);
+
 	if (S_ISDIR(old_inode->i_mode)) {
 		if (new_inode) {
 			retval = -ENOTEMPTY;
 			if (!empty_dir(new_inode))
-				goto out_oiter;
+				goto out_unlock;
 		}
 		retval = udf_fiiter_find_entry(old_inode, &dotdot_name,
 					       &diriter);
@@ -795,7 +805,7 @@ static int udf_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 			retval = -EFSCORRUPTED;
 		}
 		if (retval)
-			goto out_oiter;
+			goto out_unlock;
 		has_diriter = true;
 		tloc = lelb_to_cpu(diriter.fi.icb.extLocation);
 		if (udf_get_lb_pblock(old_inode->i_sb, &tloc, 0) !=
@@ -805,25 +815,25 @@ static int udf_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 				"directory (ino %lu) has parent entry pointing to another inode (%lu != %u)\n",
 				old_inode->i_ino, old_dir->i_ino,
 				udf_get_lb_pblock(old_inode->i_sb, &tloc, 0));
-			goto out_oiter;
+			goto out_unlock;
 		}
 	}
 
 	retval = udf_fiiter_find_entry(new_dir, &new_dentry->d_name, &niter);
 	if (retval && retval != -ENOENT)
-		goto out_oiter;
+		goto out_unlock;
 	/* Entry found but not passed by VFS? */
 	if (!retval && !new_inode) {
 		retval = -EFSCORRUPTED;
 		udf_fiiter_release(&niter);
-		goto out_oiter;
+		goto out_unlock;
 	}
 	/* Entry not found? Need to add one... */
 	if (retval) {
 		udf_fiiter_release(&niter);
 		retval = udf_fiiter_add_entry(new_dir, new_dentry, &niter);
 		if (retval)
-			goto out_oiter;
+			goto out_unlock;
 	}
 
 	/*
@@ -882,7 +892,10 @@ static int udf_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 			mark_inode_dirty(new_dir);
 		}
 	}
+	up_read(&old_iinfo->i_data_sem);
 	return 0;
+out_unlock:
+	up_read(&old_iinfo->i_data_sem);
 out_oiter:
 	if (has_diriter)
 		udf_fiiter_release(&diriter);
-- 
2.39.0

