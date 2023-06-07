Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 926F372687C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 20:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231823AbjFGSWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 14:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232818AbjFGSW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 14:22:26 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79666E6C
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 11:21:51 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-650c8cb68aeso4304290b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 11:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686162110; x=1688754110;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qV89SGlXzzybQ68Kw8PJEO9/Nh725SOfx0EhcbhN+uM=;
        b=CsvpAdfz+FpKfF+eNU1WwuJCSi+OkRfPodzVUkrx/GfkVKXEiV5slFtoBuMzy6vHym
         c3VNpZ0p917FK3HEDj1p2hMDDOja1FELK+lT96FDKoWH0ohKEUYWLGNQAtyIpslYZa78
         UIS7FWI4mVeHHeponI2OlPV5LiSd3qKrlox/hx+6M7Kv2/fCmEfG7NwCIqgVJiluYVXa
         SrjL4lOaF2O7mLZoNdD906xey5xAXD+2xInP8Icos2Lm3HOiSTZht47y9LHXnVPTVfsV
         bCFgxqR2tGEHFBtHS+IvlH1mR3kmIvm5FxBTJYKoHL4eoipjnFhpA/q270Ye5MD2GrQI
         IQUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686162110; x=1688754110;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qV89SGlXzzybQ68Kw8PJEO9/Nh725SOfx0EhcbhN+uM=;
        b=B7f/yj2yq+AaxVmI5nxxFJuzIWfOpPNTVPsVcwvzK+hK70A1Lp1X6mXr/Exl4tM5Is
         MwnOwtBbvO3KykYISMOpUM0dnxedfqkkZVYnhs9ortVkG1y4GvTImDMF+xZo0jtnu87C
         3nfqOEGfx8epDtrppAyETQptxAx5y6W28pys/QoXW58VTIcguMUJDKZvEV10QDLU/7cz
         D6ZXUtmeFgyVPTWOfRzB4J8TlzA3h+MdlK1J4g5L+v/1laNg/UR7BnIKkV91sa19brGD
         RRtpEUYMM1JW31aI1mA902N7PDfQlKdJJwYHVtw1+LegjTBJ/YaW/loV6XOLfjZav1Hn
         t93g==
X-Gm-Message-State: AC+VfDwZCF15XmSpfvHgf2dBvPFGzVLfoILSVuQJegf0Yo09o+fnXh82
        ezKzo1WG3sJgqheNVyl5GwU=
X-Google-Smtp-Source: ACHHUZ5IMsi4CD0h0RIWIAtqAa94c0huJdM4QururY1TsLDFSlRtz2KBaUEzVLNOQSq3Jsc6l7WlcQ==
X-Received: by 2002:a05:6a20:914b:b0:10b:cb87:f5e with SMTP id x11-20020a056a20914b00b0010bcb870f5emr2041304pzc.45.1686162110413;
        Wed, 07 Jun 2023 11:21:50 -0700 (PDT)
Received: from VAN-928222-PC0.fortinet-us.com ([173.214.130.2])
        by smtp.gmail.com with ESMTPSA id j8-20020aa78d08000000b0065ebeb9bb23sm1645427pfe.149.2023.06.07.11.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 11:21:49 -0700 (PDT)
From:   Qingjie Xing <xqjcool@gmail.com>
To:     mingo@redhat.com
Cc:     peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, brauner@kernel.org,
        linux-kernel@vger.kernel.org, xqjcool@gmail.com
Subject: [PATCH] sched/debug,sched/core: Reset hung task detector while processing sysrq-t
Date:   Wed,  7 Jun 2023 11:21:33 -0700
Message-Id: <20230607182133.4142729-1-xqjcool@gmail.com>
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

