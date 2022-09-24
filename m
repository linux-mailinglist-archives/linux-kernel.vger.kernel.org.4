Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C83655E8E52
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 18:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233967AbiIXQE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 12:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233884AbiIXQEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 12:04:52 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D23E17589
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 09:04:49 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id b23so2807933pfp.9
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 09:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=k5ZdDnm5VZy/Bo71jYQEyWHcd3BpkxNOXBActn4MIS8=;
        b=m9Nf8nW/iRQvvu2NxaRzgNT7YScZtrAwFFUIiwC6uHJ0JdjHXjITxPH+pIFBy6le9C
         R59KLAWqy/6az6mdvxDuCjTumENktgb0IK2X4bF9iYQTDjcglqXFgMoZl+EgBwpvovVu
         8JODPMjbFbUY3CX3la0Wu0RKo+s7C3dBPHrut42F93vSE3iyqF2lmwd32eM2d2fKq68g
         Cufk5/kN2kvzf7boHSeZUn6ekP2zV2JQEIJzpMFnIL6OxSPe3mqAm2x1oE56R1md9RtL
         w6zsDKctOHD/KH0tJgFVMV3HBnZX9A0IrOqAvu9r4B0B1FoDHaAyPaQ4dCy1FDJRwakt
         s7HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=k5ZdDnm5VZy/Bo71jYQEyWHcd3BpkxNOXBActn4MIS8=;
        b=NlSC6sJmgUj86p4//i+8KMQSg9+oDgX4ParJC0scJPjZ4qSjliOu1db4qS8CgQRW4+
         H6SoG5rGv6nQLuPDN+0lmEljtG7TaWKLw8rsmhhXzJn03thk8SuZqSHXr7MOc1jto2lK
         T4KekWNcbtZnG0ZGKOHms6IfO4D/t9oYMxcAg459Ji1HIwZb9c3cwfl71MbzyQJ2J4nZ
         +rsYIdcIIJVWBOBMVJABACAxq5XrJdWvcHSpFiP7ZEOl1CV+eJo9R2vvnGeBCefmbgoA
         iRqbn7kT4pFUISEzptX9m7DOH9Z/WQZDjDSmpaZSUMYqrYn8nHLk+Qo8qIcXUSwGEPsL
         Jfxw==
X-Gm-Message-State: ACrzQf0Z7F1ApKJ4/gXl2s93/UO5PeyqdRwT1cFC6Lxo9sroLnZMUcDM
        ZRocVChYztDTh4FeqFBPDFTfnrlzgWKCfw==
X-Google-Smtp-Source: AMsMyM72IUErONlT+eQbR8unNaC8XnryZYKTKU0G8T3XBfex4BW2ElFwowSrzV2bkpf7Tgpk/jXhxg==
X-Received: by 2002:a05:6a00:b49:b0:545:8bf9:be6e with SMTP id p9-20020a056a000b4900b005458bf9be6emr14875852pfo.2.1664035488917;
        Sat, 24 Sep 2022 09:04:48 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a28:e65:7770:2059:e8ad:fa8b:a6bd])
        by smtp.gmail.com with ESMTPSA id q15-20020a170902a3cf00b0017691eb7e17sm7879975plb.239.2022.09.24.09.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Sep 2022 09:04:48 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com
Cc:     linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH 1/2] sched/fair: Skip updating PELT for !fair task
Date:   Sun, 25 Sep 2022 00:04:28 +0800
Message-Id: <20220924160429.71312-1-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
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

The set_task_rq_fair() is introduced by the commit ad936d8658fd
("sched/fair: Make it possible to account fair load avg consistently")
to update PELT for !fair task when it got migrated or moved to another
cgroup.

Since we don't really care about !fair task's PELT values until when
it switched_to_fair(), so we can just adjust its last_update_time,
its PELT values will be updated correctly when switched_to_fair().

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 kernel/sched/fair.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e4a0b8bd941c..dea86d8a6c02 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3636,8 +3636,7 @@ void set_task_rq_fair(struct sched_entity *se,
 	p_last_update_time = cfs_rq_last_update_time(prev);
 	n_last_update_time = cfs_rq_last_update_time(next);
 
-	__update_load_avg_blocked_se(p_last_update_time, se);
-	se->avg.last_update_time = n_last_update_time;
+	se->avg.last_update_time += n_last_update_time - p_last_update_time;
 }
 
 /*
-- 
2.37.2

