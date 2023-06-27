Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5593D73F34B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 06:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbjF0EXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 00:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjF0EXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 00:23:31 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3508D1715
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 21:23:30 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-bd69bb4507eso5587861276.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 21:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687839809; x=1690431809;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=avzs4/2teeLyiygOd/b1Z8yOJdjymCMBXiqSvPvjnU8=;
        b=xItssmSvERMw9dsz1Nh5mK37qPbVAP5IEkuWu1uDTGcdg9Vwz2ARZEnjyozZOEqUuG
         e8uckzXLnLK7yP5FRM7n4SZnRy9wztCXumxHxgkSmrrAMof/XLBanlvGazRLnO/sRoJN
         UCIl1KpUKDC8OR2vK1T4hTMRgAefTBd7NM+Dx6ZXICvZBrXfyNX3TUTCKVgYWm2hUS2l
         gOq88g1izAtjxSu5tZWmDb9LNBvXrPbf9h1PhZMWTUxNWgeVfGL1S4kF5FPib76mtzVI
         DLL3RiWHlMy/zCm8bB7icB7scjmZmtSqhqRFvK87ijBCTPJOJVmbS5n00YK5TtuwF9oT
         e7Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687839809; x=1690431809;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=avzs4/2teeLyiygOd/b1Z8yOJdjymCMBXiqSvPvjnU8=;
        b=eqxObvzZGruAxtqWkuC0fPiAe/hHS1jUrTwA4RQySuO/DTddtTbz82parti/eiFtYB
         ZRFaFLIpntVE8a65IpHh53pmIlmg/m1PnMZ9zNWuWHjNJhlng9yvZeIgAcfWWHQ2Jxu5
         fHdqyIEHRCBLR7iBEb1uG+qi52gk2aHmhrS2ZkHF2rtlSeTS1StpwB3aJL3+fK0ZyGZg
         Ubog3jY3HoBpNy75I2ouUdh9cd9Lu+5DddArlHwUAutNt/L0aWsZQjZ/rLukDuhSd4BK
         QTqGe1nvW1Ht2mBKVfePFfDAKESWZE0qeNqHKLHedubKj4UK2/43L94pCYoDQWvc1L6O
         T/dQ==
X-Gm-Message-State: AC+VfDz8+q/OPENjoGpuyyhVrbRNLcs000q36J1lNxX4mPYwPC/DFwUz
        OcLSWDBBtc6HA6AQTKfWqAPmYgRgTm0=
X-Google-Smtp-Source: ACHHUZ5AuZJxZCfveJ0bV7TxtQYd9lNOfSSAPqhvcXC32iXyNPsD+vrMDeCVzVPvKZJ/jqjM2C5sDhTgrX4=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:5075:f38d:ce2f:eb1b])
 (user=surenb job=sendgmr) by 2002:a25:a28f:0:b0:c15:cbd1:60da with SMTP id
 c15-20020a25a28f000000b00c15cbd160damr2662160ybi.6.1687839809398; Mon, 26 Jun
 2023 21:23:29 -0700 (PDT)
Date:   Mon, 26 Jun 2023 21:23:15 -0700
In-Reply-To: <20230627042321.1763765-1-surenb@google.com>
Mime-Version: 1.0
References: <20230627042321.1763765-1-surenb@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230627042321.1763765-3-surenb@google.com>
Subject: [PATCH v3 2/8] mm: add missing VM_FAULT_RESULT_TRACE name for VM_FAULT_COMPLETED
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     willy@infradead.org, hannes@cmpxchg.org, mhocko@suse.com,
        josef@toxicpanda.com, jack@suse.cz, ldufour@linux.ibm.com,
        laurent.dufour@fr.ibm.com, michel@lespinasse.org,
        liam.howlett@oracle.com, jglisse@google.com, vbabka@suse.cz,
        minchan@google.com, dave@stgolabs.net, punit.agrawal@bytedance.com,
        lstoakes@gmail.com, hdanton@sina.com, apopple@nvidia.com,
        peterx@redhat.com, ying.huang@intel.com, david@redhat.com,
        yuzhao@google.com, dhowells@redhat.com, hughd@google.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        pasha.tatashin@soleen.com, surenb@google.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VM_FAULT_RESULT_TRACE should contain an element for every vm_fault_reason
to be used as flag_array inside trace_print_flags_seq(). The element
for VM_FAULT_COMPLETED is missing, add it.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 include/linux/mm_types.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 306a3d1a0fa6..79765e3dd8f3 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1070,7 +1070,8 @@ enum vm_fault_reason {
 	{ VM_FAULT_RETRY,               "RETRY" },	\
 	{ VM_FAULT_FALLBACK,            "FALLBACK" },	\
 	{ VM_FAULT_DONE_COW,            "DONE_COW" },	\
-	{ VM_FAULT_NEEDDSYNC,           "NEEDDSYNC" }
+	{ VM_FAULT_NEEDDSYNC,           "NEEDDSYNC" },	\
+	{ VM_FAULT_COMPLETED,           "COMPLETED" }
 
 struct vm_special_mapping {
 	const char *name;	/* The name, e.g. "[vdso]". */
-- 
2.41.0.178.g377b9f9a00-goog

