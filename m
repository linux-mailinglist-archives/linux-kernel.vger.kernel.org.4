Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3B3A73F048
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 03:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjF0BUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 21:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbjF0BUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 21:20:44 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1168A173C
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 18:20:42 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fa5295fcc8so34235e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 18:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687828840; x=1690420840;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MwvCpFW/GbNtPlS+NY4oiqTY4IcMkcTsbkaeYou0CDY=;
        b=MrXhAAJE9l6zSW90GA8n65w4+eCK49qK/xWh8182A8ET/4h+ybVFaIi0tNHp5ac5Bo
         rSqwJWk9svsna+Mu53daPYTGiqe5GaNwXjVx9VAHJrGU4cJp9aHc6voM4wN0s5KO3K/y
         +O/kPFMf+XtRWmXwYPmeIZZ9a/iT9pfCfMFmllEJbgdnlm83bCiBqBl53Y68hN5RfxrM
         9W8t86scw7RxHinoj/GwRSRaUlFZu8cWPJsBazjhm0IJUgY3S2JGoVFeg9iUh08ZYBsH
         MrXf8fbQAP4jm8jnmhmKSKxtAXDdwE2qdS21V2aGV4Xqc14Vm/OnkU5s0Ss/9sij+5Mi
         ptYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687828840; x=1690420840;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MwvCpFW/GbNtPlS+NY4oiqTY4IcMkcTsbkaeYou0CDY=;
        b=Sj/n1Q/LBIP9IgYuryhaFdYjroftqqdKrVUMzg/DdU88sh0L0nWUSOjjlHuGDIbTq9
         B7fh3mvfjHVqEztpq+5v+0kpgM+kgqwiMu3dXPjB8uWJRCUQwg/YUz4DXJxwdoc9+g+l
         sv6L96NS8td6dWvJ0CwjKgj8fAVGqNgMYypL9h0MTLkJUM4trKj/MYFMxYn5pEpDE99v
         hWgf+OmR2ENlgItxQ+f9YIgLxUo439NeDznvnz5HpTjUHYkalt4w8hyK3eIyU+lRh7Ag
         +FzMxGLR+T8J4a2kavodN9DZslz+MNCdnWas1keOBJ6kfkXFpNd4ewBrSLtsAWdU3nqx
         S6jg==
X-Gm-Message-State: AC+VfDzI2C7bckz8AK3CYoea/Oko5KDXjoG1/FNjID6nj3/WunlhyqTT
        ohjTmv2WXkdO4Dg348gCXs3IUNvsmlFckc+fL4khKw==
X-Google-Smtp-Source: ACHHUZ4yNnIeW6xZpPLiaVRnq3DPPpO7aR3C7mWs6623sflXXuUQ+liw5rmNxwTYrcSkLr+wQPlWHm14UHK8qJMbQK8=
X-Received: by 2002:a05:600c:4fcd:b0:3f6:f4b:d4a6 with SMTP id
 o13-20020a05600c4fcd00b003f60f4bd4a6mr283186wmq.7.1687828840459; Mon, 26 Jun
 2023 18:20:40 -0700 (PDT)
MIME-Version: 1.0
From:   Yuxiao Zhang <yuxiaozhang@google.com>
Date:   Mon, 26 Jun 2023 18:20:29 -0700
Message-ID: <CAOOoKeQ=b4u1C_FZ-OFHSfVt5Z9xw1KtpJ4316zubt46Tny41Q@mail.gmail.com>
Subject: support pmsg record size larger than kmalloc limitation
To:     keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        linux-hardening@vger.kernel.org
Cc:     William Kennington <wak@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi pstore maintainers,

Recently we are trying to use pmsg ramoops to store relatively large
file. We found that even with enough space configured with pmsg-size,
it still failed because of kmalloc limitation.

We are thinking of using kvmalloc instead of kmalloc for ramoops pmsg
record buffer. It seems ok to us that the memory is not physically
contiguous. We want to consult with you whether it is safe to do so.

Below is the patch file, note that the change only touches the pmsg
ram path, we don't touch other paths like pstore zone. It is not yet a
solution for all the use case in pstore, just an idea of how we want
to address the issue. We test this on 5.15 and large file works fine.

-----------------------------------

From 5f7ac624d47b49ea827c1ad8e3b47534e0709ea3 Mon Sep 17 00:00:00 2001
From: Yuxiao Zhang <yuxiaozhang@google.com>
Date: Mon, 26 Jun 2023 16:40:40 -0700
Subject: [PATCH] pstore: ramoops: support pmsg size larger than kmalloc
 limitation

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
@@ -54,7 +54,7 @@ static void free_pstore_private(struct
pstore_private *private)
  if (!private)
  return;
  if (private->record) {
- kfree(private->record->buf);
+ kvfree(private->record->buf);
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

@@ -549,7 +550,7 @@ static int pstore_write_user_compat(struct
pstore_record *record,
  if (record->buf)
  return -EINVAL;

- record->buf = memdup_user(buf, record->size);
+ record->buf = vmemdup_user(buf, record->size);
  if (IS_ERR(record->buf)) {
  ret = PTR_ERR(record->buf);
  goto out;
@@ -557,7 +558,7 @@ static int pstore_write_user_compat(struct
pstore_record *record,

  ret = record->psi->write(record);

- kfree(record->buf);
+ kvfree(record->buf);
 out:
  record->buf = NULL;

@@ -730,7 +731,7 @@ static void decompress_record(struct pstore_record *record)
  return;

  /* Swap out compressed contents with decompressed contents. */
- kfree(record->buf);
+ kvfree(record->buf);
  record->buf = unzipped;
  record->size = unzipped_len;
  record->compressed = false;
@@ -783,7 +784,7 @@ void pstore_get_backend_records(struct pstore_info *psi,
  rc = pstore_mkfile(root, record);
  if (rc) {
  /* pstore_mkfile() did not take record, so free it. */
- kfree(record->buf);
+ kvfree(record->buf);
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
@@ -268,7 +269,7 @@ static ssize_t ramoops_pstore_read(struct
pstore_record *record)
  /* ECC correction notice */
  record->ecc_notice_size = persistent_ram_ecc_string(prz, NULL, 0);

- record->buf = kmalloc(size + record->ecc_notice_size + 1, GFP_KERNEL);
+ record->buf = kvmalloc(size + record->ecc_notice_size + 1, GFP_KERNEL);
  if (record->buf == NULL) {
  size = -ENOMEM;
  goto out;
@@ -282,7 +283,7 @@ static ssize_t ramoops_pstore_read(struct
pstore_record *record)

 out:
  if (free_prz) {
- kfree(prz->old_log);
+ kvfree(prz->old_log);
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
- kfree(prz->old_log);
+ kvfree(prz->old_log);
  prz->old_log = NULL;
  prz->old_log_size = 0;
 }
--

-------------------------------------------
Thanks in advance.
-Yuxiao
