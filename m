Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4556C43E3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 08:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjCVHN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 03:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjCVHNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 03:13:16 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B22F10406
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 00:13:14 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id m2so15951758wrh.6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 00:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679469192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6V65cLUX2xeh+2N2Uvy0EZnP8d1je6ufa1jMbqVjM6A=;
        b=eYs5xqSPmMEgQfGjpDiC1O/TEI4F34/TS+CptIoVWwDLTmFaX5Gi6zYIBTkFYVfEs7
         jnUiYNwbuhtlc3ihu+38eZchK6OG0cemBxMeBLRyanu92lnJCAQz8B4jQYmxzUyZK9Bd
         FFAFR6inDRSQJTpm+swOqW8zwKIX+ADzuMFM5z1y/QY01xETXhhx1mnV5cuG0X/0txzZ
         E0MHtIyQ7HYYHLosQ5EdXJiufL2l1Bsj8jRyi3p51RHqLbx2HGZHpplcCkf7GDAyiY+b
         n0QM3WehGKxUcxJ0FW24k6a55Ubg9UcQVWtmO8/TBTBacp+ynOkr9/rBPbmP/6jswVfb
         7JPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679469192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6V65cLUX2xeh+2N2Uvy0EZnP8d1je6ufa1jMbqVjM6A=;
        b=YFcal5GkcpOt5LFzNY9i3eZF3/YM+5PgZhZCsUjomQ0RlKJoEhu2mOEfXY5MpWC6GR
         B/71SooZwCRD02LWDC7acu0BY3VbeXINzF1hi79+EYQgDx5hw7/XW/bQWuJOrzKa1Ccn
         D+FToaNG8i8/qAaEzpZQmFXM5exWNm4PcKsSW4tlx3F8qinkc87K24orkLVYAX+5JjZ/
         9AgVDn6B9ui7H54OAPvzR44Cqe0OFBdpwh3jxVgIiV4YF/fRxfdYDSyZTjmw8XX+eGTw
         94lQ2tgdCMUwodyVWXodcZybWGLWEvFPl86gcd3k/Kk08h98abYAN22D1yAFtVFBPK7B
         foYw==
X-Gm-Message-State: AO0yUKVCXmoX3T4Aztdl7fmcsQbcdqkx7wiPphczApSBte8OcT/P7w5i
        N4jgTouRrkueUeOAVpHMRRo=
X-Google-Smtp-Source: AK7set+SUkTDrSR7EEwrLnc4ekdxQxI6HDvm9VBHUhBXpanAcTysAjoFazHussT1sGpTaf1Hni0UbA==
X-Received: by 2002:a5d:61ce:0:b0:2cf:3a99:9c1e with SMTP id q14-20020a5d61ce000000b002cf3a999c1emr4275633wrv.49.1679469192544;
        Wed, 22 Mar 2023 00:13:12 -0700 (PDT)
Received: from lucifer.home (host86-146-209-214.range86-146.btcentralplus.com. [86.146.209.214])
        by smtp.googlemail.com with ESMTPSA id u4-20020a5d4344000000b002c5526234d2sm13290279wrr.8.2023.03.22.00.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 00:13:11 -0700 (PDT)
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        maple-tree@lists.infradead.org, Vernon Yang <vernon2gm@gmail.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH v3 3/4] mm/mmap/vma_merge: explicitly assign res, vma, extend invariants
Date:   Wed, 22 Mar 2023 07:13:03 +0000
Message-Id: <a88bff4cee88232027bf6356a6c3e265600521d4.1679468982.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1679468982.git.lstoakes@gmail.com>
References: <cover.1679468982.git.lstoakes@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously, vma was an uninitialised variable which was only definitely
assigned as a result of the logic covering all possible input cases - for
it to have remained uninitialised, prev would have to be NULL, and next
would _have_ to be mergeable.

The value of res defaults to NULL, so we can neatly eliminate the
assignment to res and vma in the if (prev) block and ensure that both res
and vma are both explicitly assigned, by just setting both to prev.

In addition we add an explanation as to under what circumstances both might
change, and since we absolutely do rely on addr == curr->vm_start should
curr exist, assert that this is the case.

Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 mm/mmap.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index dbdbb92493b2..2a4f63716231 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -911,7 +911,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 {
 	pgoff_t pglen = (end - addr) >> PAGE_SHIFT;
 	pgoff_t vma_pgoff;
-	struct vm_area_struct *curr, *next, *res = NULL;
+	struct vm_area_struct *curr, *next, *res;
 	struct vm_area_struct *vma, *adjust, *remove, *remove2;
 	int err = -1;
 	bool merge_prev = false;
@@ -939,14 +939,18 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 	else
 		next = NULL;		/* case 5 */
 
-	/* verify some invariant that must be enforced by the caller */
+	/*
+	 * By default, we return prev. Cases 3, 4, 8 will instead return next
+	 * and cases 3, 8 will also update vma to point at next.
+	 */
+	res = vma = prev;
+
+	/* Verify some invariant that must be enforced by the caller. */
 	VM_WARN_ON(prev && addr <= prev->vm_start);
-	VM_WARN_ON(curr && end > curr->vm_end);
+	VM_WARN_ON(curr && (addr != curr->vm_start || end > curr->vm_end));
 	VM_WARN_ON(addr >= end);
 
 	if (prev) {
-		res = prev;
-		vma = prev;
 		vma_start = prev->vm_start;
 		vma_pgoff = prev->vm_pgoff;
 		/* Can we merge the predecessor? */
@@ -957,6 +961,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 			vma_prev(vmi);
 		}
 	}
+
 	/* Can we merge the successor? */
 	if (next && mpol_equal(policy, vma_policy(next)) &&
 	    can_vma_merge_before(next, vm_flags,
@@ -997,6 +1002,10 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 			adj_start = -(prev->vm_end - addr);
 			err = dup_anon_vma(next, prev);
 		} else {
+			/*
+			 * Note that cases 3 and 8 are the ONLY ones where prev
+			 * is permitted to be (but is not necessarily) NULL.
+			 */
 			vma = next;			/* case 3 */
 			vma_start = addr;
 			vma_end = next->vm_end;
-- 
2.39.2

