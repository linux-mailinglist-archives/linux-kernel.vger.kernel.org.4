Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E36DD7404F2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 22:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbjF0U0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 16:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbjF0UZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 16:25:58 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE86D1FEA
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 13:25:55 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-57003dac4a8so5280817b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 13:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687897555; x=1690489555;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OrGhpjSBH+uvN2RlFVrnMyWFjf7MZCvpoWYUAG+UcGg=;
        b=J1Ay4xaAwE50titRnLAf8EZ4tOlp28f3hhclzOHSVchSUxINJwhyXY9wEHPBbWfTge
         jR+g6Qg7w9D7qLD7y8MPyelzGYCKfMt40xm05TJk8JQzDZ2Xv0FIDFrt2MjLrE7EqPuR
         +FhFBpbySZ4yVC722kZ+WSAf44aMVbcssT1g9QIOqa1me2sIWUujzxgSR4AmrFtTObz6
         Nt50EtsaW67uPWXg8PwR3SWnu+MuBJwsepJWfrwtDsUVeqqnYqx3jWepoAWjotKXDVyn
         gkqH3ypgLtrjW9EZmi1a24+cbBfm9HqDaddwo2Q2fhlXEhzIELgqVmz9o0rwAVUyCkoW
         JuiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687897555; x=1690489555;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OrGhpjSBH+uvN2RlFVrnMyWFjf7MZCvpoWYUAG+UcGg=;
        b=B0nKsYCREMLpvOdrSj3X1w83EseQPBeSbSiug120R79JNRyUoLUl7tb7MxEKB7FPML
         JTpZFQydAW8Qv7czCDGdZOyJef3tekgx/CbXhKIPxKZjizrOh1WQzJm9bGxaNQYSB/EE
         ti/Km5dlXVUoH+7ZG2tM+R27ZoFPDsPkIUv72Qyy+UvLv5poRTIpWzdilgQJhuqGhgtH
         Pij71c10SBjVQdwk/wdFkgiepoNzBmZMnwTt7Yv8PHfYGFC3VB+P6IkFj1K/2TJwRyky
         NCvzQRMjSxFViFoeEngDrXNhAWVYoSkb83Ozc+px+2paM2fGbWhpb2r9H3/twc1BaDg1
         R76Q==
X-Gm-Message-State: AC+VfDymZN6XVB7vfe2EOyES7Flhtp5w4XbJHIx6GYsM+8FuPFHpyv6d
        5VIEh0Orbm4l/66gR57z4HOgvTpAp0GRZTOIvQ==
X-Google-Smtp-Source: ACHHUZ7pwzISo3tUi89gxWua4UMbJKl2ONFmvL3K96MUD3/tkU2czKYAmuuzG/84BwbTNX2A7s33obaNpq3hC+l0CQ==
X-Received: from yuxiao.svl.corp.google.com ([2620:15c:2a3:200:372c:3efd:f120:f25d])
 (user=yuxiaozhang job=sendgmr) by 2002:a25:d205:0:b0:ba8:381b:f764 with SMTP
 id j5-20020a25d205000000b00ba8381bf764mr12393540ybg.3.1687897555050; Tue, 27
 Jun 2023 13:25:55 -0700 (PDT)
Date:   Tue, 27 Jun 2023 13:25:41 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230627202540.881909-2-yuxiaozhang@google.com>
Subject: [PATCH] pstore: ramoops: support pmsg size larger than kmalloc limitation
From:   Yuxiao Zhang <yuxiaozhang@google.com>
To:     Kees Cook <keescook@chromium.org>, Tony Luck <tony.luck@intel.com>,
        "'Guilherme G . Piccoli'" <gpiccoli@igalia.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-hardening@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, wak@google.com,
        Yuxiao Zhang <yuxiaozhang@google.com>
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

Current pmsg implementation is using kmalloc for pmsg record buffer,
which has max size limits based on page size. Currently even we
allocate enough space with pmsg-size, pmsg will still fail if the
file size is larger than what kmalloc allowed.

Since we don't need physical contiguous memory for pmsg buffer
, we can use kvmalloc to avoid such limitation.

