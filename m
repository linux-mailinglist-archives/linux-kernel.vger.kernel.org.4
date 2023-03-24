Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A31E6C8114
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 16:22:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232326AbjCXPWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 11:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231806AbjCXPWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 11:22:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1754E144B0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 08:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679671296;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RwIl1QSNvzkLS9Sxxe5+7dE+ydIew8YzAZjo7jsngNU=;
        b=cbNUE6Sc9lnh/KCWD0ipA8U4nJ5J7//06QP2ml8u88Bjv9YQqRtpn2+6pab3HOuxgCErAU
        E3db2bHAm44hkTOmGSSjcqB1XnmaYnEze8e/71QRx8kw+Ngvoq9/eiW4NlYMU+H3zb8BSk
        3MnRRJMKbgqNZS3P0JzcHddsp9+Pn1o=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-vCAGJAugN_-07-G9WLdsFA-1; Fri, 24 Mar 2023 11:21:25 -0400
X-MC-Unique: vCAGJAugN_-07-G9WLdsFA-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-5aae34d87f7so1123416d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 08:21:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679671285;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RwIl1QSNvzkLS9Sxxe5+7dE+ydIew8YzAZjo7jsngNU=;
        b=PpG6KsZXmjibRJa6KcfxQKPO3bP1TRRvxEH2rtbqHmwvqBogqkbMv/f9XeA6hMJd7S
         n61kE6quiKeawWdrVU+3web8AAF1+oaf6dSc+rvGOOdJhr3QY0h9m00EHGA626ygeezT
         0ROGfczFr4pzljSZ8l07wysThg9HC37VqsWRW3dmvhg2hke8y9Ac+fkhfeSWFfdnWalt
         IRNwB8Z90drOD++78B901ajpFuDj2yXMXWaOwUgcyo9ZpUBgZsoV9LskWp7Mb3f8+lzO
         H1H3EcMmB1lhEbUjh3tpxvrhQp86Q7ksYQncIUAgxf55e67WEI1mWePsLF69K0EprUco
         0R+g==
X-Gm-Message-State: AAQBX9fmvbrC9b2HklbtdjVrmiut0LTTce+uV46scQLpyEGhXcHRgwF9
        pwFHcP6CE0vbhGEw3k/BwlbWTZrTJK2laHhSPOb9SPVMimhGLOrmX3l9um/SMh9hcoIz+YAlV6H
        1QQLmoD4tMLrOmcjBUTFYJCVS
X-Received: by 2002:a05:6214:4004:b0:5da:b965:1efe with SMTP id kd4-20020a056214400400b005dab9651efemr2961684qvb.4.1679671285432;
        Fri, 24 Mar 2023 08:21:25 -0700 (PDT)
X-Google-Smtp-Source: AKy350Yh3EX2TBM32j7Q3MeOBZCe4bgG3votqEqto8U63meOgC0P9tIDTYjcwKiQFIXCo2UstG63RA==
X-Received: by 2002:a05:6214:4004:b0:5da:b965:1efe with SMTP id kd4-20020a056214400400b005dab9651efemr2961642qvb.4.1679671285172;
        Fri, 24 Mar 2023 08:21:25 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id do8-20020a056214096800b005dd8b9345dasm764403qvb.114.2023.03.24.08.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 08:21:24 -0700 (PDT)
Date:   Fri, 24 Mar 2023 11:21:22 -0400
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Nadav Amit <nadav.amit@gmail.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v4 1/2] mm/uffd: UFFD_FEATURE_WP_UNPOPULATED
Message-ID: <ZB2/8jPhD3fpx5U8@x1n>
References: <20230309223711.823547-1-peterx@redhat.com>
 <20230309223711.823547-2-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="PrVZmVHSrLNPnUcY"
Content-Disposition: inline
In-Reply-To: <20230309223711.823547-2-peterx@redhat.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PrVZmVHSrLNPnUcY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Thu, Mar 09, 2023 at 05:37:10PM -0500, Peter Xu wrote:
> This is a new feature that controls how uffd-wp handles none ptes.  When
> it's set, the kernel will handle anonymous memory the same way as file
> memory, by allowing the user to wr-protect unpopulated ptes.

[...]

Hi, Andrew,

Could you add a fixup to this patch as attached?  It contains two comment
changes suggested by David, and also a oneliner fix to khugepaged (to bail
out anon thp collapsing when seeing pte markers).  The latter one was
something I spot only later on.

Thanks,

-- 
Peter Xu

--PrVZmVHSrLNPnUcY
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment;
	filename="0001-fixup-mm-uffd-UFFD_FEATURE_WP_UNPOPULATED.patch"

From 085596bc8913349cbeb3ec3303815f71f1a34d89 Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Tue, 21 Mar 2023 16:09:26 -0400
Subject: [PATCH] fixup! mm/uffd: UFFD_FEATURE_WP_UNPOPULATED

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 Documentation/admin-guide/mm/userfaultfd.rst | 2 +-
 mm/khugepaged.c                              | 2 +-
 mm/mprotect.c                                | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/mm/userfaultfd.rst b/Documentation/admin-guide/mm/userfaultfd.rst
index 16843d5a4f65..7c304e432205 100644
--- a/Documentation/admin-guide/mm/userfaultfd.rst
+++ b/Documentation/admin-guide/mm/userfaultfd.rst
@@ -226,7 +226,7 @@ For anonymous memory, ``ioctl(UFFDIO_WRITEPROTECT)`` will ignore none ptes
 (e.g. when pages are missing and not populated).  For file-backed memories
 like shmem and hugetlbfs, none ptes will be write protected just like a
 present pte.  In other words, there will be a userfaultfd write fault
-message generated when writting to a missing page on file typed memories,
+message generated when writing to a missing page on file typed memories,
 as long as the page range was write-protected before.  Such a message will
 not be generated on anonymous memories by default.
 
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index bdde0a02811b..2a5372c49b82 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1283,7 +1283,7 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
 				 * enabled swap entries.  Please see
 				 * comment below for pte_uffd_wp().
 				 */
-				if (pte_swp_uffd_wp(pteval)) {
+				if (pte_swp_uffd_wp_any(pteval)) {
 					result = SCAN_PTE_UFFD_WP;
 					goto out_unmap;
 				}
diff --git a/mm/mprotect.c b/mm/mprotect.c
index e27bbd0fde6f..b9da9a5f87fe 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -329,8 +329,8 @@ static inline int pmd_none_or_clear_bad_unless_trans_huge(pmd_t *pmd)
 }
 
 /*
- * Return true if we want to split huge thps in change protection
- * procedure, false otherwise.
+ * Return true if we want to split THPs into PTE mappings in change
+ * protection procedure, false otherwise.
  */
 static inline bool
 pgtable_split_needed(struct vm_area_struct *vma, unsigned long cp_flags)
-- 
2.39.1


--PrVZmVHSrLNPnUcY--

