Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 390026A73FB
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 20:05:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbjCATFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 14:05:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjCATFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 14:05:03 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAFF04608F
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 11:05:01 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-536a545bfbaso291491417b3.20
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 11:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677697501;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eZZzZE8GpdNY+MwogNnFVaUs2b/RvHe7OTvEU8aJPfc=;
        b=Fyrl4aN8thLa08lvSwfnz3pS77dLDE/JPDoL0n+GfSBVkEYmU/na7n6N3awmHGcBsx
         fg4YM6nkuIRNWndpa/Vvh28BBbpGpJRQu2vsHAWiO6a5ZOUjmcMA7LOEEPP8t186icRE
         TTzl2f0lYKQ2gEv3faqd7R7sHmLmFHvz7aRO6WVgfOeUssnPkNyUgEAinVLSyUArDjIp
         kbm/6C3MBv1I4BXWlD3jhzvuaIkNNoC3TdQPTPCNNYNwWctyfsetJwP6v0E+I8n/tQPA
         F1L2rtHP4dGjfzEUvNlYgeld/2PRYT7D9g8oV1r1Tb8v8B8+31LZevINjOdzhGWMe5yh
         P0iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677697501;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eZZzZE8GpdNY+MwogNnFVaUs2b/RvHe7OTvEU8aJPfc=;
        b=WZUEvirwD7UCbnGijsQ8TGdrO1nS5k4gOwPGR0jA+eRSnzpvQbzBOgwpNAxpiStSo+
         o9k1q6GfX7k9o3qpGOcxirKcl1zaqvVfwIil/zbu+BSXR2cwMBwVp48t/bsK7lO5+zUz
         sfE9/6yKsZH0k2tmVMrGojzLqXLWROoupy7+XcBjFJtyJJJvgJO6wwpQP/Whau7j6GNR
         ILEEMH4qCRYTFrAvsTHlW/Tyc6qH1/HU+y172rTjWlpH3nuzUegsqE+UkfTkO0uLRltK
         Lj/NIQDHGJnnwiWyRbhXt09KqB7iuCaqTKu2UIP+zWP3qYdXr1BjcwU+0cUKPUP+YUBJ
         DH5w==
X-Gm-Message-State: AO0yUKWVAxaR63KmU39rbt1nL/59qpDHHvR3kQq/MppIj1xJazjEZ576
        0EwQ43wmicX8ES+mTAQHrsdMUHGI19U=
X-Google-Smtp-Source: AK7set/9C/tFDvwQ8AH2AjoEK29ndZJWeqFhKnrMFIlBfk3w7trnnd608E+7P+Ccqu1RqtfeQNT22abiIwk=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:3c40:eeb3:7c3a:807e])
 (user=surenb job=sendgmr) by 2002:a0d:c506:0:b0:533:b8f6:828e with SMTP id
 h6-20020a0dc506000000b00533b8f6828emr19ywd.411.1677697500632; Wed, 01 Mar
 2023 11:05:00 -0800 (PST)
Date:   Wed,  1 Mar 2023 11:04:57 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
Message-ID: <20230301190457.1498985-1-surenb@google.com>
Subject: [PATCH 1/1] mm/nommu: remove unnecessary VMA locking
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
        Suren Baghdasaryan <surenb@google.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
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

Since CONFIG_PER_VMA_LOCK depends on CONFIG_MMU, the changes in nommu
are not needed. Remove them.

Fixes: bad94decd6a4 ("mm: write-lock VMAs before removing them from VMA tree")
Reported-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Link: https://lore.kernel.org/all/Y%2F8CJQGNuMUTdLwP@localhost/
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
Fix cleanly applies over mm-unstable, SHA in "Fixes" is from that tree.

 mm/nommu.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/mm/nommu.c b/mm/nommu.c
index 2ab162d773e2..57ba243c6a37 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -588,7 +588,6 @@ static int delete_vma_from_mm(struct vm_area_struct *vma)
 		       current->pid);
 		return -ENOMEM;
 	}
-	vma_start_write(vma);
 	cleanup_vma_from_mm(vma);
 
 	/* remove from the MM's tree and list */
@@ -1520,10 +1519,6 @@ void exit_mmap(struct mm_struct *mm)
 	 */
 	mmap_write_lock(mm);
 	for_each_vma(vmi, vma) {
-		/*
-		 * No need to lock VMA because this is the only mm user and no
-		 * page fault handled can race with it.
-		 */
 		cleanup_vma_from_mm(vma);
 		delete_vma(mm, vma);
 		cond_resched();
-- 
2.40.0.rc0.216.gc4246ad0f0-goog

