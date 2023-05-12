Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3756FFDE8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 02:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239605AbjELAbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 20:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjELAbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 20:31:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567F255AC
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 17:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683851467;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=GadWHwp50KH9hxb9lEESltKioaCu8cw3tBG7j+NI1MU=;
        b=bi6qAr9GuWIyuG+j1CiPwuKJqvA98vklEQD/QWWJcsEhCUF9MmjskXUc4Gm6Aynt1da5z1
        yp37wfNKpOHfFHO9exzo+NVrktlutvXHsFwtZnx7QHuP33CmgCN7x1Xe4XJP+OCEb/7M5J
        VPlc6g200uPAtKWD7rbtI0fVk+BHt3k=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-SuA8UH45OsaiXJVRmf4XDw-1; Thu, 11 May 2023 20:31:06 -0400
X-MC-Unique: SuA8UH45OsaiXJVRmf4XDw-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-74e23e33f80so96671785a.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 17:31:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683851465; x=1686443465;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GadWHwp50KH9hxb9lEESltKioaCu8cw3tBG7j+NI1MU=;
        b=fk5eM8HifheCEp8zhWJsmV1A+jWssqUBAKMzEanQAQ7ZRi5n39A4jRMangtFf+tr5i
         zm+k08THoZBdnHgDzB2X+aGnYCoYeWgq3qACT+FJGQ7QGiipA9Ad8nNKavyff51Z16vA
         4ijTtRQyQTFjtQvLfm/GKtUoHmlS2b4FvKd/3HG3CMcjApF1KvzhK8zipgTFX9ZB3sZ6
         HZoRcdcLxarXsYoEcnbgHcefhSU35z8YOEr3606AMg4+N7LDhCOf3GFAK1rXehkWuJH0
         k8j/EzstEJN8APooCld0VLXo8Ij3jjWN/X21vkoKdnWhHwvlba/XHBhdOYBEeYv29xVs
         TJ7Q==
X-Gm-Message-State: AC+VfDznqKsu7NEqBPlgSXQ3Tb/QzrFgiNQ6sMIw30gUXJfUjowkiIFX
        loC59e3TaBWZQHTCuJapFsA+MQVCBNKQJRsVSnPrMV5sE+Bc7FCPcHF691qON2tISUBqLdHE2kw
        j1CmY5854bIRT8h4/AKf6Bya+f1f0JyK+
X-Received: by 2002:ac8:5c91:0:b0:3f2:38d:5c84 with SMTP id r17-20020ac85c91000000b003f2038d5c84mr38416138qta.4.1683851464974;
        Thu, 11 May 2023 17:31:04 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4GZ+IEWUFzTh92wkKNXuxaRW1/gPh6xOqwEBKdblJQ8DEN9s4K+2av9EFrKk0/m7CHKrQMlQ==
X-Received: by 2002:ac8:5c91:0:b0:3f2:38d:5c84 with SMTP id r17-20020ac85c91000000b003f2038d5c84mr38416117qta.4.1683851464664;
        Thu, 11 May 2023 17:31:04 -0700 (PDT)
Received: from x1n.. (bras-base-aurron9127w-grc-62-70-24-86-62.dsl.bell.ca. [70.24.86.62])
        by smtp.gmail.com with ESMTPSA id v21-20020a05622a189500b003ef38277445sm1498590qtc.16.2023.05.11.17.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 17:31:04 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Lorenzo Stoakes <lstoakes@gmail.com>, peterx@redhat.com,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH] mm/gup: Fixes FOLL_UNLOCKABLE against FOLL_NOWAIT
Date:   Thu, 11 May 2023 20:31:02 -0400
Message-Id: <20230512003102.3149737-1-peterx@redhat.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a follow up on f04740f54594 ("mm/gup: add FOLL_UNLOCKABLE").

FOLL_NOWAIT is the gup alias of FAULT_FLAG_RETRY_NOWAIT, which means when
FOLL_NOWAIT is set we definitely don't want to release the mmap read lock
when faulting.  It's against the meaning of the newly introduced flag
FOLL_UNLOCKABLE.

E.g., with current code we could at last have FAULT_FLAG_RETRY_NOWAIT set
even if with a FOLL_UNLOCKABLE gup which doesn't make a lot of sense.

Code-wise, it _seems_ all still fine, because when NOWAIT+UNLOCKABLE both
set it'll be the same as old NOWAIT plus FAULT_FLAG_KILLABLE (since luckily
both of them leverage ALLOW_RETRY OTOH), which I don't see a major issue so
far.  So not copying stable or attaching fixes, as there's no immediate
issue found.  Still better clarify the use.

Since at it, the same commit added unconditional FOLL_UNLOCKABLE in
faultin_vma_page_range(), which is code-wise correct becuase the helper
only has one user right now and it always has "locked" set.  However it can
be abused if someone reuse faultin_vma_page_range() in other call sites in
the future.  Add a sanity check for that, also add the missing comment for
UNLOCKABLE.

Cc: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---

This is something I found when I was reading the code alongside only.  I
hope I didn't miss something.
---
 mm/gup.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 90d9b65ff35c..202097627667 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1621,6 +1621,9 @@ long faultin_vma_page_range(struct vm_area_struct *vma, unsigned long start,
 	VM_BUG_ON_VMA(end > vma->vm_end, vma);
 	mmap_assert_locked(mm);
 
+	/* We'll do unconditional FOLL_UNLOCKABLE */
+	VM_WARN_ON_ONCE(!locked);
+
 	/*
 	 * FOLL_TOUCH: Mark page accessed and thereby young; will also mark
 	 *	       the page dirty with FOLL_WRITE -- which doesn't make a
@@ -1629,6 +1632,7 @@ long faultin_vma_page_range(struct vm_area_struct *vma, unsigned long start,
 	 * FOLL_HWPOISON: Return -EHWPOISON instead of -EFAULT when we hit
 	 *		  a poisoned page.
 	 * !FOLL_FORCE: Require proper access permissions.
+	 * FOLL_UNLOCKABLE: Allow the fault to unlock mmap read lock
 	 */
 	gup_flags = FOLL_TOUCH | FOLL_HWPOISON | FOLL_UNLOCKABLE;
 	if (write)
@@ -2334,10 +2338,13 @@ EXPORT_SYMBOL(get_user_pages);
 long get_user_pages_unlocked(unsigned long start, unsigned long nr_pages,
 			     struct page **pages, unsigned int gup_flags)
 {
+	unsigned int extra = FOLL_TOUCH;
 	int locked = 0;
 
-	if (!is_valid_gup_args(pages, NULL, NULL, &gup_flags,
-			       FOLL_TOUCH | FOLL_UNLOCKABLE))
+	if (!(gup_flags & FOLL_NOWAIT))
+		extra |= FOLL_UNLOCKABLE;
+
+	if (!is_valid_gup_args(pages, NULL, NULL, &gup_flags, extra))
 		return -EINVAL;
 
 	return __get_user_pages_locked(current->mm, start, nr_pages, pages,
-- 
2.39.1

