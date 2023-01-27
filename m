Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD4167EEA2
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 20:44:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbjA0Toj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 14:44:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232176AbjA0TnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 14:43:22 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C190227A3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 11:43:03 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-434eb7c6fa5so65876357b3.14
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 11:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=L4ezA/DdKPqYrQ5cS+Ke2gtcDFDEWQ5+mTqJ9joAzRk=;
        b=GKKENfMfMG4N0pZCcl9OmPXOIcATJjfZsJmDxgzcwEK7KGqwCsad+AWtcOXvaoC0br
         qvO01w86MwzjSygGqi8PA6cojX9dXaSV7GQ7IPy4D+7hoAEyyoJoE4vESGbmz//KocjS
         XInPKVcNcxUU/7v9tYz8Eq3N+worhIjUrPeLT3iGbzfEm71MChhnFLrlat60IF4TyfFg
         cT/sx9cN16Dq7Csnqgd8AQwbf9+2MwGgrR42iD3xwMMpBpotxh+QKt5ySOsx98KoL0iq
         FNYiUMi+Hv+PIq3dZA5NAAwxArkgkUL/euE7T+pJZglO6ldDOiv8hb2KxyDrVWXCBL/Q
         MOaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L4ezA/DdKPqYrQ5cS+Ke2gtcDFDEWQ5+mTqJ9joAzRk=;
        b=aJNtgNfBVDFVITTGk1sfpBqXPwGFJfeWRjHIr0C+EpkZJP/uUnMKjIrtlyoRQ8xbyE
         k/ejOf/PWYbitVr1vn1ucQyc7ah/yk8ISnqJQmvBy3jbwEyxyq52HgOYn1+1/ZaEhCyb
         WmAin9d4K0UFhPnzhY5VNinPxM1VV2FtLwIeu62nAopm574UaBAhZjn5RiAH8VEbli5r
         VU+TlTLLAfZNZdyh2dHrJY5ar4zluW4NNklkrhmiJlYLc1EVW0h+wLJpkOR2GqWtQWgA
         SR7SzoUKE3eE14v5dvf0janWtMkl8pSh9dzFA47bYaQ9Qy8FWQ6gOugclVOAG+qLIi4B
         8+UA==
X-Gm-Message-State: AFqh2kp3RUyDPUctKMITWf5kkPCIZ6Cq8ner6woMPoFnPKD7J0RnyEuG
        LwmHOzqea4N6+5jzPRL/PKwRNXHHi0w=
X-Google-Smtp-Source: AMrXdXtaMEzriXRGDDaPyWp6cI2qFr9C55J9V7x8prQAmgawr911NF2wOHqTeINFz8M7FkUN1SViGFe49Jc=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:4e19:be9:c5d0:8483])
 (user=surenb job=sendgmr) by 2002:a25:3c9:0:b0:803:3696:c473 with SMTP id
 192-20020a2503c9000000b008033696c473mr2168756ybd.224.1674848514947; Fri, 27
 Jan 2023 11:41:54 -0800 (PST)
Date:   Fri, 27 Jan 2023 11:40:54 -0800
In-Reply-To: <20230127194110.533103-1-surenb@google.com>
Mime-Version: 1.0
References: <20230127194110.533103-1-surenb@google.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Message-ID: <20230127194110.533103-18-surenb@google.com>
Subject: [PATCH v2 17/33] mm/mremap: write-lock VMA while remapping it to a
 new address range
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
index 60038c24d836..b3c247073aa0 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3202,6 +3202,7 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 			get_file(new_vma->vm_file);
 		if (new_vma->vm_ops && new_vma->vm_ops->open)
 			new_vma->vm_ops->open(new_vma);
+		vma_start_write(new_vma);
 		if (vma_link(mm, new_vma))
 			goto out_vma_link;
 		*need_rmap_locks = false;
diff --git a/mm/mremap.c b/mm/mremap.c
index 411a85682b58..dd541e59edda 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -623,6 +623,7 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 			return -ENOMEM;
 	}
 
+	vma_start_write(vma);
 	new_pgoff = vma->vm_pgoff + ((old_addr - vma->vm_start) >> PAGE_SHIFT);
 	new_vma = copy_vma(&vma, new_addr, new_len, new_pgoff,
 			   &need_rmap_locks);
-- 
2.39.1

