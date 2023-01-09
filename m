Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 940E76631E8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 21:55:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237285AbjAIUya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 15:54:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235639AbjAIUx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 15:53:57 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5EA774598
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 12:53:56 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id r8-20020a252b08000000b007b989d5e105so6925570ybr.11
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 12:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tpY24U65dxDevik5396IsQMXmVZXiLzmW2j6b7ptC2o=;
        b=FGVUXzbMKsAgHtVe2H+ZGPByy9vTxmIYvrPV7ZuF76ZDV4PCOupJdRY2uHLiI7i+8R
         4Fjm3rnOC/ry4DX8g5MN/0YQ4aHPdCQZYFwG7UcSZ/43mvYNjuR6DmjlzCEnl8acF7KD
         ERVaFO4iv0zgtEZ4MmYzhpcYCiFLTkatnznfDTOltPoYyw5CvEIb1yptgTPwDbjWQDix
         pGxXZ1tFpWIKQUAKj6j+gMffNX2JeuA3u7s8cWrwnHHzy9T6apLvHv6bApzCw3vZvb6B
         a2xiK595oO97JhT8ZQYkTmP/j11qoIyiGxI24X5jHCYtpJjinnDlcXs5UPFQKhdZ/Kdz
         DK0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tpY24U65dxDevik5396IsQMXmVZXiLzmW2j6b7ptC2o=;
        b=TO7rP8Kc59XyDQqzqM0my/30gHtjua5O65Yh0CaeCm/ezC+m+04aIdUT964TXyVT+F
         rn558gf0OP6JryPHKswGQVkvqOuHCOcz7MPBV7JMEYifdGr1awHq6vopOZI8Nqny7QOC
         0+ApA8hblSS3tf2D3KuuTiPUa2sUqvFsXCNIR5n7NMOTH1ubjGFsND/zRyrTQX0hdPkv
         nSKhHiNzuahUS/vpQz2ra0SArYWeYdagE9xSwbX2uczRDZ8a8JYneIcGRvrtjHdpx7P2
         f8bkuD4NO+DqhaaINQOMdniMOJLGWyl9oE4NAMfSJv+NL9O2vc0pNin8dLKVNeHrpwyd
         bukw==
X-Gm-Message-State: AFqh2kqqiJtOKmjA/pP0v2vGk+cWnMcjMaumLdcLbau8/ApWG/J6kRkg
        zyY57lyIouv5ZHKXxqY4nv7JgIiMv6Y=
X-Google-Smtp-Source: AMrXdXs5jnkdpf0WLGjSqHJja91Z23ecX2Os+zrAvpCFIdrfHWytTqhc2UPXUEbTUa59RZZK2SYuIAkg8gM=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:9393:6f7a:d410:55ca])
 (user=surenb job=sendgmr) by 2002:a25:2491:0:b0:7ba:cd98:5bed with SMTP id
 k139-20020a252491000000b007bacd985bedmr646916ybk.69.1673297636065; Mon, 09
 Jan 2023 12:53:56 -0800 (PST)
Date:   Mon,  9 Jan 2023 12:53:01 -0800
In-Reply-To: <20230109205336.3665937-1-surenb@google.com>
Mime-Version: 1.0
References: <20230109205336.3665937-1-surenb@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230109205336.3665937-7-surenb@google.com>
Subject: [PATCH 06/41] maple_tree: Add smp_rmb() to dead node detection
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
index 8066fb1e8ec9..80ca28b656d3 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -535,9 +535,11 @@ static inline struct maple_node *mte_parent(const struct maple_enode *enode)
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
 
@@ -552,6 +554,8 @@ static inline bool mte_dead_node(const struct maple_enode *enode)
 	struct maple_node *parent, *node;
 
 	node = mte_to_node(enode);
+	/* Do not reorder reads from the node prior to the parent check */
+	smp_rmb();
 	parent = mte_parent(enode);
 	return (parent == node);
 }
-- 
2.39.0

