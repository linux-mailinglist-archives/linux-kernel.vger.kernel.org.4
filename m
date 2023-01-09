Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 866CD6631FA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 21:56:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237765AbjAIU4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 15:56:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237715AbjAIUze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 15:55:34 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 957307458B
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 12:54:32 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id y66-20020a25c845000000b00733b5049b6fso10232847ybf.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 12:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FDedOk4BDhI0jXVeiXMnt29MYEOAHvgEHolCeEtDVh8=;
        b=m9qNPQfvAaSk/cZYvrILeQolkFuo8oX0rPOdz+ZeBZe0viaaMWSs2xM9wojEerSzR9
         Ehc0liLdN4Rf9t9ITHbgyUo/TpjLKodzNOt3cYyWGhisrg0tQj8O7DOpS0TtK3tPQLQG
         qUB/3EWr0qIxJ9v9dQ2Qpf6kyj6P77wOGaZ+XxUB3NlRJ4nvQo0f4D36W3MPMO4ktFMc
         ysLVV5w6Mp+QnxSVtHOQDDwbxZ7kpIUBpnDdTFd6J6q0MuwMTyvve19XzRy6+EFEsY7p
         5CEU/qiYVWTESVV3KMWaGXvUZnEBFFh/Tdv+49ubumcalCQjcVJZu4o8Eo8hhtY4lcfd
         RRGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FDedOk4BDhI0jXVeiXMnt29MYEOAHvgEHolCeEtDVh8=;
        b=OUuTXtNvUDVWu6R5zX/GeqhSGq96BSGhtqdFA7FfooxyTv4V/fh4aO4L/eu/lutw6b
         bMqKwAGut14W14Q0gxn7Hpw3oxWEigGQ2rIVh6lHFwTGNO9Vg74YMMUU+SFSF14HSIJ4
         IvcfK1Jykh/37DOicMA/cF4QjAhwWBzXUK/gAZBX7Fgjyj5LvidiF+tNyG4EDT3FrfqT
         6tJj2Dyttp7k/R4sO1ZBi0rvaj81jZO60/x2VzhsjU6cJOBb1byw1swSxYYgUMmntjpd
         ZTswJMZPj+ltefoDVfNz8/oNeiWalrupZk54p7PpA3bYfy/xIf8U6wgebfqOW8KIiVhc
         t6QA==
X-Gm-Message-State: AFqh2krKGAPZSFn31H5N0Y67TD+OEGt/BsZaciihR/3M2rn61hOOGc0w
        uXTsvpJcQXVo51M9nE8XknvwvuV1EPE=
X-Google-Smtp-Source: AMrXdXvGyOxiOv+MuSWvovzrd0so3mEpN1Edvcx+Z2HBXoeLvz+P6Hw4SXaxw2akuo9mk6+zHwkliVPrxQU=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:9393:6f7a:d410:55ca])
 (user=surenb job=sendgmr) by 2002:a25:1489:0:b0:6fb:ef1e:bb1a with SMTP id
 131-20020a251489000000b006fbef1ebb1amr6925224ybu.168.1673297671808; Mon, 09
 Jan 2023 12:54:31 -0800 (PST)
Date:   Mon,  9 Jan 2023 12:53:15 -0800
In-Reply-To: <20230109205336.3665937-1-surenb@google.com>
Mime-Version: 1.0
References: <20230109205336.3665937-1-surenb@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230109205336.3665937-21-surenb@google.com>
Subject: [PATCH 20/41] mm/mmap: write-lock VMAs in vma_adjust
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        vbabka@suse.cz, hannes@cmpxchg.org, mgorman@techsingularity.net,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        peterz@infradead.org, ldufour@linux.ibm.com,
        laurent.dufour@fr.ibm.com, paulmck@kernel.org, luto@kernel.org,
        songliubraving@fb.com, peterx@redhat.com, david@redhat.com,
        dhowells@redhat.com, hughd@google.com, bigeasy@linutronix.de,
        kent.overstreet@linux.dev, punit.agrawal@bytedance.com,
        lstoakes@gmail.com, peterjung1337@gmail.com, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        jannh@google.com, shakeelb@google.com, tatashin@google.com,
        edumazet@google.com, gthelen@google.com, gurua@google.com,
        arjunroy@google.com, soheil@google.com, hughlynch@google.com,
        leewalsh@google.com, posk@google.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        surenb@google.com
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

vma_adjust modifies a VMA and possibly its neighbors. Write-lock them
before making the modifications.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/mmap.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index f6ca4a87f9e2..1e2154137631 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -614,6 +614,12 @@ inline int vma_expand(struct ma_state *mas, struct vm_area_struct *vma,
  * The following helper function should be used when such adjustments
  * are necessary.  The "insert" vma (if any) is to be inserted
  * before we drop the necessary locks.
+ * 'expand' vma is always locked before it's passed to __vma_adjust()
+ * from vma_merge() because vma should not change from the moment
+ * can_vma_merge_{before|after} decision is made.
+ * 'insert' vma is used only by __split_vma() and it's always a brand
+ * new vma which is not yet added into mm's vma tree, therefore no need
+ * to lock it.
  */
 int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
 	unsigned long end, pgoff_t pgoff, struct vm_area_struct *insert,
@@ -633,6 +639,10 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
 	MA_STATE(mas, &mm->mm_mt, 0, 0);
 	struct vm_area_struct *exporter = NULL, *importer = NULL;
 
+	vma_write_lock(vma);
+	if (next)
+		vma_write_lock(next);
+
 	if (next && !insert) {
 		if (end >= next->vm_end) {
 			/*
@@ -676,8 +686,11 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
 			 * If next doesn't have anon_vma, import from vma after
 			 * next, if the vma overlaps with it.
 			 */
-			if (remove_next == 2 && !next->anon_vma)
+			if (remove_next == 2 && !next->anon_vma) {
 				exporter = next_next;
+				if (exporter)
+					vma_write_lock(exporter);
+			}
 
 		} else if (end > next->vm_start) {
 			/*
@@ -850,6 +863,8 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
 		if (remove_next == 2) {
 			remove_next = 1;
 			next = next_next;
+			if (next)
+				vma_write_lock(next);
 			goto again;
 		}
 	}
-- 
2.39.0

