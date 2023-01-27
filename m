Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42EF367EEA9
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 20:46:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232018AbjA0Tpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 14:45:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232062AbjA0ToH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 14:44:07 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A505CD1A
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 11:43:09 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id x8-20020a25e008000000b007cb4f1e3e57so1753366ybg.8
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 11:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dtbb/rgJDVPG5hb8ydKzjEL35WMZYcFrpyL4j03oF8s=;
        b=GSbfUJd90yi2xMLpxJwkNIQoO7AYaRuo1p0W3egBrsgFnTlql/QObCOWtQyWcyCJri
         L9IkPEewPotUja2mT2dWXCpgA9vVmlCVPbr2KFEVViPcTyej+SHFX8+fhAEaOP6xtrM/
         x5eCKOKsLW06Glc5jxntDrg/hIgANLyaiKO4UzofC0FOHh/fDzJT0Gg9GuJf/nEgmEZV
         hix6GjSSYXSWndo4QypjFazRowiaazjUscTvm2uHMbtPJDABgUnEX51b4PI7vURt3LgP
         X4xLvpH0mH+5Sv/7D+0hQE/rAXv1nGKdGusu8zdXbWRFOMqJp4iPgA6p21w37iQT/eTP
         bctw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dtbb/rgJDVPG5hb8ydKzjEL35WMZYcFrpyL4j03oF8s=;
        b=qOUIpBPL+rpft3hZySD7KKTVnepWMqlG6hLPEcKmV4cggdRv1DCq+7V1plUbCs951X
         lxMH/szkt80Br8JxeG/hL0bKBtnz+4Box8316nGao3F1fjd8lEUK6ofTduGEO1YctdHS
         ejvqbRHp/TIV1v5Q+Y2zmBbFzAG4QwyhrGqUObzpVIDH8EeMjkhYzAA6rZGeS/yA+JBc
         ggcv7ztumPD6pY+APTxeGzXS2QpTmAJjOqmhtZuLAZnWLN7He9ZsbLfSZO0lfcYZeC1a
         NKMWQh7o2pLJ9oL98hwmBqsiH5GimfUl5sNpxN1iOqz//I99LkjJt4JRNxQV2DecaMl4
         oMSw==
X-Gm-Message-State: AFqh2kqfZfJYOvJouHXBZLzvGYCzq190xmj8L7HZdkMWzzivaLCejg0S
        KEZOYTGRFj2I+TAVWWInPflYWhwxsJM=
X-Google-Smtp-Source: AMrXdXszwUWrk3+ezT3vpCagEl0mvWZa9sEHax26SYGf7QapJl4fBzpxwL0/6TcVCB7ktvgIaczCkSx6r1s=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:4e19:be9:c5d0:8483])
 (user=surenb job=sendgmr) by 2002:a0d:fc86:0:b0:4db:3ac0:78a3 with SMTP id
 m128-20020a0dfc86000000b004db3ac078a3mr5702708ywf.266.1674848538548; Fri, 27
 Jan 2023 11:42:18 -0800 (PST)
Date:   Fri, 27 Jan 2023 11:41:04 -0800
In-Reply-To: <20230127194110.533103-1-surenb@google.com>
Mime-Version: 1.0
References: <20230127194110.533103-1-surenb@google.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Message-ID: <20230127194110.533103-28-surenb@google.com>
Subject: [PATCH v2 27/33] mm: prevent userfaults to be handled under per-vma lock
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

Due to the possibility of handle_userfault dropping mmap_lock, avoid fault
handling under VMA lock and retry holding mmap_lock. This can be handled
more gracefully in the future.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Suggested-by: Peter Xu <peterx@redhat.com>
---
 mm/memory.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mm/memory.c b/mm/memory.c
index 33ecc850d3cb..55582c6fa2fd 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5256,6 +5256,15 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
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
2.39.1