Signed-off-by: Yuxiao Zhang <yuxiaozhang@google.com>
---
 fs/pstore/inode.c    | 2 +-
 fs/pstore/platform.c | 9 +++++----
 fs/pstore/ram.c      | 5 +++--
 fs/pstore/ram_core.c | 3 ++-
 4 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/fs/pstore/inode.c b/fs/pstore/inode.c
index ffbadb8b3032..df7fb2ad4599 100644
--- a/fs/pstore/inode.c
+++ b/fs/pstore/inode.c
@@ -54,7 +54,7 @@ static void free_pstore_private(struct pstore_private *private)
 	if (!private)
 		return;
 	if (private->record) {
-		kfree(private->record->buf);
+		kvfree(private->record->buf);
 		kfree(private->record->priv);
 		kfree(private->record);
 	}
diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index cbc0b468c1ab..f51e9460ac9d 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -32,6 +32,7 @@
 #include <linux/uaccess.h>
 #include <linux/jiffies.h>
 #include <linux/workqueue.h>
+#include <linux/mm.h>
 
 #include "internal.h"
 
@@ -549,7 +550,7 @@ static int pstore_write_user_compat(struct pstore_record *record,
 	if (record->buf)
 		return -EINVAL;
 
-	record->buf = memdup_user(buf, record->size);
+	record->buf = vmemdup_user(buf, record->size);
 	if (IS_ERR(record->buf)) {
 		ret = PTR_ERR(record->buf);
 		goto out;
@@ -557,7 +558,7 @@ static int pstore_write_user_compat(struct pstore_record *record,
 
 	ret = record->psi->write(record);
 
-	kfree(record->buf);
+	kvfree(record->buf);
 out:
 	record->buf = NULL;
 
@@ -730,7 +731,7 @@ static void decompress_record(struct pstore_record *record)
 		return;
 
 	/* Swap out compressed contents with decompressed contents. */
-	kfree(record->buf);
+	kvfree(record->buf);
 	record->buf = unzipped;
 	record->size = unzipped_len;
 	record->compressed = false;
@@ -783,7 +784,7 @@ void pstore_get_backend_records(struct pstore_info *psi,
 		rc = pstore_mkfile(root, record);
 		if (rc) {
 			/* pstore_mkfile() did not take record, so free it. */
-			kfree(record->buf);
+			kvfree(record->buf);
 			kfree(record->priv);
 			kfree(record);
 			if (rc != -EEXIST || !quiet)
diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
index ade66dbe5f39..296465b14fa9 100644
--- a/fs/pstore/ram.c
+++ b/fs/pstore/ram.c
@@ -20,6 +20,7 @@
 #include <linux/compiler.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/mm.h>
 
 #include "internal.h"
 #include "ram_internal.h"
@@ -268,7 +269,7 @@ static ssize_t ramoops_pstore_read(struct pstore_record *record)
 	/* ECC correction notice */
 	record->ecc_notice_size = persistent_ram_ecc_string(prz, NULL, 0);
 
-	record->buf = kmalloc(size + record->ecc_notice_size + 1, GFP_KERNEL);
+	record->buf = kvmalloc(size + record->ecc_notice_size + 1, GFP_KERNEL);
 	if (record->buf == NULL) {
 		size = -ENOMEM;
 		goto out;
@@ -282,7 +283,7 @@ static ssize_t ramoops_pstore_read(struct pstore_record *record)
 
 out:
 	if (free_prz) {
-		kfree(prz->old_log);
+		kvfree(prz->old_log);
 		kfree(prz);
 	}
 
diff --git a/fs/pstore/ram_core.c b/fs/pstore/ram_core.c
index 966191d3a5ba..3453d493ec27 100644
--- a/fs/pstore/ram_core.c
+++ b/fs/pstore/ram_core.c
@@ -17,6 +17,7 @@
 #include <linux/slab.h>
 #include <linux/uaccess.h>
 #include <linux/vmalloc.h>
+#include <linux/mm.h>
 #include <asm/page.h>
 
 #include "ram_internal.h"
@@ -385,7 +386,7 @@ void *persistent_ram_old(struct persistent_ram_zone *prz)
 
 void persistent_ram_free_old(struct persistent_ram_zone *prz)
 {
-	kfree(prz->old_log);
+	kvfree(prz->old_log);
 	prz->old_log = NULL;
 	prz->old_log_size = 0;
 }
-- 
2.41.0.162.gfafddb0af9-goog
