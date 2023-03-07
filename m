Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0F8C6AD7DF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 07:58:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbjCGG6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 01:58:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbjCGG6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 01:58:11 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC5688EE1
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 22:57:15 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id 16so6992496pge.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 22:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1678172234;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pKI1kuAHKypUXeareR/09n2feCgpJViSdOybhZI+EsM=;
        b=MyoQeF+Z1Ozq9bE9/PbK9injww7cXqExwhY7rvSLxR4g/4O+Nfc9fGmLGzFYJMpAHD
         Zob+jZZ+kbE9jLOG+OEUynRAhk/1wDg68aB229TqJDeviGbMSvnk+L9gn1ZEZC2xzZew
         OV+vxUHqrr+Tv0KeVOcVBlszBPmxncShiPqOZhplHv4c4JKf7I0IqXVPOMWMvDJaZt4R
         LtsYlahwTiomz3DM5CScou3sBZL/2DaB/HRpvPb940m2H7IkHsGjeco1KuyTRwCNdWya
         0gnRlmOrxjy+r8Q8lkkhv4vWG6f46ZgtO0AxZHLWg6LCI26AiYHKnM1ulIrPiJzRhtno
         V4Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678172234;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pKI1kuAHKypUXeareR/09n2feCgpJViSdOybhZI+EsM=;
        b=HzWzQa3kD3hTa5qVzS3lohAw4fLh4w5nrgE7KegPjcLJTKx67U5gKcBk0FxBQyP07C
         2RLk6/8+FY0cGh7H6joFAS1X+2j1lsBAxdv65Hxfue+bjJHNu9zu545r8VgdMOGWR0Mu
         bmW4rGB0mAHgqSlsgkyPn09o2CTrDHYmx8x7mnInLUOyUfSaV2NWhfXOLs42iw35DnW6
         zbI/c43+vSe4heQCaFlGczMa/o1/m6RROdXYd+r806YWWSLXphWyaxulWala39Gr5h5h
         zhp9Qmcs58L4stAnaR8Wdyk3cDXoZaPXzt3Vf9dA3i671i/s3Kv2UZLLfHyLNTukjW68
         w91w==
X-Gm-Message-State: AO0yUKUtv9QRPkLKXgPCB97o+0p9kT6BLc8HzNHwPFQQ9AHMpiMQ/gzx
        dOLIyXFlDWWIiJ82jDjSjpH2OA==
X-Google-Smtp-Source: AK7set/l9M6WgXBhpjojFQaIgGb5t8qipqn824NRUYVF7PhtZRZwJeaPHfCe3DAy+Lx024T0Tr2DWg==
X-Received: by 2002:aa7:8892:0:b0:5d1:bbd2:7604 with SMTP id z18-20020aa78892000000b005d1bbd27604mr12474542pfe.2.1678172233918;
        Mon, 06 Mar 2023 22:57:13 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id e5-20020a62ee05000000b00608dae58695sm7230854pfi.209.2023.03.06.22.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 22:57:13 -0800 (PST)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, tkhai@ya.ru, hannes@cmpxchg.org,
        shakeelb@google.com, mhocko@kernel.org, roman.gushchin@linux.dev,
        muchun.song@linux.dev, david@redhat.com, shy828301@gmail.com,
        rppt@kernel.org
Cc:     sultan@kerneltoast.com, dave@stgolabs.net,
        penguin-kernel@I-love.SAKURA.ne.jp, paulmck@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v4 7/8] mm: vmscan: remove shrinker_rwsem from synchronize_shrinkers()
Date:   Tue,  7 Mar 2023 14:56:04 +0800
Message-Id: <20230307065605.58209-8-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230307065605.58209-1-zhengqi.arch@bytedance.com>
References: <20230307065605.58209-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
index 7aaf6f94ac1b..ac7ab4aa344f 100644
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

