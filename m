Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA70F698BA6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 06:18:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjBPFSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 00:18:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjBPFS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 00:18:26 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F413B42BD8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 21:18:10 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id e191-20020a2537c8000000b009433a21be0dso835758yba.19
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 21:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/TbDrnT4JTA4cMZmAjPRNE76LJNgcWEHHiVobOaA+Y8=;
        b=WMbcZd2H6xEYgh8jPBjtr3c52H6Pfawu+33AP54ppxn4975bHziKOFepXARIS5jFg+
         e6WwvlJoOPdxReXGpPCKc/NAAxfX4rbkO7DDbRqhMho2D2UtZ3EYOUrPrXvxo+yY0eM4
         LMQxZ5khHMqm3h0sfllZRxbm/tuunDq1ItomZ38Vc5vIB77wslGrayg6KY3mbC66vptv
         Do13gHFViUDuIVWARk2CRzZ0n21J2khqCauKfFko2Yy6sWDAGtNFzpXO3m4fv/AYk9g9
         lA127TPhorpqkZg7qKdsS4C88Qpbq0ryHT7Lx24g1uyKmp6VAfvqXa/maK1LoDRn6fAx
         1DGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/TbDrnT4JTA4cMZmAjPRNE76LJNgcWEHHiVobOaA+Y8=;
        b=InqrOQHPGViOEwqvQJpC8dX2pF5OhmMmiO6svOisN4Zj+QldjOJbPDmP9KL4H3FvWi
         JAYsllW/hQpCUtUaOx/9tE1k9uhKH85vwc8mu9n3VJp/LVxfxgYbQKgazDrdDvZRGBmj
         ZL/9AwlvFXqpooQlGFCfBI/9gcAHRCrheGK2xDKJrAtu3P8xxHssid068b0VWitF+iWl
         INM7WKd85QzIbSnSWaIp9NX/1TPWdM3KzIWd9FTH4TFS5hJI4Xu/1gAkiyaczr//0O8z
         XKc9SPPK4xqXCQExs7iU02DRfk4e6jt2toTHGosdDKAmDnr/s8SvzgpGLNTjjgJq80Fd
         Dj3Q==
X-Gm-Message-State: AO0yUKXaUWicOVXr0NyTbw6Xz/L02Wuc7Btdwr9dPNBXAp1XmOlyBpBb
        XfS3ZIR5Ulnza8JuZuFAOhlb3zL0F9U=
X-Google-Smtp-Source: AK7set9oeDTHuLB1nfzndbZXzwVBlMHEMtdn96b6e8LnbJxiPKVQLZhG0+zpZpEt4JvzRmnu9oC+9ACRvag=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:f781:d5ed:1806:6ebb])
 (user=surenb job=sendgmr) by 2002:a25:7805:0:b0:8d7:9497:cbb3 with SMTP id
 t5-20020a257805000000b008d79497cbb3mr12ybc.5.1676524689233; Wed, 15 Feb 2023
 21:18:09 -0800 (PST)
Date:   Wed, 15 Feb 2023 21:17:21 -0800
In-Reply-To: <20230216051750.3125598-1-surenb@google.com>
Mime-Version: 1.0
References: <20230216051750.3125598-1-surenb@google.com>
X-Mailer: git-send-email 2.39.1.581.gbfd45094c4-goog
Message-ID: <20230216051750.3125598-7-surenb@google.com>
Subject: [PATCH v3 06/35] maple_tree: Add smp_rmb() to dead node detection
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
2.39.1

