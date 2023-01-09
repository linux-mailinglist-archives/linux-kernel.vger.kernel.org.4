Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7BB663204
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 21:57:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237807AbjAIU47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 15:56:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237607AbjAIU4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 15:56:02 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB8808B535
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 12:54:37 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id z17-20020a25e311000000b00719e04e59e1so10332272ybd.10
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 12:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1FpUUiRmr7dBuhWWRB46HjSP7TgY2quKdzRuNf/hqHM=;
        b=AsrsBvZP9aQHF3L5Nl/u1fB+D2bm7e0YjzSCvgbBaPzVvDqUAEV/bKN3f/FWWFnJld
         y54pIfCVv+Sf28j1GT6GnDmjTV3QxG0dtIi870ieojG97R1YrLaN1+Hnnh1RqNC6IKhV
         FDsy8k4m0XBTPaqC3JVLB2amGI721PZ/e3uTJFIVXTdjA/KJiKwGIaizGxyvcp5J8QaW
         5xEAO0mZOLLdDxM+ya/sdbkzi1vVwSyWReOOtmKkNqv4WGZ0uHxmN44Y8NrueULgHAw2
         BBJ3cZtaXuduG2TgX3HtPnChX2RwWmECLeYtrImIURhb/vK80eEmATn6FHpKHV2WHJD9
         N1QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1FpUUiRmr7dBuhWWRB46HjSP7TgY2quKdzRuNf/hqHM=;
        b=7mh5zTs6gpnI607jpHI6uZiwptDQdvYWBqlhWBXMRyjtvvdf2pSxsNBdRuOVN5iJao
         wBU1NlY53WWFpm3cFGCEcF/soXHTbUcX3CacPXCc2Y1j3woLPQvTXLRwR6mN6GnRSWLv
         8P1GXmiRm7XNTOCE0km5CZeyT7UoOecIUj9qXpVWWdWrwGJ6i2BFcI36IvGvJ/IEw2mn
         bVtLWwTv+Bg7SM5Hq6Z2Rr7NrtbXkNxWoGOPZPgvNWTQwuOp5X4JKnzugW8R+yyLAXsv
         c92LzA0jfb6b7vPzSgrxL20dZOWGuDyawkF+2eqjiSLHJ0CKQ25MN75lTo2ZYkxU7ALA
         sN5A==
X-Gm-Message-State: AFqh2kr/s7x7pc30V35IN1Wibl8TKOnuSAhSXXSIwXcNixKsPOwFfOr5
        Jhj5rmM77W2R9Rqx+e11XS7hCvToHN8=
X-Google-Smtp-Source: AMrXdXtAgZu+pAoAaYuQQAsM5E55paYeoDQZrstt2b6LAIgKd1Hk/SubADrA5GRLvEWllXjlmSi56GzDLGU=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:9393:6f7a:d410:55ca])
 (user=surenb job=sendgmr) by 2002:a25:4646:0:b0:799:3955:201f with SMTP id
 t67-20020a254646000000b007993955201fmr3367922yba.94.1673297676537; Mon, 09
 Jan 2023 12:54:36 -0800 (PST)
Date:   Mon,  9 Jan 2023 12:53:17 -0800
In-Reply-To: <20230109205336.3665937-1-surenb@google.com>
Mime-Version: 1.0
References: <20230109205336.3665937-1-surenb@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230109205336.3665937-23-surenb@google.com>
Subject: [PATCH 22/41] mm/mremap: write-lock VMA while remapping it to a new
 address range
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

Write-lock VMA as locked before copying it and when copy_vma produces
a new VMA.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Laurent Dufour <laurent.dufour@fr.ibm.com>
---
 mm/mmap.c   | 1 +
 mm/mremap.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/mm/mmap.c b/mm/mmap.c
index ff02cb51e7e7..da1908730828 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3261,6 +3261,7 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 			get_file(new_vma->vm_file);
 		if (new_vma->vm_ops && new_vma->vm_ops->open)
 			new_vma->vm_ops->open(new_vma);
+		vma_write_lock(new_vma);
 		if (vma_link(mm, new_vma))
 			goto out_vma_link;
 		*need_rmap_locks = false;
diff --git a/mm/mremap.c b/mm/mremap.c
index 2ccdd1561f5b..d24a79bcb1a1 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -622,6 +622,7 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 			return -ENOMEM;
 	}
 
+	vma_write_lock(vma);
 	new_pgoff = vma->vm_pgoff + ((old_addr - vma->vm_start) >> PAGE_SHIFT);
 	new_vma = copy_vma(&vma, new_addr, new_len, new_pgoff,
 			   &need_rmap_locks);
-- 
2.39.0

