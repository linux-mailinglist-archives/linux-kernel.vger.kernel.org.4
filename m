Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4C106E0E3C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 15:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbjDMNNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 09:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbjDMNNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 09:13:00 -0400
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70312A5F6
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 06:12:39 -0700 (PDT)
Received: by mail-ed1-x549.google.com with SMTP id q27-20020a50aa9b000000b00505034ae370so2883120edc.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 06:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681391558; x=1683983558;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5hl8mLgZ8vfFyAYGSuilKL0D92tfM3tv959zGBlMPY8=;
        b=3g3kcnsZVl5BwzCD7l2Xo768ttu3qPYULVrQMP5xF9enWn5TBU3XzrzUhG/7hwEHQA
         wPLn47/ryUIDarxbfs0tE7kinLwqMnxfwdQc9Q1dUN8JcWR+QRB1dpnx08/iFWkqR2Lk
         NNSidDbqp2G1GtnwG23rwxGljSRZFninLhww6HZAy1DTUk234ZDJBq5flP+4WWjmWQM+
         8Uix+/hEB8gXaepnyyxnUvHwpTRRtrP74mMwqCZz1CP5JVkB4+8uXG6l4d4BkgTOte8D
         7KhEZEdSO9t3ZrKdlBLF64cImCAAa1EQIUDgwpJ1BLBeNAApg6yCW8UH9Z6PPH58aN5H
         kJPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681391558; x=1683983558;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5hl8mLgZ8vfFyAYGSuilKL0D92tfM3tv959zGBlMPY8=;
        b=OEcGR5tsYKj8P6TQO5wsBYUIHTGm0JXfSjo556OfWxx2GCOMNVcW418PlIHwGXm4lg
         UcVhfmhiRqQj9yQy3Uo3oCRtiNrNcYi7cquDbo5ZhkkwhIvto25RsyUUer4PFMF8jM4m
         EjZJS+gunNnolKMuJZrAsyGbPlZkknrBJbfoUQ7yD9L/EygmowW8OTdadAegFcEhaqjS
         fuqlVJRBgaz7EaYfs5dx80l0NI6mEl61OVRWj+Hxyo1shv+Kp/sQeVnHhdg+vuqjZlPB
         NiUyLvSNCb46XwHkK4WzCq04A1OYc2KbSCNNhEMTsxkUyfIhP6YbrbaK7GBhgtvL1ECG
         uO6g==
X-Gm-Message-State: AAQBX9cOLnlWAdYQhb1cj2tuPQHB8tyREua2NksXCEe+8FcxKXtJYqBC
        WQSaVHR9PTwq6/D1K4yIP10xAATdodI=
X-Google-Smtp-Source: AKy350a9ouyXSsvTMFtTTTvt+/1HR6+68HAPE3D8GNHQDJB5FXfIXg3IfKHFWgMSoRb1WkwpEEN+s/qJiXc=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:eb2b:4d7d:1d7f:9316])
 (user=glider job=sendgmr) by 2002:a17:906:3091:b0:94a:a6ac:8a2d with SMTP id
 17-20020a170906309100b0094aa6ac8a2dmr1265450ejv.13.1681391557908; Thu, 13 Apr
 2023 06:12:37 -0700 (PDT)
Date:   Thu, 13 Apr 2023 15:12:23 +0200
In-Reply-To: <20230413131223.4135168-1-glider@google.com>
Mime-Version: 1.0
References: <20230413131223.4135168-1-glider@google.com>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
Message-ID: <20230413131223.4135168-4-glider@google.com>
Subject: [PATCH v2 4/4] mm: apply __must_check to vmap_pages_range_noflush()
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com
Cc:     urezki@gmail.com, hch@infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, elver@google.com,
        dvyukov@google.com, kasan-dev@googlegroups.com,
        Dipanjan Das <mail.dipanjan.das@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To prevent errors when vmap_pages_range_noflush() or
__vmap_pages_range_noflush() silently fail (see the link below for an
example), annotate them with __must_check so that the callers do not
unconditionally assume the mapping succeeded.

Reported-by: Dipanjan Das <mail.dipanjan.das@gmail.com>
Link: https://lore.kernel.org/linux-mm/CANX2M5ZRrRA64k0hOif02TjmY9kbbO2aCBPyq79es34RXZ=cAw@mail.gmail.com/
Signed-off-by: Alexander Potapenko <glider@google.com>
---
 mm/internal.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 7920a8b7982ec..a646cf7c41e8a 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -833,20 +833,20 @@ size_t splice_folio_into_pipe(struct pipe_inode_info *pipe,
  * mm/vmalloc.c
  */
 #ifdef CONFIG_MMU
-int vmap_pages_range_noflush(unsigned long addr, unsigned long end,
-                pgprot_t prot, struct page **pages, unsigned int page_shift);
+int __must_check vmap_pages_range_noflush(unsigned long addr, unsigned long end,
+		pgprot_t prot, struct page **pages, unsigned int page_shift);
 #else
 static inline
-int vmap_pages_range_noflush(unsigned long addr, unsigned long end,
-                pgprot_t prot, struct page **pages, unsigned int page_shift)
+int __must_check vmap_pages_range_noflush(unsigned long addr, unsigned long end,
+		pgprot_t prot, struct page **pages, unsigned int page_shift)
 {
 	return -EINVAL;
 }
 #endif
 
-int __vmap_pages_range_noflush(unsigned long addr, unsigned long end,
-			       pgprot_t prot, struct page **pages,
-			       unsigned int page_shift);
+int __must_check __vmap_pages_range_noflush(
+	unsigned long addr, unsigned long end, pgprot_t prot,
+	struct page **pages, unsigned int page_shift);
 
 void vunmap_range_noflush(unsigned long start, unsigned long end);
 
-- 
2.40.0.577.gac1e443424-goog

