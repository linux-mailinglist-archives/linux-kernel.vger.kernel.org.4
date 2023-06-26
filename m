Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B347173EC08
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 22:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjFZUqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 16:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbjFZUqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 16:46:22 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A129198C
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 13:46:17 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fa99742bd1so12472205e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 13:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687812376; x=1690404376;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2gaBnNp5IBEywyARaUu76L5/AmouMcYydCft2iETs/w=;
        b=Z1uS+WpdhZxDdhL8sris3m1/L9QbHq0SHLWsGQwnXANleHoAyDYRhYh1WRtfU5y/TW
         x1kAYzGFzqawHRlabWEV4rsr9Wctw4yhgdFlRQMukZgOXD6RH+VPQDrCidrf/QR7u636
         edAgMbP0v0zoNZdDbdx6WuWMOhPbi3Z02IZtc7OXr+3g9A+Z1L8gNs99ErJQept0HmnH
         XHuTVLZ7knD8orstCeXrk43WVXUo4jXZzIoytpmEEkSljL7sYRjkGbKX2KH2XNLQ2XDF
         NxMPxeSC83ITv0h3cLQGqzFefWq1sapQyQDVA3IopTwUfkNmvlHUV9EYhL5da4DzA5f3
         vsmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687812376; x=1690404376;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2gaBnNp5IBEywyARaUu76L5/AmouMcYydCft2iETs/w=;
        b=VcoZDGfUDf0/1NwHQ4QiJNrfWU3t1hKitpQgwhB3uwqwiAPjtWDQGmyJBFL887G3FO
         sDA7paJBdToYmQgGNWYnykjimtJN+4qobMU+X4YFXoRsxTzkc9Hm11IpLC/lN9knTA3x
         XBU3qek0Cn+lPSrmTtGkVY0QIdkem8wOIKdtFdLeR+pLKIKPwnv35cFKulcY4HtwF29E
         UC1iBRb1P0tE21I8K1StkwZLTnHbeaetQrJpVdYpwc9ODSXC0NyBaLDGDVFy5uNdkEU8
         moAmDyjH5p5zMWhN5L5x69z+0s1wP0CAfuE3YmI3SW9PTTVCHN1u5bjVzN8oF47enUOm
         KJEw==
X-Gm-Message-State: AC+VfDxwW6g+YZ3hebO7begUeKW6htLwh0hAa/8gnTZwP5Gru7Q1YvDw
        HJGqLZKM607y3PEZBNs3Xro=
X-Google-Smtp-Source: ACHHUZ4HxYglAVFiYj8XS1l6Cqiegev83efJRSlZtOe9Cet1VjcWI6sSriaz0XBPEDjrnLJze1RASQ==
X-Received: by 2002:a7b:c7c5:0:b0:3fa:9554:fb23 with SMTP id z5-20020a7bc7c5000000b003fa9554fb23mr2756440wmk.21.1687812375494;
        Mon, 26 Jun 2023 13:46:15 -0700 (PDT)
Received: from lucifer.home ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.googlemail.com with ESMTPSA id d11-20020a1c730b000000b003fb416d732csm1111726wmb.6.2023.06.26.13.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 13:46:14 -0700 (PDT)
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH] mm/mprotect: allow unfaulted VMAs to be unaccounted on mprotect()
Date:   Mon, 26 Jun 2023 21:46:12 +0100
Message-ID: <20230626204612.106165-1-lstoakes@gmail.com>
X-Mailer: git-send-email 2.41.0
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

When mprotect() is used to make unwritable VMAs writable, they have the
VM_ACCOUNT flag applied and memory accounted accordingly.

If the VMA has had no pages faulted in and is then made unwritable once
again, it will remain accounted for, despite not being capable of extending
memory usage.

Consider:-

ptr = mmap(NULL, page_size * 3, PROT_READ, MAP_ANON | MAP_PRIVATE, -1, 0);
mprotect(ptr + page_size, page_size, PROT_READ | PROT_WRITE);
mprotect(ptr + page_size, page_size, PROT_READ);

The first mprotect() splits the range into 3 VMAs and the second fails to
merge the three as the middle VMA has VM_ACCOUNT set and the others do not,
rendering them unmergeable.

This is unnecessary, since no pages have actually been allocated and the
middle VMA is not capable of utilising more memory, thereby introducing
unnecessary VMA fragmentation (and accounting for more memory than is
necessary).

Since we cannot efficiently determine which pages map to an anonymous VMA,
we have to be very conservative - determining whether any pages at all have
been faulted in, by checking whether vma->anon_vma is NULL.

We can see that the lack of anon_vma implies that no anonymous pages are
present as evidenced by vma_needs_copy() utilising this on fork to
determine whether page tables need to be copied.

The only place where anon_vma is set NULL explicitly is on fork with
VM_WIPEONFORK set, however since this flag is intended to cause the child
process to not CoW on a given memory range, it is right to interpret this
as indicating the VMA has no faulted-in anonymous memory mapped.

If the VMA was forked without VM_WIPEONFORK set, then anon_vma_fork() will
have ensured that a new anon_vma is assigned (and correctly related to its
parent anon_vma) should any pages be CoW-mapped.

The overall operation is safe against races as we hold a write lock against
mm->mmap_lock.

If we could efficiently look up the VMA's faulted-in pages then we would
unaccount all those pages not yet faulted in. However as the original
comment alludes this simply isn't currently possible, so we remain
conservative and account all pages or none at all.

Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 mm/mprotect.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/mm/mprotect.c b/mm/mprotect.c
index 6f658d483704..9461c936082b 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -607,8 +607,11 @@ mprotect_fixup(struct vma_iterator *vmi, struct mmu_gather *tlb,
 	/*
 	 * If we make a private mapping writable we increase our commit;
 	 * but (without finer accounting) cannot reduce our commit if we
-	 * make it unwritable again. hugetlb mapping were accounted for
-	 * even if read-only so there is no need to account for them here
+	 * make it unwritable again except in the anonymous case where no
+	 * anon_vma has yet been assigned.
+	 *
+	 * hugetlb mapping were accounted for even if read-only so there is
+	 * no need to account for them here.
 	 */
 	if (newflags & VM_WRITE) {
 		/* Check space limits when area turns into data. */
@@ -622,6 +625,9 @@ mprotect_fixup(struct vma_iterator *vmi, struct mmu_gather *tlb,
 				return -ENOMEM;
 			newflags |= VM_ACCOUNT;
 		}
+	} else if ((oldflags & VM_ACCOUNT) && vma_is_anonymous(vma) &&
+		   !vma->anon_vma) {
+		newflags &= ~VM_ACCOUNT;
 	}
 
 	/*
@@ -652,6 +658,9 @@ mprotect_fixup(struct vma_iterator *vmi, struct mmu_gather *tlb,
 	}
 
 success:
+	if ((oldflags & VM_ACCOUNT) && !(newflags & VM_ACCOUNT))
+		vm_unacct_memory(nrpages);
+
 	/*
 	 * vm_flags and vm_page_prot are protected by the mmap_lock
 	 * held in write mode.
-- 
2.41.0

