Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E809698BAC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 06:19:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjBPFTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 00:19:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjBPFSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 00:18:52 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4285245F6C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 21:18:23 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-52a8f97c8ccso8654047b3.6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 21:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OfsRQat1IE0fDeYSs5Psw7qjLLZE8mkiXmSdSDqQs6E=;
        b=MfUNnuRVqilTlETV75doNo5d3X2f1I64PkztavWwbIZWW2j+3a5GtwWp8jaeE2FAS7
         MLS5o+W6QzlLw73Ic3jcbhKR5fcnDvpJtAm6NUi7rdrBvnG1z5U94zlj5p9Rf6AtiMXB
         /0WTQWR4hibDfKvJz8o49Ph/XAqUGXxJaWOev01ngzcVh9Xd6JHGOFVoBB6DDs9XGB0U
         jDPi/dJdwD6mt/I/Iobb8XMkCnfA0C9OXZWj96tLYiXqom79AFLMHYYopE8HfxvEiMuA
         aI5RyI6LPkvxen53dNb8XfFirBUFuNssxJItswg1uaEv8wS3br6uTFvWft0h1+Cz189K
         IN3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OfsRQat1IE0fDeYSs5Psw7qjLLZE8mkiXmSdSDqQs6E=;
        b=0INJSZZGRj5H2sQcuUY0td4iWSAnT1XYft+W7vQ8n31jU7wcv5lT+ju/qvpI/+FpD1
         FfArRVteTZ9cv+jMavW5HeCtFEYrcHI2Ugb+k5X64pLkARHIVHdz+1DhYsvgEBrvuTBV
         xTZ/i9+TD/KUxEEKaJrwOPLZOt7Tmc8zt/UkfQmu8JCTAqBpqT/LPtj9E7dCSScg7j6c
         AjhAFC0MFGwSexfHTCmz0MMC1VkMGvB/GN82u5fpZ0wyQl/ge9DvnE5aWZuuDeX5lr5q
         pwhPENknly0wFvNT7ibOzStD0vlJLrBCIeH8lbiQI3Fx9jRzxV9V8mey9yNWuwNOeoSr
         6jnA==
X-Gm-Message-State: AO0yUKU8lGwq22vHBgm5Q2nw+NNwVJWO6oDg/HYyQQoONaquZTDnIk6a
        3mV6EVCycZ8+CxePqkBE6iLX6YXgw3c=
X-Google-Smtp-Source: AK7set/k5YICRmbO5PrlJaB9Zo139wu7UxHEXvq6ujpnvYnblxA9RcHNr8XeBP6uxC5C9xnIzXdi58p2CG0=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:f781:d5ed:1806:6ebb])
 (user=surenb job=sendgmr) by 2002:a25:8e8c:0:b0:965:bac9:d458 with SMTP id
 q12-20020a258e8c000000b00965bac9d458mr0ybl.11.1676524701625; Wed, 15 Feb 2023
 21:18:21 -0800 (PST)
Date:   Wed, 15 Feb 2023 21:17:26 -0800
In-Reply-To: <20230216051750.3125598-1-surenb@google.com>
Mime-Version: 1.0
References: <20230216051750.3125598-1-surenb@google.com>
X-Mailer: git-send-email 2.39.1.581.gbfd45094c4-goog
Message-ID: <20230216051750.3125598-12-surenb@google.com>
Subject: [PATCH v3 11/35] mm: move mmap_lock assert function definitions
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

Move mmap_lock assert function definitions up so that they can be used
by other mmap_lock routines.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/mmap_lock.h | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
index 96e113e23d04..e49ba91bb1f0 100644
--- a/include/linux/mmap_lock.h
+++ b/include/linux/mmap_lock.h
@@ -60,6 +60,18 @@ static inline void __mmap_lock_trace_released(struct mm_struct *mm, bool write)
 
 #endif /* CONFIG_TRACING */
 
+static inline void mmap_assert_locked(struct mm_struct *mm)
+{
+	lockdep_assert_held(&mm->mmap_lock);
+	VM_BUG_ON_MM(!rwsem_is_locked(&mm->mmap_lock), mm);
+}
+
+static inline void mmap_assert_write_locked(struct mm_struct *mm)
+{
+	lockdep_assert_held_write(&mm->mmap_lock);
+	VM_BUG_ON_MM(!rwsem_is_locked(&mm->mmap_lock), mm);
+}
+
 static inline void mmap_init_lock(struct mm_struct *mm)
 {
 	init_rwsem(&mm->mmap_lock);
@@ -150,18 +162,6 @@ static inline void mmap_read_unlock_non_owner(struct mm_struct *mm)
 	up_read_non_owner(&mm->mmap_lock);
 }
 
-static inline void mmap_assert_locked(struct mm_struct *mm)
-{
-	lockdep_assert_held(&mm->mmap_lock);
-	VM_BUG_ON_MM(!rwsem_is_locked(&mm->mmap_lock), mm);
-}
-
-static inline void mmap_assert_write_locked(struct mm_struct *mm)
-{
-	lockdep_assert_held_write(&mm->mmap_lock);
-	VM_BUG_ON_MM(!rwsem_is_locked(&mm->mmap_lock), mm);
-}
-
 static inline int mmap_lock_is_contended(struct mm_struct *mm)
 {
 	return rwsem_is_contended(&mm->mmap_lock);
-- 
2.39.1

