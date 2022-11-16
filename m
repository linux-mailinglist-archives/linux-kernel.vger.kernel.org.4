Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90ACA62CADF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 21:31:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233277AbiKPUbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 15:31:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231565AbiKPUbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 15:31:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F01A1CFE4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 12:31:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D2D20B81EB6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 20:31:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 764B4C433D6;
        Wed, 16 Nov 2022 20:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668630667;
        bh=4/0Jt/PpnMRO7Kd+0c2cQFy0LCiSrdPi9kSmFQ+p528=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=iCCFcpUC0G0V3ZIk1VJWoG9zS7X3C2NGyRzFZ8ToWHxwuVka1LxJ17/DutyKT8a4b
         tXYVnGqpqceC1JxzelZhZ1ZHsSEkzSREImiih4iYNSvYMXc9XPHygj7/ej/ZCsnSbT
         zzXtB8LyF2dqfzTCwBmIgXTUGLq4upvIKLXapa6KppO74FRtilSE6gnoGu9+AJpFJl
         9CDdwUH9FmWLWFiPZ/hH+DvtZL07dF7xN3EJKBzPrey4K40SVzvGcrokoBs+WToqtY
         acaWpW9T4/dXoDV0fWRR4H69nQRoAMoLJbNLTe2bNrJGolTLT6rs6E/A4SWh3y/wmi
         x1XvDrjV245GQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 1524A5C0865; Wed, 16 Nov 2022 12:31:07 -0800 (PST)
Date:   Wed, 16 Nov 2022 12:31:07 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Yunying Sun <yunying.sun@intel.com>
Cc:     tglx@linutronix.de, peterz@infradead.org, longman@redhat.com,
        x86@kernel.org, linux-kernel@vger.kernel.org, feng.tang@intel.com
Subject: Re: [PATCH] clocksource: Print clocksource name when clocksource is
 tested unstable
Message-ID: <20221116203107.GX4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221116082221.25243-1-yunying.sun@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116082221.25243-1-yunying.sun@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 04:22:21PM +0800, Yunying Sun wrote:
> Some "TSC fall back to HPET" cases are seen on systems that have more
> than 2 numa nodes. When this happens, in kernel log it has:
> 
> clocksource: timekeeping watchdog on CPU168: hpet read-back delay of 4296200ns, attempt 4, marking unstable
> 
> The "hpet" here is misleading since it prints only the name of watchdog,
> where actually it's measuring the delay of 3 reads: wd-clocksource-wd.
> 
> Signed-off-by: Yunying Sun <yunying.sun@intel.com>

Good eyes!

I queued this with wordsmithing as shown below.  Please let me know if
I messed something up.

							Thanx, Paul

------------------------------------------------------------------------

commit 72ff63e2d3f19963a4ef401e5f8c1bd16646b587
Author: Yunying Sun <yunying.sun@intel.com>
Date:   Wed Nov 16 16:22:21 2022 +0800

    clocksource: Print clocksource name when clocksource is tested unstable
    
    Some "TSC fall back to HPET" messages appear on systems having more than
    2 NUMA nodes:
    
    clocksource: timekeeping watchdog on CPU168: hpet read-back delay of 4296200ns, attempt 4, marking unstable
    
    The "hpet" here is misleading the clocksource watchdog is really
    doing repeated reads of "hpet" in order to check for unrelated delays.
    Therefore, print the name of the clocksource under test, prefixed by
    "wd-" and suffixed by "-wd", for example, "wd-tsc-wd".
    
    Signed-off-by: Yunying Sun <yunying.sun@intel.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 4015ec6503a52..6f681d56a843f 100644
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
