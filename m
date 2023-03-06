Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 626646AD20C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 23:51:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjCFWvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 17:51:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjCFWu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 17:50:57 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8287A5C10B
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 14:50:44 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-536c6ce8d74so115799977b3.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 14:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678143043;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fCs2kW6NCF2FQxv/16BmAeybjQmvN98hsAEGZhfLc7o=;
        b=Pi5j39DnN746rr0nyyIrU+OZA7nt9gA5kRLY8WZEitzZEw84ouQnj7Kd1iOl0qWchx
         Fsfg00plnVHHS60F/Wc6+ccaXAKfjxGnfVpaBAT4bywVH+N2CtSx0nGbHxMpiXZcYn5c
         7dAjjL04g0p4w20e8rC2VpO0wlJPz5IUuzfsclgAC8hVwzJ5khrb/9zdoYrT6XFU5d8P
         Xg98zuA4dN5mdtwBlCeLZLx6kuC0ltkIK4z5Tpescuyukxc37xVqtTe5BPuMka6BKArx
         gCevuBjXleSJjazrchDJ2vVWI3749RNQVNQa4QX8dpKCYRGDb+nHDma40VUPhUcgCdpU
         Yi8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678143043;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fCs2kW6NCF2FQxv/16BmAeybjQmvN98hsAEGZhfLc7o=;
        b=LYjxIlXBzr99UmHG6B5Mf2tXzIOtLhkDH852QN9qPY5/TMGdhIQSVNO8yetmkBU3jt
         uVfIYlPskLJgHzbX31K5/HTGBiC8iUqm56gwr1qhg+ZrqwaInCKQ1M2sIFL/b/vWp9X6
         olzNruQlVJUcL1Rh1rtdpxugxUDsq0B7ncwV/6wyrEf20utlHt5EuGfjaMc/Wh8EvpLi
         7g3XiFAmkoQ9Iugwp+TJhKe0p6VJ/+P5DuDiqAFAleQcrUn1jThfEogmFXbr62VuapyM
         vBCrEhRMJH8Zq0d7X38yYGRUU5E6MPIk24oN1EL9YOYsM/JvDVwwcBH7cABheEbDrIFM
         VonQ==
X-Gm-Message-State: AO0yUKWIpHMKhpP/xqxHu7GRk0oW7Vg6veUy0x8VeA4DLorigEfIpgtk
        jPzTlvFepuduAA/1QRBtWrf+iUSouU4wxm2TorAH
X-Google-Smtp-Source: AK7set+7tWiFs0DhgMxSdJYHm9bwvHmkVPC2lzv1VN4ZzMhIYlRNSGRdQY5JfD8Ssp705gy5eOt8xeE+y9dIHikuTzWR
X-Received: from axel.svl.corp.google.com ([2620:15c:2d4:203:17e9:c330:41ce:6b08])
 (user=axelrasmussen job=sendgmr) by 2002:a05:6902:208:b0:a98:bd27:91de with
 SMTP id j8-20020a056902020800b00a98bd2791demr7381210ybs.7.1678143043755; Mon,
 06 Mar 2023 14:50:43 -0800 (PST)
Date:   Mon,  6 Mar 2023 14:50:24 -0800
In-Reply-To: <20230306225024.264858-1-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20230306225024.264858-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
Message-ID: <20230306225024.264858-6-axelrasmussen@google.com>
Subject: [PATCH v3 5/5] mm: userfaultfd: add UFFDIO_CONTINUE_MODE_WP to
 install WP PTEs
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Nadav Amit <namit@vmware.com>, Peter Xu <peterx@redhat.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     James Houghton <jthoughton@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Axel Rasmussen <axelrasmussen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UFFDIO_COPY already has UFFDIO_COPY_MODE_WP, so when installing a new
PTE to resolve a missing fault, one can install a write-protected one.
This is useful when using UFFDIO_REGISTER_MODE_{MISSING,WP} in
combination.

So, add an analogous UFFDIO_CONTINUE_MODE_WP, which does the same thing
but for *minor* faults.

Update the selftest to do some very basic exercising of the new flag.

Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 fs/userfaultfd.c                         | 8 ++++++--
 include/linux/userfaultfd_k.h            | 2 +-
 include/uapi/linux/userfaultfd.h         | 7 +++++++
 mm/userfaultfd.c                         | 5 +++--
 tools/testing/selftests/mm/userfaultfd.c | 4 ++++
 5 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 984b63b0fc75..b5750e20ae00 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1859,6 +1859,7 @@ static int userfaultfd_continue(struct userfaultfd_ctx *ctx, unsigned long arg)
 	struct uffdio_continue uffdio_continue;
 	struct uffdio_continue __user *user_uffdio_continue;
 	struct uffdio_range range;
