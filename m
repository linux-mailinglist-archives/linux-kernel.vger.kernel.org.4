Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8E7628D67
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 00:28:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235813AbiKNX2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 18:28:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbiKNX2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 18:28:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D290F0B
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 15:28:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CCAAD614B1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 23:28:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CFCCC433C1;
        Mon, 14 Nov 2022 23:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668468488;
        bh=1FW+G4TwrbSlGabM9+WKmnumD94d0xrskPEMNyCwnLA=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=bdOCF8oimotk8J50F+VkpGQh3TBSUO5URCTzEM/Iw/N/YJiXd2kQncXPrDv/AytwN
         wJFN0JEh2z+XtOqj/PNgiCvL1byae5VfqhfMlN2QcPWE/ssWck+DnkaTMoAgRVdsZR
         Ibt6/kC/c7VBmVEL3ipdZ+LlWW4ozKHCYri+iGB/iEczaOdvc1S6OkFgWAVZHcVP87
         t7gdj15lnfLcV87X/az/BXdQBXDOQ5daDsu2Q7AxRo9p//slSTSbaRIV+SGoarOutB
         4I9rc0+qer1b1nxbvJK5sNbuUNZu7eEoZq4Sy6AzEZBh638cEqWKG2OvBp1leXCAgS
         A+U2s/8/Dy4GQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id BF90C5C14FC; Mon, 14 Nov 2022 15:28:07 -0800 (PST)
Date:   Mon, 14 Nov 2022 15:28:07 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        sboyd@kernel.org, corbet@lwn.net, Mark.Rutland@arm.com,
        maz@kernel.org, kernel-team@meta.com, neeraju@codeaurora.org,
        ak@linux.intel.com, feng.tang@intel.com, zhengjun.xing@intel.com
Subject: [PATCH clocksource 0/3] Reject bogus watchdog clocksource
 measurements
Message-ID: <20221114232807.GA834337@paulmck-ThinkPad-P17-Gen-1>
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

This series adds comments classifying bogus measurements and adds capped
exponential backoff for messages that are likely caused by overly busy
systems.

1.	Reject bogus watchdog clocksource measurements.

2.	Add comments to classify bogus measurements.

3.	Exponential backoff for load-induced bogus watchdog reads.

Changes since v1:

o	Merge the "Reject bogus watchdog clocksource measurements" [1] series
	with the "Clocksource-watchdog classification and backoff" [2] series.

o	Updated messages to indicate timer bug for too-short watchdog
	intervals based on Feng Tang feedback.

o	Added explanatory comments before error messages based on Feng
	Tang feedback.

o	Check both the reference clocksource and the clocksource under
	test to handle clocksource-internal counter wrap, based on Feng
	Tang feedback.

o	Reversed the order of the checks, so that the too-long check
	preceeds the too-short check.  This avoids too-short false
	positives due to counter wrap.

o	Simplified exponential-backoff time checks based on feedback
	from Waiman Long.

o	Updated the exponentially backed off messages to more clearly
	indicate that the counts are instances since the last printed
	message.

o	Applied Reviewed-by tags.

[1] https://lore.kernel.org/all/20221019230904.GA2502730@paulmck-ThinkPad-P17-Gen-1
[2] https://lore.kernel.org/all/20221102184001.GA1306489@paulmck-ThinkPad-P17-Gen-1/

						Thanx, Paul

------------------------------------------------------------------------

 b/include/linux/clocksource.h |    3 +++
 b/kernel/time/clocksource.c   |   13 ++++++++++++-
 kernel/time/clocksource.c     |   33 +++++++++++++++++++++++++++------
 3 files changed, 42 insertions(+), 7 deletions(-)
