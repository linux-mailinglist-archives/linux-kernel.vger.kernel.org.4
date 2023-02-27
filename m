Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 850726A4829
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 18:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbjB0RhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 12:37:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbjB0Rgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 12:36:55 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D7BC23C72
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 09:36:48 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-536b7eb9117so153558437b3.14
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 09:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fnkDgHrJ0cqyk4yVnPbndf59jVemOaMLlO/iS92oZbE=;
        b=cLE4KbCrSo3Ipu4g+yzfkRmcncyjiA+PVjyxhSlE0CxpbROsbbX5H0DHpPWYcZcUvL
         IgBczq5t3IK+5ladr1TbWOx/+SU8LSbf8Yx9jr8PkelvEstvvhZXeX43s6JTSESoyEye
         3OJvntBP7bSxCk5pBrTwRFBtDhh/o6VDU9KVAovEJZ9n4EduivQuGfxt0pt6fskiyQUB
         zHwyjGzqyAJgiciJUq8aC5hSo+rK3+lmuiggplyhk0zrZZEyghcsffT9pFo2TSF/swmL
         j04i+/EYbcR8DTa/IGgGuaUtWO9uflgS4pwivCZBPdFnqw+L6jKJzSVJqswEg+Tmf1nw
         9kkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fnkDgHrJ0cqyk4yVnPbndf59jVemOaMLlO/iS92oZbE=;
        b=lx4bTmzhD6PUNha9qcuzKOkVzC+JZVUMTBSIhOR4/2ut/RwxxGNJoe76YjSAJweiup
         DAyfPMicJAkrWODdgT7f63gFPAUKRDD+spfeyqCyTpN90yy+nnWMfcV+NQRMerQwWF20
         +D0/Cyi6EeBk6iQNPY2NYTRqxO3lPiQZ360O7mcmKp3eO8B72nmqEFE7jfGeXFid0e2Z
         J3LGJHHG2Bvk73AARTWXcZyL71OAHUQ07iSCKc9Hc27wluOX4/31dV2PHADml9Le83He
         60K4rdeWLhbqL1tPx82QC4wN7dYWqfiezy/qB1swfs5TaMW9LwRF6htZmmYhGct3IaUk
         0/Sg==
X-Gm-Message-State: AO0yUKWYNsos3WrlS12kTrY7UtM1XEetRPL7cXc1zf7/7G3hx8GeLE9A
        hKgnNraaIem3MtQwnO0F5f/kYoYhk9M=
X-Google-Smtp-Source: AK7set9OxVnGQxF1LzHrZxP47amBuaMy7ZRonNPJ1uJTtUoNYZIGL83gP4W8p3rUFsPEboBNOudLGUD3TJ0=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:e1f6:21d1:eead:3897])
 (user=surenb job=sendgmr) by 2002:a05:6902:34f:b0:a35:f3f2:7deb with SMTP id
 e15-20020a056902034f00b00a35f3f27debmr14636ybs.250.1677519407298; Mon, 27 Feb
 2023 09:36:47 -0800 (PST)
Date:   Mon, 27 Feb 2023 09:36:03 -0800
In-Reply-To: <20230227173632.3292573-1-surenb@google.com>
Mime-Version: 1.0
References: <20230227173632.3292573-1-surenb@google.com>
X-Mailer: git-send-email 2.39.2.722.g9855ee24e9-goog
Message-ID: <20230227173632.3292573-5-surenb@google.com>
Subject: [PATCH v4 04/33] maple_tree: remove extra smp_wmb() from mas_dead_leaves()
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
index 44d6ce30b28e..3d5ab02f981a 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -5517,7 +5517,6 @@ unsigned char mas_dead_leaves(struct ma_state *mas, void __rcu **slots,
 			break;
 
 		mte_set_node_dead(entry);
-		smp_wmb(); /* Needed for RCU */
 		node->type = type;
 		rcu_assign_pointer(slots[offset], node);
 	}
-- 
2.39.2.722.g9855ee24e9-goog

