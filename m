Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95949663209
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 21:57:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237338AbjAIU5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 15:57:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237690AbjAIU4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 15:56:54 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE598CBC2
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 12:54:51 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id t13-20020a056902018d00b0074747131938so10284629ybh.12
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 12:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=89ITsq4nUiN8d4MMzUNaP/VKvoRvGlIDiLzssAyWMSw=;
        b=nfh/0wSN7du3H+jbnftiNBYsH0L/ZzvAjrQDNKD6/Ux50j22Vuiz0S8HvVp3TvO1vo
         K/T56ndCuYOiwpC071dddEQYgomwd4Y1mEzWyHgdRsI4Zm5Szg4pGbhhjtZTIjjKwBZ2
         DuLjlMuvIIQ0lWiW9Nfxk/1vqmTgUUR+Vpz2r/N+XxIUJS4L6MBvWuo91YhKUizAdsFD
         /Z7UYgJwWP6aH5EHzLl9AB9L/N1SliUIF0AbaZQSGUEgi4Q4Dc2tmxMGPV7cLiqwxdNW
         0MiPjg6rJc2LN6ARMi2zMWyKxfOe4Y81VTcKlWoejCss5A49BpopZcqw0LB7HbZRjJwk
         DoGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=89ITsq4nUiN8d4MMzUNaP/VKvoRvGlIDiLzssAyWMSw=;
        b=DBTBJvVe3+oAwgyt14LIjDrL4HG9CZIfbWtxhCVftB7Pc2Aiw/JZJAplIhi+NxXJZy
         +Ovc4HvfTE/ngRHwXNWUoonRLwKarZ3F6aChRAdzpzqaMDXtudugSv74mgtBEt2ls8sE
         MeuVnQC5H+r2wgwydXTmEtidi4J7AkUeMCQgULXQdBxqQP9z4USQ5g8fdP/7G3jiNXMS
         ggFOMOQ9Dq1zXw7lSNMxLHcgzM4eTVMNgoO1d+VcDfkypcR2c1K3RGOrrl4dY1Yt1qsb
         7a5kB5fAM0vd4SwUq0iQEwcXnBoQI+hOaHiDBR4uh62SqrxmjcfN0beh0LX/D9NBvKBu
         DVig==
X-Gm-Message-State: AFqh2krVtVF/0/dlDb/GmVKGGcNMK2uDqErFld4JVT8dqlKnY1vSF1hL
        gez0thUQVC3HlhECsE93lInml48WlTY=
X-Google-Smtp-Source: AMrXdXvWplK/QqycNgSSdeBDfganGdyEUrMbsmwVLuA4csVljoZeQRUCGyXX2t9p/6nnKr16T46cKc1FR2o=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:9393:6f7a:d410:55ca])
 (user=surenb job=sendgmr) by 2002:a0d:eacb:0:b0:485:126c:3834 with SMTP id
 t194-20020a0deacb000000b00485126c3834mr6100451ywe.360.1673297684211; Mon, 09
 Jan 2023 12:54:44 -0800 (PST)
Date:   Mon,  9 Jan 2023 12:53:20 -0800
In-Reply-To: <20230109205336.3665937-1-surenb@google.com>
Mime-Version: 1.0
References: <20230109205336.3665937-1-surenb@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230109205336.3665937-26-surenb@google.com>
Subject: [PATCH 25/41] mm/mmap: write-lock adjacent VMAs if they can grow into
 unmapped area
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

While unmapping VMAs, adjacent VMAs might be able to grow into the area
being unmapped. In such cases write-lock adjacent VMAs to prevent this
growth.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/mmap.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 0d767ce043af..30c7d1c5206e 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2461,11 +2461,13 @@ do_mas_align_munmap(struct ma_state *mas, struct vm_area_struct *vma,
 	 * down_read(mmap_lock) and collide with the VMA we are about to unmap.
 	 */
 	if (downgrade) {
-		if (next && (next->vm_flags & VM_GROWSDOWN))
+		if (next && (next->vm_flags & VM_GROWSDOWN)) {
+			vma_write_lock(next);
 			downgrade = false;
-		else if (prev && (prev->vm_flags & VM_GROWSUP))
+		} else if (prev && (prev->vm_flags & VM_GROWSUP)) {
+			vma_write_lock(prev);
 			downgrade = false;
-		else
+		} else
 			mmap_write_downgrade(mm);
 	}
 
-- 
2.39.0

