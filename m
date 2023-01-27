Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 418C167EE87
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 20:43:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbjA0TnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 14:43:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231783AbjA0Tm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 14:42:59 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A3E584B67
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 11:42:35 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-507aac99fdfso65529237b3.11
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 11:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=A97N+ZL4sr7Moa7VA3MaIfeszXjKUidgl5sbUl4VE3M=;
        b=h4z95aWqlTijLuw2+pa/O521iwctvYJ/JE9Gk94Om8JNdm1J4qRBJ1EfNZDOaurfUb
         h0xAr5ZA79m4jhsd5KmptV8L5YTVXkJEqIIo06fTcAgDWyf2Iw1unXEy8R6f3F+h7n0/
         eKAno27phPvhqEsCndY+cAQm1TD4BuL7gONpQNAXYFn8Kf2q+ZhvCxmCxJsT4hK4blKF
         lDmG8J5RutFJ9mwfq4DqWgfTIN8+TeptwgRlAF+qB5k0K+pf2NR8dkIUNhEjxCEKvwc/
         GAm3buayP+cfA/HX9e16HQfg7j+WzzAIFSLNgZD3Zm/44+VjSwN/Bplr8AdUjUNKklkq
         c5Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A97N+ZL4sr7Moa7VA3MaIfeszXjKUidgl5sbUl4VE3M=;
        b=nMiyFHMJqR8b2ffuEaRwQtF07DKs2Hwn3ZXPEfWZicJGrNC4annzsol19JRM0dBeVW
         PWAaYNKJCBshwA/YVevYrhwU1mTZBK+Wa/L8ULBJL/I7rXR/XsAWhJdoMi1GdmaBlhsp
         KutnA6+FtBtxLIXzYs74wUUud94H7A732GOsYTWWRa8Dg/8/IWP2JUxhHqw9SHVfB+gE
         hVOX0K0aKdNA3lPmgZVqjMSBeQnADpk3FN+rRtMNhfN600qGD/Uwf9TEKMwve909GBW5
         C8Qs1mDRRNfTydx5BMh/6Vsu31TooEGJa4+oDunenpSclGnFDl47NUfCd3THcv0icJ9I
         1oUw==
X-Gm-Message-State: AO0yUKWbdOKiCcfIAT5+/rB0xRlsSBQAXJ83uy5xYMz8sRjqSRkrOxpy
        +qXaoeCVmYvz57CnHzquaIIfijgV3uQ=
X-Google-Smtp-Source: AK7set8r1BYS7Wv/oAXgdJ6+dIiQhgZ/QiambSorQvdFTePlCpS2jC0PmTUUP3dVFKS1ORR7IfLO9gpuOYg=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:4e19:be9:c5d0:8483])
 (user=surenb job=sendgmr) by 2002:a81:9bd6:0:b0:509:5557:c194 with SMTP id
 s205-20020a819bd6000000b005095557c194mr892323ywg.449.1674848488954; Fri, 27
 Jan 2023 11:41:28 -0800 (PST)
Date:   Fri, 27 Jan 2023 11:40:43 -0800
In-Reply-To: <20230127194110.533103-1-surenb@google.com>
Mime-Version: 1.0
References: <20230127194110.533103-1-surenb@google.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Message-ID: <20230127194110.533103-7-surenb@google.com>
Subject: [PATCH v2 06/33] maple_tree: Add smp_rmb() to dead node detection
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
        surenb@google.com, "Liam R. Howlett" <Liam.Howlett@oracle.com>
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
index 49e399e8afaa..859303d2da90 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -532,9 +532,11 @@ static inline struct maple_node *mte_parent(const struct maple_enode *enode)
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
 
@@ -549,6 +551,8 @@ static inline bool mte_dead_node(const struct maple_enode *enode)
 	struct maple_node *parent, *node;
 
 	node = mte_to_node(enode);
+	/* Do not reorder reads from the node prior to the parent check */
+	smp_rmb();
 	parent = mte_parent(enode);
 	return (parent == node);
 }
-- 
2.39.1

