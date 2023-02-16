Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F02C698BBE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 06:20:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbjBPFUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 00:20:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjBPFTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 00:19:50 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3DE7457D4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 21:18:57 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-4cddba76f55so8311157b3.23
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 21:18:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=76w8C0WtscQXhYR05yNYHvPFGtZWYYoigmdRBKNsAGs=;
        b=FCDmrKExzLuCArz312mMsT1GG2XBAJpY0IRk4Dudkq8tacxOtpStMHAB4mCqF7cHzr
         HxmYKbJzh0e/OlcI5tze/pJirqiUzOseaOUlDEtDH80qm7FP3CxiVmnvUlVVgBXp61ej
         ykGRdx137mYbxOiW4ntwVshjUhNYXqvxbpsd7tR4+U5K8xmf3z6sAC5BmIr5igjBFbE2
         Lhh7YXKnyKDhial8w7C+wSOyLz2qDj3wAEjKVPIMU3N4BzLNr3q2F7Jzk8qKKMPeJp0i
         mhDW6Px8X9de0wrc9+taZBLP7xnnbG62Qe2RXE2u3O0X+3PidgLM2eknvp7ECPYQAyqI
         26OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=76w8C0WtscQXhYR05yNYHvPFGtZWYYoigmdRBKNsAGs=;
        b=Cl/2dg7px0VteYTm0pbQw/GnSDeS3R4D6VtyflogegSEOZoWEluwyTU/AlNNcDyfU1
         qzLngBSYK2fAbFY7MXdonFLKX2iihrOywsQkp196b31AmMQs66bVyZjcqwYGiEKdV2As
         kI6qNDJKI8hp+4BFj3SHyy9J/bi+BrIIZ9YBAS9ro/c2Kn0CdOlRUj7QBrC+zMpwoepW
         76GuwSpmusAEGjcieAX6cJENr51VyktlWN2Kk0V/VCrAJNEYfm/oIBNF4XKDI419JXZD
         W22h+sTVVExRJ1n9d8uR/y4l9KsxqbH8pwNyrijbcFQizA2cJnhWwpRO3sBcQRoTx6ef
         9ENQ==
X-Gm-Message-State: AO0yUKVaIfCPc3sKSXOFm2HkN/387vQOxApK9NEv/Wj7DBhMXSgdKfwr
        xckfzea6zM4CUEz9ld2zPHhxxJQYL8s=
X-Google-Smtp-Source: AK7set/7Y/K8KWVB4K6J3b/XMgTvXO7u2Z/Kc+o++p3RcwHAcWZWf0oYrOVDXbq6GKc7ezqD+HuFayT02ok=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:f781:d5ed:1806:6ebb])
 (user=surenb job=sendgmr) by 2002:a81:9e0a:0:b0:532:a8a0:8d76 with SMTP id
 m10-20020a819e0a000000b00532a8a08d76mr235300ywj.85.1676524737340; Wed, 15 Feb
 2023 21:18:57 -0800 (PST)
Date:   Wed, 15 Feb 2023 21:17:41 -0800
In-Reply-To: <20230216051750.3125598-1-surenb@google.com>
Mime-Version: 1.0
References: <20230216051750.3125598-1-surenb@google.com>
X-Mailer: git-send-email 2.39.1.581.gbfd45094c4-goog
Message-ID: <20230216051750.3125598-27-surenb@google.com>
Subject: [PATCH v3 26/35] mm: fall back to mmap_lock if vma->anon_vma is not
 yet set
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

When vma->anon_vma is not set, page fault handler will set it by either
reusing anon_vma of an adjacent VMA if VMAs are compatible or by
allocating a new one. find_mergeable_anon_vma() walks VMA tree to find
a compatible adjacent VMA and that requires not only the faulting VMA
to be stable but also the tree structure and other VMAs inside that tree.
Therefore locking just the faulting VMA is not enough for this search.
Fall back to taking mmap_lock when vma->anon_vma is not set. This
situation happens only on the first page fault and should not affect
overall performance.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/memory.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/memory.c b/mm/memory.c
index 5e1c124552a1..13369ff15ec1 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5242,6 +5242,10 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
 	if (!vma_is_anonymous(vma))
 		goto inval;
 
+	/* find_mergeable_anon_vma uses adjacent vmas which are not locked */
+	if (!vma->anon_vma)
+		goto inval;
+
 	if (!vma_start_read(vma))
 		goto inval;
 
-- 
2.39.1

