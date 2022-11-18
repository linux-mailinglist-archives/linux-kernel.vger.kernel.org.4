Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6672F62EAC3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 02:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240951AbiKRBM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 20:12:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240986AbiKRBMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 20:12:24 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A06987545
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 17:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668733847;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xhz/Ckbg8bcdF0GpIUPbn4oL7x6YrFJTnL8UpEBPxx4=;
        b=PkuZEJ3dctm5sHPy0w3qwC0AzBlz0/AQ9WX3wc93hLJEG5SCXOGffUq1Ha3UeEMmECWGuu
        2VCWYFqs5VN+nqQzMmsKJrPXt7ZRQpgoTN/6hldrqld9TzgRbIlCoEbb4OCJXm15wQ3VIj
        xH3e9cLr1Tpc7aqCXWlSWONPCCUZG70=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-121-MEt2zR_RNp-orh1tA5HS4w-1; Thu, 17 Nov 2022 20:10:46 -0500
X-MC-Unique: MEt2zR_RNp-orh1tA5HS4w-1
Received: by mail-qv1-f70.google.com with SMTP id nn2-20020a056214358200b004bb7bc3dfdcso3241055qvb.23
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 17:10:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xhz/Ckbg8bcdF0GpIUPbn4oL7x6YrFJTnL8UpEBPxx4=;
        b=mw5PXbiGBZ4tiD2RruQ229XIWXuDm8NCHB6Qh/LDUMjXB9quLoCp1bZ46jJk/i3hQi
         MRgOrCTNCIozAc16uoIHEgLsFs6EvStCJGcdl1UY/TZ+LalLrW6Osy8pBhH5nKOolF95
         KWcQp4fXUd54wbOTnZGGlYJlSJJQWoTqlUtJvz3pp4BT42GuRrRX0bRhfBz2skDEgyit
         13AZHJ8h66ty66ZcXYnrbs6VlBG+4XbV0V7c4XJxf5PGOOpxbvIbwQRZ09iSnPRMxmjB
         GFCUg4M8JtpNQW1IT38jw1PiH12FdF944i2KqZ5KDiSnakU4ccqqbbf8LxVICpaeSxQ4
         Q5eg==
X-Gm-Message-State: ANoB5pmQQyz3F3AKVBofLsm9ebhEZK6swmNSx3F0psnVFkVhDhApIzQv
        KtThKgjWEBD7raK6eJPJajUxLFR84Jvne6gtS/Bbmy7uJqzhkIxD+szgDs9+dig3FCad8yOVXf0
        KkeRLRAKTOoPPTlhQXUp+xMiy
X-Received: by 2002:a05:620a:a10:b0:6fb:a7e6:96e with SMTP id i16-20020a05620a0a1000b006fba7e6096emr3968828qka.675.1668733844054;
        Thu, 17 Nov 2022 17:10:44 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7dJcHqBiR7Zv4m+XJwPOWgqJH93kZp3F2AOeTKPKZTLrUWczK3rZnxkV5Lt7km6veLvhXYzg==
X-Received: by 2002:a05:620a:a10:b0:6fb:a7e6:96e with SMTP id i16-20020a05620a0a1000b006fba7e6096emr3968816qka.675.1668733843810;
        Thu, 17 Nov 2022 17:10:43 -0800 (PST)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id u7-20020a05620a430700b006eed75805a2sm1491342qko.126.2022.11.17.17.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 17:10:43 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Rik van Riel <riel@surriel.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
        James Houghton <jthoughton@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH RFC v2 10/12] mm/hugetlb: Use hugetlb walker lock in walk_hugetlb_range()
Date:   Thu, 17 Nov 2022 20:10:23 -0500
Message-Id: <20221118011025.2178986-11-peterx@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221118011025.2178986-1-peterx@redhat.com>
References: <20221118011025.2178986-1-peterx@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hugetlb walker lock makes sure the pte_t* won't go away from under us.  One
thing to mention is there're two hugetlb_entry() users that can yield the
thread within hugetlb_entry(), that'll need to add unlock/lock pair around
the yield, meanwhile document hugetlb_entry() explaining the lock for
sleepable hugetlb_entry()s.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/s390/mm/gmap.c      | 2 ++
 fs/proc/task_mmu.c       | 2 ++
 include/linux/pagewalk.h | 9 ++++++++-
 mm/pagewalk.c            | 2 ++
 4 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index 02d15c8dc92e..fb2938e8d1c7 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -2644,7 +2644,9 @@ static int __s390_enable_skey_hugetlb(pte_t *pte, unsigned long addr,
 	end = start + HPAGE_SIZE - 1;
 	__storage_key_init_range(start, end);
 	set_bit(PG_arch_1, &page->flags);
+	hugetlb_walker_unlock();
 	cond_resched();
+	hugetlb_walker_lock();
 	return 0;
 }
 
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 89338950afd3..ed750a52e60b 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1612,7 +1612,9 @@ static int pagemap_hugetlb_range(pte_t *ptep, unsigned long hmask,
 			frame++;
 	}
 
+	hugetlb_walker_unlock();
 	cond_resched();
+	hugetlb_walker_lock();
 
 	return err;
 }
diff --git a/include/linux/pagewalk.h b/include/linux/pagewalk.h
index 959f52e5867d..7fa3724c6eb5 100644
--- a/include/linux/pagewalk.h
+++ b/include/linux/pagewalk.h
@@ -21,7 +21,14 @@ struct mm_walk;
  *			depth is -1 if not known, 0:PGD, 1:P4D, 2:PUD, 3:PMD.
  *			Any folded depths (where PTRS_PER_P?D is equal to 1)
  *			are skipped.
- * @hugetlb_entry:	if set, called for each hugetlb entry
+ * @hugetlb_entry:	if set, called for each hugetlb entry.  Note that
+ *			each pte_t* is protected by hugetlb_walker_lock(),
+ *			and the lock does not allow sleep.  If explicit
+ *			sleep in the entry fn needed, the caller needs to
+ *			release the lock (hugetlb_walker_unlock()), then
+ *			relock it (hugetlb_walker_lock()) before return.
+ *			After the unlock, the pte_t* may become invalid
+ *			anytime so cannot be accessed anymore.
  * @test_walk:		caller specific callback function to determine whether
  *			we walk over the current vma or not. Returning 0 means
  *			"do page table walk over the current vma", returning
diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index 7f1c9b274906..abf310011ab1 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -302,6 +302,7 @@ static int walk_hugetlb_range(unsigned long addr, unsigned long end,
 	const struct mm_walk_ops *ops = walk->ops;
 	int err = 0;
 
+	hugetlb_walker_lock();
 	do {
 		next = hugetlb_entry_end(h, addr, end);
 		pte = huge_pte_offset(walk->mm, addr & hmask, sz);
@@ -314,6 +315,7 @@ static int walk_hugetlb_range(unsigned long addr, unsigned long end,
 		if (err)
 			break;
 	} while (addr = next, addr != end);
+	hugetlb_walker_unlock();
 
 	return err;
 }
-- 
2.37.3

