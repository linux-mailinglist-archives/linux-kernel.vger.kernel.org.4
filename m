Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F23766631EF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 21:55:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237479AbjAIUy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 15:54:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237271AbjAIUyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 15:54:03 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D187E7A39C
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 12:54:01 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id a4-20020a5b0004000000b006fdc6aaec4fso10372319ybp.20
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 12:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bU2TYXI/IQ+ahWPrvtMjvIvPP35LcWsiAJFQ60YWV8o=;
        b=hJQlgWQOwjt9bdNS4iNCFQHGlLFypCJo9NibsA7lH+Cj66pCbZCU+CxVh9F7A2fm7T
         vmlH3bAYg1kSOc6vTNCehxfbrsiSwMkUwfklPcXaZBTBOgsQNuQ1lURfneHqEpASj7ak
         72wsJeHj+71ppFuT3bry8xcf97dMVhsy87IzDxduellVAKg7BiJc4vIK8HA7ompTnbjq
         +gURuiw11LvdH0ad+L6DkctzinvpOQbzYQIPe9DQz0Et4Siymb/UJSUp4isr8x/TUfSb
         z+/96aen7RzYU/fA94YBNLJOwTLnQ/SBQCaJx176+XVEeqKe1Aaxg+5hL1pkiSz0xMHc
         S9Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bU2TYXI/IQ+ahWPrvtMjvIvPP35LcWsiAJFQ60YWV8o=;
        b=6ankpYhCrBJCI3tw4GGTUQA78ZhrF3vS+bvjens+A2YtAzNBYbmBSbbinpq8oluG1t
         DEZzzV7WlvGepKkcL16ExPrCsikPRMXG4IMrAyDotyfC1HoG4HQDrsLpBNzdpGX4gEUP
         xWqVFACS8BDHBG1kche1+ysOytcAtr2paDTSUYiHz8yJPnErYJjAoGgtXtunGT5Ha7lz
         su5n5jL3MrrlpVD+w4DDJEVaTU+W7/pdWmio9cKWCi7SOZCVcENXIzrusBxIwE/oUQWQ
         09EdWC3pfY1xNhblOW9226aQmFtJKb+iyDY1D8nXDt5S4L1BFQasBfLF0kPA6M+eGlKT
         YLmA==
X-Gm-Message-State: AFqh2kofjfIYk3POQw957Ax06ZxYq33OW7AWmlrgmG4lOL0irTVgKzxN
        FR5z5lnE5aO3a7tD61R5fRo8ynZ//EI=
X-Google-Smtp-Source: AMrXdXt3ngSzeTd4BjcWtYkKZUmKlJ+coRJjsu8zn30hseAAXL6r6J79qyIJjR/uVl5OkeApgAgECG74aLI=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:9393:6f7a:d410:55ca])
 (user=surenb job=sendgmr) by 2002:a25:9f8b:0:b0:705:cde7:2363 with SMTP id
 u11-20020a259f8b000000b00705cde72363mr8137319ybq.81.1673297640913; Mon, 09
 Jan 2023 12:54:00 -0800 (PST)
Date:   Mon,  9 Jan 2023 12:53:03 -0800
In-Reply-To: <20230109205336.3665937-1-surenb@google.com>
Mime-Version: 1.0
References: <20230109205336.3665937-1-surenb@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230109205336.3665937-9-surenb@google.com>
Subject: [PATCH 08/41] mm: introduce CONFIG_PER_VMA_LOCK
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

This configuration variable will be used to build the support for VMA
locking during page fault handling.

This is enabled by default on supported architectures with SMP and MMU
set.

The architecture support is needed since the page fault handler is called
from the architecture's page faulting code which needs modifications to
handle faults under VMA lock.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/Kconfig | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/mm/Kconfig b/mm/Kconfig
index ff7b209dec05..0aeca3794972 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1183,6 +1183,19 @@ config LRU_GEN_STATS
 	  This option has a per-memcg and per-node memory overhead.
 # }
 
+config ARCH_SUPPORTS_PER_VMA_LOCK
+       def_bool n
+
+config PER_VMA_LOCK
+	bool "Per-vma locking support"
+	default y
+	depends on ARCH_SUPPORTS_PER_VMA_LOCK && MMU && SMP
+	help
+	  Allow per-vma locking during page fault handling.
+
+	  This feature allows locking each virtual memory area separately when
+	  handling page faults instead of taking mmap_lock.
+
 source "mm/damon/Kconfig"
 
 endmenu
-- 
2.39.0

