Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60B68698BB1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 06:19:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbjBPFTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 00:19:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbjBPFTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 00:19:13 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E8946178
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 21:18:32 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id p83-20020a25d856000000b0095d2ada3d26so832015ybg.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 21:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pCPLSRzUXQbjlFnRzNKKqjCLNtpc7ieGcBzd48Gb76w=;
        b=Aww5hQNuikXrQshFEtykppDfMBP38yEIiv8YZeHijhJepfYOC8bhl72PA7W7euJsgq
         UTdE3Yop6yuQ+QJ/imxEBpOD963eWsY1ljkA0jBaqGGg7cF+cENyfejTL2VbGXvtI8Gp
         zk9pQRaFettmR6L6WtIha8F6CvO6a31a83bm3SVswwIqM5PcX+z7DGQBjncH/5EAGpUc
         AT/XTvZe03bL8P4vyUJmA5jKJVVP1mrUYpMWnBW8gSUZQLx6c9BBl7Qtd+VfpJh9LBNJ
         HXZBHaakiRojDQMlDwmDxwqFzGyn5/4IdZKihfypYjTTs63kUZWxAGQtxOSq8MgWRU/t
         uPxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pCPLSRzUXQbjlFnRzNKKqjCLNtpc7ieGcBzd48Gb76w=;
        b=pHXQo1pPLEDZiV1gU1KpP87jqWOjYqrO3mNpuQ1aVjTNbhPQkVG3sivFB6UcS/JPhT
         BTB+S+4Rmt+4oiV9V3mK1VmK5q20ZZVNkwDi5nDBlnUDchEg9cbvGzLihZT9PzUbtjzF
         hPyoumH4uxjWdkxXhHDLyD805++3HzDXRM2oJBHPIg89emyyfIiP8TqJGlb1DFgshNbK
         lgNn4BKHR/towu34S15Dyx8At9r6HcycAJhxUf12ncBSvPqiNkViSedFbp5JAvIX/z1B
         NotTDVZMHWi/dkNRgLdi+9Jb79RJ4V09cMqq9IdZ6iUW7gC7mnG2eMtwO0fSxzPCu0I2
         vQjQ==
X-Gm-Message-State: AO0yUKW1/cC3rRElFXiPEzFbK8BxTI8KXb8qKf/AaczCiqDrrRo1D5O0
        j5ag6v6Iihbps/4aK5qHiSH40sBtQFQ=
X-Google-Smtp-Source: AK7set+U14wrD6Ap1lad6EVJBTJXnEdfFV5kP7qrWMf6wQhZaMdydVfue60wPwI1XeNtgIFp8aY/q1HqCcY=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:f781:d5ed:1806:6ebb])
 (user=surenb job=sendgmr) by 2002:a0d:d5c6:0:b0:500:e6a3:a141 with SMTP id
 x189-20020a0dd5c6000000b00500e6a3a141mr575676ywd.470.1676524709201; Wed, 15
 Feb 2023 21:18:29 -0800 (PST)
Date:   Wed, 15 Feb 2023 21:17:29 -0800
In-Reply-To: <20230216051750.3125598-1-surenb@google.com>
Mime-Version: 1.0
References: <20230216051750.3125598-1-surenb@google.com>
X-Mailer: git-send-email 2.39.1.581.gbfd45094c4-goog
Message-ID: <20230216051750.3125598-15-surenb@google.com>
Subject: [PATCH v3 14/35] mm/mmap: move VMA locking before vma_adjust_trans_huge
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

vma_adjust_trans_huge() modifies the VMA and such modifications should
be done after VMA is marked as being written. Therefore move VMA flag
modifications before vma_adjust_trans_huge() so that VMA is marked
before all these modifications.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/mmap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 06c0f6686de8..c5f2ddf17b87 100644
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

