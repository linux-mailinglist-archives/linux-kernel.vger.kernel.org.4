Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CBF96E56A0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 03:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbjDRBl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 21:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbjDRBlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 21:41:14 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B555B84
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 18:41:00 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-54f97aac3d0so147121987b3.15
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 18:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681782060; x=1684374060;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tI4xcmLYwpmFva3i/dRZyfQFdXSO1OOUgkc/BOul5Ro=;
        b=2V9e6mUN9Le2shS/G4YvhPJcIGT2cNDZPr1QkNJOacyGU//myujH64KDbejS/tMlXz
         4E6nR0HLcdcTv09CWWYmtKIX5wVZpN0ReS4cFCAJVsgaJjGnWqRP+K97KcNMss7R5lc/
         8wSlpIQsxhUI3w04o4cPXpyg3kA0F6KHlojC/d7SlYfU/cCvQzPLbwOg1psSwLmSzRXn
         Qn3vxYWDKyf/Fn+ASbJ7PU1gdKO1me/kfleFJ2griqgfwNcqIJ9AF057vwZ+pRcgxCsX
         sF1c9SZLi/nimZi9xbCd1jVXTRuM8JHWnHdMqXKLly0BeGcWX5EH1LSs7jCfFcSZkogo
         szkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681782060; x=1684374060;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tI4xcmLYwpmFva3i/dRZyfQFdXSO1OOUgkc/BOul5Ro=;
        b=akRD7qR63m/SRMFyF2VdmTfCNH9yxtOgnH/0ukOE9Pz8s2QBThKiPOB3SHNXP8z8xZ
         lG/+cDuyKgfkYv/xGdrydvlidgwutLOyozwL0dcuTzOvATzFBmx9wQbaVn8Fc9J5YhH9
         x0cyQQhBvXzp/8humwlaVOiUxts5oK5mL1hBCLJ7/fHGreQ3a1pWtxf3UvKjYlIemL/Y
         jsOavmCCtJkjSkKiQCdW0mgTBEUSUbRTARRiCZPLoy9ei7Cr3sn/rh5/pepq00dBggMv
         +R8drgkRSAHxkIl/j8Sq/EEQYwlfaLsSh1rZPaTP8YT0L8FHLkv+nhLXcFaLujomT3Uw
         oQzA==
X-Gm-Message-State: AAQBX9dP/tFGyFKNCMd9docWbp3Rw5V3wH08eDEeUQxqMKpfYY2YcAj9
        d8eo2gCNtNdcSEKIrBEu/bHkacMsQXg=
X-Google-Smtp-Source: AKy350YKpzErYw3bq9/BlI+znfoyrC46XNLf6K9cGOqwUJLaLH9t7tNWGgZpyi5xKkrMqdSo1O9knK3ZgUU=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:201:e67a:98b0:942d:86aa])
 (user=drosen job=sendgmr) by 2002:a25:d70a:0:b0:b77:ae4b:1b27 with SMTP id
 o10-20020a25d70a000000b00b77ae4b1b27mr8727839ybg.8.1681782059999; Mon, 17 Apr
 2023 18:40:59 -0700 (PDT)
Date:   Mon, 17 Apr 2023 18:40:04 -0700
In-Reply-To: <20230418014037.2412394-1-drosen@google.com>
Mime-Version: 1.0
References: <20230418014037.2412394-1-drosen@google.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230418014037.2412394-5-drosen@google.com>
Subject: [RFC PATCH v3 04/37] fs: Generic function to convert iocb to rw flags
From:   Daniel Rosenberg <drosen@google.com>
To:     Miklos Szeredi <miklos@szeredi.hu>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>
Cc:     Amir Goldstein <amir73il@gmail.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Joanne Koong <joannelkoong@gmail.com>,
        Mykola Lysenko <mykolal@fb.com>, kernel-team@android.com,
        Alessio Balsini <balsini@google.com>,
        Alessio Balsini <balsini@android.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alessio Balsini <balsini@google.com>

OverlayFS implements its own function to translate iocb flags into rw
flags, so that they can be passed into another vfs call.
With commit ce71bfea207b4 ("fs: align IOCB_* flags with RWF_* flags")
Jens created a 1:1 matching between the iocb flags and rw flags,
simplifying the conversion.

Reduce the OverlayFS code by making the flag conversion function generic
and reusable.

Signed-off-by: Alessio Balsini <balsini@android.com>
---
 fs/overlayfs/file.c | 23 +++++------------------
 include/linux/fs.h  |  5 +++++
 2 files changed, 10 insertions(+), 18 deletions(-)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index 7c04f033aadd..759893e4da04 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -15,6 +15,8 @@
 #include <linux/fs.h>
 #include "overlayfs.h"
 
+#define OVL_IOCB_MASK (IOCB_DSYNC | IOCB_HIPRI | IOCB_NOWAIT | IOCB_SYNC)
+
 struct ovl_aio_req {
 	struct kiocb iocb;
 	refcount_t ref;
@@ -241,22 +243,6 @@ static void ovl_file_accessed(struct file *file)
 	touch_atime(&file->f_path);
 }
 
-static rwf_t ovl_iocb_to_rwf(int ifl)
-{
-	rwf_t flags = 0;
-
-	if (ifl & IOCB_NOWAIT)
-		flags |= RWF_NOWAIT;
-	if (ifl & IOCB_HIPRI)
-		flags |= RWF_HIPRI;
-	if (ifl & IOCB_DSYNC)
-		flags |= RWF_DSYNC;
-	if (ifl & IOCB_SYNC)
-		flags |= RWF_SYNC;
-
-	return flags;
-}
-
 static inline void ovl_aio_put(struct ovl_aio_req *aio_req)
 {
 	if (refcount_dec_and_test(&aio_req->ref)) {
@@ -316,7 +302,8 @@ static ssize_t ovl_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 	old_cred = ovl_override_creds(file_inode(file)->i_sb);
 	if (is_sync_kiocb(iocb)) {
 		ret = vfs_iter_read(real.file, iter, &iocb->ki_pos,
-				    ovl_iocb_to_rwf(iocb->ki_flags));
+				    iocb_to_rw_flags(iocb->ki_flags,
+						     OVL_IOCB_MASK));
 	} else {
 		struct ovl_aio_req *aio_req;
 
@@ -380,7 +367,7 @@ static ssize_t ovl_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 	if (is_sync_kiocb(iocb)) {
 		file_start_write(real.file);
 		ret = vfs_iter_write(real.file, iter, &iocb->ki_pos,
-				     ovl_iocb_to_rwf(ifl));
+				     iocb_to_rw_flags(ifl, OVL_IOCB_MASK));
 		file_end_write(real.file);
 		/* Update size */
 		ovl_copyattr(inode);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index c85916e9f7db..c849074f44b7 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3009,6 +3009,11 @@ static inline int kiocb_set_rw_flags(struct kiocb *ki, rwf_t flags)
 	return 0;
 }
 
+static inline rwf_t iocb_to_rw_flags(int ifl, int iocb_mask)
+{
+	return ifl & iocb_mask;
+}
+
 static inline ino_t parent_ino(struct dentry *dentry)
 {
 	ino_t res;
-- 
2.40.0.634.g4ca3ef3211-goog

