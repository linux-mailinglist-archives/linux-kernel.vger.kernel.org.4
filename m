Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9B16A4825
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 18:36:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjB0Rgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 12:36:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjB0Rgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 12:36:44 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C3510DE
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 09:36:43 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-536bbaa701aso152695117b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 09:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lArWv6/BKpLmlLXC6GszXodHEO09dxzXTjGiFRBLB5o=;
        b=Rtawk/5qB+wQAwcC1iD4VXuhoYDvFfWXoR8TLDjNU0mxzXG+OcIc5M1YDwWsJSdzc1
         5ov0BA8i2CNkZg28B06fzU5xhMSs1uI1giDFkRO+7bYBZMhhkWnMlBAHldMBIWHj/nI6
         Se6XX7qnInZ409hEUwR8XAgKIrmPJD89Fz59bDJnlZVSabti6XILWdKtE9EozNXeoXJo
         jeE4G4VS8SUdBqPqEoVdM/8Bov6AoMRWvMj0a5NQOXvkupkTbiI158Odu2A7RSMPsE77
         crrvpWC4xPR29dzTvNq/UerrAnu3X0id5UHZqYhq5AWR42pdWVuHy+UOicXnyhpFqhVJ
         jDJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lArWv6/BKpLmlLXC6GszXodHEO09dxzXTjGiFRBLB5o=;
        b=uCfxwqDNGP9JwCZv3QZGkcrjBZnkJnXhaoOuqtMR1LoQpr+tJ0GryuyUtsv1MrojPd
         wXQJ4uafsBCpfXWWjCgafirgkSe2McL4qpG/HK0XsU4Eeh6FtC3iGfaqP62jQWkLg2WJ
         HeHptlTU4+FpIXEOaFx2DGW+YNUw1WxRtqUCBsieCmSLIzpR9ibibLpXFyllkHJtgF0c
         Lb77qqRoUtoFkrepqjDjBNxm7nFNK0YopWzKWGnH6zIBTOuJui+KXkMY3sDrk1wcGaih
         YNbbqv51b/PC1W/Ndd/EeTHajlnXSMiknoSM/ZNvBZ+LdbxtN0F5pEVp8/eWJccZD9Nn
         odNg==
X-Gm-Message-State: AO0yUKX8KXpQeqK0Al5LxTsWMqsoFoUSBw6s8110dOy1GDRY6ARzCz0F
        doj3ryGqyhbgvRu/eKGQaNyg2P2IVKY=
X-Google-Smtp-Source: AK7set/6BFahylhHoQQLwR3PqP3k7QFJ6TbZ44w6th+v/3oGX1dR6WIuOL9QS1wjUZYjoh9QnZVdIWwPxxI=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:e1f6:21d1:eead:3897])
 (user=surenb job=sendgmr) by 2002:a25:8890:0:b0:a0d:8150:be04 with SMTP id
 d16-20020a258890000000b00a0d8150be04mr7185754ybl.13.1677519402335; Mon, 27
 Feb 2023 09:36:42 -0800 (PST)
Date:   Mon, 27 Feb 2023 09:36:01 -0800
In-Reply-To: <20230227173632.3292573-1-surenb@google.com>
Mime-Version: 1.0
References: <20230227173632.3292573-1-surenb@google.com>
X-Mailer: git-send-email 2.39.2.722.g9855ee24e9-goog
Message-ID: <20230227173632.3292573-3-surenb@google.com>
Subject: [PATCH v4 02/33] maple_tree: Detect dead nodes in mas_start()
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
        Liam Howlett <Liam.Howlett@oracle.com>,
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
index cc356b8369ad..089cd76ec379 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -1360,12 +1360,16 @@ static inline struct maple_enode *mas_start(struct ma_state *mas)
 		mas->max = ULONG_MAX;
 		mas->depth = 0;
 
+retry:
 		root = mas_root(mas);
 		/* Tree with nodes */
 		if (likely(xa_is_node(root))) {
 			mas->depth = 1;
 			mas->node = mte_safe_root(root);
 			mas->offset = 0;
+			if (mte_dead_node(mas->node))
+				goto retry;
+
 			return NULL;
 		}
 
-- 
2.39.2.722.g9855ee24e9-goog

