Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9C5169C786
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 10:17:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231506AbjBTJRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 04:17:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbjBTJRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 04:17:49 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62FFF144AE
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 01:17:24 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id qi12-20020a17090b274c00b002341621377cso430187pjb.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 01:17:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112; t=1676884644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+SuOsoPKf5aCTrdN4oo5ZtKUiUHbFHnkKOWfb3ggCgM=;
        b=JxT0r83NllZWDrv7JUbi57ga92yM+aV9REzj4acVWyDEC0qP6CkyEbEtUoBJBuS9q0
         EmuU2mv0gSa+rVWs9ezOVY7JDMeIZ43k4AXpUSAQB6AdIxCSGzjOaPZ6AwD8FZdu+xj8
         KqBK8u5KJuURh/jBiBPwgQcLVYo8QdvgjooE8iFX5K/C+5c1neFrb20RGiwO7pLYhkpx
         Pm7zBDLdADM1l0+KQy41Ws2iuIjA3OuXyqw27+xYBk0HctZU8tWkikX0xOU4A6qvcPuI
         IeHxUsqC/EryGaQnmdCJLqENq3+l53MZEuHQ8WxAIARks9MMf6XnteE6OVTM6echH0ty
         jkKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676884644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+SuOsoPKf5aCTrdN4oo5ZtKUiUHbFHnkKOWfb3ggCgM=;
        b=xAt1Alxft8oxvSfZXpSvUZcyKgXyXhqDZPusn6MOB9aRmpWzyqBXZpQQ5cuxRupouC
         eFzrr6EsqdASf6kXPkX0eEzD4jKKirJuM1KuQk0nBulQMyXUD8zmXftN+lW2JyvJIf6F
         pbbCmglby/tpjz0wtG596AT/g+odG1411y8rXrDqZA8mD4F4zZxO09/HbBAQaL0pquz8
         cSJe+APghEoiW2bWLjmElVmEJzlyS18OZiEHvu7R433uvva91JpY4acS1w/3WqIx0eHh
         0dqMVCGHFdqOYkoSzLhLvFt+jJSqAwDuknWsNNvTe8A1TuoVD6a+BsJ6Prfl7NHvqloS
         7lJg==
X-Gm-Message-State: AO0yUKVvn0Bt7pEs2rTHc1K3qzufEqfJAkN5SjqUFlYojGyjvMv1ITy+
        AhLyVVBD3v8yCreJaY1hD9eisg==
X-Google-Smtp-Source: AK7set9Jss6nYpleTWMKLk37JYg5U2t/GE2b3ogkN+P0mI3dj50eWKwdpAoiMz4LEqWxjmoXlXyuDQ==
X-Received: by 2002:a17:90a:a516:b0:234:9d30:84ff with SMTP id a22-20020a17090aa51600b002349d3084ffmr950101pjq.3.1676884643904;
        Mon, 20 Feb 2023 01:17:23 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.229])
        by smtp.gmail.com with ESMTPSA id fs13-20020a17090af28d00b002339195a47bsm432382pjb.53.2023.02.20.01.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 01:17:23 -0800 (PST)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, hannes@cmpxchg.org, shakeelb@google.com,
        mhocko@kernel.org, roman.gushchin@linux.dev, muchun.song@linux.dev,
        david@redhat.com, shy828301@gmail.com
Cc:     tkhai@ya.ru, sultan@kerneltoast.com, dave@stgolabs.net,
        penguin-kernel@I-love.SAKURA.ne.jp, paulmck@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH 4/5] mm: vmscan: remove shrinker_rwsem from synchronize_shrinkers()
Date:   Mon, 20 Feb 2023 17:16:36 +0800
Message-Id: <20230220091637.64865-5-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230220091637.64865-1-zhengqi.arch@bytedance.com>
References: <20230220091637.64865-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
index dc47396ecd0e..b8da56beba96 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -787,15 +787,11 @@ EXPORT_SYMBOL(unregister_shrinker);
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

