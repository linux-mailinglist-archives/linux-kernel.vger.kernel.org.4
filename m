Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFA9C726837
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 20:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbjFGSNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 14:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231991AbjFGSNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 14:13:02 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D90E295
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 11:12:37 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-2568fc3d8a9so2963126a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 11:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686161557; x=1688753557;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qV89SGlXzzybQ68Kw8PJEO9/Nh725SOfx0EhcbhN+uM=;
        b=JPoC/y3KG/Q+B2RdcJtUx7SrMOC5cg46F1UuQnSSLXq4+eM8AiL8fX1iu/qBzQtxc8
         g3Gc97P/CRY/UkDe5/dNICquALZBm11+nBqbl+VF63Hg2ZpOrjwTe8uo+w75eWkKp16k
         Qt7ri13PTI2EokvKr+1XCYE5L6gYhgDS/JPs79B4UL9KRDtv+rLWKhCvbILNAP8qrSqo
         cw/FW7rDmFjbr6np7uAXtui54yTseIYQlvtjZU6Rs7iMmqI72P58WL56NIG7fZjGMQgQ
         dDyIbJpJnQsFMta9F+mznMYM6e7pPckruRzA7bi1W1+1u1p8oZLe+f/8W7lNBpGlxfWS
         BIDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686161557; x=1688753557;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qV89SGlXzzybQ68Kw8PJEO9/Nh725SOfx0EhcbhN+uM=;
        b=Av+eooSM773mc5meMfjPJij3phKPtt9Q0p2X7SkS0YMA+ixOgyWtATvdjnxCkGSO8l
         vUODv2spsDqw7DrVBESCYcfaeOCT4rSs7O+hjNgRhfbvisZbK6tAgDm868C25okDWwLk
         ny5AA1HbbE5hirTvP2Lcf+R338+ms3FVh5w6K6g/7RfBRzdltR6sWBwiS1FijvCAMOp0
         O+t9T/2Co1bvHaKF1+LE4LWzqe8/6vOLuN70WFeZnw/KH5vmIkXFhhSqLOcA+TLA3Bjz
         f+KQH31nLnXPZIhL6DKolVRPFtQKpC+CfCVXy10OaUukBDfIWy2NTjgRuI3NrKtKSTtp
         4uWg==
X-Gm-Message-State: AC+VfDwHpGbacewrBOIBgaHZdWijPFOsHa9TdM9dJ1ImVn8RCk6Yatgh
        H2QoPq8j/mGAHL4bFZRPFx8=
X-Google-Smtp-Source: ACHHUZ71v+5zaWqi7ahXQ7Oxvby9IuRht0hEhPUtiWq6G00yQW1o+5g9Ljn48YLKwJpT/E0xSBpZWw==
X-Received: by 2002:a17:90a:49:b0:259:343:86b5 with SMTP id 9-20020a17090a004900b00259034386b5mr2128951pjb.47.1686161557323;
        Wed, 07 Jun 2023 11:12:37 -0700 (PDT)
Received: from VAN-928222-PC0.fortinet-us.com ([173.214.130.2])
        by smtp.gmail.com with ESMTPSA id 15-20020a17090a004f00b0025352448ba9sm1791811pjb.0.2023.06.07.11.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 11:12:36 -0700 (PDT)
From:   Qingjie Xing <xqjcool@gmail.com>
To:     mingo@redhat.com
Cc:     peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, brauner@kernel.org,
        linux-kernel@vger.kernel.org, xqjcool@gmail.com
Subject: [PATCH] sched/debug,sched/core: Reset hung task detector while processing sysrq-t
Date:   Wed,  7 Jun 2023 11:12:21 -0700
Message-Id: <20230607181221.4118381-1-xqjcool@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On devices with multiple CPUs and multiple processes, outputting lengthy
sysrq-t content on a slow serial port can consume a significant amount
of time. We need to reset the hung task detector to avoid false hung task
alerts.

Signed-off-by: Qingjie Xing <xqjcool@gmail.com>
---
 kernel/sched/core.c  | 1 +
 kernel/sched/debug.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a68d1276bab0..5773283b752c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9176,6 +9176,7 @@ void show_state_filter(unsigned int state_filter)
 		 */
 		touch_nmi_watchdog();
 		touch_all_softlockup_watchdogs();
+		reset_hung_task_detector();
 		if (state_filter_match(state_filter, p))
 			sched_show_task(p);
 	}
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 0b2340a79b65..43065808b425 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -904,6 +904,7 @@ void sysrq_sched_debug_show(void)
 		 */
 		touch_nmi_watchdog();
 		touch_all_softlockup_watchdogs();
+		reset_hung_task_detector();
 		print_cpu(NULL, cpu);
 	}
 }
-- 
2.40.1

