Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6000A6A0A84
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 14:28:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234283AbjBWN2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 08:28:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234578AbjBWN2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 08:28:35 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 395B1366BC
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 05:28:27 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id il18-20020a17090b165200b0023127b2d602so12255919pjb.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 05:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1677158906;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CCg67xK9T4mK7fnQXbRxQLg+KO6dWMg4osRlqGhwwto=;
        b=lETgDORHGvM9YstoHGbA1w0c/zosszK5Tl/tNTL5K5GecaMVH3OBn+bE4nEakg6egq
         Pvrj1imBQ3mvMDd4ZkkT+KTl+KI7731rrPWGJr93xhck6jDmBdEQXOnXXEO1QfhSK6RX
         ygXjpnptKdeVKz4W3Pi6mq9d0qV+R8FOe534PaajduVj/IHLnCHezzp/AdV++OCktNuP
         8w/SRgZpNscp1wPYqJzwvIGsa1g6aKBO/N4rrdP+sT3ClXNrbTOpm5Hjwya0rBJVadLP
         3Nf3Tv+Z4D5QSw8ejD088MsxJyTzHJO0ORVGeG8DQ79R3RuVcqlVVKIQp+9BWC5EuICj
         qEMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677158906;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CCg67xK9T4mK7fnQXbRxQLg+KO6dWMg4osRlqGhwwto=;
        b=8QACjcmf20IJ75f1GJnqvKISNknRGJ3v/jsiL7efsiNAOPErq1/BJyF9Oa7nnJJkPz
         QMeGXTJv7T0iNc+qYWHUUyujOmJdymp7dYIFHSA4JIrOJxRZlStPLppZfhax7uAjx5xl
         OzsxgwYHVRQwF2FumfIlyyhBA5iJuB8mJupK3kshFJQxQM2IoMLQPH8ygEmwCEAxjCdB
         c+k7WO2DEwnHY6L27jOwPIM7G8nkFD18Qf4qbRHJe/mcqFg3o+UAONJgOd48I8iNtoEz
         CyY4dhiu1nPnk7QdmFSdQ/wk+8e1YaMyGdUZ+CSXWK9oNGb8Xtxcr6V9W9yA7KHOBzQp
         tiog==
X-Gm-Message-State: AO0yUKXtQnur+ggpe2FiPEtSGuN2/lB1bIyIYy6ST7LzMpHP/Kky0EhL
        cyr1SKcddY0pITc+7wC6o1yEDw==
X-Google-Smtp-Source: AK7set/QZbVb36Sv4JLFW6OnERnzffyx6wAbjX3Cubg0yhkLOIgaCU3CSjc6M3m8hEj3yZzy5iBl6A==
X-Received: by 2002:a05:6a21:33a4:b0:cc:35f5:1a84 with SMTP id yy36-20020a056a2133a400b000cc35f51a84mr1073433pzb.5.1677158906681;
        Thu, 23 Feb 2023 05:28:26 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id g18-20020aa78752000000b005a9bf65b591sm3848591pfo.135.2023.02.23.05.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 05:28:26 -0800 (PST)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, tkhai@ya.ru, hannes@cmpxchg.org,
        shakeelb@google.com, mhocko@kernel.org, roman.gushchin@linux.dev,
        muchun.song@linux.dev, david@redhat.com, shy828301@gmail.com
Cc:     sultan@kerneltoast.com, dave@stgolabs.net,
        penguin-kernel@I-love.SAKURA.ne.jp, paulmck@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v2 6/7] mm: vmscan: remove shrinker_rwsem from synchronize_shrinkers()
Date:   Thu, 23 Feb 2023 21:27:24 +0800
Message-Id: <20230223132725.11685-7-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230223132725.11685-1-zhengqi.arch@bytedance.com>
References: <20230223132725.11685-1-zhengqi.arch@bytedance.com>
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

Now there are no readers of shrinker_rwsem, so
synchronize_shrinkers() does not need to hold the
writer of shrinker_rwsem to wait for all running
shinkers to complete, synchronize_srcu() is enough.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/vmscan.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 89602e97583a..d1a95d60d127 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -794,15 +794,11 @@ EXPORT_SYMBOL(unregister_shrinker);
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
 	synchronize_srcu(&shrinker_srcu);
 }
 EXPORT_SYMBOL(synchronize_shrinkers);
-- 
2.20.1

