Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37A9C6A483D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 18:38:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbjB0Ri0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 12:38:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjB0Rhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 12:37:47 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E321724C89
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 09:37:21 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5376fa4106eso153559837b3.7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 09:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=r0m7Mx7yExEfpE40BLjkT9H7Bv79s8byLhYJ0wRxTC4=;
        b=J6HTSW3ije3IDV45f4imLJua2F9c9fG/LezyaDIF0k2VV4fuwgH+fku2QXSjWP2auL
         d+6+O+xNSm6Xj7FlWbcn2IucG0PD3/gJW2mH/MURmde3Q+9WMeczT04Csr++aQNQAB4v
         uOclz5rts/w0oMZxgj6JdiddKEJJwswsgJAAZvi48OAzGBi1BuSBhTNF8+d2d3+YbCDm
         fwaoPEsSaG9C8KiMPsrgpeVhqU2cm1pHUxTYDzrWvN6667+vmOEZ293x3rsB2i9qTzir
         LhGya0SRahx81MeDy4vFauftQ8Z+i+VjBO+uhvPnINIKKKPeRWHZkWIWZS9shPaay/sM
         /HGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r0m7Mx7yExEfpE40BLjkT9H7Bv79s8byLhYJ0wRxTC4=;
        b=5uYSAYKwD5doJXYhic5PCBoDqbu70mY5a36+UV34OOTYxNhLjtbowNKbbNyt7SX6Zp
         Hrswm12lbMtbln6IyqLKNshrhvhypHs5hnk+PSUa2LPaCjVhbopMjrzNetsaGayZ/RCV
         svHV5HwQRwc7zQHAsK86AmtJJLTmbJ/OB9z3YNN1M5gPtB/Q5hLhAwScm+/53Oy2jBE/
         buk75JMs16VObL87jxMYDjzXKgdygYDsirawymQC49cDHcfJkjA9bguhu273ldh1XM6g
         lx3LRGqlB1DeBkmPMROn3/jDKV1wLdhc4KHtgaBsJ3GqKDyIK5vK4IUsbv+rMPle+Ty0
         IxyQ==
X-Gm-Message-State: AO0yUKU1hEQvZ6J/paSSYmBWR4TNfWXwULDhNcIEN235UxqVfVmQQKYT
        jW/nHdvkf0I3DuOzbKu/bJaqqQzkb0A=
X-Google-Smtp-Source: AK7set8EV36Dr/ESiL80fu1d1SaW9bmdiDECZfWEbGGMOjKuqTD7GEuVWa5jynsNqQ2pFS6J79ENwuY0pY0=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:e1f6:21d1:eead:3897])
 (user=surenb job=sendgmr) by 2002:a25:938e:0:b0:a60:c167:c056 with SMTP id
 a14-20020a25938e000000b00a60c167c056mr4911453ybm.9.1677519440118; Mon, 27 Feb
 2023 09:37:20 -0800 (PST)
Date:   Mon, 27 Feb 2023 09:36:17 -0800
In-Reply-To: <20230227173632.3292573-1-surenb@google.com>
Mime-Version: 1.0
References: <20230227173632.3292573-1-surenb@google.com>
X-Mailer: git-send-email 2.39.2.722.g9855ee24e9-goog
Message-ID: <20230227173632.3292573-19-surenb@google.com>
Subject: [PATCH v4 18/33] mm: write-lock VMAs before removing them from VMA tree
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

Write-locking VMAs before isolating them ensures that page fault
handlers don't operate on isolated VMAs.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/mmap.c  | 1 +
 mm/nommu.c | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/mm/mmap.c b/mm/mmap.c
index 1f42b9a52b9b..f7ed357056c4 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2255,6 +2255,7 @@ int split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 static inline int munmap_sidetree(struct vm_area_struct *vma,
 				   struct ma_state *mas_detach)
 {
+	vma_start_write(vma);
 	mas_set_range(mas_detach, vma->vm_start, vma->vm_end - 1);
 	if (mas_store_gfp(mas_detach, vma, GFP_KERNEL))
 		return -ENOMEM;
diff --git a/mm/nommu.c b/mm/nommu.c
index 57ba243c6a37..2ab162d773e2 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -588,6 +588,7 @@ static int delete_vma_from_mm(struct vm_area_struct *vma)
 		       current->pid);
 		return -ENOMEM;
 	}
+	vma_start_write(vma);
 	cleanup_vma_from_mm(vma);
 
 	/* remove from the MM's tree and list */
@@ -1519,6 +1520,10 @@ void exit_mmap(struct mm_struct *mm)
 	 */
 	mmap_write_lock(mm);
 	for_each_vma(vmi, vma) {
+		/*
+		 * No need to lock VMA because this is the only mm user and no
+		 * page fault handled can race with it.
+		 */
 		cleanup_vma_from_mm(vma);
 		delete_vma(mm, vma);
 		cond_resched();
-- 
2.39.2.722.g9855ee24e9-goog

