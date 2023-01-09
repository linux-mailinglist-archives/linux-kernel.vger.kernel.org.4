Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 854AA663210
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 21:59:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237860AbjAIU6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 15:58:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237451AbjAIU5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 15:57:35 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 365078D5D1
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 12:55:01 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id t13-20020a056902018d00b0074747131938so10285211ybh.12
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 12:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=B6J4oGWYAsMb5e7sz4HwYEXURXCKE081WlUNIaNvLis=;
        b=RmMHlCmm38xVKeEsK8n8bfn/aY3rbZqU5QjWJwlg7PYpTvR8g1QwX79gxnClyI+zIW
         JCQh5e4SjFQ2Q8nxF5bjIKp19Ks1VtVZP+kR4i8xND+6Fj+6CTJ8vlU6n1mfUhVhmmz7
         +sE7byDQX+/dNdDepWb8tj8CSiQt6RCyFFAm480IRiAV2JLM0c7a5e0c36lCq09bYHwP
         wg+XvRL1iHdJUlNZBka6/ieT4oXpnPfG2/UuJktrbb0wvhMWj6jl5RcTqQ78qy0Rsk8c
         4BQSRlXhCecUdC5ZETwJhxsGpmEcobjcEL9EE3pAQY+ImA2TDfMr31CaGMQDdx5w7rZe
         dkaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B6J4oGWYAsMb5e7sz4HwYEXURXCKE081WlUNIaNvLis=;
        b=OYu0cg5uScXr9lHNabXtT2qxo8FVN8pBbHLdBGUSsle74ct5ohvXGZS749Y+FWc88J
         ZBjsH6l7MqFt0DoproH793BZnyjTbhqVG9HJvNEogIJTK09PRYOEnZPxxNBYs6JSNwQX
         RAC/YB0v0rkxouYe5QzVbYrg5j7M70hJ1Z5x62T7fCDgeIIieb1FXeMWdIBFXFkjMzLt
         exniDaYnXpgvAZ0AzeQolyRGKvgKUTN86yz0nTnPXITGRHQvJnjOx16E8aryuF0sLXFS
         /p7vZMgbmoDjfPvtsch5HY4Wxo0kSkq5kyf1D0vS6bJCHg8wT2U21qbBaOgQSbTKDgI8
         2Lhw==
X-Gm-Message-State: AFqh2krUiYnp2V4R+uYWIKASmmK2/KuHbyg+DM4w9u3Zf7nioRec/r4r
        PAAtCE4RLgqeVySQU+m5F6G+HXiQuVo=
X-Google-Smtp-Source: AMrXdXvwV2DJ0LbEXE5ZgdwVnwlID+Hh7Y6icoi6WDsC3E+JAvvNZYvjiQv0jw9VN21R/xnRr9wwO4IvIuA=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:9393:6f7a:d410:55ca])
 (user=surenb job=sendgmr) by 2002:a25:e7c7:0:b0:7bf:cf52:ede5 with SMTP id
 e190-20020a25e7c7000000b007bfcf52ede5mr196156ybh.626.1673297696306; Mon, 09
 Jan 2023 12:54:56 -0800 (PST)
Date:   Mon,  9 Jan 2023 12:53:25 -0800
In-Reply-To: <20230109205336.3665937-1-surenb@google.com>
Mime-Version: 1.0
References: <20230109205336.3665937-1-surenb@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230109205336.3665937-31-surenb@google.com>
Subject: [PATCH 30/41] mm: add FAULT_FLAG_VMA_LOCK flag
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
        surenb@google.com
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

Add a new flag to distinguish page faults handled under protection of
per-vma lock.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Laurent Dufour <laurent.dufour@fr.ibm.com>
---
 include/linux/mm.h       | 3 ++-
 include/linux/mm_types.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index d0fddf6a1de9..2e3be1d45371 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -467,7 +467,8 @@ static inline bool fault_flag_allow_retry_first(enum fault_flag flags)
 	{ FAULT_FLAG_USER,		"USER" }, \
 	{ FAULT_FLAG_REMOTE,		"REMOTE" }, \
 	{ FAULT_FLAG_INSTRUCTION,	"INSTRUCTION" }, \
-	{ FAULT_FLAG_INTERRUPTIBLE,	"INTERRUPTIBLE" }
+	{ FAULT_FLAG_INTERRUPTIBLE,	"INTERRUPTIBLE" }, \
+	{ FAULT_FLAG_VMA_LOCK,		"VMA_LOCK" }
 
 /*
  * vm_fault is filled by the pagefault handler and passed to the vma's
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 0d27edd3e63a..fce9113d979c 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1103,6 +1103,7 @@ enum fault_flag {
 	FAULT_FLAG_INTERRUPTIBLE =	1 << 9,
 	FAULT_FLAG_UNSHARE =		1 << 10,
 	FAULT_FLAG_ORIG_PTE_VALID =	1 << 11,
+	FAULT_FLAG_VMA_LOCK =		1 << 12,
 };
 
 typedef unsigned int __bitwise zap_flags_t;
-- 
2.39.0

