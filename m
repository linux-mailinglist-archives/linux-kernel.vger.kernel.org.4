Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F26566665A4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 22:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235486AbjAKVcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 16:32:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235143AbjAKVcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 16:32:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4954D13B
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 13:32:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6D805B81D73
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 21:32:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D55DC433EF;
        Wed, 11 Jan 2023 21:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673472731;
        bh=dr6fiRdtfzejt5sfT0dVpS69rQ2Pb5vhRcOde1gXe2M=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=czvSYazh+LQrKU1mGIE/sgjUy9zTNozzhTj1hbunML9xWznhNJyPUTix4Mweqs1zC
         hZJF1Nil3IgMaDWTzDvP2PZZ6ptd18WBrz57C+o4x5OwVouNBw3ak3WbdcTTjOCto9
         6VR35fZjIArTk/bdh0mxqSx/FoVAIt0IZNpDj793/Ao8kclokw2lvhy1Bm9lBdJRFv
         AIdKfcfds47iqBI4HgSdbPuD7D5I7swsmZLk3u7fe7fzVmk91fpGz+I1MjS36FZUzS
         nvRYLtpGhIiGRr/8W1MBGUEZfv2g/1pxt9FmhCda0r/0kpyE/ZIOMfGGeTjBUC/Xx5
         bNFi4DKVpp2lQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A7CE75C0920; Wed, 11 Jan 2023 13:32:10 -0800 (PST)
Date:   Wed, 11 Jan 2023 13:32:10 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        sboyd@kernel.org, corbet@lwn.net, Mark.Rutland@arm.com,
        maz@kernel.org, kernel-team@meta.com, neeraju@codeaurora.org,
        ak@linux.intel.com, feng.tang@intel.com, zhengjun.xing@intel.com,
        Waiman Long <longman@redhat.com>,
        John Stultz <jstultz@google.com>
Subject: Re: [PATCH clocksource 5/6] clocksource: Suspend the watchdog
 temporarily when high read latency detected
Message-ID: <20230111213210.GA4028633@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230105010429.GA1773522@paulmck-ThinkPad-P17-Gen-1>
 <20230105010701.1773895-5-paulmck@kernel.org>
 <87r0w1ia65.ffs@tglx>
 <20230111175056.GW4028633@paulmck-ThinkPad-P17-Gen-1>
 <87wn5sepl5.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wn5sepl5.ffs@tglx>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2023 at 10:19:50PM +0100, Thomas Gleixner wrote:
> On Wed, Jan 11 2023 at 09:50, Paul E. McKenney wrote:
> > On Wed, Jan 11, 2023 at 12:26:58PM +0100, Thomas Gleixner wrote:
> > Yes, if a system was 100% busy forever, this patch would suppress these
> > checks.  But 100% busy forever is not the common case, due to thermal
> > throttling and to security updates if nothing else.
> >
> > With all that said, is there a better way to get the desired effects of
> > this patch?
> 
> Sane hardware?

I must let Feng talk to his systems, but most of the systems I saw were
production systems.  A few were engineering samples, from which some
insanity might be expected behavior.

Clearly, something about the hardware or firmware was insane in order
to get this result, but that is what diagnostics are for, even on
engineering samples.

							Thanx, Paul
