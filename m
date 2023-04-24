Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95EF36ED663
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 22:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232063AbjDXU4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 16:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232396AbjDXU4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 16:56:34 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDFD172BC
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 13:56:30 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-b92309d84c1so23438461276.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 13:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682369790; x=1684961790;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QAxnpNVVBFuzE9GYOOg2/Ftab/EjG3MWY6IMj4Qumjs=;
        b=ujb5zcd1KBzxKAOR4hk1uqxutbd1kanM+csJA1meOHmJYxrDHyXEUf3s3F1CNaMMTY
         F2UwG5dJWdwrPjS2m5St4fIIHRJgNJiv0eMCV6hQxhsfJ1N8OaV3vbFI+A7C3y1gHu+y
         g0M22QeG0lUyYp4TXj6vtk5ieXBXEvHzRFXWxXxCWmZCBUyzVZZz+uPZfQ1GzE18UOXY
         4M+ZzEilfIiNrA+1l4QqmYZZEjKLkiQH7TBNlsxSgN7UG/arCZzAtq+ArTot61JKzNGT
         uDp4x5XHVNY6pLU5J2Ri8EtTP4pSnmqQVeQFLhwuYrSz4MJtzFS+UQa7ewmDeHz8iBWN
         Z39Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682369790; x=1684961790;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QAxnpNVVBFuzE9GYOOg2/Ftab/EjG3MWY6IMj4Qumjs=;
        b=YEUyWGl1rdqbZizzeD1agag2f32gfFL/9NXsgJ5mzf98lyIw8kD5GlKry6UeDjso0h
         1yqSBYocCEsVQpMbZ29dtT45Nashjd3oKIgevBQ23E8OP1UBYYwp1htDTS10oBa0Yhq/
         r+9MEYMITPbI4RzNiloUTRjnMyANq+1tKekvlBXJONfxtnhSDmjxU0pWnvumC6CRkQJY
         Azp/gIymlKaMo/5vVHjGJKKgjvGjwUVfaRs0doMaQeJwIyrQxCwHRTSt5/KgVue5N9vQ
         vm8lNCpBasTnBPQUjNl3dVh3vVtw1c4eJUXEvElS/4I7FcMfq07tDxWz5KobKUE/sFw8
         SqLA==
X-Gm-Message-State: AAQBX9c0kmGUQBnqBZ2AoRuqba1jFsp13GwQeoBPwZGer+SoAJ4cRjWc
        8rwnUsdYHiyXwf1QaymTwXCkHX1AOVxlKQ==
X-Google-Smtp-Source: AKy350YYjyTgO+6IXh8tE7lK5L05UhrxABixhGBxviWUwc34wdRKdakSngp8Can2PQClrrENEQ1oz1U4wvGx7A==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a25:cc16:0:b0:b8e:efd8:f2c with SMTP id
 l22-20020a25cc16000000b00b8eefd80f2cmr8406994ybf.1.1682369790208; Mon, 24 Apr
 2023 13:56:30 -0700 (PDT)
Date:   Mon, 24 Apr 2023 20:55:48 +0000
In-Reply-To: <20230424205548.1935192-1-cmllamas@google.com>
Mime-Version: 1.0
References: <20230424205548.1935192-1-cmllamas@google.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230424205548.1935192-3-cmllamas@google.com>
Subject: [RFC PATCH 3/3] binder: add lockless binder_alloc_(set|get)_vma()
From:   Carlos Llamas <cmllamas@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Carlos Llamas <cmllamas@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Liam Howlett <liam.howlett@oracle.com>
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

Cc: Liam Howlett <liam.howlett@oracle.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder_alloc.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index eb082b33115b..9d166e10315e 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -309,17 +309,16 @@ static int binder_update_page_range(struct binder_alloc *alloc, int allocate,
 	return vma ? -ENOMEM : -ESRCH;
 }
 
+static inline void binder_alloc_set_vma(struct binder_alloc *alloc,
+		struct vm_area_struct *vma)
+{
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
+	return smp_load_acquire(&alloc->vma);
 }
 
 static bool debug_low_async_space_locked(struct binder_alloc *alloc, int pid)
@@ -382,6 +381,7 @@ static struct binder_buffer *binder_alloc_new_buf_locked(
 	size_t size, data_offsets_size;
 	int ret;
 
+	/* Check binder_alloc is fully initialized */
 	if (!binder_alloc_get_vma(alloc)) {
 		binder_alloc_debug(BINDER_DEBUG_USER_ERROR,
 				   "%d: binder_alloc_buf, no vma\n",
@@ -777,7 +777,9 @@ int binder_alloc_mmap_handler(struct binder_alloc *alloc,
 	buffer->free = 1;
 	binder_insert_free_buffer(alloc, buffer);
 	alloc->free_async_space = alloc->buffer_size / 2;
-	alloc->vma = vma;
+
+	/* Signal binder_alloc is fully initialized */
+	binder_alloc_set_vma(alloc, vma);
 
 	return 0;
 
@@ -959,7 +961,7 @@ int binder_alloc_get_allocated_count(struct binder_alloc *alloc)
  */
 void binder_alloc_vma_close(struct binder_alloc *alloc)
 {
-	alloc->vma = 0;
+	binder_alloc_set_vma(alloc, NULL);
 }
 
 /**
-- 
2.40.0.634.g4ca3ef3211-goog

