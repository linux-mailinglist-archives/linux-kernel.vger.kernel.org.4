Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0B767A7B6
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 01:29:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234906AbjAYA2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 19:28:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234844AbjAYA2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 19:28:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F91B4FCF9
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 16:28:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 13015B81733
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 00:27:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9194C433D2;
        Wed, 25 Jan 2023 00:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674606452;
        bh=tNnAiq5HYDDhjHdWky6iQVYABLIWoBenLL5L50zs8N4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VwL9RjIynMxgRjV7vJJ4DVSGgr9HP66z59GPqdNyaTTCH/mGO8pgQlEMliBHMBbWf
         K/v4erTgqLapYCyAQYvU1gcIWjNRJve/+Y7y8JvTWuFBSd/6IOMdyWMKzezOiFC0X9
         kUtDuapIjbCkaMFgU4bc+gtcbEcyAAlngeMI2I96uzJoODzEWFNV2fZyTogbV9QVOJ
         Kpx6jGAdNRcmKNXn6c8o5uHzinrXPxVvj1e1iypF2YB9RCwMIal2NbiWDZvEP8oHMA
         6bGLfg56FPc/taghp4N0ColrG4u57Jo2dZuY3togkI8893JEGEZT3eaiZKNiSkKeL/
         2meIwr+u4tkUA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 6FE445C1052; Tue, 24 Jan 2023 16:27:32 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        sboyd@kernel.org, corbet@lwn.net, Mark.Rutland@arm.com,
        maz@kernel.org, kernel-team@meta.com, neeraju@codeaurora.org,
        ak@linux.intel.com, feng.tang@intel.com, zhengjun.xing@intel.com,
        Yunying Sun <yunying.sun@intel.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 clocksource 1/7] clocksource: Print clocksource name when clocksource is tested unstable
Date:   Tue, 24 Jan 2023 16:27:24 -0800
Message-Id: <20230125002730.1471349-1-paulmck@kernel.org>
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

