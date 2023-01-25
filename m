Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 555AA67A7AD
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 01:28:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234810AbjAYA2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 19:28:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234776AbjAYA2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 19:28:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B10B34FCE4
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 16:27:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1F85AB817B0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 00:27:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5AE4C433A1;
        Wed, 25 Jan 2023 00:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674606452;
        bh=ZxflhOZe+HfSeKoe2YE5lW7UCVsim4bFg/Q32iI5pZk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CFCBsChk11U1OdzY0Ae1UZuelg2vUshpjAcvDpHpLrGrsl3hYCHZgf36c3Vz81xpq
         t5McnArBb5PK1zKcnF7XMajXFvs2O6c+NQ8xLdHqJs6MyGqt0i4hT6arXaMy1J4mhx
         tArxfPbW/plciZF0sFLosPE4BYqRcj4P0c8EyaJkbpaEiW90NJl758LJorI7zMALQd
         5Y2e4d5m2QlXc8Kk6iCsbHgAvPoAqyLXkUkHyKgy43MXHo+Fvkfx6kaVnn/nk7iDRp
         Ne1dqc6suNhYtf177qfGNy46QpyXzQpaqmLajeFUocHT8BibTwe2dKVROtA6Hsh1bJ
         oEHHg1uzaU14A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 748B75C1C66; Tue, 24 Jan 2023 16:27:32 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        sboyd@kernel.org, corbet@lwn.net, Mark.Rutland@arm.com,
        maz@kernel.org, kernel-team@meta.com, neeraju@codeaurora.org,
        ak@linux.intel.com, feng.tang@intel.com, zhengjun.xing@intel.com,
        "Paul E. McKenney" <paulmck@kernel.org>,
        John Stultz <jstultz@google.com>
Subject: [PATCH v2 clocksource 3/7] clocksource: Improve read-back-delay message
Date:   Tue, 24 Jan 2023 16:27:26 -0800
Message-Id: <20230125002730.1471349-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20230125002708.GA1471122@paulmck-ThinkPad-P17-Gen-1>
References: <20230125002708.GA1471122@paulmck-ThinkPad-P17-Gen-1>
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

