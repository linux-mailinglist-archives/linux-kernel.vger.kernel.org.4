Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94F15683AE2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 01:01:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbjBAABh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 19:01:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231469AbjBAABd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 19:01:33 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0155C1024B
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 16:01:28 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id p19-20020a25d813000000b0080b78270db5so17980762ybg.15
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 16:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bxtFPzszSwirgU1/0J+PiMZRXMSQgSBrsapRb9QUY2A=;
        b=Rk9+8STvrqcbQlKiAZtMBFXlHokjI0hFJPEVyGKrBrbMfUwZG8qeTJEuvgsTMPrddh
         QBvNTohEnVdpbnlrXIgz3Ikz6D2cz4x6un8ohdjcDpAfu7gZ17WU+drJlhJu9Qtc4X1w
         EN1waKUDwB0WD09JdlRGgqA2ctv2OIzWCDINQo+peotxUMRoWPkFgEen/RotX4SxEykY
         LuacT9neZvFmURFR16w8DaONfwFwVOcr03mG+PjT2JsZXXZmxD4X3lmTqKTBd5FY/kIG
         JWR8f0Sx+Z/NFa0Ne873ZtAwDgad97njkhjjwAf7i14upKxsl5EruUIt4SUZYeig/N3q
         ro2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bxtFPzszSwirgU1/0J+PiMZRXMSQgSBrsapRb9QUY2A=;
        b=PdKlbWUtySgUlFUD5NLTVWV+CVlrUxDHqqp5Axz7XLxIeZDGH7g88Vpnev+bGAFrCz
         dkXO1zQxd6Qc3ixW+PmrD/IQXm8jKtZDyOpCmxWM4Vp7WMEqgdJTi2p68XdobtUdVy1m
         cn50C4eTc+dBl5utO/9QN0ligiPXU/Hoqt0pSVzBeMN+OHjCJLLcMUEQdLxjXASkES2T
         vl7KOlyGSLFlg1N2ux3zUIc7Jl/+2nCbp86YJ9aqFKmjDg2k8hxDI3nOFpkpVuzM9hzX
         o9lgpeBQyayHDLzsBfFtJdWIs/RTo5kndRveBPzlwUjAE9Jk6Pc7xYgtsZZ2yUNyRCoY
         k8gg==
X-Gm-Message-State: AO0yUKULE6yk9dU1rbiKC/kpJb0IXVI65lB3jZTyyAA6fQpqwaUS3XIf
        Ow2z0C1TXKoK/1okyCdYZ0dtDRPNX/o=
X-Google-Smtp-Source: AK7set8qCAXBbF1QMD7keC0/SZMMktYNysM7vnt2K6tJydZhJP2e/r9qdYRWK1+YTYhm0sm9RG76XRb3Zl4=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:3d02:e79b:d9e3:ddd3])
 (user=surenb job=sendgmr) by 2002:a81:204:0:b0:4db:df79:a7c7 with SMTP id
 4-20020a810204000000b004dbdf79a7c7mr21711ywc.515.1675209688185; Tue, 31 Jan
 2023 16:01:28 -0800 (PST)
Date:   Tue, 31 Jan 2023 16:01:16 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Message-ID: <20230201000116.1333160-1-surenb@google.com>
Subject: [PATCH 1/1] mm: introduce vm_flags_reset_once to replace WRITE_ONCE
 vm_flags updates
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
        rppt@kernel.org, 42.hyeyoo@gmail.com, jannh@google.com,
        shakeelb@google.com, tatashin@google.com, edumazet@google.com,
        gthelen@google.com, gurua@google.com, arjunroy@google.com,
        soheil@google.com, leewalsh@google.com, posk@google.com,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
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

Provide vm_flags_reset_once() and replace the vm_flags updates which used
WRITE_ONCE() to prevent compiler optimizations.

Fixes: 0cce31a0aa0e ("mm: replace vma->vm_flags direct modifications with modifier calls")
Reported-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
Notes:
- The patch applies cleanly over mm-unstable
- The SHA in Fixes: line is from mm-unstable, so is... unstable

 include/linux/mm.h | 7 +++++++
 mm/mlock.c         | 4 ++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 5bf0ad48faaa..23ce04f6e91e 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -648,6 +648,13 @@ static inline void vm_flags_reset(struct vm_area_struct *vma,
 	vm_flags_init(vma, flags);
 }
 
+static inline void vm_flags_reset_once(struct vm_area_struct *vma,
+				       vm_flags_t flags)
+{
+	mmap_assert_write_locked(vma->vm_mm);
+	WRITE_ONCE(ACCESS_PRIVATE(vma, __vm_flags), flags);
+}
+
 static inline void vm_flags_set(struct vm_area_struct *vma,
 				vm_flags_t flags)
 {
diff --git a/mm/mlock.c b/mm/mlock.c
index ed49459e343e..617469fce96d 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -380,7 +380,7 @@ static void mlock_vma_pages_range(struct vm_area_struct *vma,
 	 */
 	if (newflags & VM_LOCKED)
 		newflags |= VM_IO;
-	vm_flags_reset(vma, newflags);
+	vm_flags_reset_once(vma, newflags);
 
 	lru_add_drain();
 	walk_page_range(vma->vm_mm, start, end, &mlock_walk_ops, NULL);
@@ -388,7 +388,7 @@ static void mlock_vma_pages_range(struct vm_area_struct *vma,
 
 	if (newflags & VM_IO) {
 		newflags &= ~VM_IO;
-		vm_flags_reset(vma, newflags);
+		vm_flags_reset_once(vma, newflags);
 	}
 }
 
-- 
2.39.1.456.gfc5497dd1b-goog

