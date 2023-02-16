Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3EA4698B9D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 06:18:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjBPFSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 00:18:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjBPFSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 00:18:02 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B405A1BACE
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 21:18:00 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-52ee93d7863so8353547b3.18
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 21:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eiC+Iexfup+RTroKLCxxsKt1sRroZAPvjqioHV2wMiw=;
        b=gSbKQNPX+j8W3tzxYZsRNAblkFTxWANtMyo2LSqGNkakVHWziV6JTyqlohrqDf6nLO
         7F5N7WpIKnXsbFPEflJy25rhat2iqZIJRLZvV94iATncucILtc8zFlPzaxOQpEoApKoJ
         RWEtB6lTCeOcIkp8qbIxk4V683W1L3zeK3vTsHv9Yla4n9gJP1xuJQs99Ms5w5HF3olN
         Kli7prX+XczaCsAJ+8hVggWwSYtxp34C+A6/4yuDSchSQcAT4VW0lygmuaxa708qKR/5
         zV/LK3WvWxvtgplCG5tRDu/7iPKMsNWXdzFiEgVvRQ3tE0ZzhzdCi73gDraIVPZ+cD1H
         1RBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eiC+Iexfup+RTroKLCxxsKt1sRroZAPvjqioHV2wMiw=;
        b=HtBka/XnXeDgIdXq2ejdDwuy3vY3xy3ojb8+iyaKytdNa/2lc2izy2fcHN4lzJv2cg
         c4W+fmKeRC3bXmeGMgxQY/YAKJNx14LEamTrR7icC+gau94X/NyfyGl/HpNVxb4P4saE
         pO5j9VnaED+mDlRsAQTLOf5m5gamElsIps6q+u0DgIVdBtpa9wdGV77s/YrnqPis5ZnP
         nm+yHrcG5Nu0fXHs21Gd/qV/pMN7Puv1FzPP8KlZKntuKoXreDFpKN9RCMkyk6gq/fQs
         xxS/+lwvIEu5pGFdAlApZnNwjGveYSE+GnPkMi2FH7cM/sZdOA9dWuVxrH4te5ZnjaOv
         dEWQ==
X-Gm-Message-State: AO0yUKV9jFICdSO6w4epQYDcm/Ljw362gHscDjCDDbBgZTxRL0MYtcOU
        PwUaHDALWeBoSP+dM8iXNwUrB47rO5U=
X-Google-Smtp-Source: AK7set+h9VKChaGyyozNEu9Udu5uv7zPqiNZXg8WkDwG0C713PEP5x3O9LtVk8xkCPSk1ZyxP2XheyHDpnY=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:f781:d5ed:1806:6ebb])
 (user=surenb job=sendgmr) by 2002:a05:6902:10f:b0:855:fa17:4f5f with SMTP id
 o15-20020a056902010f00b00855fa174f5fmr78ybh.1.1676524678798; Wed, 15 Feb 2023
 21:17:58 -0800 (PST)
Date:   Wed, 15 Feb 2023 21:17:17 -0800
In-Reply-To: <20230216051750.3125598-1-surenb@google.com>
Mime-Version: 1.0
References: <20230216051750.3125598-1-surenb@google.com>
X-Mailer: git-send-email 2.39.1.581.gbfd45094c4-goog
Message-ID: <20230216051750.3125598-3-surenb@google.com>
Subject: [PATCH v3 02/35] maple_tree: Detect dead nodes in mas_start()
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
2.39.1

