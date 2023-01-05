Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5001065E232
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 02:07:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbjAEBHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 20:07:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbjAEBHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 20:07:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C7530562
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 17:07:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 47BA3B81980
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 01:07:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1E9DC433F0;
        Thu,  5 Jan 2023 01:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672880823;
        bh=ZxflhOZe+HfSeKoe2YE5lW7UCVsim4bFg/Q32iI5pZk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r+YiZtfFBZfzgNj7s7ovifNLZtJ4uYwpTFf2uaMsVsEhbEAqq8IBqdUsdYNYAvKKB
         jtWs0m44JrzvmW7SKXdV56RWB8TYOTl68yfgziyO3MXmSxd12eRpSYGuu3gHnyp3Mz
         HoSkfWWe/Rct3zheX2cXZC9bvaesj6OrP30Rc+iFK6Jdm82dHEehZ2ryOL0bsWUzwk
         g9C7GuLc9uU7WeFuEbztQGZECqJZVai9rxCrx/E+r7MG6+ua0d5kXPaG9HfBRkjFHg
         kQRMrauSSJPMXMJs/D7i9Mqavt4UmiBI6qOqD3ZxhyD03asnfwC9o3NLxhDnJt4uXl
         DJp/0cIRqjZFA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id AC8935C08E5; Wed,  4 Jan 2023 17:07:02 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        sboyd@kernel.org, corbet@lwn.net, Mark.Rutland@arm.com,
        maz@kernel.org, kernel-team@meta.com, neeraju@codeaurora.org,
        ak@linux.intel.com, feng.tang@intel.com, zhengjun.xing@intel.com,
        "Paul E. McKenney" <paulmck@kernel.org>,
        John Stultz <jstultz@google.com>
Subject: [PATCH clocksource 3/6] clocksource: Improve read-back-delay message
Date:   Wed,  4 Jan 2023 17:06:58 -0800
Message-Id: <20230105010701.1773895-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20230105010429.GA1773522@paulmck-ThinkPad-P17-Gen-1>
References: <20230105010429.GA1773522@paulmck-ThinkPad-P17-Gen-1>
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

When cs_watchdog_read() is unable to get a qualifying clocksource read
within the limit set by max_cswd_read_retries, it prints a message
and marks the clocksource under test as unstable.  But that message is
unclear to anyone unfamiliar with the code:

clocksource: timekeeping watchdog on CPU13: wd-tsc-wd read-back delay 1000614ns, attempt 3, marking unstable

Therefore, add some context so that the message appears as follows:

clocksource: timekeeping watchdog on CPU13: wd-tsc-wd excessive read-back delay of 1000614ns vs. limit of 125000ns, wd-wd read-back delay only 27ns, attempt 3, marking tsc unstable

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: John Stultz <jstultz@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Feng Tang <feng.tang@intel.com>
---
 kernel/time/clocksource.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index a3d19f6660ac7..b59914953809f 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -260,8 +260,8 @@ static enum wd_read_status cs_watchdog_read(struct clocksource *cs, u64 *csnow,
 			goto skip_test;
 	}
 
-	pr_warn("timekeeping watchdog on CPU%d: wd-%s-wd read-back delay of %lldns, attempt %d, marking unstable\n",
-		smp_processor_id(), cs->name, wd_delay, nretries);
+	pr_warn("timekeeping watchdog on CPU%d: wd-%s-wd excessive read-back delay of %lldns vs. limit of %ldns, wd-wd read-back delay only %lldns, attempt %d, marking %s unstable\n",
+		smp_processor_id(), cs->name, wd_delay, WATCHDOG_MAX_SKEW, wd_seq_delay, nretries, cs->name);
 	return WD_READ_UNSTABLE;
 
 skip_test:
-- 
2.31.1.189.g2e36527f23

