Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC6416BC7A8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 08:49:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbjCPHtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 03:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjCPHtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 03:49:06 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A11ACB97;
        Thu, 16 Mar 2023 00:48:58 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id q14so582704pfu.7;
        Thu, 16 Mar 2023 00:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678952938;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oLMa64tOXtUboutgw3wHxnPNOyffSqKsOl76z8VN4uM=;
        b=J0ql/N1jcwlIxs0v4upjzjqWI9WyFNnSNdhb/rr9WNzDVNCb7oNR5OIwrojCrc2eiO
         6w3TW5pPhH3qqpsXcnKeTrnpGJ/WTvdbiASknR7wm+FhEt0WuElaQH9Fx5BaLu6oCf4n
         S/8de6hBBp36SkSyvgl5DFe756pYWcvhJYPaA9p9l8+JMrEqPjlTNjMWTBDV2xvGYEZO
         9Fwjd9CGiGmBWNLv85LcdrEt3+h8zQzTOehZDn/iL2GmCw+u1zfikTyPzySvqMKBUnPR
         a4ZlaKEUYxs0/+rzG2JhsPqOCrdEy9D0aII40aH4XchQyMPYYJy7I3nNuB9R7ftFj6e3
         vU/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678952938;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oLMa64tOXtUboutgw3wHxnPNOyffSqKsOl76z8VN4uM=;
        b=aG6DCxtl4qT1zwh72eshLWIz9vhFgyjh1T+HQW3guXYDg0dRUG9izUXB0BoLJH0lTA
         43T2+D176Ox29gfwZvNdy4cRylEVrCGd1/kGtg2/ULER5BNDS1/BlWftbBEl76YG7flQ
         1wBsSphgKCueN7b/b6Qa29kfH9WXwqjlnS9/xNeklJRV+YjqjuudyDIArm5itL4WVbQg
         el7EUX6j8SVG98NNVdUk7u0ooU9tTHq/BDmDR4GjupCzwLFny7zk6KfTb1bWCWvmnrl2
         Dbfm2YQMLLcTxCx3Z0sf4QrKBezrnHX3Yb3H1ArrE5ibgVNfjZO32C5BwzqfK+c1umeY
         L+aw==
X-Gm-Message-State: AO0yUKUBy13hH1M0SDvV/JkNmdmsFU8nwNhMR8dMeyQgvJ4DLjRvPDtS
        FQTq13Em3tW9gZ0N2BCfn+EjKArRfc/u4Q==
X-Google-Smtp-Source: AK7set/go7uhSdWUI1Uqk8ab5FdWukX4cHvJAqvKEM2H4nl7xIiizLJo0xQHwvj7H0uwlXiC8GURZg==
X-Received: by 2002:aa7:96b0:0:b0:624:a58a:d28 with SMTP id g16-20020aa796b0000000b00624a58a0d28mr2234103pfk.4.1678952938362;
        Thu, 16 Mar 2023 00:48:58 -0700 (PDT)
Received: from kazuki-mac.lan ([2400:4051:ea3:5910::789])
        by smtp.gmail.com with ESMTPSA id 23-20020aa79217000000b005e099d7c30bsm4683618pfo.205.2023.03.16.00.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 00:48:58 -0700 (PDT)
From:   Kazuki H <kazukih0205@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Kazuki H <kazukih0205@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] sched/idle: Remove stale comments
Date:   Thu, 16 Mar 2023 16:47:48 +0900
Message-Id: <20230316074750.289025-1-kazukih0205@gmail.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rcu_idle_enter/exit() got removed in commit 1098582a0f6c
("sched,idle,rcu: Push rcu_idle deeper into the idle path"), so this
comment is outdated. Remove it.

Signed-off-by: Kazuki H <kazukih0205@gmail.com>
---
 kernel/sched/idle.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index f26ab2675f7d..dbfc2eb5ccbd 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -179,12 +179,6 @@ static void cpuidle_idle_call(void)
 		return;
 	}
 
-	/*
-	 * The RCU framework needs to be told that we are entering an idle
-	 * section, so no more rcu read side critical sections and one more
-	 * step to the grace period
-	 */
-
 	if (cpuidle_not_available(drv, dev)) {
 		tick_nohz_idle_stop_tick();
 
-- 
2.40.0

