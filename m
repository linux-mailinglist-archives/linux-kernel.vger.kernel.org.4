Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFAF165E22F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 02:07:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbjAEBHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 20:07:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjAEBHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 20:07:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E1B2F7B2
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 17:07:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9053C61881
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 01:07:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAF85C433EF;
        Thu,  5 Jan 2023 01:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672880823;
        bh=tNnAiq5HYDDhjHdWky6iQVYABLIWoBenLL5L50zs8N4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GN77Hc6XS1nlTuMi12zL+N+XWGpzdO2v30sgdGDbi9bCgHju5MURna2GwsoIifsPV
         vc1CaTS3N8FZqPl7Loq6Dtw53crh8h4cwiRccmYhE3kihvi4neBVQHbZZ6A6kpJVxC
         nT/3hb/XQZwWRMgaTlmuBIb+c9zK90NbpP5svTCaqW6JT2FB1izLxtejExLy3bEGHR
         e8Fj1/gQ8pg+zZ2twpmPJljotcSA0bMgvp6APi6jrVKUB39Dw3gQs3jPCaKGjvrkzp
         AnVY3pcTkWw1xmILRbyU7UlcoTOr5lhAEK+B76viUgUg7snuN05dvC2/HgYO5R/pz1
         G1YoEbd+wY8CQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A84285C05CA; Wed,  4 Jan 2023 17:07:02 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        sboyd@kernel.org, corbet@lwn.net, Mark.Rutland@arm.com,
        maz@kernel.org, kernel-team@meta.com, neeraju@codeaurora.org,
        ak@linux.intel.com, feng.tang@intel.com, zhengjun.xing@intel.com,
        Yunying Sun <yunying.sun@intel.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH clocksource 1/6] clocksource: Print clocksource name when clocksource is tested unstable
Date:   Wed,  4 Jan 2023 17:06:56 -0800
Message-Id: <20230105010701.1773895-1-paulmck@kernel.org>
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

From: Yunying Sun <yunying.sun@intel.com>

Some "TSC fall back to HPET" messages appear on systems having more than
2 NUMA nodes:

clocksource: timekeeping watchdog on CPU168: hpet read-back delay of 4296200ns, attempt 4, marking unstable

The "hpet" here is misleading the clocksource watchdog is really
doing repeated reads of "hpet" in order to check for unrelated delays.
Therefore, print the name of the clocksource under test, prefixed by
"wd-" and suffixed by "-wd", for example, "wd-tsc-wd".

Signed-off-by: Yunying Sun <yunying.sun@intel.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/time/clocksource.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 9cf32ccda715d..4a2c3bb92e2e9 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -257,8 +257,8 @@ static enum wd_read_status cs_watchdog_read(struct clocksource *cs, u64 *csnow,
 			goto skip_test;
 	}
 
-	pr_warn("timekeeping watchdog on CPU%d: %s read-back delay of %lldns, attempt %d, marking unstable\n",
-		smp_processor_id(), watchdog->name, wd_delay, nretries);
+	pr_warn("timekeeping watchdog on CPU%d: wd-%s-wd read-back delay of %lldns, attempt %d, marking unstable\n",
+		smp_processor_id(), cs->name, wd_delay, nretries);
 	return WD_READ_UNSTABLE;
 
 skip_test:
-- 
2.31.1.189.g2e36527f23

