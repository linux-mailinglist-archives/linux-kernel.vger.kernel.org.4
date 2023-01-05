Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBC3F65E225
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 02:04:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjAEBEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 20:04:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjAEBEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 20:04:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF0F113DD1
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 17:04:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 64B0BB81982
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 01:04:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B250C433D2;
        Thu,  5 Jan 2023 01:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672880670;
        bh=agBVmk3wvoAPWOGA1Lw/W0u63NCMhCs6RazubDz7nKE=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=FUZBwl+3o1t9C5xNDypnrz6EBHan7TfT8yY82kCR6jfXkGioWLzjNZNfJoJZd6QHS
         obiQqTs/Z9U626pVPaS9K6L4P0fosf3Jr6w8nZ3eUtbxMVzPFcz6mBpO62WaIoSX5P
         V1oitavz1qxHwrnhaGMN/b3FwlcWcKc6XCNxcaj9pGkg+tCLecWh4zV34Qkw/IGowu
         lTcu8zIogMn0JYE2/jv2XxQYs9Qv+/wwufAMlPfudtzMrLP6gWnW4gbZpdNHoZ8HB1
         lp6xYlHnC2S4RKsZPealxcRDqOt8KzurOtUBx0T3QsrOAQb+K7Z+Xmc6vtjaQ0yOuu
         N8VLgB/2s9jfQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A18C75C05CA; Wed,  4 Jan 2023 17:04:29 -0800 (PST)
Date:   Wed, 4 Jan 2023 17:04:29 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        sboyd@kernel.org, corbet@lwn.net, Mark.Rutland@arm.com,
        maz@kernel.org, kernel-team@meta.com, neeraju@codeaurora.org,
        ak@linux.intel.com, feng.tang@intel.com, zhengjun.xing@intel.com
Subject: [PATCH clocksource 0/6] Clocksource watchdog updates for v6.3
Message-ID: <20230105010429.GA1773522@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This series contains clocksource-watchdog updates:

1.	Print clocksource name when clocksource is tested unstable,
	courtesy of Yunying Sun.

2.	Loosen clocksource watchdog constraints.

3.	Improve read-back-delay message.

4.	Improve "skew is too large" messages.

5.	Suspend the watchdog temporarily when high read latency detected,
	courtesy of Feng Tang.

6.	Verify HPET and PMTMR when TSC unverified.

						Thanx, Paul

------------------------------------------------------------------------

 b/arch/x86/include/asm/time.h   |    1 
 b/arch/x86/kernel/hpet.c        |    2 +
 b/arch/x86/kernel/tsc.c         |    5 ++
 b/drivers/clocksource/acpi_pm.c |    6 ++-
 b/kernel/time/Kconfig           |    6 ++-
 b/kernel/time/clocksource.c     |    4 +-
 kernel/time/clocksource.c       |   72 ++++++++++++++++++++++++++++------------
 7 files changed, 70 insertions(+), 26 deletions(-)
