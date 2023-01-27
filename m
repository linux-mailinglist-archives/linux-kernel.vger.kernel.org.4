Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86C7B67EE9D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 20:44:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232100AbjA0ToH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 14:44:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231774AbjA0TnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 14:43:19 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C5521707
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 11:42:50 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-4b34cf67fb6so65244707b3.6
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 11:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=icGEQDhVNg8AQkGt0Dau1cb43VWZWeb/kUxMjHSAwGA=;
        b=nhjpt9VbHDPsHYg33OlJfuq5Iz35VmBZ3kiMxPcXRXZZYdOboFlR0spKtxfGWFFcLn
         eBkIzKgB8QHaANcEzDHfkdLN1fRlxg2tqUBsMTv/7fNevBLbu/43ueowkRgVsLx1vLRo
         uHdRFKLtGeWmcojM55WkW4Vbk+IWqqj37nvYWjKvQOLDRhcdlXynMiveqJDQteuGpWZz
         ETc6Sup2efRPDAlMWE74qe3dlQIJeV8JWIsag7a7AlDm28r/breAdd9LIL/XkRDxD2X3
         yud8bBPMeadGbrZ7ftbCoegvJj4wUFszXo3BfVZSLdIr/XgKY9tYqvkkj2bzILo8Fvtn
         ItZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=icGEQDhVNg8AQkGt0Dau1cb43VWZWeb/kUxMjHSAwGA=;
        b=y1HZAyEVXuN9pXeCS2t5qJSou9ObpYXCbbNtNA2JwnwOoFIEUN/bECVKKhd07WP/0r
         6TNZKusGdxCRcH4XFI7UEr8qFwnbUwhu/M5ebxDPlMuSuY9ysmIIdNTFJn6m3WpoicD6
         mQCLFb4BUY79qHln00XP1YbuW3Ljl3If9APCkKwJj9o7kzw9R3EiIcNYQ18QMhS/rmBc
         0r9up9QuxckVync0u3RMgFvqJwZa+H1GxodCHr0JnfLIHag4cAKojD8qihR4HQF40zUI
         9QP5T18zb8TkCEDcJbM/vzM7eaRaTFszoi31gF25tcWg72GZ4UN6xhA00/r4AsdMI7eN
         JVig==
X-Gm-Message-State: AO0yUKXcFnMYtY8XvKy6qfMYqRNV601DG3sjngfFmok7Mny19cesngMc
        MbJpJXtj1ereY5NAWMIlKHT/bMURsZk=
X-Google-Smtp-Source: AK7set+R/81FxpFmvdAm43AdDVGV+lMO8EmoQcyFeqmQ4bL2GAdYwzTWfE7122Mwrx91JEcHzv5APn9iCmY=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:4e19:be9:c5d0:8483])
 (user=surenb job=sendgmr) by 2002:a81:48cb:0:b0:506:4c8b:231e with SMTP id
 v194-20020a8148cb000000b005064c8b231emr1848392ywa.80.1674848505193; Fri, 27
 Jan 2023 11:41:45 -0800 (PST)
Date:   Fri, 27 Jan 2023 11:40:50 -0800
In-Reply-To: <20230127194110.533103-1-surenb@google.com>
Mime-Version: 1.0
References: <20230127194110.533103-1-surenb@google.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Message-ID: <20230127194110.533103-14-surenb@google.com>
Subject: [PATCH v2 13/33] mm/mmap: move VMA locking before vma_adjust_trans_huge
 call
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

vma_adjust_trans_huge() modifies the VMA and such modifications should
be done after VMA is marked as being written. Therefore move VMA flag
modifications before vma_adjust_trans_huge() so that VMA is marked
before all these modifications.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/mmap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 9efe13d36df7..7467d691e357 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2910,11 +2910,12 @@ static int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		if (vma_iter_prealloc(vmi))
 			goto unacct_fail;
 
+		/* Set flags first to implicitly lock the VMA before updates */
+		vm_flags_set(vma, VM_SOFTDIRTY);
 		vma_adjust_trans_huge(vma, vma->vm_start, addr + len, 0);
 		init_vma_prep(&vp, vma);
 		vma_prepare(&vp);
 		vma->vm_end = addr + len;
-		vm_flags_set(vma, VM_SOFTDIRTY);
 		vma_iter_store(vmi, vma);
 
 		vma_complete(&vp, vmi, mm);
-- 
2.39.1

