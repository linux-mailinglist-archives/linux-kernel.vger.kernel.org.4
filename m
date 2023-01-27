Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3DB167EE89
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 20:43:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbjA0Tnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 14:43:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231931AbjA0TnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 14:43:05 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD478A547
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 11:42:40 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id b201-20020a2534d2000000b0080b87d910a2so6435179yba.21
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 11:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OfsRQat1IE0fDeYSs5Psw7qjLLZE8mkiXmSdSDqQs6E=;
        b=Q7jceUjhtfhNXIUFz0/MzwmS5ZgtWEAK+cBK0blt69F8+KIFs/AwOKnAqPB+IEDKT/
         FyLbx1gLVqD34Rlv7gRilV5FNygR87+qF/41EC627UqwDLTg6NJEFnAj/1s6LMME1gBy
         h9D9urWoN0e32uyucIiiCDtt59fZ91UJGpShxrAxprHccHpeDkPGS432b78Iuw1rAi+Y
         PGxS0P/Csnmusy4TpNpOjbr38NhV2uRvkkx/I7vAEJVPhb/fpP3E3BB7l9N5Jq8Ddy4K
         G0deOaLN7bYZJlZOXJL3xM94KhFiD/71EdmjsD4THVYmj7eB4g9ZYLPfdvfcp6yLyVR8
         Oqkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OfsRQat1IE0fDeYSs5Psw7qjLLZE8mkiXmSdSDqQs6E=;
        b=Bfr+txlCYis8bHpMFGgq5vlFNPvsd8cpOWeZybDcNlMvo1og1+9BceuR3DW5a4SDL1
         0q8r3eG3It+MGgyhtmEa/knqmILVulY/92sQsuoPIz4sSWu73bR5rKjl35AiuhhF8v06
         sFfMp8PSLI3ldBvOHQBdT1BTUBpWnRRzhqE4PDxbTq36/SnmYRZ2X+vCIbc3H8urgoex
         k2lv2x9aeWH1rnqWQaIm1DH0biu6uVW0xT3KozbF1cUmdaFqWjw/JJEg+9ABpCLPmb7N
         McZlNrNT2YSfIrrtVnaGIZjNhBTkxBBJ36tf5Xic2kW1jn6Hlpu2dnyOCyGbCS+kveLv
         Du0g==
X-Gm-Message-State: AO0yUKU2P/uugDWxMvSyycdgLaCCnWctXTC2zmyAq4ra6epEZTegdGw2
        erOvZQYa/DOKK4sFywa94qR21YjlVqA=
X-Google-Smtp-Source: AK7set9LIYXWd5UhR4gu2cf1OYz0XpBzDlrTVxbQWEhDgYvTk1OPOqMByF3iTmnXKTsrl+3RDXXXUtjCRT8=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:4e19:be9:c5d0:8483])
 (user=surenb job=sendgmr) by 2002:a0d:f2c3:0:b0:50a:468d:48d8 with SMTP id
 b186-20020a0df2c3000000b0050a468d48d8mr731943ywf.104.1674848498315; Fri, 27
 Jan 2023 11:41:38 -0800 (PST)
Date:   Fri, 27 Jan 2023 11:40:47 -0800
In-Reply-To: <20230127194110.533103-1-surenb@google.com>
Mime-Version: 1.0
References: <20230127194110.533103-1-surenb@google.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Message-ID: <20230127194110.533103-11-surenb@google.com>
Subject: [PATCH v2 10/33] mm: move mmap_lock assert function definitions
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

