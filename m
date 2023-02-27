Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BDC76A4845
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 18:38:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbjB0Riw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 12:38:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbjB0RiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 12:38:14 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A637024CBB
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 09:37:37 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-536bf649e70so153110567b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 09:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7ZDLcNGctmKqQEDQSm/x/HJRE1p1urqN7vMq9ze3IhQ=;
        b=rSn/HhKulcAt/dXRGMHQok87P5M5E270I0oCS3gZJEWkLWidOpnej1dxaWrgMzWbdZ
         hRegAssYtkAXj68NCwN4NlvBTUXN9bj0pr+BM9FESPqsUtzNJdLfxpMOuaf3C4zcz8AG
         QQ9sSRnDU7Hb4QEga3Ttu8/AwCSxDxNjWb2i9IxegWBslOk4oTQU94dc0rtucLzduQ3Q
         4ozKaX/E5D/Dfa902LgPaXoXtxfZ+pNftUMyHyvMV2xCazmDlSOzCrSiriiDBvuGe/Gm
         12h/Fv6wWsZva2wBOKCzc+/nhceTE6OG2eBLFHaxFB9ziU5glhrshChbsmrwR3lUlmIy
         6zUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7ZDLcNGctmKqQEDQSm/x/HJRE1p1urqN7vMq9ze3IhQ=;
        b=7I+T2+pAVPNV01pQ0w2U9A3DJlLkOvbfBd/y48qUIIoeBXjTRxFKa4RCw5IWDxp/1K
         XBaG878fo4mGVOvpSiA0+5n1edZlqY7gqv/Ebj6J9GlrZaZciyn72KV0du8+kDY8vDiS
         34KZgqAC7QwNznkXYLEo8KciGLe3ipRJvygsxiX/43K37RbZiEgoi4cj1Uu39kWv+oBR
         zm4ofUWaEzVUExKvGiLxA8rrBqAv9tyyYgbPK/3XXJovfTAB7bDAeBid8c5b8E3E70i6
         jglyj394JPilElZ6sVUcR5Pem1ZPDapjhve8KC/RneCtHsD4zXzz558OFU35edOfR/VI
         qqWw==
X-Gm-Message-State: AO0yUKVxQLl6Anxtfe2sl2c41Kdttv9TBjHtv/BRK1ewZ101uKbU8o0j
        EyNm4bVDWxY1ZflfkXgvXl1MSlkbY5k=
X-Google-Smtp-Source: AK7set8grN4JIndM+ly9gt1j/cdj3SHv32UwM9Nv4EN/4JzKqYBKorAEBnSg1fP76/edXWaaLOwjV1mMS3c=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:e1f6:21d1:eead:3897])
 (user=surenb job=sendgmr) by 2002:a5b:406:0:b0:904:2aa2:c26c with SMTP id
 m6-20020a5b0406000000b009042aa2c26cmr9545732ybp.5.1677519456128; Mon, 27 Feb
 2023 09:37:36 -0800 (PST)
Date:   Mon, 27 Feb 2023 09:36:24 -0800
In-Reply-To: <20230227173632.3292573-1-surenb@google.com>
Mime-Version: 1.0
References: <20230227173632.3292573-1-surenb@google.com>
X-Mailer: git-send-email 2.39.2.722.g9855ee24e9-goog
Message-ID: <20230227173632.3292573-26-surenb@google.com>
Subject: [PATCH v4 25/33] mm: add FAULT_FLAG_VMA_LOCK flag
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
        Suren Baghdasaryan <surenb@google.com>,
        Laurent Dufour <laurent.dufour@fr.ibm.com>
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
index 46d2db743b1a..d07ac923333f 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -478,7 +478,8 @@ static inline bool fault_flag_allow_retry_first(enum fault_flag flags)
 	{ FAULT_FLAG_USER,		"USER" }, \
 	{ FAULT_FLAG_REMOTE,		"REMOTE" }, \
 	{ FAULT_FLAG_INSTRUCTION,	"INSTRUCTION" }, \
-	{ FAULT_FLAG_INTERRUPTIBLE,	"INTERRUPTIBLE" }
+	{ FAULT_FLAG_INTERRUPTIBLE,	"INTERRUPTIBLE" }, \
+	{ FAULT_FLAG_VMA_LOCK,		"VMA_LOCK" }
 
 /*
  * vm_fault is filled by the pagefault handler and passed to the vma's
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 45a219d33c6b..6768533a6b7c 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1097,6 +1097,7 @@ enum fault_flag {
 	FAULT_FLAG_INTERRUPTIBLE =	1 << 9,
 	FAULT_FLAG_UNSHARE =		1 << 10,
 	FAULT_FLAG_ORIG_PTE_VALID =	1 << 11,
+	FAULT_FLAG_VMA_LOCK =		1 << 12,
 };
 
 typedef unsigned int __bitwise zap_flags_t;
-- 
2.39.2.722.g9855ee24e9-goog

