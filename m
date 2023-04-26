Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4F4D6EF939
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 19:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234874AbjDZRWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 13:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233825AbjDZRWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 13:22:37 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F8276A54;
        Wed, 26 Apr 2023 10:22:33 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f1950f5676so62804405e9.3;
        Wed, 26 Apr 2023 10:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682529752; x=1685121752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GAnZfqczk9XorSugn0T6gsnj6aOYhJlDWU10SzOUFWc=;
        b=GT7A+6XVhCTLKoabJ1xim2dk4pTd5+NYroN+ZOB1LoPgNHTOCnTHlTiIGNW8mtHS+Q
         YmxjVjfsR3n42NINIvTfsHi7pvGHJ+frWb9/mQQmGnjzaI5vLH0XuvYcWG7unDEVzpfp
         0b1ak/id4tsXpOtTzP3OYKaWun2BDVPgJCZeJplHaSwIJMQsU0QxoOCQxmGxSuqPFjNw
         dWhOq+3dqNde/FzFlxiR6O0M/NPXfk1TY4aN2vgYfqLD46Ou4ckk1/RBVWQEdjQ7lR2h
         amx2jSznWhtI2UxI/9T05eivoahzyf2whz/lkZH5KyZ4xxFYRTxVndbfDM+mdX94DmQ2
         hQfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682529752; x=1685121752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GAnZfqczk9XorSugn0T6gsnj6aOYhJlDWU10SzOUFWc=;
        b=YsIbg8ju3XFnyXQESn0MN/mAjK0X42ZTtr0XrLEKZ+TKabESM8g7ku+Dd3BO6rNZQU
         VRHTpGE8TmZcDAvfCeezYMnZE6jklf8EJZMq+izc5zHgT5N8sID+68wGN8dFhCA7e8yQ
         5r7J3CXdXb5/wJYgAtwn4/Pb2tbY9DLzFKLZ5x2fGEj3b1caRQIxHQeQ8ibDSWUNsOgb
         RrAJvNELAHpF20b/qtMZv3/+PW51/iJgrHi0SO1V1bMS+wkqNltSTUlhuqYXEBj8M/7c
         0bFhnsneWB7Tm6gbtYizS7HLqfySZhZ9kwFygtISvGxOdhVVa8FwDXkaAxrKnL/3nv1R
         zJkg==
X-Gm-Message-State: AAQBX9ex081l081FM+dQ7hdTP2LcS4pS/RMoNXBlozzHSXL/nSi3iQgx
        dkJgyxAXl30q6FoZWBHcgZs=
X-Google-Smtp-Source: AKy350bwGtMoDIBt2EKK1gpeuy4xB+KXy2601PoJesHoIiA4uTMMCRVgk3DkVV1JLhJ4GXUawd4BkQ==
X-Received: by 2002:a05:600c:3659:b0:3f0:3ab2:a7e5 with SMTP id y25-20020a05600c365900b003f03ab2a7e5mr14332173wmq.34.1682529751699;
        Wed, 26 Apr 2023 10:22:31 -0700 (PDT)
Received: from localhost.localdomain (host-87-21-14-179.retail.telecomitalia.it. [87.21.14.179])
        by smtp.gmail.com with ESMTPSA id v21-20020a7bcb55000000b003f16f362ae7sm18675613wmj.21.2023.04.26.10.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 10:22:31 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Tyler Hicks <code@tyhicks.com>,
        Christian Brauner <brauner@kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Al Viro <viro@zeniv.linux.org.uk>, ecryptfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH v2 1/3] fs/ecryptfs: Replace kmap() with kmap_local_page()
Date:   Wed, 26 Apr 2023 19:22:21 +0200
Message-Id: <20230426172223.8896-2-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230426172223.8896-1-fmdefrancesco@gmail.com>
References: <20230426172223.8896-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmap() has been deprecated in favor of kmap_local_page().

Therefore, replace kmap() with kmap_local_page() in fs/ecryptfs.

