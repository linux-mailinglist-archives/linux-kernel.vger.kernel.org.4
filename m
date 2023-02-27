Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8DFA6A482B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 18:37:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjB0RhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 12:37:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjB0Rg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 12:36:56 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82018241CD
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 09:36:52 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-536b7eb9117so153562077b3.14
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 09:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SQNoSLNi/WgstuG55kXE7+m1dHKl+fKKDPrkCWl/DCo=;
        b=J5wmcAzyDZcatSwztTuxgzaYtke6kriIvYIqPT/BFwSZWL+3VmHsJK6pm6uqTXXs0k
         hQBQeTTqtZMXoydWH2EraS1BwJQMWApBWO4fGke8/Jq0OvUOu4cfdsRQ8dDM68VxgizQ
         ztRQr+1fezpVtAc0lp78wCnDR/PHSs/vBVo6WXbM19HIw+eJAf+OKImpXbbC44F1OdAA
         e9ipoEkHKuhTw98suQdXekAHWIPjjRBuGbOkaPOXnZpP2dJYchLjizYibUTfDcgNqsor
         BtPgKlPExQUuIZmGBr+b23UCrNVwj01MSEdyN/KRD26rWer10z6tKSB96K/CBsjdr3nr
         Dy4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SQNoSLNi/WgstuG55kXE7+m1dHKl+fKKDPrkCWl/DCo=;
        b=20XYhyO2+dVezqMN1ZEpsVOlmBF1QI69F/IjMFdtFv62QSIVLQcVcx6kCvjCoFFxyI
         8nQcCyM3E1xUbjBGICZHL36Z30T+yWybjwfW9faKZP2jNT1V1BaInBteyWXTgNGZhdQA
         JyOiLBKSWcYwAt9ps64yirzKcN7TdH/gdCLX6dzxohf4rIsePzEfEuIoJeSVD0hitACT
         45lEB5vOZmVijAGesr9X4lAUYJaGOpaIAUCcqL2ADaFC4sTBM45e18oJSaXnxPNMbokL
         i2Uq9qEfkuf5lLiHiYv68fVHwJjXgl1kmjL3o691nupdNjltMnTFMzl+WM8rNyRQbDLJ
         446g==
X-Gm-Message-State: AO0yUKUjF1jbODVi4J5imfxYVxf3sZp7atb84GrLLrhEM2saI9a207TU
        85eXSXr4JBPgJNXXy4OLYUoili8bMbs=
X-Google-Smtp-Source: AK7set9MzLoXjLMA6aezNIGpaaorfvcTajbjU3PQe8ye5Rv3C1xsvBgDWbku9hWg2h6JXcwKW/yoJy8kVAo=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:e1f6:21d1:eead:3897])
 (user=surenb job=sendgmr) by 2002:a25:e805:0:b0:a5f:0:bf12 with SMTP id
 k5-20020a25e805000000b00a5f0000bf12mr3637071ybd.13.1677519412049; Mon, 27 Feb
 2023 09:36:52 -0800 (PST)
Date:   Mon, 27 Feb 2023 09:36:05 -0800
In-Reply-To: <20230227173632.3292573-1-surenb@google.com>
Mime-Version: 1.0
References: <20230227173632.3292573-1-surenb@google.com>
X-Mailer: git-send-email 2.39.2.722.g9855ee24e9-goog
Message-ID: <20230227173632.3292573-7-surenb@google.com>
Subject: [PATCH v4 06/33] maple_tree: Add smp_rmb() to dead node detection
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
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
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

From: "Liam R. Howlett" <Liam.Howlett@oracle.com>

Add an smp_rmb() before reading the parent pointer to ensure that
anything read from the node prior to the parent pointer hasn't been
reordered ahead of this check.

The is necessary for RCU mode.

Fixes: 54a611b60590 ("Maple Tree: add new data structure")
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 lib/maple_tree.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 6b6eddadd9d2..8ad2d1669fad 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -539,9 +539,11 @@ static inline struct maple_node *mte_parent(const struct maple_enode *enode)
  */
 static inline bool ma_dead_node(const struct maple_node *node)
 {
-	struct maple_node *parent = (void *)((unsigned long)
-					     node->parent & ~MAPLE_NODE_MASK);
+	struct maple_node *parent;
 
+	/* Do not reorder reads from the node prior to the parent check */
+	smp_rmb();
+	parent = (void *)((unsigned long) node->parent & ~MAPLE_NODE_MASK);
 	return (parent == node);
 }
 
@@ -556,6 +558,8 @@ static inline bool mte_dead_node(const struct maple_enode *enode)
 	struct maple_node *parent, *node;
 
 	node = mte_to_node(enode);
+	/* Do not reorder reads from the node prior to the parent check */
+	smp_rmb();
 	parent = mte_parent(enode);
 	return (parent == node);
 }
-- 
2.39.2.722.g9855ee24e9-goog

