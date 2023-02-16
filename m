Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 853E5698BB6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 06:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjBPFUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 00:20:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjBPFTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 00:19:20 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B942642BCD
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 21:18:45 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-527501b56ffso8390927b3.15
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 21:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jGkERMphMFi5DTXO6AzCtASC+DQ2dhGXIGrkfltmA+k=;
        b=ClKHnTmRqrwFsiwdvZoHbs8UrIxrOZcnAlLMKj0DmY4EeItAiZvM3xF/1XkOIILsHj
         t/ncp3cCJ608udelXLFUJi2J2Bkc4zBNFEFw7AtqnW62B+1ruBsojOMJ+l//Eveg6kMb
         9mESDdWGEfVZo4wbqdchVNx7evryh4U8zH6lvFtZPteOd8Fw20lUCwc+q1jxjD4dRCfO
         fPscX4k3EE8nShVcC7jG6Imy8fv3tD4a5LzQcDPbvgxMAF9FYu61sb1sXCbMYbbYMnzw
         H0gcnPTwNkiDCSFpe5MW+pIUr82O7ftWGw19nAsT/pwTKfJQo1rJfp9QBdZ/qdttHeJW
         nqYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jGkERMphMFi5DTXO6AzCtASC+DQ2dhGXIGrkfltmA+k=;
        b=qtRDFKEJip7gsG4CTysLnnszyVJIiuQkxWTuCv1I1nfYMUON81OK6T3Vy//J9mff9/
         i/XJXM6XqVacJaRsfYxvGXsAsxBQ/HH3YH3GCzeqS6SqT6rcLs3VO3c3GUvX0Wx5zZyo
         lE2Tq26qVNoMV0E8TS4bpUoHne9Wwg4pli56CK0SzWcRdtyGUq5VfJ4xclJZPHnV+oqu
         M258AcyziLknuvpaFO5Zv7rbRAH9rLx9ree/UkTEo4ZLxSRV+X5+P98C9Qk+pbEy3Tvy
         GGhG+XQXRAvjyLXWn3bxq3hYL3VxcEycT2dTM64s5KTUkj3nOEjcYFaF+9XOqqLV7kNT
         SlQg==
X-Gm-Message-State: AO0yUKWHw/wvH2cYthaA07nSK7TRG8MBnNZtkJvsJGvPdx/y5f0iFopj
        rfsT+I2Ur0X3/7R+yzQmSSALSn/eTbY=
X-Google-Smtp-Source: AK7set+tNlKzQOXitoUESk90msiy2FCUMsrjKiA2Q/PTOw27FiKf0wEmZgQspJdrm7P++s7G3RI15C4Nebc=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:f781:d5ed:1806:6ebb])
 (user=surenb job=sendgmr) by 2002:a81:ac54:0:b0:52f:45a:5b00 with SMTP id
 z20-20020a81ac54000000b0052f045a5b00mr11ywj.2.1676524717784; Wed, 15 Feb 2023
 21:18:37 -0800 (PST)
Date:   Wed, 15 Feb 2023 21:17:33 -0800
In-Reply-To: <20230216051750.3125598-1-surenb@google.com>
Mime-Version: 1.0
References: <20230216051750.3125598-1-surenb@google.com>
X-Mailer: git-send-email 2.39.1.581.gbfd45094c4-goog
Message-ID: <20230216051750.3125598-19-surenb@google.com>
Subject: [PATCH v3 18/35] mm/mremap: write-lock VMA while remapping it to a
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
        Laurent Dufour <laurent.dufour@fr.ibm.com>
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
index f079e5bbcd57..0eaa3d1a6cd1 100644
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

