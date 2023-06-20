Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08ECC73780F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 01:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbjFTX5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 19:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjFTX5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 19:57:33 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A47F4184
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 16:57:32 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-bfee66a6398so214603276.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 16:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687305452; x=1689897452;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=a/KyKqe8FdTi+g9/IKt8G5I/SC33PtSDDTh0FPFRaVQ=;
        b=djOCkf7sRmJEOqkBFJ1FAWr8LXWtr4BdpV1egpT43a8UfDOVBoBIuOCLxFedXjFa5b
         1QOybvoapiGbw4NqKAvUWz+Fu19NBYstRwQlaC9K679sBdbRylerMVN2GPJl6f40HGRd
         jkUzOBouUCpguF36dwOGv4Mqx54tXxWhHGK35MaM5gY/XnL1tOp4MMdkKJjbjpszTSXG
         +MmeKpVWaqVgIGvTyv3WvYXc4kg3IolRfClLe0BDvx9p80AJntMQZuo8Dm0Z5JpwnDBm
         eulTjrH/K/rDevjtJ8yQo2HNk4iADzua7QHUx9I7o9do4iwPamwNMonQ11jiZ1XTlxGC
         ivrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687305452; x=1689897452;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a/KyKqe8FdTi+g9/IKt8G5I/SC33PtSDDTh0FPFRaVQ=;
        b=ILxhMeoka364MTW8DlMmduAN6PS8plGVx+/66KdujYXbGkF2A+mHD6p0pV96PZeY9l
         zJyn0rzky+sh/c62el62FOTp2hVt+2qLp8r88M0+AEgpSp6Hz6MdmyKd046pJ78i7iao
         TAnoSrUojGyP9QOrkgxCBIiTNDtPPFZYbNJPbXOZqrxnW27vEkJcKKTbmO9ZHsVucYno
         7zu4uHXY5X+qW67PRgWPJz8fRrLld72cBSf3+AQzTinlNGZYOIodoQuadUM3V+WGddBY
         1NrM7+6YkcvI6wmQrqlOXfWo1ZJeqadCucUalBHnVrzVronGDWOrcxeKIkNaUerhU2ZI
         Sxrw==
X-Gm-Message-State: AC+VfDyQjNRB9Yx+B17nRlQXRFTn1L+sPTk5Co7SY0nBr3hGAGzlu4z2
        rgE5AcZisQXQD5td0tGSZlEUQ3HQGeU=
X-Google-Smtp-Source: ACHHUZ6RGKpgQ9EJdSN1FRj/ySFNHpQNXjGlsvUEbgvZMHU1XkTWuCp5dJ4lnRJ4a/8Ly/xUzjteixKvrs4=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:3f57:9854:e19:8906])
 (user=surenb job=sendgmr) by 2002:a25:fc28:0:b0:ba8:5bc9:80fe with SMTP id
 v40-20020a25fc28000000b00ba85bc980femr5330222ybd.1.1687305451896; Tue, 20 Jun
 2023 16:57:31 -0700 (PDT)
Date:   Tue, 20 Jun 2023 16:57:25 -0700
In-Reply-To: <20230620235726.3873043-1-surenb@google.com>
Mime-Version: 1.0
References: <20230620235726.3873043-1-surenb@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230620235726.3873043-2-surenb@google.com>
Subject: [PATCH 2/3] mm: change vma_start_read to fail to lock a detached VMA
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

vma_start_read can successfully lock a detached VMA relying on its
caller to check for vma->detached. Change vma_start_read to include that
check and fail if the VMA got detached.

Suggested-by: Linus Torvalds <torvalds@linuxfoundation.org>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/mm.h            |  4 ++--
 include/linux/vm_event_item.h |  1 -
 mm/memory.c                   | 10 +---------
 mm/vmstat.c                   |  1 -
 4 files changed, 3 insertions(+), 13 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 8410da79c570..74e3033c9fc2 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -651,8 +651,8 @@ static inline bool vma_start_read(struct vm_area_struct *vma)
 	if (unlikely(down_read_trylock(&vma->vm_lock->lock) == 0))
 		return false;
 
-	/* Fail if VMA was write-locked after we checked it earlier */
-	if (unlikely(vm_lock_seq != READ_ONCE(vma->vm_lock_seq))) {
+	/* Fail if VMA is detached or was write-locked after we checked it earlier */
+	if (unlikely(vma->detached || vm_lock_seq != READ_ONCE(vma->vm_lock_seq))) {
 		up_read(&vma->vm_lock->lock);
 		return false;
 	}
diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
index 8abfa1240040..e741098954ff 100644
--- a/include/linux/vm_event_item.h
+++ b/include/linux/vm_event_item.h
@@ -154,7 +154,6 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 		VMA_LOCK_SUCCESS,
 		VMA_LOCK_ABORT,
 		VMA_LOCK_RETRY,
-		VMA_LOCK_MISS,
 #endif
 		NR_VM_EVENT_ITEMS
 };
diff --git a/mm/memory.c b/mm/memory.c
index f69fbc251198..bd666fa20748 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5275,7 +5275,7 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
 	struct vm_area_struct *vma;
 
 	rcu_read_lock();
-retry:
+
 	vma = mas_walk(&mas);
 	if (!vma)
 		goto inval;
@@ -5306,14 +5306,6 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
 		goto inval;
 	}
 
-	/* Check if the VMA got isolated after we found it */
-	if (vma->detached) {
-		vma_end_read(vma);
-		count_vm_vma_lock_event(VMA_LOCK_MISS);
-		/* The area was replaced with another one */
-		goto retry;
-	}
-
 	rcu_read_unlock();
 	return vma;
 inval:
diff --git a/mm/vmstat.c b/mm/vmstat.c
index c28046371b45..5d6acdb1b611 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1403,7 +1403,6 @@ const char * const vmstat_text[] = {
 	"vma_lock_success",
 	"vma_lock_abort",
 	"vma_lock_retry",
-	"vma_lock_miss",
 #endif
 #endif /* CONFIG_VM_EVENT_COUNTERS || CONFIG_MEMCG */
 };
-- 
2.41.0.162.gfafddb0af9-goog

