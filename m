Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0EF167EEB3
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 20:46:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232078AbjA0Tpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 14:45:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232096AbjA0ToH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 14:44:07 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E399459249
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 11:43:09 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id x8-20020a25e008000000b007cb4f1e3e57so1753144ybg.8
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 11:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2v/Evza9dkU4Ne98Lm6HAWxL8/YazIwD41pmx7joRkE=;
        b=mLwUPJ0nc0ulmmwFoyR9amwtEYn4GV75pogWN7ijAK31MqrZCBgfhijsONjhepzopP
         2wYY2SkQatHOd+vKpDSxYxHFT1IvhzZTwDWuTcrFWygojUbcZe7xPlEiO9BQnq0w9fKe
         z4cHjJJqSwoele+PetnaYF8lewRv+be+h1Bgt+SNNsmNqcyEHhiyYbNRieovHRIQnY7Q
         KgzOHSrbk4QlZX3GRmHUucd8wrsetfG2ey7u2AbUsjqg+O7jZuWXERmenSwIYYomTRZT
         0AcxNZ8Sif0L8fvqzJHXb63zST/Gg9+vMF9oOa1KQZBohhw7ZSFfQ9eLw7FWbw/nE4Qf
         wodg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2v/Evza9dkU4Ne98Lm6HAWxL8/YazIwD41pmx7joRkE=;
        b=QBkDh/fgibMqfPYkzOeT4m1VgVC0juOZbAcCoOZ57g5udLbkyN890b1oCsdQAxOM3f
         gTddq7va9/XEZLpWB0rvdUzsS1Ez7x6STtZbhOs6vp5q1Z5Tw2k4gEaJ4Y5rs2Lvd04V
         Gqzf5TK47TTQ0C7fXMm/2lyz87dWNrgkF8Q4mSNgF895XWd+mrilrNgU77Mgvkelnrx+
         Gcam0vhfYHHtRkPHRP8TUUxeD5zme/V42WJAtm7R8CvetJ1l9zWBc9g80X1RuPo1udEq
         Z+RSyOSXRn4Q48tvMDOb73cjBfdHRveDTo3vFwDGFwR8uaNC6YqRuvBDXkXse3Yf09LQ
         Izsw==
X-Gm-Message-State: AO0yUKWk9EJ52y4Xbqc+d5p7fidh16VmtoDUmMa4x23EsKdkEbGIW74d
        2SSj60s/svTQmHfShakIYk8cjkmdSS0=
X-Google-Smtp-Source: AK7set9kKqDiJe5U7EOGuYIrwgRntRqTHzt+zr2t5qOdc5+YeQS/lL3tZ/xnNoww1dZdAcqE9B1Pln9KCVk=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:4e19:be9:c5d0:8483])
 (user=surenb job=sendgmr) by 2002:a81:b2c6:0:b0:509:5b20:ff22 with SMTP id
 q189-20020a81b2c6000000b005095b20ff22mr917640ywh.328.1674848534136; Fri, 27
 Jan 2023 11:42:14 -0800 (PST)
Date:   Fri, 27 Jan 2023 11:41:02 -0800
In-Reply-To: <20230127194110.533103-1-surenb@google.com>
Mime-Version: 1.0
References: <20230127194110.533103-1-surenb@google.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Message-ID: <20230127194110.533103-26-surenb@google.com>
Subject: [PATCH v2 25/33] mm: add FAULT_FLAG_VMA_LOCK flag
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

Add a new flag to distinguish page faults handled under protection of
per-vma lock.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Laurent Dufour <laurent.dufour@fr.ibm.com>
---
 include/linux/mm.h       | 3 ++-
 include/linux/mm_types.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index fa2b9d6e665e..a6de58bb40c7 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -472,7 +472,8 @@ static inline bool fault_flag_allow_retry_first(enum fault_flag flags)
 	{ FAULT_FLAG_USER,		"USER" }, \
 	{ FAULT_FLAG_REMOTE,		"REMOTE" }, \
 	{ FAULT_FLAG_INSTRUCTION,	"INSTRUCTION" }, \
-	{ FAULT_FLAG_INTERRUPTIBLE,	"INTERRUPTIBLE" }
+	{ FAULT_FLAG_INTERRUPTIBLE,	"INTERRUPTIBLE" }, \
+	{ FAULT_FLAG_VMA_LOCK,		"VMA_LOCK" }
 
 /*
  * vm_fault is filled by the pagefault handler and passed to the vma's
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 88619c6a29a3..c4c43f10344a 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1053,6 +1053,7 @@ enum fault_flag {
 	FAULT_FLAG_INTERRUPTIBLE =	1 << 9,
 	FAULT_FLAG_UNSHARE =		1 << 10,
 	FAULT_FLAG_ORIG_PTE_VALID =	1 << 11,
+	FAULT_FLAG_VMA_LOCK =		1 << 12,
 };
 
 typedef unsigned int __bitwise zap_flags_t;
-- 
2.39.1

