Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7656631E2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 21:54:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237132AbjAIUx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 15:53:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234961AbjAIUxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 15:53:47 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ECF2755E7
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 12:53:46 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id h6-20020a17090aa88600b00223fccff2efso7863654pjq.6
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 12:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GU7SFbwLvAPdD9ofPJY8ZC3AFrLWlaqOvHr/TBsM1Ak=;
        b=cDmwrsTnYnxMRe2M80E4L23YmooQix5wB2D0eUb+oN2Hp3bbyg7HFQB/PgVNLoHyKT
         pK0aWtF4CTk14CmlPxG5u4iqhHXIU+wNQHLdGD94tpFP5D5/s9ok9CC5dVKy7ZTVeaNC
         t3/Bp5EGifXzniBaXl20JHyzpYwXEFHr6vzZDBUr27QQthKbHcJnIlWiGRlMM6UQg0ND
         gIbAYHo5+gFS5Z1JXyH/8Q0hICWyuNm77sn6kp0Bt2Cy3fEKAr803t0EnzzgxBkOELQu
         v2Q/SfqHP/lVu/l9N+v6WarwdrrXQ25UydUZpK32X5OyRK1NLw7E4rGZtvAQp6+5paD/
         Xoog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GU7SFbwLvAPdD9ofPJY8ZC3AFrLWlaqOvHr/TBsM1Ak=;
        b=Jc3+iwdrxu2zn6bEtogwfbBauBNTV2ljdQzckmZE30klt1Qf/28EZKtFcSxDoHF0lE
         Xwao4WKUu6iFEcghBzs00II2UpU8dzsE20OV85fUjR8p2UeVMG3rlBfGFFwZPrt/vLUx
         he03aAM1ooW2+yAmHlyRhlMSMebDIAtZlVg0oweNqVdp+fsWYri+Y3lHMm3d3RFyZbvU
         3PWAgbhyKpDjftYKcTrMPXJwU/VHPoqSeaNBGV/SwK69IcwtK0FXoCE7X9SxeHSeLhH5
         XsGcoT3NB37TIpuW9sUaUTQi1+Wyzgqz85q0wWNFWrOw97o+opyGcUNNgu/5TCCe/qir
         zmMg==
X-Gm-Message-State: AFqh2kogAM7KQMnTsDbILHy4yU/+JJk/8yMRJ5Jl6rbhRXd+kqvcalJ+
        UhB8SYOKF6TtJmplFbbhsy7Tg6j3Wc8=
X-Google-Smtp-Source: AMrXdXsx8jOEqF8lBOHYbim74eUIuqk/BpJXbormK1OrkMgDb8c5pT4kOfmHApmrR7R22KnvvmwfjroHm1I=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:9393:6f7a:d410:55ca])
 (user=surenb job=sendgmr) by 2002:a17:902:c209:b0:177:faf5:58c5 with SMTP id
 9-20020a170902c20900b00177faf558c5mr4095626pll.166.1673297625715; Mon, 09 Jan
 2023 12:53:45 -0800 (PST)
Date:   Mon,  9 Jan 2023 12:52:57 -0800
In-Reply-To: <20230109205336.3665937-1-surenb@google.com>
Mime-Version: 1.0
References: <20230109205336.3665937-1-surenb@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230109205336.3665937-3-surenb@google.com>
Subject: [PATCH 02/41] maple_tree: Detect dead nodes in mas_start()
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

When initially starting a search, the root node may already be in the
process of being replaced in RCU mode.  Detect and restart the walk if
this is the case.  This is necessary for RCU mode of the maple tree.

Fixes: 54a611b60590 ("Maple Tree: add new data structure")
Signed-off-by: Liam Howlett <Liam.Howlett@oracle.com>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 lib/maple_tree.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index ff9f04e0150d..a748938ad2e9 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -1359,11 +1359,15 @@ static inline struct maple_enode *mas_start(struct ma_state *mas)
 		mas->depth = 0;
 		mas->offset = 0;
 
+retry:
 		root = mas_root(mas);
 		/* Tree with nodes */
 		if (likely(xa_is_node(root))) {
 			mas->depth = 1;
 			mas->node = mte_safe_root(root);
+			if (mte_dead_node(mas->node))
+				goto retry;
+
 			return NULL;
 		}
 
-- 
2.39.0

