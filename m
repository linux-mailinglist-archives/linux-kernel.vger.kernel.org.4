Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 661625F3947
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 00:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbiJCWpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 18:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiJCWpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 18:45:46 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24D8E5A3DB
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 15:45:44 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id y65-20020a25c844000000b006bb773548d5so11414891ybf.5
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 15:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date;
        bh=2D8PxGUCZHsFgO4lCALcKFXM0FNRUUxMOX6ZaOvyf7A=;
        b=EaUMjMrkuO/0pzj10phRZC8Q7qXSACWOml8Jvm2ZC8i19LqKtL4T83KCavNRJdubyb
         2+EKTRtteHA5pHi7qjDroOtPwD/Z3oXqvABLTXrJVcHc+8+s6HFFUPN4flJeI0Hzefjj
         p3u6GlXphseRDM0bbV6z/rprG87ZibXpxf/2wQs+oftxc4ZL+VNmkDar9OM4wk0N794o
         V6PvV2xvNkehWWIuG98aFQg0V2nLelgK0F3oM9q2qczH+sOczMtLHEDzz4Z5qFxFge+6
         wOrZSJvPC52pPQ8SywgPEO7Guag1ZF4Nu3bFtKYhFXveU7omnu+gkmuxMe+J/H91F1mm
         Rciw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=2D8PxGUCZHsFgO4lCALcKFXM0FNRUUxMOX6ZaOvyf7A=;
        b=GTDesCLM590kFX2L+fR3zXl0WkEB2BSZstnwzo5CXPri2Zb6Es3Yr/mUf5ZPT2LjWd
         Bu1Osp54Lxp+OY4FhCOceFJOduleC+32IMi4ke7RHHJ0HGLPou6OSJ5MtNQcOwWhIMF9
         JroP9SFTRFFEWlu+QzJIUqDTPZPGIddX1xlRe/rYhBuiqSui7FAartsEXHj6SH94dJkR
         UOs1EyFaF8y59TMcnB8gQBlaBu/gppzROkDqngOHyyT8NzPW4WrZkyCzPvIPA7bLDKT2
         xMTh6gBOh+6HaJJO28AOYhw8VvxVf37W3mpEThZ2GjSzM5OZaSR1AoSNhvrW+kkELRht
         vMKQ==
X-Gm-Message-State: ACrzQf3lwy2AjZcaYgFACTbkYcnrjq5390/SYMtKS9KGAhqYfqQmWl0e
        9zCGIWqE6eY0AD1ibSfUQebSrcOibp5iu+ZYfw==
X-Google-Smtp-Source: AMsMyM64B2YS6PMg7/9SgtM+m8Osn9M/a/x6JzdrTZ5MyLjtOSW9gSWbKfpy3xDMzkBAhE0YRkyVpH8pDLEGC3Vo6w==
X-Received: from roguebantha-cloud.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:1eee])
 (user=sethjenkins job=sendgmr) by 2002:a25:ac4c:0:b0:6be:2d74:a33f with SMTP
 id r12-20020a25ac4c000000b006be2d74a33fmr378047ybd.379.1664837144053; Mon, 03
 Oct 2022 15:45:44 -0700 (PDT)
Date:   Mon,  3 Oct 2022 18:45:31 -0400
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221003224531.1930646-1-sethjenkins@google.com>
Subject: [PATCH] mm: /proc/pid/smaps_rollup: fix no vma's null-deref
From:   FirstName LastName <sethjenkins@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Seth Jenkins <sethjenkins@google.com>,
        Jann Horn <jannh@google.com>, linux-mm@kvack.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Seth Jenkins <sethjenkins@google.com>

Commit 258f669e7e88 ("mm: /proc/pid/smaps_rollup: convert to single value
seq_file") introduced a null-deref if there are no vma's in the task in
show_smaps_rollup.

Fixes: 258f669e7e88 ("mm: /proc/pid/smaps_rollup: convert to single value seq_file")
Cc: stable@vger.kernel.org
Signed-off-by: Seth Jenkins <sethjenkins@google.com>
---
 fs/proc/task_mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 4e0023643f8b..1e7bbc0873a4 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -969,7 +969,7 @@ static int show_smaps_rollup(struct seq_file *m, void *v)
 		vma = vma->vm_next;
 	}
 
-	show_vma_header_prefix(m, priv->mm->mmap->vm_start,
+	show_vma_header_prefix(m, priv->mm->mmap ? priv->mm->mmap->vm_start : 0,
 			       last_vma_end, 0, 0, 0, 0);
 	seq_pad(m, ' ');
 	seq_puts(m, "[rollup]\n");
-- 
2.38.0.rc1.362.ged0d419d3c-goog

