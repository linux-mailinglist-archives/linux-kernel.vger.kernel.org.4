Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD5D67EE9C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 20:44:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232361AbjA0ToN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 14:44:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232110AbjA0TnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 14:43:19 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE321BBA8
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 11:42:53 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id b201-20020a2534d2000000b0080b87d910a2so6434989yba.21
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 11:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pFZiiTJ1lM5Y9cE9VJMMN6c4zys62lyfuQWFB/SvSfY=;
        b=m4Wtor8vj3J0ycRC6QGu22LySA+n2MGlbf/sH76T8N8Pnp/d8SuPXb/kR+Hyj37+ad
         48NkH1zhtbcV3yGPaiQ5KPXnB06jsyj37BRmFZaU4H+LJ2YSwMP7BoYjL006YrtxIZWR
         VsSyGQhSW7cL19AuEXNwVKmULWycfkr7kU4POPAgtbT6hDzlZniUKpxVu1Hu98jAvRgz
         bcxq0t9OKK2J7/3O0lRl4dNTg073Sp+ojK3rnWcxuyGW0RvPh9anMnsNc+W5/rLzSMsJ
         Ho/St/2m0p0zsIWZF5QsNOVQeuQXkfsBP43+XpjCQzZI9euWanUB/WzPnytDjlkSAgXd
         IXOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pFZiiTJ1lM5Y9cE9VJMMN6c4zys62lyfuQWFB/SvSfY=;
        b=1U2RGa6dSBim6mLUcCleFv/won4LB+ibPH52TR5dhn53u5bm6Hxi2ZySeG0f1XCGB5
         L7AP+dFpW9rWziz2keU1hW23Km7kjmugVGs7j73S9n/pA6FBIrFR3C57iHq/RVc2PUVk
         plhjFtuVTx0rdWtmF+L4bo0vDngFGDnTTZxL287+RmXN/VxPKITk3yaHELOVGQ9Fsdav
         ouvp5Bqn1X6wQFxWEXnSmTNPWgsgfniPncduyY18kORPeh2Si0l8n70rWahQ0VEf+0vw
         zlQ3vt6JMqkNiuaajuKA7AS3if5jBarWzjQ+51tOU43bvh2LnHWCIToB/f5mVUtFXL9l
         EXow==
X-Gm-Message-State: AFqh2krsdCWztM2Yn/OqeUYvXHhJkH/kzCWIgoQ5SOGkb8rgvsZ2T4nQ
        JBZr+VS/F9+npZuRwE9Tz2qJfB+BYNg=
X-Google-Smtp-Source: AMrXdXt7ky1YKmCHrEvdSmppryHuxdZmy/ExGSeixqws3R/QJJ6NNyUiC3cubRusLU6Amdx/dq1XzZif1cI=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:4e19:be9:c5d0:8483])
 (user=surenb job=sendgmr) by 2002:a81:1d47:0:b0:3f4:6c62:18d1 with SMTP id
 d68-20020a811d47000000b003f46c6218d1mr3383963ywd.491.1674848493581; Fri, 27
 Jan 2023 11:41:33 -0800 (PST)
Date:   Fri, 27 Jan 2023 11:40:45 -0800
In-Reply-To: <20230127194110.533103-1-surenb@google.com>
Mime-Version: 1.0
References: <20230127194110.533103-1-surenb@google.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Message-ID: <20230127194110.533103-9-surenb@google.com>
Subject: [PATCH v2 08/33] mm: introduce CONFIG_PER_VMA_LOCK
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

