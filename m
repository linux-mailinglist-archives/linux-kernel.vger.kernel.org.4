Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3024367EEBD
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 20:47:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232603AbjA0Tq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 14:46:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232574AbjA0TqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 14:46:24 -0500
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8841A91FA5
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 11:44:06 -0800 (PST)
Received: by mail-yb1-f202.google.com with SMTP id g138-20020a25db90000000b0080c27bde887so2635506ybf.18
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 11:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sBLmwmiYmTj+OGGVUcLxhx0PU/jBUoUEJpANG8soAfU=;
        b=KWtfJ/7xIlPNyMbJgMly5Sn2+77Pi3kT3bIKcXhSEYdAbccLPUNTncstNEX89dvAhW
         NM9ImIflxrHOdJ1Mj5fWozRK69MXYGw+crQDfh9Oftap/iRU1kAVPiBZhr/+UuvLj4+U
         4LLcR3mdcWgS75oxY+Q2vGwsrXQ6jEpwNWpRZ0m4MKHrCT8iGAtEZyFhrSxdE7CjPr88
         djL5aWWS3cMBdV/JlcmaRg0LM4Y33l8LwLfoSQoWCllE6I7RGCcpBFSNwKknGwVlLQii
         i5R/yajGZAULuwac7zP2AeGWc0Ux4Tm1rMqU81PAQU3nWhlQVK4py4JD6fzjGBwa6RFE
         gFWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sBLmwmiYmTj+OGGVUcLxhx0PU/jBUoUEJpANG8soAfU=;
        b=EScMkfmTrvjSIQhckS3et5hFdVMdAQ7t4NJZWmp79+IeUbRbSrqb2B0WABMWgBOpdG
         J2E0Wa+I4RowSzWJnaJ7rQHtpz8WzjPBdjAHHM4YdJ59cu1e3m3qFO4i/MKt4QNkXivd
         ZXWAYvICxo8UububZK1L9JiHP4r+5TFbesLHIamHVSzqdf3ULzXGdQUqdFa6PsEjEwZP
         2TDd8gZq+nLNft2mMMeCsQzwBED3wQhhZFDLbhws9wAWP+UBFmCBe5su9Vi2mVi8vBcm
         G1Roq8+MxAuKZ9aLnpUtbk1cstW3YlsFStCeusgKsDqef4uYOIH657uh54SUEin1xs8j
         H8fw==
X-Gm-Message-State: AFqh2krZtpaFVvgH8g42FNH/X+FR9Z6+3Eks08phyrv5mHqSg77s5lbJ
        rXT7yfH8enFdw3wPudX4v2Y5Kdz34p8=
X-Google-Smtp-Source: AMrXdXtj44VmRN6kQLB49pXglCfjpmg9iXCqYgU9gl6+Dl4v+hAma4/0PMDtIg4t8IMM3q4b9OalQWjETEg=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:4e19:be9:c5d0:8483])
 (user=surenb job=sendgmr) by 2002:a81:cd7:0:b0:4dd:9ed1:fba0 with SMTP id
 206-20020a810cd7000000b004dd9ed1fba0mr5011323ywm.265.1674848536283; Fri, 27
 Jan 2023 11:42:16 -0800 (PST)
Date:   Fri, 27 Jan 2023 11:41:03 -0800
In-Reply-To: <20230127194110.533103-1-surenb@google.com>
Mime-Version: 1.0
References: <20230127194110.533103-1-surenb@google.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Message-ID: <20230127194110.533103-27-surenb@google.com>
Subject: [PATCH v2 26/33] mm: prevent do_swap_page from handling page faults
 under VMA lock
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
        surenb@google.com, Laurent Dufour <laurent.dufour@fr.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to the possibility of do_swap_page dropping mmap_lock, abort fault
handling under VMA lock and retry holding mmap_lock. This can be handled
more gracefully in the future.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Laurent Dufour <laurent.dufour@fr.ibm.com>
---
 mm/memory.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/memory.c b/mm/memory.c
index 593548f24007..33ecc850d3cb 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3690,6 +3690,11 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	if (!pte_unmap_same(vmf))
 		goto out;
 
+	if (vmf->flags & FAULT_FLAG_VMA_LOCK) {
+		ret = VM_FAULT_RETRY;
+		goto out;
+	}
+
 	entry = pte_to_swp_entry(vmf->orig_pte);
 	if (unlikely(non_swap_entry(entry))) {
 		if (is_migration_entry(entry)) {
-- 
2.39.1

