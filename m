Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E94A67EEAA
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 20:46:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbjA0Tpq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 14:45:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232372AbjA0ToU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 14:44:20 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E5BF53B0C
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 11:43:13 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id d21-20020a25add5000000b007ff8112e8b8so6430225ybe.17
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 11:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gSaEMik01Wf1+Bdt2RmdUMjgYY7lDp9hLxJUYqXXyyM=;
        b=rcBVm8w95my/f0ebkBHOBSdk/g3dXIBnrvyKhE+0lfp8SBBL9UDohndGfm9prz69Nb
         1VsGdk5hVjbZdd99cfs1kRzqndkhM72YtTrleRtcoKwDWYV7T956W4hi9P14DNVnfcTE
         4dzd8voX/MwzX+niWcYh6zC2gtPII1RsQu2W+o1SzbH/VUzyZkZ+K0mbi6bCuvIO2r/9
         q8JUw2FMeYJjbLjibdrizaV+CI77RGRlLfF03fxNpzuIRE1ymkIpYCAH7a7Vh5p4LTWM
         djOGRW9GCrBrxw2Z+lpBSKPiwjL/b62fESDSi0yRTpPNMfCaBkk0gvqmlpNjM1674+ZN
         MkCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gSaEMik01Wf1+Bdt2RmdUMjgYY7lDp9hLxJUYqXXyyM=;
        b=r15GmN1poUZ4dQgu9keNOfHmA9pK8DE5sJA1vaiMC5qTL247YoHvDo7oijSFx/35bd
         JZp4584jIVWImblKL97t9Yurl7aJFXrxohImUMRERGgABrzmPeGakcBKkd3BfR8AoF/Q
         1WTcHq7Kv9pRfr1hAErsHoMhrGQrTQHoT75UaPzIjwrCEwcjTM+5K8uNVyeD1iI/6wIc
         w7yPO1JSxH7hXSiEwz4pSRzTpNLH0Vmr8kohycaCya4GS7jTDWoURVmIy842vrj7AIG0
         GRv4sO29D9bM2ThxDQf9xC+DH4EtAqFtXoonRV3XHrEQ7pKOwheMbmCwr7kSUVXoz1Pn
         ydmg==
X-Gm-Message-State: AO0yUKX0Pkwt6LNpxFwq8GsuuFWMUovf3ja40//j+NJeT2eRrZTWL95I
        4KXGpjQvMO3HClo9LM4f0VhRaI/EMY0=
X-Google-Smtp-Source: AK7set9ZuZbDGpVLmgenU71+ffHh46VvnF49YmmPOU0QZTkBBursiC5h0isQQWJJC0fjjZLxRphOeOdStg0=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:4e19:be9:c5d0:8483])
 (user=surenb job=sendgmr) by 2002:a0d:d8d5:0:b0:508:1348:3e54 with SMTP id
 a204-20020a0dd8d5000000b0050813483e54mr1003857ywe.440.1674848531551; Fri, 27
 Jan 2023 11:42:11 -0800 (PST)
Date:   Fri, 27 Jan 2023 11:41:01 -0800
In-Reply-To: <20230127194110.533103-1-surenb@google.com>
Mime-Version: 1.0
References: <20230127194110.533103-1-surenb@google.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Message-ID: <20230127194110.533103-25-surenb@google.com>
Subject: [PATCH v2 24/33] mm: fall back to mmap_lock if vma->anon_vma is not
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
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        rppt@kernel.org, jannh@google.com, shakeelb@google.com,
        tatashin@google.com, edumazet@google.com, gthelen@google.com,
        gurua@google.com, arjunroy@google.com, soheil@google.com,
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
index 5568fcb0a46b..593548f24007 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5244,6 +5244,10 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
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

