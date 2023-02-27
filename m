Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECCFA6A4846
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 18:39:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbjB0RjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 12:39:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbjB0RiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 12:38:20 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ECCC241EF
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 09:37:42 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-536a4eba107so153324157b3.19
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 09:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GQTFxYC9vfA9jf0qnv7gyPX3j3jACtIk3rCkUF/FJDY=;
        b=ltU27wOgGhATSjAgpKpsKxT2cYCgBXmJjPP7Vlf66xgvCPyy9Y+Q9/fs6W0SzgF7Jz
         AXhDZAKO1i4O/EUJVs8bawuizzatT9I4VypR9NCPeHEKAKGbhmDhab1/2DAQYWqdJDRL
         SlVcHXqIAb6AFOFtWd+XMHyyClJx99DPXWU2Oc6Hu8D9kLp3zMzECqCZ3BlXkfECm7ag
         vCaq44G6you6yfY7K1dBcUrSymqL5XjWSs2bzGHgp5mJNuIzmcdPLIfUbaNclxIn5eWy
         D+XKgbxlwvwdAgDoeqhoNS8X6MSQFy0GYxkz6nxN9qX46TIoCwJZF4rSw2+QWBYvnyX8
         AYFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GQTFxYC9vfA9jf0qnv7gyPX3j3jACtIk3rCkUF/FJDY=;
        b=gSSA39FuZ9YYOzaCXOwot6McLcK/dVo4hRn8L5m2ChUPc1EhjsAyUFxxGdlgWEUzgX
         0sj5u/MLOTsBsr0ba1MPphYTWo1iyJhWPVVxOJnvPP4PsKNDDbi4fkkUt/UjgPDFfSBl
         cN6a7k/Ind58YBpwKbEVDFog9HjiZLD6jmYAEKr8kCI93Y5wvbFiZTus9XCY6zIjjlrF
         iAv1L9lpYV+An1lSR7dejsMWEwBr0D0nlagBlQXj6PL4fgQCEF+XvDOXIBgzSLNcB28c
         /88ibp/GNbEU02P/zISYkE7T23bstNfyznOTAxzwWCn0zJOo3Qm+usV0lD9/fXxiU4xM
         GEmA==
X-Gm-Message-State: AO0yUKWiXfz6EPUIxmYrvAPojVbc1png1U0hxDoSeA1PSz8oV3/w0TDj
        rMM22zOSaCBBbe3tDMEj6FesxROyXJY=
X-Google-Smtp-Source: AK7set9z2RIB1+MnUTCI+d6tD2+X/XlUvgLJksvCvzE5szG4B6uXrDxC8Bbk9Da1F9i9cjnu9YsjeU4IwLs=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:e1f6:21d1:eead:3897])
 (user=surenb job=sendgmr) by 2002:a0d:ca10:0:b0:52e:e6ed:3094 with SMTP id
 m16-20020a0dca10000000b0052ee6ed3094mr727498ywd.532.1677519461069; Mon, 27
 Feb 2023 09:37:41 -0800 (PST)
Date:   Mon, 27 Feb 2023 09:36:26 -0800
In-Reply-To: <20230227173632.3292573-1-surenb@google.com>
Mime-Version: 1.0
References: <20230227173632.3292573-1-surenb@google.com>
X-Mailer: git-send-email 2.39.2.722.g9855ee24e9-goog
Message-ID: <20230227173632.3292573-28-surenb@google.com>
Subject: [PATCH v4 27/33] mm: prevent userfaults to be handled under per-vma lock
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

Due to the possibility of handle_userfault dropping mmap_lock, avoid fault
handling under VMA lock and retry holding mmap_lock. This can be handled
more gracefully in the future.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Suggested-by: Peter Xu <peterx@redhat.com>
---
 mm/memory.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mm/memory.c b/mm/memory.c
index af3c2c59cd11..f734f80d28ca 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5255,6 +5255,15 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
 	if (!vma_start_read(vma))
 		goto inval;
 
+	/*
+	 * Due to the possibility of userfault handler dropping mmap_lock, avoid
+	 * it for now and fall back to page fault handling under mmap_lock.
+	 */
+	if (userfaultfd_armed(vma)) {
+		vma_end_read(vma);
+		goto inval;
+	}
+
 	/* Check since vm_start/vm_end might change before we lock the VMA */
 	if (unlikely(address < vma->vm_start || address >= vma->vm_end)) {
 		vma_end_read(vma);
-- 
2.39.2.722.g9855ee24e9-goog

