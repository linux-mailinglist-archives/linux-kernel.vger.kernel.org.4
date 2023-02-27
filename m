Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADB876A483B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 18:38:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbjB0RiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 12:38:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbjB0Rhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 12:37:45 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3B5224120
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 09:37:18 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-536be78056eso152392247b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 09:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=h8ePWaoI68GEISPuC9Ge+4qXkO8FW2G00MOJpn9vfbw=;
        b=MCQ0c4ia6IOTYMEFJR7GcbSkx2aCS+J3n3kLqdT/eCneA5RnZIfOSsLVqqbhg8oV3C
         z6a/cjMHL2s70DKPWTui5sWqdtSoRO2Sa3X/ZDXnFAdUlSIwaWZO5o28PzA9YRicQEsL
         lrmb7xLSeO5Upy8PojNo03zIknEUlOaIGEk3GY2vDeeMswBskS1b7cfH1kyMJjq2FiTa
         EPOOWdtU+2jcY+efHi/NzqtHu6KIrndJCcMf9jiuRTBG5FPDsaXOxEi35OK/QcXUq7OH
         bWHqrLVOAQNuSwHdqjlfEqvb31BygBYoGvuY/kisE56Bi1ONNPXA+NnMTkKqBCgcNMjA
         jbEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h8ePWaoI68GEISPuC9Ge+4qXkO8FW2G00MOJpn9vfbw=;
        b=NY7LEFwc1vGVA77aOtp2hjNZxLVNpSbdpk6+MZEbc5uo989LxxNT4m+0kEkPnyM/Z4
         vpfrDkUxDzKATM3/5qDN50qUfu41o1lNeWozqkFmMhTRlP+Y9m+JDKSlGXV6JTT8WKWj
         D+CCRo/7CpYN6mZxpitHUSCub74pFgAEAG/2NkO8dSzoCbxKsorNWMzgYHe7cGDHoYGY
         sSCLW74foZ7921lJ149xWMHaU4t1UDmWV32yX4vTMBjkVwzL87UWjL2Vb4PTUZdGW8Cx
         AWMBEMsufn5qseHJfM/2007m9/dQ8Er7NSj+/gPCda2+yUFTCwokvJfcyQzwR5gwj6A9
         B9KQ==
X-Gm-Message-State: AO0yUKXsNdmkm3PQIP9zyZ9XKqKnMmjfeQB1OCZcNPF/ksZK3Q5H1XD6
        SRZCSDHe/fOQ6yp+IDPejsslXNAh0yU=
X-Google-Smtp-Source: AK7set9am1xybr1j78qWLG/uhzYsiBlXA8SkEZQ4RtcwObl9A6wj5gHEFg0gqcEhjrM4bOMvHErmcMX4UGI=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:e1f6:21d1:eead:3897])
 (user=surenb job=sendgmr) by 2002:a5b:84b:0:b0:a09:32fb:be73 with SMTP id
 v11-20020a5b084b000000b00a0932fbbe73mr9490924ybq.0.1677519434899; Mon, 27 Feb
 2023 09:37:14 -0800 (PST)
Date:   Mon, 27 Feb 2023 09:36:15 -0800
In-Reply-To: <20230227173632.3292573-1-surenb@google.com>
Mime-Version: 1.0
References: <20230227173632.3292573-1-surenb@google.com>
X-Mailer: git-send-email 2.39.2.722.g9855ee24e9-goog
Message-ID: <20230227173632.3292573-17-surenb@google.com>
Subject: [PATCH v4 16/33] mm/mmap: write-lock VMAs in vma_prepare before
 modifying them
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        vbabka@suse.cz, hannes@cmpxchg.org, mgorman@techsingularity.net,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        peterz@infradead.org, ldufour@linux.ibm.com, paulmck@kernel.org,
        mingo@redhat.com, will@kernel.org, luto@kernel.org,
        songliubraving@fb.com, peterx@redhat.com, david@redhat.com,
        dhowells@redhat.com, hughd@google.com, bigeasy@linutronix.de,
        kent.overstreet@linux.dev, punit.agrawal@bytedance.com,
        lstoakes@gmail.com, peterjung1337@gmail.com, rientjes@google.com,
        chriscli@google.com, axelrasmussen@google.com, joelaf@google.com,
        minchan@google.com, rppt@kernel.org, jannh@google.com,
        shakeelb@google.com, tatashin@google.com, edumazet@google.com,
        gthelen@google.com, gurua@google.com, arjunroy@google.com,
        soheil@google.com, leewalsh@google.com, posk@google.com,
        michalechner92@googlemail.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Suren Baghdasaryan <surenb@google.com>
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

Write-lock all VMAs which might be affected by a merge, split, expand
or shrink operations. All these operations use vma_prepare() before
making the modifications, therefore it provides a centralized place to
perform VMA locking.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/mmap.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/mm/mmap.c b/mm/mmap.c
index 92893d86c0af..e73fbb84ce12 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -502,6 +502,16 @@ static inline void init_vma_prep(struct vma_prepare *vp,
  */
 static inline void vma_prepare(struct vma_prepare *vp)
 {
+	if (vp->vma)
+		vma_start_write(vp->vma);
+	if (vp->adj_next)
+		vma_start_write(vp->adj_next);
+	/* vp->insert is always a newly created VMA, no need for locking */
+	if (vp->remove)
+		vma_start_write(vp->remove);
+	if (vp->remove2)
+		vma_start_write(vp->remove2);
+
 	if (vp->file) {
 		uprobe_munmap(vp->vma, vp->vma->vm_start, vp->vma->vm_end);
 
-- 
2.39.2.722.g9855ee24e9-goog

