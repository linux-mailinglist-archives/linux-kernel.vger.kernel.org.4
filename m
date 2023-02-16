Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE843698BAA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 06:19:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbjBPFTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 00:19:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjBPFSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 00:18:45 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A6243452
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 21:18:18 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id h14-20020a258a8e000000b00827819f87e5so917586ybl.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 21:18:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pFZiiTJ1lM5Y9cE9VJMMN6c4zys62lyfuQWFB/SvSfY=;
        b=hDLR1pvRXBoNPEsd5rWO1uuL2xRvkViIuLxNT0AXT2es+wKEpveR0MayIpEY9kMwnX
         yKqoPf3/kr2W8U8aZxHHsI3MeVglv4Uuopqy/RZQvDUL+Iw/1b3yNPaW9UiWpFiktEjT
         IG17SwGNRtI3Tudjcg57P2Pp6pg3eItytQO0663ElsQFpDjPji34Qnzv66OgBFV/+yja
         uvKllpdQQMscfNlzsu7K4yE4HNqAZ53EkNxV25Op17ac2k06MkhohfLIKcbxFpec+BdV
         695/dYeBJhC1TaWGjUDZda/yGXvfwWspsF3C1nfSkAJuqCo5le3F23yvLzWMlOVw2Nnw
         Ls0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pFZiiTJ1lM5Y9cE9VJMMN6c4zys62lyfuQWFB/SvSfY=;
        b=ZH3ovrhLib0C7VYfFMEp9wUCa1a0sNv43nTZyEj7wvYn8i+tt1UwDkeH0mm+c5GdFV
         m6U2FqPgN1XTW1NvUcnZoiu5cHbf7pkaCTbdM6Ly9FxwYz+BZKI0YJQQC9OOnYuPchRf
         pYjy/ldsOWwqAhhbUuYCvaiMiuCG7GVhBdl5imo8PPcSOGNA43Qb+9VVPXHqcM0XSLs8
         e3fEdLmjX3zLLVgaxQSvfbdFVi30PGAUS7IsaxuJ5B2FP+QLxtT7n9CAZQFFtmXBAAe8
         V/r7eTk/WMi22nDvlW2v0dhD9z43UlHQQi9a9u2z3wUUAaqWE+aDp0W9nN46vnO6aHpV
         TTnw==
X-Gm-Message-State: AO0yUKX7nXSIQWJMT9c0VHqjqeF3J7x+PExHhiOA20f2Co81l7nt81S6
        J3k82obhH4VCA8PRLHkNUrmr8IAZjtM=
X-Google-Smtp-Source: AK7set/vOsUP0PVWaWbTlqFxALvIpJBlIbMQnTBHBu2Oot2RdkwCU0iTN4oS1VPXE/uz69lz5N2GmOvT6GU=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:f781:d5ed:1806:6ebb])
 (user=surenb job=sendgmr) by 2002:a81:9e45:0:b0:50f:f163:7072 with SMTP id
 n5-20020a819e45000000b0050ff1637072mr442506ywj.285.1676524697322; Wed, 15 Feb
 2023 21:18:17 -0800 (PST)
Date:   Wed, 15 Feb 2023 21:17:24 -0800
In-Reply-To: <20230216051750.3125598-1-surenb@google.com>
Mime-Version: 1.0
References: <20230216051750.3125598-1-surenb@google.com>
X-Mailer: git-send-email 2.39.1.581.gbfd45094c4-goog
Message-ID: <20230216051750.3125598-10-surenb@google.com>
Subject: [PATCH v3 09/35] mm: introduce CONFIG_PER_VMA_LOCK
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

This configuration variable will be used to build the support for VMA
locking during page fault handling.

This is enabled on supported architectures with SMP and MMU set.

The architecture support is needed since the page fault handler is called
from the architecture's page faulting code which needs modifications to
handle faults under VMA lock.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/Kconfig | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/mm/Kconfig b/mm/Kconfig
index ca98b2072df5..2e4a7e61768a 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1211,6 +1211,18 @@ config LRU_GEN_STATS
 	  This option has a per-memcg and per-node memory overhead.
 # }
 
+config ARCH_SUPPORTS_PER_VMA_LOCK
+       def_bool n
+
+config PER_VMA_LOCK
+	def_bool y
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
2.39.1

