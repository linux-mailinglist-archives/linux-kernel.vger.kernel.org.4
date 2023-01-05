Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C19D765E13D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 01:03:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235312AbjAEADQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 19:03:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbjAEACq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 19:02:46 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF8F24F
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 16:02:45 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-47ede4426e1so246368757b3.7
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 16:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2FPuHPcUnxQtCWYTvyX7yM9LZ48eFw1C5/KmPQ+TvO4=;
        b=GgBu5oQsImcIXo2jP7+rTsbFZ4J6GJzA5TcGdhDUJdS8FD/izShQCaTVsjwG2A0JZP
         ERqghA7ROAqQONt87t5EX88eZ+Z6V0HVeybU5S8v/4T38LQzdDvbQ6XpZcfg5NLS26h0
         CbNdUqORwKoIeaiNwxnAwy7iVPjfZachw2mtptzLKnoO03ERtPB7QRRu+5zZaX8tLEq+
         li2pWjuFKbfE2/iinlfRWPxfyEEOaMmxA+VJL/T/TT/0djDDmX2M/pEY4ZQD7LbJNmIG
         vf8ZgSMXsu96kFDMsiCn5VFfrsp8j/hSAgkGGTJyNgdJDd4pCXu07HKPYPq5VdXZ55T1
         ZbOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2FPuHPcUnxQtCWYTvyX7yM9LZ48eFw1C5/KmPQ+TvO4=;
        b=qbr+bYXEikqYEdiGMKQ3IFJ3UL5oqs1bqRgjy2ZDt+WcIWsV9/t6M0/5Z2uYk5BB14
         3pWTQWCBfVtpWuZofeBwVMtn86qkl/deWfs96s0+rUVciWpjU+1lHaNd1YY4aKNim2J5
         2LULuhbUgypSRGOq7uT8mOvAoosecXqysiLtfTwUFTILdDyX7R2lcGR17dlvCi0XKdyR
         NsMhuED2sT5BUoW7pqm0W9QMAccM+Fd60bLp1N5UTzvWz1FkLX8oOiF3NZ4kXRsFOMUh
         w+saf/I+In0Ua1jzOOAUZ3ruGgiAQmDXFFQL5Ixa5WMlK7+L9ohT7Pm2t6yy0PVqfvRi
         JibQ==
X-Gm-Message-State: AFqh2krSskP8SuUdVKSfQEMLU8AyZcgSzroFFWNaN7LMEN9xgiT4i+8/
        rwf28PqzAQjXMj2TVRfzZhR7axFcUTs=
X-Google-Smtp-Source: AMrXdXsr3UK5K28malh8jXLRNrBnQiukJ1s7bXmCGqtO7t8FNwysRAsumbMS3uy9IeAkyFJH5qTFQN14A/Q=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:ed06:f432:893:3486])
 (user=surenb job=sendgmr) by 2002:a81:1495:0:b0:465:d978:9724 with SMTP id
 143-20020a811495000000b00465d9789724mr6360883ywu.249.1672876964792; Wed, 04
 Jan 2023 16:02:44 -0800 (PST)
Date:   Wed,  4 Jan 2023 16:02:40 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230105000241.1450843-1-surenb@google.com>
Subject: [PATCH v2 1/1] mm: fix vma->anon_name memory leak for anonymous shmem VMAs
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     hughd@google.com, hannes@cmpxchg.org, david@redhat.com,
        vincent.whitchurch@axis.com, seanjc@google.com, rppt@kernel.org,
        shy828301@gmail.com, pasha.tatashin@soleen.com,
        paul.gortmaker@windriver.com, peterx@redhat.com, vbabka@suse.cz,
        Liam.Howlett@Oracle.com, ccross@google.com, willy@infradead.org,
        arnd@arndb.de, cgel.zte@gmail.com, yuzhao@google.com,
        bagasdotme@gmail.com, suleiman@google.com, steven@liquorix.net,
        heftig@archlinux.org, cuigaosheng1@huawei.com,
        kirill@shutemov.name, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        surenb@google.com,
        syzbot+91edf9178386a07d06a7@syzkaller.appspotmail.com
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

free_anon_vma_name() is missing a check for anonymous shmem VMA which
leads to a memory leak due to refcount not being dropped.  Fix this by
calling anon_vma_name_put() unconditionally. It will free vma->anon_name
whenever it's non-NULL.

Fixes: d09e8ca6cb93 ("mm: anonymous shared memory naming")
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Suggested-by: David Hildenbrand <david@redhat.com>
Reported-by: syzbot+91edf9178386a07d06a7@syzkaller.appspotmail.com
Cc: David Hildenbrand <david@redhat.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
---
applies over mm-hotfixes-unstable branch of
git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tree after reverting
the original version of this patch.

 include/linux/mm_inline.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index e8ed225d8f7c..ff3f3f23f649 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -413,8 +413,7 @@ static inline void free_anon_vma_name(struct vm_area_struct *vma)
 	 * Not using anon_vma_name because it generates a warning if mmap_lock
 	 * is not held, which might be the case here.
 	 */
-	if (!vma->vm_file)
-		anon_vma_name_put(vma->anon_name);
+	anon_vma_name_put(vma->anon_name);
 }
 
 static inline bool anon_vma_name_eq(struct anon_vma_name *anon_name1,
-- 
2.39.0.314.g84b9a713c41-goog

