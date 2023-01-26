Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C69167D1F6
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 17:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232353AbjAZQmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 11:42:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232249AbjAZQmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 11:42:00 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34B06BBCF;
        Thu, 26 Jan 2023 08:41:54 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id x2-20020a17090a46c200b002295ca9855aso5810417pjg.2;
        Thu, 26 Jan 2023 08:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oMxWKmQ/i8aPoVTgMwXRe3wWNfCPGmN2wVMhtok6GV8=;
        b=oSSqVGhtKAiNc1G4eRnYzKX2qSngVoikWgtvsP35LOPVpDms2+p9FYnNNn79s8suej
         Cm3clzjflQjmKypAFrfwLXL4Rlik6QsGF60G6yghCEaxm0UbRSV+iO3f2lIsvmuGK0L6
         oq66SJJkMnOght6aRWB5hUVV6cGr3MhwiBvaury4YZ7FiFAINythTTwYygl5/fPhw9rs
         /PwPfKamx55t/3o9nnMYmteEaiq5vzPD+dLDK84b9W2GDisNLEoUcVCifVxN3VhLgeyO
         JdNNKGVHdWWDfXeRuWKqiNmZnEfgVOIMxxAXw3Vvdz1l4ay+2xGpbd0f5EJWqudYoFv1
         n/ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oMxWKmQ/i8aPoVTgMwXRe3wWNfCPGmN2wVMhtok6GV8=;
        b=rVcmBqGsUj5ZE4auGEUQigWu6ZLd386Owwvpq606WjAjKasegKEDnpJ7QcddkBJaJ/
         M3BcN9xMHin0x0aa67rPxRQlzTZW1pLt/Vo4zGZiYIX044SvflSX/kWBP7sCVSNTpHPk
         1nbMrhlXuVNr7AiR4n9xcuW3fuCwk8cqIoKuheQKgCWRXnMNfWX9gIGBDG8J+ohlOTfp
         z7ZUrjicDwznd1Dt4x5ox3BzB94LALKFA7PN7LhYoCytIZij9c87utDCl/WpSi8bvT4I
         wdSVehxD2Bf43ZsjBpzvH2KcQHc+NKkgaf0BOzkLmGpGZ4ALvmpgKdHSpQ8a+8WAJz6F
         zqDg==
X-Gm-Message-State: AFqh2kohLyK5JpRi9M9nzMvxXdgxDoKLFSaTLcq9Klq+IHUpxwk7EHpZ
        5LRn3f+j1cBfjdZ4CtrzCOg=
X-Google-Smtp-Source: AMrXdXudJs57Um0+hBQicGbSHydtc4iyZCxTRc+llt+r/QHdqJJsQ23iQgyrBL4oC9Gl+Sq2ZMbOAw==
X-Received: by 2002:a17:90a:4a95:b0:225:c3ab:3137 with SMTP id f21-20020a17090a4a9500b00225c3ab3137mr38702914pjh.44.1674751313958;
        Thu, 26 Jan 2023 08:41:53 -0800 (PST)
Received: from carrot.. (i223-217-149-217.s42.a014.ap.plala.or.jp. [223.217.149.217])
        by smtp.gmail.com with ESMTPSA id p12-20020a17090a348c00b002192db1f8e8sm1271267pjb.23.2023.01.26.08.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 08:41:52 -0800 (PST)
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-nilfs <linux-nilfs@vger.kernel.org>,
        syzbot <syzbot+5d5d25f90f195a3cfcb4@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] nilfs2: replace WARN_ONs for invalid DAT metadata block requests
Date:   Fri, 27 Jan 2023 01:41:14 +0900
Message-Id: <20230126164114.6911-1-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <0000000000005cc3d205ea23ddcf@google.com>
References: <0000000000005cc3d205ea23ddcf@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If DAT metadata file block access fails due to corruption of the DAT file
or abnormal virtual block numbers held by b-trees or inodes, a kernel
warning is generated.

This replaces the WARN_ONs by error output, so that a kernel, booted with
panic_on_warn, does not panic.  This patch also replaces the detected
return code -ENOENT with another internal code -EINVAL to notify the bmap
layer of metadata corruption.  When the bmap layer sees -EINVAL, it
handles the abnormal situation with nilfs_bmap_convert_error() and
finally returns code -EIO as it should.

Link: https://lkml.kernel.org/r/0000000000005cc3d205ea23ddcf@google.com
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Reported-by: syzbot+5d5d25f90f195a3cfcb4@syzkaller.appspotmail.com
Tested-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
---
Hi Andrew, please queue this.  This fixes a few potential WARN_ONs
for corrupted disk images like the one syzbot produced.

Thanks,
Ryusuke Konishi

fs/nilfs2/dat.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/fs/nilfs2/dat.c b/fs/nilfs2/dat.c
index 9930fa901039..1e7f653c1df7 100644
--- a/fs/nilfs2/dat.c
+++ b/fs/nilfs2/dat.c
@@ -40,8 +40,21 @@ static inline struct nilfs_dat_info *NILFS_DAT_I(struct inode *dat)
 static int nilfs_dat_prepare_entry(struct inode *dat,
 				   struct nilfs_palloc_req *req, int create)
 {
-	return nilfs_palloc_get_entry_block(dat, req->pr_entry_nr,
-					    create, &req->pr_entry_bh);
+	int ret;
+
+	ret = nilfs_palloc_get_entry_block(dat, req->pr_entry_nr,
+					   create, &req->pr_entry_bh);
+	if (unlikely(ret == -ENOENT)) {
+		nilfs_err(dat->i_sb,
+			  "DAT doesn't have a block to manage vblocknr = %llu",
+			  (unsigned long long)req->pr_entry_nr);
+		/*
+		 * Return internal code -EINVAL to notify bmap layer of
+		 * metadata corruption.
+		 */
+		ret = -EINVAL;
+	}
+	return ret;
 }
 
 static void nilfs_dat_commit_entry(struct inode *dat,
@@ -123,11 +136,7 @@ static void nilfs_dat_commit_free(struct inode *dat,
 
 int nilfs_dat_prepare_start(struct inode *dat, struct nilfs_palloc_req *req)
 {
-	int ret;
-
-	ret = nilfs_dat_prepare_entry(dat, req, 0);
-	WARN_ON(ret == -ENOENT);
-	return ret;
+	return nilfs_dat_prepare_entry(dat, req, 0);
 }
 
 void nilfs_dat_commit_start(struct inode *dat, struct nilfs_palloc_req *req,
@@ -154,10 +163,8 @@ int nilfs_dat_prepare_end(struct inode *dat, struct nilfs_palloc_req *req)
 	int ret;
 
 	ret = nilfs_dat_prepare_entry(dat, req, 0);
-	if (ret < 0) {
-		WARN_ON(ret == -ENOENT);
+	if (ret < 0)
 		return ret;
-	}
 
 	kaddr = kmap_atomic(req->pr_entry_bh->b_page);
 	entry = nilfs_palloc_block_get_entry(dat, req->pr_entry_nr,
-- 
2.34.1

