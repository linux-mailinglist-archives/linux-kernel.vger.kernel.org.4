Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8430B67EE94
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 20:44:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231995AbjA0TnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 14:43:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231848AbjA0Tm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 14:42:57 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C966E82421
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 11:42:29 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id p19-20020a25d813000000b0080b78270db5so6347404ybg.15
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 11:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DF9zqRO1prEDm4IKfYXh+Z69pFj8RdYSRvmvJpFQZKM=;
        b=rnpUdmPcBnY7plbcdmS2pwvwnctQIRIqHumfjs2guCuPsY+Dw6YQ2tfutal8HnrgXz
         edy5Yrgey9QhoRSbyw/SmRVhoDEfIcnSP0t0LCmLUom2gJSxBSb6RoRoQ6R6E1A4+8T0
         XcTb3Fhtcz5YcundAJZb+WYoiQCLWWkiPl+/L7XZyu1tWh8b/ENfJXXDc0COCB4H0HVg
         yuAJnUBiF1z/T9ta5KOn1AHf3cQZUH/oUuoUg6oOo5mcl+MifhrO/XwhHeojlZjv/4Mm
         lccC2wtCBVxTksQLP5lorO6u35MCkxakWEmMvAgnG98JEeGI6fsdBcznmI1LtXlDE24U
         yV4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DF9zqRO1prEDm4IKfYXh+Z69pFj8RdYSRvmvJpFQZKM=;
        b=DvFbCFhTP7LJ35OJ5A8wGJSN2PMiyM1gwykU48S9kgEdyQwwVHaQEs5AR6KspwLBF4
         AGd5KYEGutxqqY1yB3aUVyL8acEgDBv9IXVjpgek4KI5vSXhpY5GSJUD9hTUGeWN32n9
         mXtNH1qMPBye6iitsb56bnWmYAjEmuTLV1xznPoQvlZTmiTvqUrocKtc4Jd8htNlb/2A
         L//3LCrnwKyb7t+dY66QrN7Zxvfi3AvwAQTGXQsN1HG+bgd5WhLfNF5kzgzHnLCormvy
         wA8e8qml+MAjDJBltYxP1SFiRSvlxnQl8rlwNXa9diEYM4uZQ7Y7uX27oUAjF71ik+IN
         8ZcQ==
X-Gm-Message-State: AFqh2koyKgevasGTPFVBILuIewlaB/USuAmoldq80VvJoAVgxFg0yPoD
        DYLhxVdWMuBFMpIwK+xa3t+uOuj+SEo=
X-Google-Smtp-Source: AMrXdXs3xZaVcR3p65iqnfy8qe0w+PmLMIhbeI9n6IEvkAzMLp6jSQOzi5T/oBy2kRvdJXFWY9xcFs4GkSg=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:4e19:be9:c5d0:8483])
 (user=surenb job=sendgmr) by 2002:a0d:c8c5:0:b0:4f3:10b1:1351 with SMTP id
 k188-20020a0dc8c5000000b004f310b11351mr5009568ywd.516.1674848483749; Fri, 27
 Jan 2023 11:41:23 -0800 (PST)
Date:   Fri, 27 Jan 2023 11:40:41 -0800
In-Reply-To: <20230127194110.533103-1-surenb@google.com>
Mime-Version: 1.0
References: <20230127194110.533103-1-surenb@google.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Message-ID: <20230127194110.533103-5-surenb@google.com>
Subject: [PATCH v2 04/33] maple_tree: remove extra smp_wmb() from mas_dead_leaves()
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
index 73917dd2c608..75cce2d4d5da 100644
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
2.39.1

