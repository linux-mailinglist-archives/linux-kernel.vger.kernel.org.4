Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE0066F4B0B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 22:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjEBUMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 16:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjEBUMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 16:12:31 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C5AC10FF
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 13:12:30 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-b9e50081556so3379097276.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 13:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683058349; x=1685650349;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PxtEaaNRJEnS8gUq7TvU2r4SfUgelfPOgo5JiP3hUpo=;
        b=BYEMeUVTavoTcRxgokm9LZOiUo7JnHslNZEV71QJ15VCAvQjDYwvQHxDp2GbTG40ky
         jG2xF68/iZX42EldBxCWvGasW0z36zT9XC1HFjr04Y697ZGrsWbiwH2FA3zv1TtdktJI
         55wsjAMD/JNIzadT0P2aX0LbJlXXDdBrpC+GmJBScI84NR/3vbTpABptoKLhg91pELnJ
         ZuB7VbtRpx+HBXi/6wB6WZLOPfNdjpWyFCMJQiN1NG7xXqLQAt3cQH0KBgMiTmqWaWDl
         TLaP3TxZgsfeHl6em2N7yxiTF+tiX72e521bm6Gb7UjxnkW8hG3L0ZbkQZOAvzPTQcE6
         FxIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683058349; x=1685650349;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PxtEaaNRJEnS8gUq7TvU2r4SfUgelfPOgo5JiP3hUpo=;
        b=gafNx7W/0x0SZ8/H7p4j0ljJFgvLYNvvJcc9K0xvOdQ5KYA6xtlwnIJKR3SluA2m+H
         fbEh7mtbQAMLy5dqZ9rC4kR2cm667ebEm5sMPrM8jQVSQJIJNV3sMlvYj6FUVpxlG/ky
         5HQP6cuY7a1mLt7LRlMMIV2MSaCYnzDbcl0LiLIgASkgaBgQSs12T+Y58MFxSJs4JILJ
         s8rPQ+Jit4ZhBr6voGrKwNSEVqe0U9qbsi3CPbTkqt7Ci7ecww13DapMBleIRD6M/hoJ
         BYIL12r/sjo7/S6uWRGfNsQUFGIgcApSF/rRX9Cnsiy/Vj5g2VSDCWPUIvlcimdvBktw
         k1OQ==
X-Gm-Message-State: AC+VfDy6OSklRFCSpfGoga0jxejiGg2CrLxNkONzmNhfIx2/j37tmfUh
        qJMwSV97wXPKjByP4gKU+AAgdpC6+tomUQ==
X-Google-Smtp-Source: ACHHUZ71vmhsscaNHlobIISSRxVBPUvmF6vJFmZpp0ShentSMNd8RVevcFg864koEGGNqYEDfNo3/RpT+CLYXQ==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a25:adcf:0:b0:b9d:894f:c9a8 with SMTP id
 d15-20020a25adcf000000b00b9d894fc9a8mr5202420ybe.0.1683058349442; Tue, 02 May
 2023 13:12:29 -0700 (PDT)
Date:   Tue,  2 May 2023 20:12:17 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230502201220.1756319-1-cmllamas@google.com>
Subject: [PATCH 1/3] Revert "binder_alloc: add missing mmap_lock calls when
 using the VMA"
From:   Carlos Llamas <cmllamas@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Carlos Llamas <cmllamas@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Liam Howlett <liam.howlett@oracle.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        stable@vger.kernel.org
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

This reverts commit 44e602b4e52f70f04620bbbf4fe46ecb40170bde.

This caused a performance regression particularly when pages are getting
reclaimed. We don't need to acquire the mmap_lock to determine when the
binder buffer has been fully initialized. A subsequent patch will bring
back the lockless approach for this.

[cmllamas: resolved trivial conflicts with renaming of alloc->mm]

Fixes: 44e602b4e52f ("binder_alloc: add missing mmap_lock calls when using the VMA")
Cc: Liam Howlett <liam.howlett@oracle.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: stable@vger.kernel.org
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder_alloc.c | 31 ++++++++++---------------------
 1 file changed, 10 insertions(+), 21 deletions(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index 55a3c3c2409f..92c814ec44fe 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -380,15 +380,12 @@ static struct binder_buffer *binder_alloc_new_buf_locked(
 	size_t size, data_offsets_size;
 	int ret;
 
-	mmap_read_lock(alloc->mm);
 	if (!binder_alloc_get_vma(alloc)) {
-		mmap_read_unlock(alloc->mm);
 		binder_alloc_debug(BINDER_DEBUG_USER_ERROR,
 				   "%d: binder_alloc_buf, no vma\n",
 				   alloc->pid);
 		return ERR_PTR(-ESRCH);
 	}
-	mmap_read_unlock(alloc->mm);
 
 	data_offsets_size = ALIGN(data_size, sizeof(void *)) +
 		ALIGN(offsets_size, sizeof(void *));
@@ -916,25 +913,17 @@ void binder_alloc_print_pages(struct seq_file *m,
 	 * Make sure the binder_alloc is fully initialized, otherwise we might
 	 * read inconsistent state.
 	 */
-
-	mmap_read_lock(alloc->mm);
-	if (binder_alloc_get_vma(alloc) == NULL) {
-		mmap_read_unlock(alloc->mm);
-		goto uninitialized;
-	}
-
-	mmap_read_unlock(alloc->mm);
-	for (i = 0; i < alloc->buffer_size / PAGE_SIZE; i++) {
-		page = &alloc->pages[i];
-		if (!page->page_ptr)
-			free++;
-		else if (list_empty(&page->lru))
-			active++;
-		else
-			lru++;
+	if (binder_alloc_get_vma(alloc) != NULL) {
+		for (i = 0; i < alloc->buffer_size / PAGE_SIZE; i++) {
+			page = &alloc->pages[i];
+			if (!page->page_ptr)
+				free++;
+			else if (list_empty(&page->lru))
+				active++;
+			else
+				lru++;
+		}
 	}
-
-uninitialized:
 	mutex_unlock(&alloc->mutex);
 	seq_printf(m, "  pages: %d:%d:%d\n", active, lru, free);
 	seq_printf(m, "  pages high watermark: %zu\n", alloc->pages_high);
-- 
2.40.1.495.gc816e09b53d-goog

