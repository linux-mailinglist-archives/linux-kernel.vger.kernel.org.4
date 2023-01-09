Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEC7B6631E5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 21:54:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237290AbjAIUyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 15:54:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237026AbjAIUxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 15:53:52 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD22755E7
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 12:53:51 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-434eb7c6fa5so104996567b3.14
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 12:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xyMpIuQX3h8xEF8sgRu6qp18jXndG+tVBpDaAHqFUcE=;
        b=fcpOTy1E+3ThlAgpg3hHomgF7jysjdpHFVliFHHbaTXw696G+d4UafDfpkipyR4nuU
         tlOJBreetd3v3dCXyb/Rdewxh5p1khH4cqHcd7IJy4L2zy/b/nqItrk1BUqrfoTrE/cO
         7u4Zqnf/OqJvpx/Forf/3GSWw4rGhAxROXbd0Dn4cjHGhWxv2F6/FkGrRQlT4BSVn9QB
         Gq9sxTxT4dzmvld2wEbl8PkQKZUyemG56T9+2h4MZ3hLbr2uHjNUXIbifPrLJAMZf98P
         qyO5BkbAlxHe07UMVtRr4iqChj93uPwUR0TOsMr/XaxeajQHkPY5F6oCUcd/VOMyVzz5
         1yLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xyMpIuQX3h8xEF8sgRu6qp18jXndG+tVBpDaAHqFUcE=;
        b=DNvomKQppWhF4WxN1TWiLpb7diWj9SAugEWfFfVy3b0WwqqUhbN87HvzkfcFuD/oCO
         DUtLCjb/y9Ky6CaYw5i7BhII5xRoyV+QljBnLHYre9T4cn66JJUPFg01pA+GBzFtO3zc
         RhHVl7703qvHNkrVnFz8jKNeaO9bTFKa4pAvYfgXIHQRV7G8U3+w49RiR9Nz4DP8bR4C
         /5YXfoNVgrH7m6qEG7WDPCG3uze4ynqJbBGVNGc0tMML8JRMiJCh132nHZRdpgNvGi3x
         4/N4pY+f2nsRgnU2NZqVZET8ow92AyPDPOrjrVOh7qwU3o/zi2aQbHaTaUlq7f029LJq
         MslA==
X-Gm-Message-State: AFqh2koFoFDC98djgkA4TVWFAmWy01bMYiNi+Ys8hEdqJS2OtJ4PycVG
        8pcdPqnluk5XhEd42P2HmWLloetlc6o=
X-Google-Smtp-Source: AMrXdXs29F0iyIf9MRCODAQbmPmP2d9pU1gWPBdnTE2PRXcNw1d8zc+w15TjL10LubrEOMnWhSTePMV2FM0=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:9393:6f7a:d410:55ca])
 (user=surenb job=sendgmr) by 2002:a05:690c:299:b0:370:2d8c:8193 with SMTP id
 bf25-20020a05690c029900b003702d8c8193mr1225043ywb.221.1673297630870; Mon, 09
 Jan 2023 12:53:50 -0800 (PST)
Date:   Mon,  9 Jan 2023 12:52:59 -0800
In-Reply-To: <20230109205336.3665937-1-surenb@google.com>
Mime-Version: 1.0
References: <20230109205336.3665937-1-surenb@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230109205336.3665937-5-surenb@google.com>
Subject: [PATCH 04/41] maple_tree: remove extra smp_wmb() from mas_dead_leaves()
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
        surenb@google.com, Liam Howlett <Liam.Howlett@oracle.com>
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

From: Liam Howlett <Liam.Howlett@oracle.com>

The call to mte_set_dead_node() before the smp_wmb() already calls
smp_wmb() so this is not needed.  This is an optimization for the RCU
mode of the maple tree.

Fixes: 54a611b60590 ("Maple Tree: add new data structure")
Signed-off-by: Liam Howlett <Liam.Howlett@oracle.com>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 lib/maple_tree.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index a11eea943f8d..d85291b19f86 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -5510,7 +5510,6 @@ unsigned char mas_dead_leaves(struct ma_state *mas, void __rcu **slots,
 			break;
 
 		mte_set_node_dead(entry);
-		smp_wmb(); /* Needed for RCU */
 		node->type = type;
 		rcu_assign_pointer(slots[offset], node);
 	}
-- 
2.39.0

