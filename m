Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97907668833
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 01:12:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240626AbjAMAM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 19:12:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240175AbjAMALm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 19:11:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF05B5D8A6;
        Thu, 12 Jan 2023 16:11:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 63283B811FF;
        Fri, 13 Jan 2023 00:11:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEA59C433A7;
        Fri, 13 Jan 2023 00:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673568695;
        bh=myT394PI0jK3w9+Y5Yr+wETBeUZkki6xDb1CBO26XOM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JcrSReQ6I5UiUeSr97F6GLgeLj+fRWzZUT4wxx1ddKGgLdhcXMjvZCt0EsfR5lVhJ
         rJJTJfit+sZBEOl6jHh2JE3kvk93y9dagrFKbZMM7/XOVQ2kViI5lJz5+Omthi186N
         23O6txmbqvrU4283ZX7uLG6SMTrS4iOzkkc7qSzS6KQFA0F/myvVicocWHQb/mmltS
         XmvYLPR6/vriWTejAX303miylTUMv7bt9ZUg0AhVig8ZNbbZjl9RBxXmmtomXyAnob
         rlCTPjPOiWQ/4K6mbDCFDQ8H5JLfSjN4XbqzMYDEqJlsX39FvKz7Pcd970Ap94pgKy
         pooc6feXb+pFA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 9ABE85C0F2E; Thu, 12 Jan 2023 16:11:34 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org, John Ogness <john.ogness@linutronix.de>
Subject: [PATCH rcu v2 03/20] drivers/cpufreq: Remove "select SRCU"
Date:   Thu, 12 Jan 2023 16:11:15 -0800
Message-Id: <20230113001132.3375334-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20230113001103.GA3374173@paulmck-ThinkPad-P17-Gen-1>
References: <20230113001103.GA3374173@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the SRCU Kconfig option is unconditionally selected, there is
no longer any point in selecting it.  Therefore, remove the "select SRCU"
Kconfig statements.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: <linux-pm@vger.kernel.org>
Acked-by: "Rafael J. Wysocki" <rafael@kernel.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: John Ogness <john.ogness@linutronix.de>
---
 drivers/cpufreq/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
index 2a84fc63371e2..785541df59379 100644
--- a/drivers/cpufreq/Kconfig
+++ b/drivers/cpufreq/Kconfig
@@ -3,7 +3,6 @@ menu "CPU Frequency scaling"
 
 config CPU_FREQ
 	bool "CPU Frequency scaling"
-	select SRCU
 	help
 	  CPU Frequency scaling allows you to change the clock speed of 
 	  CPUs on the fly. This is a nice method to save power, because 
-- 
2.31.1.189.g2e36527f23

