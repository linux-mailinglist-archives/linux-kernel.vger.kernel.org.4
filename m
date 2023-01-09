Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE1906631E9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 21:55:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237561AbjAIUyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 15:54:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235462AbjAIUyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 15:54:07 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3334D76822
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 12:54:06 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id g9-20020a25bdc9000000b0073727a20239so10200306ybk.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 12:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=S7Z9LsPdf1X6x51hAUi2Nm1VlEONIlFgbEepvCuHuj0=;
        b=lU92C8Jcfmul8qFoqZuzCOb83nRDo2DOHABHtbUeff7KpjabsQdodVMIjgjNegm4Ui
         gxUyuAPRcETsiRyXJ5mliOj6g1oYM6B1qnPvTAT1LA3dK82Ds4hQfkrM9RtYlbde0cbx
         i9uLWTSQCuYKj1fxgTqem2OIhsK37AMmmELynCklGF8pD//eviNoFDjhffy4KqRRdQJC
         MSzyVPeVUGI3nBlo70SJ15d8SfW3UoSbvzQXr0uydmfUdXg4Fl9jpjR3RSUiLlvME5Kv
         Z62tI5fReQIg+DMNczYR66QAZbTIG8pGdwhVnCRBmPZaWsdfRkDIb3vX4UMeFSba2+4A
         TcUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S7Z9LsPdf1X6x51hAUi2Nm1VlEONIlFgbEepvCuHuj0=;
        b=35iZIX8Q6oOETnTkGoO3qvd4aVmM+DjFKN5BvA1DhyCMLg94UeDK+ELkc8Q9PfE1se
         iZBO2Q3avgobUVlYyda99gV7k/j0Gq0CGg3K5HgBLTVAWiDKl9Mo+AiDK4DXvS0SWhb6
         O7jVwe6YwUURDIcmE0GLwB7b/+2wf8jvt8HFuwpzFv3/XcWkzjhrWStry7WoDmAC/b3N
         MFXoBJu8LtfQ6w6Z8lodne+MFCZ2DeENlnn+lXg0zsYg6lYt/d8HVGkF/8qEOI8+o5C1
         pvSPOVVnUpc6gLwuZnSydH69DUiOu+OW3dv1a+HZ5s6/w3vjKM6sEUG/h2IGXQz0AgKg
         es/g==
X-Gm-Message-State: AFqh2kpkUXznPRJOPtfJKEmuMrfMJk0cUnDSDvGjnWHloFcRklGc+3y3
        X/zr0zpPHV2vNxWj11sMj44O58E4Aco=
X-Google-Smtp-Source: AMrXdXt5VtatAvHvgu6DDkpLTQLv6tox4QHYgsFVwcGGt6mUkf2zF94ad2ULjvwhvY9gJJrtYWAmbQIwTHs=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:9393:6f7a:d410:55ca])
 (user=surenb job=sendgmr) by 2002:a81:4fd0:0:b0:468:5f78:265a with SMTP id
 d199-20020a814fd0000000b004685f78265amr1632391ywb.87.1673297645909; Mon, 09
 Jan 2023 12:54:05 -0800 (PST)
Date:   Mon,  9 Jan 2023 12:53:05 -0800
In-Reply-To: <20230109205336.3665937-1-surenb@google.com>
Mime-Version: 1.0
References: <20230109205336.3665937-1-surenb@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230109205336.3665937-11-surenb@google.com>
Subject: [PATCH 10/41] mm: move mmap_lock assert function definitions
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        vbabka@suse.cz, hannes@cmpxchg.org, mgorman@techsingularity.net,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        peterz@infradead.org, ldufour@linux.ibm.com,
        laurent.dufour@fr.ibm.com, paulmck@kernel.org, luto@kernel.org,
        songliubraving@fb.com, peterx@redhat.com, david@redhat.com,
        dhowells@redhat.com, hughd@google.com, bigeasy@linutronix.de,
        kent.overstreet@linux.dev, punit.agrawal@bytedance.com,
        lstoakes@gmail.com, peterjung1337@gmail.com, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        jannh@google.com, shakeelb@google.com, tatashin@google.com,
        edumazet@google.com, gthelen@google.com, gurua@google.com,
        arjunroy@google.com, soheil@google.com, hughlynch@google.com,
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
2.39.0

