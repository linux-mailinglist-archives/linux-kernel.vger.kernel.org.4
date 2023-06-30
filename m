Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4B81744378
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 22:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232631AbjF3UvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 16:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231778AbjF3UvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 16:51:14 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B2EF3A81
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 13:51:12 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-565d1b86a64so21568177b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 13:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688158271; x=1690750271;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=q2oZ1GyS+YBD++gh5iZvdENiFKHgmT5vxF1elFZs+tI=;
        b=xQduKdzaisQiNSO8GyRHTAMpm4SWDdDFRUGqIW0jLDeN6Qs7WuZCt+rbWNwKfBMN93
         aAHNrzSwAO6y3bOk5Q+7WIoxwrXZ9220qjTUq5PMgAivWr1RIr1JPi3XUNECparkoZV5
         yEJEAw/jUGGxgiwuoKJ3GXLTOsUihTCjbmYW9XL0tKUIAv7ulVGBt/TbtsZ2tDRjByVL
         6diUbC7ILRnsV895y/f4/UU41Isn21tD8QXeVCzrKwHtFXyaoc+AbD10N/UX5XJS+n7t
         NxYZzU69q2uEdFw3sG0lhfY8hGa9AhZuWryO2m/lWw86//EkfyMjqSxdCFkzeTIUWI7M
         EK4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688158271; x=1690750271;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q2oZ1GyS+YBD++gh5iZvdENiFKHgmT5vxF1elFZs+tI=;
        b=cVMBF7Ollz+QM9cixjOHamG3WMyFpRLe0jw1Dk91gp8CDEiHOALPOzPbN3ltJAQXkn
         rygIiXX1GreI7YF6wSnflqpVf9kzOpqfN0CeBfBu77m7BMu04xWf2dwucMZyZZou7YOj
         beS/R/M65e/+j4HikoUZ/LDP5SHiNHLcXeQ+A2aQGpB4pLxShOuv8ZiAMMBFAWvcjXPG
         yUcafkSeAOO/jtCp1ct3ES2RRvNzq6eVSHrPDwexmO29V9ZNlmye9hyCC9DG9YuqROaT
         WV4O8Bp0mhyuCNoQSnzkV6ZADBn7JJSfkuNDlEn3CmwIS19xNnvDUcFfzwOJrfZi0S5D
         k3PA==
X-Gm-Message-State: ABy/qLaTlV5fYCk8p6IJvQBBlcI4RiNhIb3YwpTixsXF8xTmu88KsF8h
        2sWDRmJqpfwZcArszyP8E8ebUQvM0O8i37GNJQ==
X-Google-Smtp-Source: APBJJlHlQmOvcoJBXaf9tTjL0Ifnuf7HAUhkkg/L1tJmWU5+tLmUrQI0udcf1PQb5H29TR3qM2YjX6Dh7t6TEyggTw==
X-Received: from yuxiao.svl.corp.google.com ([2620:15c:2a3:200:511c:d1b:e03e:e72])
 (user=yuxiaozhang job=sendgmr) by 2002:a81:6d8e:0:b0:56d:3c2b:2471 with SMTP
 id i136-20020a816d8e000000b0056d3c2b2471mr25272ywc.3.1688158271574; Fri, 30
 Jun 2023 13:51:11 -0700 (PDT)
Date:   Fri, 30 Jun 2023 13:50:55 -0700
In-Reply-To: <202306281053.EC5115465B@keescook>
Mime-Version: 1.0
References: <202306281053.EC5115465B@keescook>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230630205055.3600376-1-yuxiaozhang@google.com>
Subject: Re: [PATCH] pstore: ramoops: support pmsg size larger than kmalloc limitation
From:   Yuxiao Zhang <yuxiaozhang@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Tony Luck <tony.luck@intel.com>,
        "'Guilherme G . Piccoli'" <gpiccoli@igalia.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        wak@google.com, Added@google.com, size@google.com,
        details@google.com, to@google.com, commit@google.com,
        message@google.com, and@google.com, fixed@google.com,
        the@google.com, format.See@google.com, new@google.com,
        Yuxiao Zhang <yuxiaozhang@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,
-Yuxiao


From cd3ec6155a3cf0e198afdf2d040c73ee146b696f Mon Sep 17 00:00:00 2001
From: Yuxiao Zhang <yuxiaozhang@google.com>
Date: Fri, 30 Jun 2023 10:45:21 -0700
Subject: [PATCH] pstore: ramoops: support pmsg size larger than kmalloc
 limitation

Current pmsg implementation is using kmalloc for pmsg record buffer,
which has max size limits of 2^(MAX_ORDER + PAGE_SHIFT). Currently even
we allocate enough space with pmsg-size, pmsg will still fail if the
file size is larger than what kmalloc allowed.

Since we don't need physical contiguous memory for pmsg buffer,
we can use kvmalloc to avoid such limitation.

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
2.41.0.255.g8b1d071c50-goog

