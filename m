Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E38966F4B0F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 22:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjEBUMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 16:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjEBUMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 16:12:37 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 981AF1FC4
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 13:12:36 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-55a42c22300so48385527b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 13:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683058356; x=1685650356;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VMIztS2TNwPWi8y+6jVOhYQ7jYaHWdPJl8c/QL2NrEY=;
        b=vQlQykZ5uh/16XZqfDggy9giUk9u4L5cMszHyutb9jXZOteX3TlrL/HOqx9UkTOLiT
         p3tRhBkLYOgTRbxTtbLi2Tny2dzCqPk9AHO/ZbislK7TlzxNPJifN4qKVffH5lLCY++D
         xMClbgbIJLFfFSjHgvZlOAGgPd0tj+Him+dRX/76AV9bcP5WzwGHBhOgfUhq/NDJJNmL
         59YF0JvwcNmQ015tapHXY9Q5D7rASjUc5yReEUhP5T78kxhNsvsVkYl12BX/Sy6BgNZu
         B/2vOtSiHdlhvV6PCCkhGP45QhB4DTmxg6UcMrCueloiYQSGqr7Vm8CUp8t6Cmb+aqar
         AbLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683058356; x=1685650356;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VMIztS2TNwPWi8y+6jVOhYQ7jYaHWdPJl8c/QL2NrEY=;
        b=l6GLI47Hv86vp076eFtkq+E7d0tsmGAKRtY0W3KNxQGIYfKagvf9yeTpicIC0PbWla
         l2/PbWneJ/NuGNR7MkY1gaVmsKXwsY/RGQQQ+qcLzkZ4kmuWZMvVAm0pbVzP/nZMyBmX
         HKvc6RiOBkTWDcnzvd2xjdoCpvGuo8Y43Hh0RheDtRkBIt3vkX8ZF9CKkwoX9lDP3/lU
         5MO5js/gLa3MtwFyDgsKukvX+whP+A8Wl6h5lLTF/5YA8TvVmib09ndFcoCAugabxP6B
         +G4xKZ0ackVN/3hX4n2G+/pI03t1lPvQWWA1YcyMltnX5oxxmwZ8RYW+gcnY33CtAPKq
         897A==
X-Gm-Message-State: AC+VfDzl88zcgh4OdhaT/8GOgcTVqdk+tq+IuL/H29j8r1ok+tqZHpx1
        BYT6kbvQtCnSfIA1sXMoehRiClk7Yju6zA==
X-Google-Smtp-Source: ACHHUZ5LCvzhAYVMOiqdp21gwJ4dCMIkLjoIb5K22efre2i1f9fvCbNB0ZSEg4gg39aEP4G726g7J4liKCcyTQ==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a81:ac49:0:b0:55a:8e39:57a7 with SMTP id
 z9-20020a81ac49000000b0055a8e3957a7mr2299204ywj.6.1683058355888; Tue, 02 May
 2023 13:12:35 -0700 (PDT)
Date:   Tue,  2 May 2023 20:12:19 +0000
In-Reply-To: <20230502201220.1756319-1-cmllamas@google.com>
Mime-Version: 1.0
References: <20230502201220.1756319-1-cmllamas@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230502201220.1756319-3-cmllamas@google.com>
Subject: [PATCH 3/3] binder: add lockless binder_alloc_(set|get)_vma()
From:   Carlos Llamas <cmllamas@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Carlos Llamas <cmllamas@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Liam Howlett <liam.howlett@oracle.com>, stable@vger.kernel.org
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

Bring back the original lockless design in binder_alloc to determine
whether the buffer setup has been completed by the ->mmap() handler.
However, this time use smp_load_acquire() and smp_store_release() to
wrap all the ordering in a single macro call.

Also, add comments to make it evident that binder uses alloc->vma to
determine when the binder_alloc has been fully initialized. In these
scenarios acquiring the mmap_lock is not required.

Fixes: a43cfc87caaf ("android: binder: stop saving a pointer to the VMA")
Cc: Liam Howlett <liam.howlett@oracle.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: stable@vger.kernel.org
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder_alloc.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index eb082b33115b..e7c9d466f8e8 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -309,17 +309,18 @@ static int binder_update_page_range(struct binder_alloc *alloc, int allocate,
 	return vma ? -ENOMEM : -ESRCH;
 }
 
+static inline void binder_alloc_set_vma(struct binder_alloc *alloc,
+		struct vm_area_struct *vma)
+{
+	/* pairs with smp_load_acquire in binder_alloc_get_vma() */
+	smp_store_release(&alloc->vma, vma);
+}
+
 static inline struct vm_area_struct *binder_alloc_get_vma(
 		struct binder_alloc *alloc)
 {
-	struct vm_area_struct *vma = NULL;
-
-	if (alloc->vma) {
-		/* Look at description in binder_alloc_set_vma */
-		smp_rmb();
-		vma = alloc->vma;
-	}
-	return vma;
+	/* pairs with smp_store_release in binder_alloc_set_vma() */
+	return smp_load_acquire(&alloc->vma);
 }
 
 static bool debug_low_async_space_locked(struct binder_alloc *alloc, int pid)
@@ -382,6 +383,7 @@ static struct binder_buffer *binder_alloc_new_buf_locked(
 	size_t size, data_offsets_size;
 	int ret;
 
+	/* Check binder_alloc is fully initialized */
 	if (!binder_alloc_get_vma(alloc)) {
 		binder_alloc_debug(BINDER_DEBUG_USER_ERROR,
 				   "%d: binder_alloc_buf, no vma\n",
@@ -777,7 +779,9 @@ int binder_alloc_mmap_handler(struct binder_alloc *alloc,
 	buffer->free = 1;
 	binder_insert_free_buffer(alloc, buffer);
 	alloc->free_async_space = alloc->buffer_size / 2;
-	alloc->vma = vma;
+
+	/* Signal binder_alloc is fully initialized */
+	binder_alloc_set_vma(alloc, vma);
 
 	return 0;
 
@@ -959,7 +963,7 @@ int binder_alloc_get_allocated_count(struct binder_alloc *alloc)
  */
 void binder_alloc_vma_close(struct binder_alloc *alloc)
 {
-	alloc->vma = 0;
+	binder_alloc_set_vma(alloc, NULL);
 }
 
 /**
-- 
2.40.1.495.gc816e09b53d-goog

