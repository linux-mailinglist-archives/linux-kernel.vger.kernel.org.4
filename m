Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8982E6EF938
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 19:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233825AbjDZRWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 13:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234539AbjDZRWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 13:22:38 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA5D2659C;
        Wed, 26 Apr 2023 10:22:36 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f09b4a156eso50064575e9.3;
        Wed, 26 Apr 2023 10:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682529755; x=1685121755;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M2lKJ7H2AsnPXnAoRhxC4/QNYeStDrQGHV93BCmG0Qk=;
        b=ovVlK3mUnL5PxCnuMsF/F7CJzQEvkzeNKwTDaOqDQH/wtcEcObY8SZovSARnXzo48D
         5WZatdlcVN53E+ZbOacBVcbhVFASWLOhRce1jZ5uE4T/4GVGyjnNnL2A/IX36gN/BL7R
         /cdnOLqnIR9eHguMRexaSVyeflq/qNCA890EujZEtgTfTq/n95wz6mUnBAxzXdlUezxL
         L9UpfKxqMw5VG0a77bQpHNTWgyZ5RBIFM/YfqxM52mefCxuPMDekYX0oMJCivJPUudQB
         1rh9WusNGV6r5R0TwyrirLUTW5skUTgsX6xxtsZLEjrXJSrxZuW7m1sUEZUkkcm9T+Iz
         1dIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682529755; x=1685121755;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M2lKJ7H2AsnPXnAoRhxC4/QNYeStDrQGHV93BCmG0Qk=;
        b=OOwd27RCUfx8YbkBJGH6JqPs+nwB04dcK3k/0CARtQUJ/X64mZ58vznwzDQOKJCWPg
         UT3VpRo2tKGTuz6cYyrOiCUk4OF3T/fL5E8Vk1IwXXPPl4b/AUn9z5ve3R4N7oufKWss
         tO8XO6rYt6iGF1hrHcvHX033NYPl9oidEXa1qrqE3sBbeKAIa4pPmd/c6e3BoEQuNwIa
         yGosQLA+MI/lN0DoL3EWAvsozM/zcqS8NU9m2xJJb4iUZIpQUxyaF5yY9WBdP35VKmGi
         6SljFvRqzHZevZ8YC+XL1UDnzlwknR5HY8DHx8h3weeg9Oujdrb6AkCAllBrjUejp/h5
         aHrg==
X-Gm-Message-State: AAQBX9f7mj6uJD9xC/Oyh8+9Q5VsBlcCubYRT5sEnYCX0ySapoYWJZI0
        ExyUfa4CfioqefMLjMGoTp6USuVnobE=
X-Google-Smtp-Source: AKy350bQz4xJGQrPbvsHjzNKXIpaf52CPbDK2Xhbosn8rBfTawkRh8ySw5Gxe0HpAI92oL79Y6ErRw==
X-Received: by 2002:a05:600c:378f:b0:3f1:73c8:3a6d with SMTP id o15-20020a05600c378f00b003f173c83a6dmr13831126wmr.12.1682529754983;
        Wed, 26 Apr 2023 10:22:34 -0700 (PDT)
Received: from localhost.localdomain (host-87-21-14-179.retail.telecomitalia.it. [87.21.14.179])
        by smtp.gmail.com with ESMTPSA id v21-20020a7bcb55000000b003f16f362ae7sm18675613wmj.21.2023.04.26.10.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 10:22:34 -0700 (PDT)
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
Subject: [PATCH v2 3/3] fs/ecryptfs: Use kmap_local_page() in copy_up_encrypted_with_header()
Date:   Wed, 26 Apr 2023 19:22:23 +0200
Message-Id: <20230426172223.8896-4-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230426172223.8896-1-fmdefrancesco@gmail.com>
References: <20230426172223.8896-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
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

kmap_atomic() has been deprecated in favor of kmap_local_page().

Therefore, replace kmap_atomic() with kmap_local_page() in
ecryptfs_copy_up_encrypted_with_header().

kmap_atomic() is implemented like a kmap_local_page() which also
disables page-faults and preemption (the latter only in !PREEMPT_RT
kernels). The kernel virtual addresses returned by these two API are
only valid in the context of the callers (i.e., they cannot be handed to
other threads).

With kmap_local_page() the mappings are per thread and CPU local like
in kmap_atomic(); however, they can handle page-faults and can be called
from any context (including interrupts). The tasks that call
kmap_local_page() can be preempted and, when they are scheduled to run
again, the kernel virtual addresses are restored and are still valid.

In ecryptfs_copy_up_encrypted_with_header(), the block of code between
the mapping and un-mapping does not depend on the above-mentioned side
effects of kmap_aatomic(), so that the mere replacements of the old API
with the new one is all that is required (i.e., there is no need to
explicitly call pagefault_disable() and/or preempt_disable()).

Tested in a QEMU/KVM x86_32 VM, 6GB RAM, booting a kernel with
HIGHMEM64GB enabled.

Cc: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 fs/ecryptfs/mmap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ecryptfs/mmap.c b/fs/ecryptfs/mmap.c
index 373c3e5747e6..cb1e998ce54d 100644
--- a/fs/ecryptfs/mmap.c
+++ b/fs/ecryptfs/mmap.c
@@ -125,7 +125,7 @@ ecryptfs_copy_up_encrypted_with_header(struct page *page,
 			/* This is a header extent */
 			char *page_virt;
 
-			page_virt = kmap_atomic(page);
+			page_virt = kmap_local_page(page);
 			memset(page_virt, 0, PAGE_SIZE);
 			/* TODO: Support more than one header extent */
 			if (view_extent_num == 0) {
@@ -138,7 +138,7 @@ ecryptfs_copy_up_encrypted_with_header(struct page *page,
 							       crypt_stat,
 							       &written);
 			}
-			kunmap_atomic(page_virt);
+			kunmap_local(page_virt);
 			flush_dcache_page(page);
 			if (rc) {
 				printk(KERN_ERR "%s: Error reading xattr "
-- 
2.40.0