+	int flags = 0;
 
 	user_uffdio_continue = (struct uffdio_continue __user *)arg;
 
@@ -1881,12 +1882,15 @@ static int userfaultfd_continue(struct userfaultfd_ctx *ctx, unsigned long arg)
 	/* double check for wraparound just in case. */
 	if (range.start + range.len <= range.start)
 		goto out;
-	if (uffdio_continue.mode & ~UFFDIO_CONTINUE_MODE_DONTWAKE)
+	if (uffdio_continue.mode & ~(UFFDIO_CONTINUE_MODE_DONTWAKE |
+				     UFFDIO_CONTINUE_MODE_WP))
 		goto out;
+	if (uffdio_continue.mode & UFFDIO_CONTINUE_MODE_WP)
+		flags |= MFILL_ATOMIC_WP;
 
 	if (mmget_not_zero(ctx->mm)) {
 		ret = mfill_atomic_continue(ctx->mm, &range,
-					    &ctx->mmap_changing);
+					    &ctx->mmap_changing, flags);
 		mmput(ctx->mm);
 	} else {
 		return -ESRCH;
diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index fcd95e3d3dcd..d691f898bae2 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -71,7 +71,7 @@ extern ssize_t mfill_atomic_zeropage(struct mm_struct *dst_mm,
 				     atomic_t *mmap_changing);
 extern ssize_t mfill_atomic_continue(struct mm_struct *dst_mm,
 				     const struct uffdio_range *dst,
-				    atomic_t *mmap_changing);
+				    atomic_t *mmap_changing, int flags);
 extern int mwriteprotect_range(struct mm_struct *dst_mm,
 			       const struct uffdio_range *range,
 			       bool enable_wp, atomic_t *mmap_changing);
diff --git a/include/uapi/linux/userfaultfd.h b/include/uapi/linux/userfaultfd.h
index 005e5e306266..14059a0861bf 100644
--- a/include/uapi/linux/userfaultfd.h
+++ b/include/uapi/linux/userfaultfd.h
@@ -297,6 +297,13 @@ struct uffdio_writeprotect {
 struct uffdio_continue {
 	struct uffdio_range range;
 #define UFFDIO_CONTINUE_MODE_DONTWAKE		((__u64)1<<0)
+	/*
+	 * UFFDIO_CONTINUE_MODE_WP will map the page write protected on
+	 * the fly.  UFFDIO_CONTINUE_MODE_WP is available only if the
+	 * write protected ioctl is implemented for the range
+	 * according to the uffdio_register.ioctls.
+	 */
+#define UFFDIO_CONTINUE_MODE_WP			((__u64)1<<1)
 	__u64 mode;
 
 	/*
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 870e7489e8d1..6adbfc8dc277 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -691,10 +691,11 @@ ssize_t mfill_atomic_zeropage(struct mm_struct *dst_mm,
 
 ssize_t mfill_atomic_continue(struct mm_struct *dst_mm,
 			      const struct uffdio_range *dst,
-			      atomic_t *mmap_changing)
+			      atomic_t *mmap_changing,
+			      int flags)
 {
 	return mfill_atomic(dst_mm, 0, dst,
-			    mmap_changing, MFILL_ATOMIC_CONTINUE);
+			    mmap_changing, flags | MFILL_ATOMIC_CONTINUE);
 }
 
 long uffd_wp_range(struct vm_area_struct *dst_vma,
diff --git a/tools/testing/selftests/mm/userfaultfd.c b/tools/testing/selftests/mm/userfaultfd.c
index 7f22844ed704..41c1f9abc481 100644
--- a/tools/testing/selftests/mm/userfaultfd.c
+++ b/tools/testing/selftests/mm/userfaultfd.c
@@ -585,6 +585,8 @@ static void continue_range(int ufd, __u64 start, __u64 len)
 	req.range.start = start;
 	req.range.len = len;
 	req.mode = 0;
+	if (test_uffdio_wp)
+		req.mode |= UFFDIO_CONTINUE_MODE_WP;
 
 	if (ioctl(ufd, UFFDIO_CONTINUE, &req))
 		err("UFFDIO_CONTINUE failed for address 0x%" PRIx64,
@@ -1332,6 +1334,8 @@ static int userfaultfd_minor_test(void)
 	uffdio_register.range.start = (unsigned long)area_dst_alias;
 	uffdio_register.range.len = nr_pages * page_size;
 	uffdio_register.mode = UFFDIO_REGISTER_MODE_MINOR;
+	if (test_uffdio_wp)
+		uffdio_register.mode |= UFFDIO_REGISTER_MODE_WP;
 	if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register))
 		err("register failure");
 
-- 
2.40.0.rc0.216.gc4246ad0f0-goog

