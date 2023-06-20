Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C25773780E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 01:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjFTX5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 19:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjFTX5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 19:57:31 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91636184
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 16:57:30 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-be7e1d31646so4685638276.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 16:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687305450; x=1689897450;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6My5zaxRwCubM/znAlFWMrzsQs0o4/hMLfIyqDwIdCM=;
        b=CSSYpE6o2vAYB+EczjNxHQoW9ZZEIQkPp00UpPzxbzxvXBVI4La9GGnHYy8QOAimev
         sfzfDqWb0009TEU/RKdrkDPXynJU93p0tuZD9SmZGHcLexKdiOKqZWJHOqcUGvtktcrY
         6STtqvnsGmXhMto4nbyL6fX0OZ5Mm8HfxnS/LYv9XTquxzNy8LHbClyPaVrhoICYyZ/2
         g7WkUN6m7pcrbGPcMrAUVmt45VALmV9NtE5bNAkafpbx7TM/rk6YC/Ke8TslHhaYfECz
         8sS3IXfjPcEJnj01RFYOknIlwJz0+ih21+BBteNcARxJv49L9w0p5ZwII+bz34K/JCZ/
         JX1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687305450; x=1689897450;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6My5zaxRwCubM/znAlFWMrzsQs0o4/hMLfIyqDwIdCM=;
        b=fTP2dqNH0Qu7La1q98t1+3nzBVN642i2q5U6p5/75d1RieybWwialCmzZ5hzWtCbkt
         CAmwdpOlGRq3I5NvoQT++1lh1h5zRv5JDPvrLrv3i3u9deduzctweLzOfGp2rmmS5HX+
         diJMRAJXBiZZfBniZIpU1s6hjOwZeJaAtIwcM4MMX2R6aZKvUlDATACIZIRZq5L7eb14
         2GncxBl2M1ghttmHjKlEEh6W6+IvDCOX71WWsnR2e+5FR4rdft9rFmKSpmLc+EJPj6V2
         RZeF1VU9fcOzc2rN0TN+i6HS3G1qo7GlPbdNlh5pFttDm3uFOE6vx+M18MpJ63L57ym1
         oI0Q==
X-Gm-Message-State: AC+VfDxYLaKjnr6gBZpLriNFpQeRYmi7GiQGNI4YhQOOxk6G6gdwx+0y
        viT3fQJOkjsoxNWY7ukaGE5VidBl7Rk=
X-Google-Smtp-Source: ACHHUZ7lmHtfjY/K80Z1E48r7yvyTtsMdx0YbswhxFGrQ9sy28TJt2rAbO44vsYSrvgTnZ1JPXOfT1sdcAc=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:3f57:9854:e19:8906])
 (user=surenb job=sendgmr) by 2002:a05:6902:91:b0:ba8:6dc0:cacf with SMTP id
 h17-20020a056902009100b00ba86dc0cacfmr1731864ybs.12.1687305449890; Tue, 20
 Jun 2023 16:57:29 -0700 (PDT)
Date:   Tue, 20 Jun 2023 16:57:24 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230620235726.3873043-1-surenb@google.com>
Subject: [PATCH 1/3] mm: change vma_start_read to fail if VMA got detached
 from under it
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     willy@infradead.org, torvalds@linuxfoundation.org,
        vegard.nossum@oracle.com, mpe@ellerman.id.au,
        Liam.Howlett@oracle.com, lrh2000@pku.edu.cn, mgorman@suse.de,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, surenb@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current implementation of vma_start_read() checks VMA for being locked
before taking vma->vm_lock and then checks that again. This mechanism
fails to detect a case when the VMA gets write-locked, modified and
unlocked after the first check but before the vma->vm_lock is obtained.
While this is not strictly a problem (vma_start_read would not produce
a false unlocked result), this allows it to successfully lock a VMA which
got detached from the VMA tree while vma_start_read was locking it.
New condition checks for any change in vma->vm_lock_seq after we obtain
vma->vm_lock and will cause vma_start_read() to fail if the above race
occurs.

Fixes: 5e31275cc997 ("mm: add per-VMA lock and helper functions to control it")
Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/mm.h | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 27ce77080c79..8410da79c570 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -639,23 +639,24 @@ static inline void vma_numab_state_free(struct vm_area_struct *vma) {}
  */
 static inline bool vma_start_read(struct vm_area_struct *vma)
 {
-	/* Check before locking. A race might cause false locked result. */
-	if (vma->vm_lock_seq == READ_ONCE(vma->vm_mm->mm_lock_seq))
+	int vm_lock_seq = READ_ONCE(vma->vm_lock_seq);
+
+	/*
+	 * Check if VMA is locked before taking vma->vm_lock. A race or
+	 * mm_lock_seq overflow might cause false locked result.
+	 */
+	if (vm_lock_seq == READ_ONCE(vma->vm_mm->mm_lock_seq))
 		return false;
 
 	if (unlikely(down_read_trylock(&vma->vm_lock->lock) == 0))
 		return false;
 
-	/*
-	 * Overflow might produce false locked result.
-	 * False unlocked result is impossible because we modify and check
-	 * vma->vm_lock_seq under vma->vm_lock protection and mm->mm_lock_seq
-	 * modification invalidates all existing locks.
-	 */
-	if (unlikely(vma->vm_lock_seq == READ_ONCE(vma->vm_mm->mm_lock_seq))) {
+	/* Fail if VMA was write-locked after we checked it earlier */
+	if (unlikely(vm_lock_seq != READ_ONCE(vma->vm_lock_seq))) {
 		up_read(&vma->vm_lock->lock);
 		return false;
 	}
+
 	return true;
 }
 
-- 
2.41.0.162.gfafddb0af9-goog

