Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 945926B7604
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 12:31:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbjCMLbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 07:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbjCMLbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 07:31:02 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD1962B53
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 04:30:22 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 132so6666485pgh.13
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 04:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1678707022;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Z4Tof/PnwUFj5i0NNzN56+j5kNnB7gWDICsVdyoruc=;
        b=LueY7xOnIXHIbNor8k5oEpAk+tX93l8rCkl4eUPXSjj/FR0coKA+VxIcbga8n7x+3/
         UVYQ+xwM5v7aAKibviyLXFIf9yfA5DqdUrbSgL59K0+yWXOscDZ9kE0PPEbSKSAKGOeW
         fYdcX0uAb27i11e16ubA0DvK2mQmR+nk8oZAtv85shH1l8grZ50ghPaV1UKNldaTWetj
         vt+eouSQMr0HwGA/8pBbk59dg1Pgdhd0cKvtaYLaKLCdPxJ8k+oWK21Mgq9NtpfoT2OG
         W0HAgtKswNDuPDIH/Ey2qVGkFfAIGkpwaECFhXVuXnSl/4V4k4XFXHrDTRlXi/isujEx
         xkxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678707022;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Z4Tof/PnwUFj5i0NNzN56+j5kNnB7gWDICsVdyoruc=;
        b=nNUI68runvX8mQmO8km0VUGlP4ncRHDzN/N/eiwRc0Cz6Eqh4e/13dL18Ktgg3Rzmr
         bmykdNOihfNhI6t753yqO8j+YCTj1+TRBir7oYUHeRaqJ9Q/4tAdES0Q1K3e4cGNJH1b
         mjIl/hFq2qsUuh0UzEQvH+sJ4HpSfhCTTXZsISCQjaqcAlEZyJ5J0v23NyzbKt/aEJd7
         DSnlv7+6fnwxMN4vD/6fMWVou4YnTsvBM0skdvi2H0ZB59D8Ed7jNrxDYsoY4W1oAiYV
         sEaJAm9ena/kaRh5aMcJgQs5s+vkivTYbf7sFOQZ1wJ51gdy+nGhEYO4EbbpMcHmh8nT
         b2Ew==
X-Gm-Message-State: AO0yUKUEf+Mb938cW1BWhe9iUETJdGl8emeYAhGLMzhPHxFgWw1KZ437
        Dq3YSxDOVDAefnAQEb+Jmtxlhg==
X-Google-Smtp-Source: AK7set/YWnhAf+YFhv2OXt5fozTrmg2G/24NbjxXRH9lebvV7mE5dh40UrMVfpfJ10aHjkOkvNuTfA==
X-Received: by 2002:a05:6a00:2148:b0:606:d3d1:4cc4 with SMTP id o8-20020a056a00214800b00606d3d14cc4mr10844065pfk.3.1678707021778;
        Mon, 13 Mar 2023 04:30:21 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.229])
        by smtp.gmail.com with ESMTPSA id n2-20020a654882000000b0050300a7c8c2sm4390827pgs.89.2023.03.13.04.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 04:30:21 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, tkhai@ya.ru, vbabka@suse.cz,
        christian.koenig@amd.com, hannes@cmpxchg.org, shakeelb@google.com,
        mhocko@kernel.org, roman.gushchin@linux.dev, muchun.song@linux.dev,
        david@redhat.com, shy828301@gmail.com
Cc:     sultan@kerneltoast.com, dave@stgolabs.net,
        penguin-kernel@I-love.SAKURA.ne.jp, paulmck@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v5 7/8] mm: vmscan: remove shrinker_rwsem from synchronize_shrinkers()
Date:   Mon, 13 Mar 2023 19:28:18 +0800
Message-Id: <20230313112819.38938-8-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230313112819.38938-1-zhengqi.arch@bytedance.com>
References: <20230313112819.38938-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the synchronize_shrinkers() is only used by TTM
pool. It only requires that no shrinkers run in parallel,
and doesn't care about registering and unregistering of
shrinkers.

Since slab shrink is protected by SRCU, synchronize_srcu()
is sufficient to ensure that no shrinker is running in
parallel. So the shrinker_rwsem in synchronize_shrinkers()
is no longer needed, just remove it.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: Kirill Tkhai <tkhai@ya.ru>
---
 mm/vmscan.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 8c1ae7ea8dea..2b22a42d83c4 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -790,15 +790,11 @@ EXPORT_SYMBOL(unregister_shrinker);
 /**
  * synchronize_shrinkers - Wait for all running shrinkers to complete.
  *
- * This is equivalent to calling unregister_shrink() and register_shrinker(),
- * but atomically and with less overhead. This is useful to guarantee that all
- * shrinker invocations have seen an update, before freeing memory, similar to
- * rcu.
+ * This is useful to guarantee that all shrinker invocations have seen an
+ * update, before freeing memory.
  */
 void synchronize_shrinkers(void)
 {
-	down_write(&shrinker_rwsem);
-	up_write(&shrinker_rwsem);
 	atomic_inc(&shrinker_srcu_generation);
 	synchronize_srcu(&shrinker_srcu);
 }
-- 
2.20.1

