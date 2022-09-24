Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 697CF5E8C31
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 14:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233819AbiIXMSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 08:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233812AbiIXMSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 08:18:36 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DDFBB517B
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 05:18:34 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id t3so2398553ply.2
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 05:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=9aIVtq9LZI+Ug1xm034RxKJmV6QnLLHdaDu3UcryddU=;
        b=ZQLxpkZs8/8zmmqBb5IS+scyitsPQwRtemTsM/uRuukUM2wAXG16LF9TankEHxZZY2
         b3FdXwd70ZoOc44qUohG0UL5v5NqwDxKh+hz+AisJkOp80r/u+l971inocp7PJVMqbO1
         HGjGe3sAedkEXTMU5man/DdrAGVoItj/yz64XbQe9AQwKOVWZcVn3cHlw16CKZJ+Kncq
         1qGA3A7z6iJlBHbhMNsVpxZK/BWZomVI599N/gRRE51uqEfhVPlg6LO0775bDDfnOwYs
         soY3tsjvtAX9q5b0FclT8avfWUtJsexSbJ682CoVCIL3kSHCqR0YrpXyfoHFqtJJMq8s
         XDSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=9aIVtq9LZI+Ug1xm034RxKJmV6QnLLHdaDu3UcryddU=;
        b=0nfkPRPE6UUgv28GVZwMNDxEWaSO3v38kmLrY14DF9VmkuXKOEwWAidQ+3o2e6HmVN
         ZuwAt0VtkpYCw6yaHXYl387FDyxmXHRijR+o+0XMRXqdKmGl2UwMuAnCVR2w8pnbleR8
         eUm4XXiHVBkBDXlCoGJIdCtXQciS2D8rW4apjY8cipKamLa1CAmW1Oi0bv7+SgRGGg9i
         NWKNEtuY04yRgzv9ME7fyepr6vh4tn4L51BtpaIxEIERv76dX4OhFvJcoRx9dLwW8ToO
         w3fgsKU6NdgBAfgLNh7yI+xbgbUkO9VyyB4l4Q3LTGWQjy/+SsMUH9rSfN75Wn6GNrpe
         Ih9A==
X-Gm-Message-State: ACrzQf33kV4crKhLy8NPnsaKTo3KY9BI6BSatjHe0X21Vb3YHbybio7x
        QV1DlIDEHDD8S6HHygdH4hs1pQ==
X-Google-Smtp-Source: AMsMyM4EwMsrCA2pbM9dzng6xXcsHniRuTy5mh+XwSxCfCQ52NHh818Spx2ubWE3ZG1UD8JKrW2J0A==
X-Received: by 2002:a17:90b:3e87:b0:203:b9c:f9b7 with SMTP id rj7-20020a17090b3e8700b002030b9cf9b7mr14504722pjb.93.1664021913992;
        Sat, 24 Sep 2022 05:18:33 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a28:e65:7770:2059:e8ad:fa8b:a6bd])
        by smtp.gmail.com with ESMTPSA id y13-20020a17090a1f4d00b001fd7e56da4csm3264739pjy.39.2022.09.24.05.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Sep 2022 05:18:33 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com
Cc:     linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH] sched/core: Always do the balancing pass from dl_sched_class
Date:   Sat, 24 Sep 2022 20:16:09 +0800
Message-Id: <20220924121609.54129-1-zhouchengming@bytedance.com>
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

The commit 67692435c411 ("sched: Rework pick_next_task() slow-path") and
commit 6e2df0581f56 ("sched: Fix pick_next_task() vs 'change' pattern race")
changed the original pick_next_task() loop logic a little.

Previously we always do class->pick_next_task(rq, prev, rf) from highest
to lowest, and balance happened in that class->pick_next_task(), so we
don't need to pull RT task if we can pick a DL task.

The current code do the balancing pass from prev->class, say prev task
is a RT task to sleep, we will try balance for rt sched_class even though
we have a DL task on rq.

This patch changes to always do the balancing pass from dl_sched_class,
since we will check if balance is really needed in each class->balance(),
we can terminate the balance pass as soon as we know there is a runnable
task of @class priority or higher.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ee28253c9ac0..ff5e7ac236bd 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5774,7 +5774,7 @@ static void put_prev_task_balance(struct rq *rq, struct task_struct *prev,
 	 * We can terminate the balance pass as soon as we know there is
 	 * a runnable task of @class priority or higher.
 	 */
-	for_class_range(class, prev->sched_class, &idle_sched_class) {
+	for_class_range(class, &dl_sched_class, &idle_sched_class) {
 		if (class->balance(rq, prev, rf))
 			break;
 	}
-- 
2.37.2

