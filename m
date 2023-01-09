Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6477166320C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 21:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237640AbjAIU5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 15:57:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237821AbjAIU5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 15:57:16 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 674578CBF2
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 12:54:54 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-349423f04dbso105152877b3.13
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 12:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Bx36nWIWIaMqsyKC4DFh9Dy6zgkZnlvdwV69ikS09tQ=;
        b=GjzlXD654bxHD8qHg+BCMZfuuyb19mHGKgBfyrdYtuHPZI3RXY2mylK8MrrZ6vi/KV
         XpBGPAViKdrJ111khQK0LarqUyqdysojbfZLW54fo2JQeFn5ElZgOwEGNBdof4Exx32h
         oce1agjXuGHjstOPH9icNCzJQUnGWQYtYgBGU792WEzYIKYlpSXiCOhWF2Ne+MX/DqXf
         xrifjQ0boHWSv5tXEGAlsRbW4dbyfRz7jLqAVJ0lSkujXDjZ2O7m0HOdnuYL7/iH8Jk5
         Up4mHJat+wejXPO4fCLDWlYHvfZ/+JBFjf5EhWbTUQtFaZy2JybPs/XeOQ27EyoIyzsK
         wpvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bx36nWIWIaMqsyKC4DFh9Dy6zgkZnlvdwV69ikS09tQ=;
        b=oPZP1oeJTK5yhJ+VhRoPHY1vNKKEuZNPJtcKLJBT+/jc2bVVwgbWSZPNFZW49j2GjU
         aJn0TVMcsKMMGVg/CRC840qIe/VhYp/DiVFQ5TAk63NZ2q6GZfJtciCUEmzv/7YqLIdj
         eWkfJhZaD1duxyx8hEWFfHZ7kBI7q9LfboWMEusEi1le7BcljfUksS6zhGgimBrpIzmk
         BDr1CHT5C3P+K0d3PVu9GazxqCJOnoG0bVQJgVYmnUR/gXOWkSYE9d8e1nc0pJzMLKnK
         x1EwI63w6RPuNW6mu3R9jSBIalao0CSz8pkbRFx1tGBpD1xnuj37+U0jkWqZz/tGavmd
         OIgA==
X-Gm-Message-State: AFqh2krwGjKbjRVkpCDlwX6Cwk46F9/IZd5NmdcjBWkSgSAdKIevUlf0
        XTJjeugRTsE0u+MARplO3rcYOI/QI+0=
X-Google-Smtp-Source: AMrXdXsUnoeDnhtdWoii8DMH8rCFUM9XgPs0a9yaOqp3Qv/VXJUnVpuxBD4Is/HyplWdMowbocjku3a0aLg=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:9393:6f7a:d410:55ca])
 (user=surenb job=sendgmr) by 2002:a25:3c83:0:b0:700:604:2e1b with SMTP id
 j125-20020a253c83000000b0070006042e1bmr7014317yba.246.1673297694067; Mon, 09
 Jan 2023 12:54:54 -0800 (PST)
Date:   Mon,  9 Jan 2023 12:53:24 -0800
In-Reply-To: <20230109205336.3665937-1-surenb@google.com>
Mime-Version: 1.0
References: <20230109205336.3665937-1-surenb@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230109205336.3665937-30-surenb@google.com>
Subject: [PATCH 29/41] mm: fall back to mmap_lock if vma->anon_vma is not yet set
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

When vma->anon_vma is not set, pagefault handler will set it by either
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
index a658e26d965d..2560524ad7f4 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5264,6 +5264,10 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
 	if (!vma_is_anonymous(vma))
 		goto inval;
 
+	/* find_mergeable_anon_vma uses adjacent vmas which are not locked */
+	if (!vma->anon_vma)
+		goto inval;
+
 	if (!vma_read_trylock(vma))
 		goto inval;
 
-- 
2.39.0

