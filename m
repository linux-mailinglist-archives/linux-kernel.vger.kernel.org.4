Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFE9E663211
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 21:59:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237949AbjAIU6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 15:58:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237782AbjAIU5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 15:57:35 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C27E58CD03
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 12:55:01 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id z17-20020a25e311000000b00719e04e59e1so10333479ybd.10
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 12:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kEbjJObwF3X8F3sFkf3mioj7FiTBVSLxL3AOZVg1QSY=;
        b=b707Zl9+U9/mZ9c+XkHaueCkegKOCNYI/oVAEusRFU63I3srOxecFlDkxyKx//4mW5
         JwP5obEgccip2H4R9+fiuFL4CW2k5fc/GSQhSK1HsVxo3ZKjTR0Lux66eUg0E3PQlBTw
         wXh6GkCABKuopnTH7q3BfoKfyBQ/HE6fsvI1JacGKFSqz7wW0ul/c07mqYyM4k4N+tIJ
         sPYdgU87tyvftSSm83lgw37DswrvUBJMsShqXbiuQjXDGVNwSgoByZHvozZ1Xmfis7g3
         cB964lLozfT6WEMDCdFsl0vR2EiUHB+3pHP9fkmg+z92l6SffusdjR7B04cQIU05PEZE
         4Ang==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kEbjJObwF3X8F3sFkf3mioj7FiTBVSLxL3AOZVg1QSY=;
        b=On5XH7T/XztBTIHK1F0jbT3+7EpKtly/sB/VELy5QXD64CES6fsN4Df0fL6okyF+sS
         cm8TpIp+16HIV2IAmsYDzfFra/o1/rO9Ivt8WkYS+ylN7Frx+hZAW+FjH/qeQ9nw0lt9
         yU+qIWO8ZEZmeOehDze2kSA6MImtN65Cz0M3rv+cJBXSGEQaO7qxTO/VCX56KQ3OcYGR
         k7IPUzZMH0P3CmUqcwIu2YX6DESYCCHF+ZmZ/z/HS9YFEChTsHDD9dl6nmqPMvJR76Ui
         zEn57ofBgclev2pSkbePmANZpd1XidywhVOOEeZWyjD5UCyHeWX9+PgKCMhjYQm+5OfG
         mwiQ==
X-Gm-Message-State: AFqh2kpezNhwfZi/psI2KulaQFNumhrpEUXU/e2Un16i3JiAyyLH5NmZ
        w7SukcgcjZuk8lUTpsf9Bn/1QmgQWGU=
X-Google-Smtp-Source: AMrXdXuMlfQ+hsH5bYnRbFVRQKfHDnoMxNv1bo1mLunTWqhQUT5+3qxDxTtfm+RaU7eYfnfY1D8yBkPOjiE=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:9393:6f7a:d410:55ca])
 (user=surenb job=sendgmr) by 2002:a25:9304:0:b0:7bf:ffcb:79d7 with SMTP id
 f4-20020a259304000000b007bfffcb79d7mr163411ybo.446.1673297701437; Mon, 09 Jan
 2023 12:55:01 -0800 (PST)
Date:   Mon,  9 Jan 2023 12:53:27 -0800
In-Reply-To: <20230109205336.3665937-1-surenb@google.com>
Mime-Version: 1.0
References: <20230109205336.3665937-1-surenb@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230109205336.3665937-33-surenb@google.com>
Subject: [PATCH 32/41] mm: prevent userfaults to be handled under per-vma lock
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

Due to the possibility of handle_userfault dropping mmap_lock, avoid fault
handling under VMA lock and retry holding mmap_lock. This can be handled
more gracefully in the future.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Suggested-by: Peter Xu <peterx@redhat.com>
---
 mm/memory.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/memory.c b/mm/memory.c
index 20806bc8b4eb..12508f4d845a 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5273,6 +5273,13 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
 	if (!vma->anon_vma)
 		goto inval;
 
+	/*
+	 * Due to the possibility of userfault handler dropping mmap_lock, avoid
+	 * it for now and fall back to page fault handling under mmap_lock.
+	 */
+	if (userfaultfd_armed(vma))
+		goto inval;
+
 	if (!vma_read_trylock(vma))
 		goto inval;
 
-- 
2.39.0

