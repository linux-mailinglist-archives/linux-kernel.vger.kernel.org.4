Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8D2C6631F6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 21:56:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237358AbjAIU4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 15:56:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237546AbjAIUzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 15:55:24 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF5E81D7F
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 12:54:25 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id k18-20020a170902c41200b001896d523dc8so6993492plk.19
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 12:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hDqG76VNjmKFCkYaVQCHk1jK9PV7CZBX+MdyRpSUw7Y=;
        b=oTTbEHXXf074UTT/LXfKIzTlYAOVSZBWjz/z2pi8uw2sgTsKOn0pf4M+FUmb3fhKEp
         t8utYb+BYUrtOmcMbBRfjQmj3HjZCnvt7nX8XXsh4x467hUw4mc17N9vBA4v3IH0gXYu
         Tf0NgJ8TRnq+dnC575YF2XUlugz8igLSTMm592zbLFSlzWIJOjCEMLUlmrt7z2QrvV2T
         gekww8A2UJVHgfp1zwqjj/KBiOxEMFrYzziSkpJrGHAD1djB4N2zU8kmwkE7PnEOrNUu
         hxvDlopUQbh5t04B3B6cW3kLOVcLSOY+TAkcMQBqHoc5+w1BV2sS39QIbB6FPKvgrwld
         s2sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hDqG76VNjmKFCkYaVQCHk1jK9PV7CZBX+MdyRpSUw7Y=;
        b=CaFAor7JdrXfi8+vNs4KOkeelfkQptUs/UWVR9Fxwg0aucomzDTtjMNI3Y3DvdgWNP
         wzvuEukT8nnTy8wxW/1SyUpLihHe5bGhAcj2aK+0nPOzhzVdjtubNfuRBXKHRDvrNsCw
         n+sL8/gh6kaw6SZusaXG5Oku0/C3H5c+y3hR2O8UmmwkUgnrk7HDvLCZCQAz8UpQAgaz
         fd8U2KdCJ7JH8U5IDQpH+a6coo2gMTBoRQqVSHf3iRQQ1lo632dKWRlK7caQyjbRajMO
         14KN3mv278DxYYus2mId4lAItBmXuOjqyNNM6hX7ywzP2jiZqoKOvFDk0nf/Q5Ct9g4C
         pVWw==
X-Gm-Message-State: AFqh2kp8e+dQFCnFn+dErp4nus9y36gqot+LlmJaNI2ltTrcoZE+v1dZ
        kMhsV//g+Iu3++8W2NWbiIro7Hd+yrw=
X-Google-Smtp-Source: AMrXdXvx+5mjUKCd2siyFSRbOdBiHgQPNh6ZnBtsj8lXWONeXJTph7ewao1odYnxoExvO1xzjoIbjT4zuzo=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:9393:6f7a:d410:55ca])
 (user=surenb job=sendgmr) by 2002:a17:90a:638b:b0:221:52e3:1f56 with SMTP id
 f11-20020a17090a638b00b0022152e31f56mr5166916pjj.225.1673297664681; Mon, 09
 Jan 2023 12:54:24 -0800 (PST)
Date:   Mon,  9 Jan 2023 12:53:12 -0800
In-Reply-To: <20230109205336.3665937-1-surenb@google.com>
Mime-Version: 1.0
References: <20230109205336.3665937-1-surenb@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230109205336.3665937-18-surenb@google.com>
Subject: [PATCH 17/41] mm/mmap: move VMA locking before anon_vma_lock_write call
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

Move VMA flag modification (which now implies VMA locking) before
anon_vma_lock_write to match the locking order of page fault handler.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/mmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index fa994ae903d9..53d885e70a54 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2953,13 +2953,13 @@ static int do_brk_flags(struct ma_state *mas, struct vm_area_struct *vma,
 		if (mas_preallocate(mas, vma, GFP_KERNEL))
 			goto unacct_fail;
 
+		set_vm_flags(vma, VM_SOFTDIRTY);
 		vma_adjust_trans_huge(vma, vma->vm_start, addr + len, 0);
 		if (vma->anon_vma) {
 			anon_vma_lock_write(vma->anon_vma);
 			anon_vma_interval_tree_pre_update_vma(vma);
 		}
 		vma->vm_end = addr + len;
-		set_vm_flags(vma, VM_SOFTDIRTY);
 		mas_store_prealloc(mas, vma);
 
 		if (vma->anon_vma) {
-- 
2.39.0