There are two main problems with kmap(): (1) It comes with an overhead as
the mapping space is restricted and protected by a global lock for
synchronization and (2) it also requires global TLB invalidation when the
kmap’s pool wraps and it might block when the mapping space is fully
utilized until a slot becomes available.

With kmap_local_page() the mappings are per thread, CPU local, can take
page faults, and can be called from any context (including interrupts).
It is faster than kmap() in kernels with HIGHMEM enabled. The tasks can
be preempted and, when they are scheduled to run again, the kernel
virtual addresses are restored and still valid.

Obviously, thread locality implies that the kernel virtual addresses
returned by kmap_local_page() are only valid in the context of the
callers (i.e., they cannot be handed to other threads).

The use of kmap_local_page() in fs/ecryptfs does not break the
above-mentioned assumption, so it is allowed and preferred.

Tested in a QEMU/KVM x86_32 VM, 6GB RAM, booting a kernel with
HIGHMEM64GB enabled.

Suggested-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 fs/ecryptfs/crypto.c     | 8 ++++----
 fs/ecryptfs/read_write.c | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
index c16f0d660cb7..03bd55069d86 100644
--- a/fs/ecryptfs/crypto.c
+++ b/fs/ecryptfs/crypto.c
@@ -441,10 +441,10 @@ int ecryptfs_encrypt_page(struct page *page)
 	}
 
 	lower_offset = lower_offset_for_page(crypt_stat, page);
-	enc_extent_virt = kmap(enc_extent_page);
+	enc_extent_virt = kmap_local_page(enc_extent_page);
 	rc = ecryptfs_write_lower(ecryptfs_inode, enc_extent_virt, lower_offset,
 				  PAGE_SIZE);
-	kunmap(enc_extent_page);
+	kunmap_local(enc_extent_virt);
 	if (rc < 0) {
 		ecryptfs_printk(KERN_ERR,
 			"Error attempting to write lower page; rc = [%d]\n",
@@ -490,10 +490,10 @@ int ecryptfs_decrypt_page(struct page *page)
 	BUG_ON(!(crypt_stat->flags & ECRYPTFS_ENCRYPTED));
 
 	lower_offset = lower_offset_for_page(crypt_stat, page);
-	page_virt = kmap(page);
+	page_virt = kmap_local_page(page);
 	rc = ecryptfs_read_lower(page_virt, lower_offset, PAGE_SIZE,
 				 ecryptfs_inode);
-	kunmap(page);
+	kunmap_local(page_virt);
 	if (rc < 0) {
 		ecryptfs_printk(KERN_ERR,
 			"Error attempting to read lower page; rc = [%d]\n",
diff --git a/fs/ecryptfs/read_write.c b/fs/ecryptfs/read_write.c
index 60bdcaddcbe5..5edf027c8359 100644
--- a/fs/ecryptfs/read_write.c
+++ b/fs/ecryptfs/read_write.c
@@ -64,11 +64,11 @@ int ecryptfs_write_lower_page_segment(struct inode *ecryptfs_inode,
 
 	offset = ((((loff_t)page_for_lower->index) << PAGE_SHIFT)
 		  + offset_in_page);
-	virt = kmap(page_for_lower);
+	virt = kmap_local_page(page_for_lower);
 	rc = ecryptfs_write_lower(ecryptfs_inode, virt, offset, size);
 	if (rc > 0)
 		rc = 0;
-	kunmap(page_for_lower);
+	kunmap_local(virt);
 	return rc;
 }
 
@@ -253,11 +253,11 @@ int ecryptfs_read_lower_page_segment(struct page *page_for_ecryptfs,
 	int rc;
 
 	offset = ((((loff_t)page_index) << PAGE_SHIFT) + offset_in_page);
-	virt = kmap(page_for_ecryptfs);
+	virt = kmap_local_page(page_for_ecryptfs);
 	rc = ecryptfs_read_lower(virt, offset, size, ecryptfs_inode);
 	if (rc > 0)
 		rc = 0;
-	kunmap(page_for_ecryptfs);
+	kunmap_local(virt);
 	flush_dcache_page(page_for_ecryptfs);
 	return rc;
 }
-- 
2.40.0

