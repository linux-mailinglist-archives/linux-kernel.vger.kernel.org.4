Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D10896A30EB
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 15:54:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbjBZOye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 09:54:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbjBZOxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 09:53:49 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E58AA19BA
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 06:50:05 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id i10so4190450plr.9
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 06:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rPbK2mA8SftO30bweBpSZUhXCxYptD2QUCquMlUkzZQ=;
        b=RLNAX82ej6WiOp+gJxxrYUevqQBzdDGYpvRp2WltPYHzsFagaq47ozL06y+Hy6OgmK
         JK9iGaHN7dJvbFey7hQXB7aig8jRb8Fzh2ihtgS4KPi3JJgVeer/QP403MbnYAJfXhak
         bYN0OJJ/krh591ZGhC6ZmW4Bo9d/0ELhp3VjgtJ7eyFa0hScQMuwE81nRfrktkjFE6Os
         OjbYs65uBBhgwi4YlDp3YuXDzBBPVqJDlkDh/2welq1ly/HLAfshGinj1f1s9zkkezz/
         2xhknARP+taXDeqDm4xAjtZ8aw0C7dGDxIicSpRhb2gQC9so4gEZ84pp+H7E0riZtKLc
         Tpsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rPbK2mA8SftO30bweBpSZUhXCxYptD2QUCquMlUkzZQ=;
        b=lTqDzm1efkpTNt4k/tKU05+Of29BHCQCgBFmQ5Wdvz7aV0BfbDeD/EPr2i5xRmx9V/
         Siqc42IS5V1pdzJuae3TQ0MaDeJDZatYBCRrWIo0aEtBZcuL7XZtgwyvgMKhiiPiWVxc
         IGljWhfcBHQNsJ638ojfT8d0qEbdx+134jJD0fFPsXXlX2gTLA/iOWnVVNrJi2jhJEfg
         xMKB4OIrWNfx70QcCbj2CuX3DbE7tgyzeE9A/DFBTcLX8yuEM0XIny0EX6v41jL2LT4a
         9ZKzD2SvIRdO+2KfxsT4Xe04L8fywOhggSkzM/aUYxxShLEhUzaQqWWx3qQZzJGtoSU2
         LeRg==
X-Gm-Message-State: AO0yUKUtq9TLwP/GkJDiNfkS87JRAzn9T49lmsXQLdDGRDzLDq0K/5Zf
        CUvbSW7UAJB7mBU64B9UXMHY+Q==
X-Google-Smtp-Source: AK7set8jSrtu5jvJSft27Jtxn5UB2T4NTHUh1NNGGVH4kZw+rpTeROnHO4aYE0DylXNd7RBZ0PVGQw==
X-Received: by 2002:a17:902:d4c8:b0:19a:7217:32af with SMTP id o8-20020a170902d4c800b0019a721732afmr23249925plg.5.1677422930708;
        Sun, 26 Feb 2023 06:48:50 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.248])
        by smtp.gmail.com with ESMTPSA id y20-20020a170902ed5400b0019c2cf12d15sm2755589plb.116.2023.02.26.06.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 06:48:50 -0800 (PST)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, tkhai@ya.ru, hannes@cmpxchg.org,
        shakeelb@google.com, mhocko@kernel.org, roman.gushchin@linux.dev,
        muchun.song@linux.dev, david@redhat.com, shy828301@gmail.com
Cc:     sultan@kerneltoast.com, dave@stgolabs.net,
        penguin-kernel@I-love.SAKURA.ne.jp, paulmck@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v3 7/8] mm: vmscan: remove shrinker_rwsem from synchronize_shrinkers()
Date:   Sun, 26 Feb 2023 22:46:54 +0800
Message-Id: <20230226144655.79778-8-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230226144655.79778-1-zhengqi.arch@bytedance.com>
References: <20230226144655.79778-1-zhengqi.arch@bytedance.com>
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
index 16ff64813175..2d71fd565c78 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -796,15 +796,11 @@ EXPORT_SYMBOL(unregister_shrinker);
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

