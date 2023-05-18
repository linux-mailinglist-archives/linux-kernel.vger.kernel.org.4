Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4486708198
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 14:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbjERMnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 08:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbjERMnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 08:43:02 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D898F
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 05:42:14 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-51b0f9d7d70so1747280a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 05:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1684413710; x=1687005710;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G7R4w9fF0O96j6E7s3O266tf7WZDrfjpg6MXApwCsXo=;
        b=G337Jniv8+DJ0J/DvJ6ENbRKNs4k874YWBFd2ohEIzp0ds70nTGJ60CnbM/XKAyfe1
         BMzS7qgPK5UE40CrXFR+Dvjh5EKuLqcO6Epl6XiK879eDQMZ1wEnxro4lSDJoXzjRv0E
         XS39RR1GE2RxAlk8KtWS5z4p8Z8icCnHkFEr3X9FPv83Ik8dr5WBwusUrHN3Gke4l/ql
         OIkEwvQr5+VQGQtMZtJGeKJKjZJNXorI0J84gW+ZaEtvP1B/05L5RxoY7l824zKUzYXc
         WYnSl5UTbNw0lHsPJxovLA4cOdKi8pbkoOVedeC7LOd0eHTV4DvDVLvhSGWAhjkaeNYt
         hM6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684413710; x=1687005710;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G7R4w9fF0O96j6E7s3O266tf7WZDrfjpg6MXApwCsXo=;
        b=gMEzQ5tcWStFysGC0SnkYC3ZeVTqSxlooPTDkW9Koetn+S2aB6qR7IFRquOGMdUxqQ
         X2V3+gBx62V7k4OdC4uuIt+sgXo40L/HByYAhtOjcqBxIunuGH2SP56Dhk5rG4TwwIrK
         ZwfftSR5WfkvS5tzYTapkKpAY5UiNPK+ZaeBhTVvf9EOHQ7Jpx9uOpadO8bwOv+BRZYJ
         hnRhHmFeeIPWE7Rk/C6f20bw/2rTdgp02iRxSQec/03kLxZr6uS1BfKuYdJ1yPOip/cD
         gcm9WDlyy48skc5fcXY1OpDj7+Ur8/hU8a1MTMCacqvKPUxyl+Ga0tWkmPywRSfcod6G
         1RTQ==
X-Gm-Message-State: AC+VfDyU53N2/RFituHTzaA37kNb5eCXiHXvuHfW6mChtUsbouBBLpGA
        7xlu/uNHj2qGoMJ9CcXH4SwbaQ==
X-Google-Smtp-Source: ACHHUZ7ZS2Rl3/J2eqUKMw6daeqXMrBxveDLBVlPvyxw4DMDgOKP2Ghds2ROXHhsqAAo+o0E1vRJdw==
X-Received: by 2002:a17:90a:e284:b0:253:4409:3c4a with SMTP id d4-20020a17090ae28400b0025344093c4amr2751990pjz.28.1684413710262;
        Thu, 18 May 2023 05:41:50 -0700 (PDT)
Received: from C02G87K0MD6R.bytedance.net ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id cx14-20020a17090afd8e00b0025352448ba9sm2116434pjb.0.2023.05.18.05.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 05:41:49 -0700 (PDT)
From:   Hao Jia <jiahao.os@bytedance.com>
To:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hao Jia <jiahao.os@bytedance.com>
Subject: [PATCH] cgroup: rstat: Simplified cgroup_base_stat_flush() update last_bstat logic
Date:   Thu, 18 May 2023 20:41:42 +0800
Message-Id: <20230518124142.57644-1-jiahao.os@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In cgroup_base_stat_flush() function, {rstatc, cgrp}->last_bstat
needs to be updated to the current {rstatc, cgrp}->bstat, directly
assigning values instead of adding the last value to delta.

Signed-off-by: Hao Jia <jiahao.os@bytedance.com>
---
 kernel/cgroup/rstat.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index 9c4c55228567..3e5c4c1c92c6 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -376,14 +376,14 @@ static void cgroup_base_stat_flush(struct cgroup *cgrp, int cpu)
 	/* propagate percpu delta to global */
 	cgroup_base_stat_sub(&delta, &rstatc->last_bstat);
 	cgroup_base_stat_add(&cgrp->bstat, &delta);
-	cgroup_base_stat_add(&rstatc->last_bstat, &delta);
+	rstatc->last_bstat = rstatc->bstat;
 
 	/* propagate global delta to parent (unless that's root) */
 	if (cgroup_parent(parent)) {
 		delta = cgrp->bstat;
 		cgroup_base_stat_sub(&delta, &cgrp->last_bstat);
 		cgroup_base_stat_add(&parent->bstat, &delta);
-		cgroup_base_stat_add(&cgrp->last_bstat, &delta);
+		cgrp->last_bstat = cgrp->bstat;
 	}
 }
 
-- 
2.37.0

