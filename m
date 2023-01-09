Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3316629D4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 16:25:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbjAIPZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 10:25:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232599AbjAIPZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 10:25:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1377B0E;
        Mon,  9 Jan 2023 07:25:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 384E6B80DFB;
        Mon,  9 Jan 2023 15:25:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3C59C433EF;
        Mon,  9 Jan 2023 15:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673277905;
        bh=OG4B8Y2n8B6FbXPUbSEVg7sBqbLSJsKvgb0WiNtKEHg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=U7t2pjogSdogUTcqBihJoYtr0eY9CXoweN/cY8DLmRFLvMLnJNhV209xaR/MZbCaQ
         BUKhNt7dPC5qFv8IcexuUlh+y2FiTcS/enI9ZothRyp+/SOliiAJfPvWseEVkZVCE8
         BiNM7p/xrPfUhYT6sOhmL7TMVDz6dEOHoZVRnyN8FSG17WZHDvJcJTs/5Cl5sZPV1S
         r/243cMep7haTUXYYtnl6WxL/cic+OAHjfo5sx4JHnoSCqLnLVYBIaQ6F7271ujTSr
         GODFRKLpRBvMOv48A1pgsu8H7R/3d9iCdtRK0u4NNjLC9l7pzcWQYbrdbjtRCcZSmB
         bp0KHlNO85aIQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 77DDE5C090A; Mon,  9 Jan 2023 07:25:05 -0800 (PST)
Date:   Mon, 9 Jan 2023 07:25:05 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Zhouyi Zhou <zhouzhouyi@gmail.com>, fweisbec@gmail.com,
        tglx@linutronix.de, mingo@kernel.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-next] mark access to tick_do_timer_cpu with
 READ_ONCE/WRITE_ONCE
Message-ID: <20230109152505.GA4070882@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221219052128.18190-1-zhouzhouyi@gmail.com>
 <Y7wN0TKU1jDyTZs5@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7wN0TKU1jDyTZs5@lothringen>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2023 at 01:51:29PM +0100, Frederic Weisbecker wrote:
> On Mon, Dec 19, 2022 at 01:21:28PM +0800, Zhouyi Zhou wrote:
> > mark access to tick_do_timer_cpu with READ_ONCE/WRITE_ONCE to fix concurrency bug
> > reported by KCSAN.
> > 
> > Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
> > ---
> > During the rcutorture test on linux-next,
> > ./tools/testing/selftests/rcutorture/bin/torture.sh --do-kcsan  --kcsan-kmake-arg "CC=clang-12"
> > following KCSAN BUG is reported:
> > [   35.397089] BUG: KCSAN: data-race in tick_nohz_idle_stop_tick / tick_nohz_next_event^M
> > [   35.400593] ^M
> > [   35.401377] write to 0xffffffffb64b1270 of 4 bytes by task 0 on cpu 3:^M
> > [   35.405325]  tick_nohz_idle_stop_tick+0x14c/0x3e0^M
> > [   35.407162]  do_idle+0xf3/0x2a0^M
> > [   35.408016]  cpu_startup_entry+0x15/0x20^M
> > [   35.409084]  start_secondary+0x8f/0x90^M
> > [   35.410207]  secondary_startup_64_no_verify+0xe1/0xeb^M
> > [   35.411607] ^M
> > [   35.412042] no locks held by swapper/3/0.^M
> > [   35.413172] irq event stamp: 53048^M
> > [   35.414175] hardirqs last  enabled at (53047): [<ffffffffb41f8404>] tick_nohz_idle_enter+0x104/0x140^M
> > [   35.416681] hardirqs last disabled at (53048): [<ffffffffb41229f1>] do_idle+0x91/0x2a0^M
> > [   35.418988] softirqs last  enabled at (53038): [<ffffffffb40bf21e>] __irq_exit_rcu+0x6e/0xc0^M
> > [   35.421347] softirqs last disabled at (53029): [<ffffffffb40bf21e>] __irq_exit_rcu+0x6e/0xc0^M
> > [   35.423685] ^M
> > [   35.424119] read to 0xffffffffb64b1270 of 4 bytes by task 0 on cpu 0:^M
> > [   35.425870]  tick_nohz_next_event+0x233/0x2b0^M
> > [   35.427119]  tick_nohz_idle_stop_tick+0x8f/0x3e0^M
> > [   35.428386]  do_idle+0xf3/0x2a0^M
> > [   35.429265]  cpu_startup_entry+0x15/0x20^M
> > [   35.430429]  rest_init+0x20c/0x210^M
> > [   35.431382]  arch_call_rest_init+0xe/0x10^M
> > [   35.432508]  start_kernel+0x544/0x600^M
> > [   35.433519]  secondary_startup_64_no_verify+0xe1/0xeb^M
> > 
> > fix above bug by marking access to tick_do_timer_cpu with READ_ONCE/WRITE_ONCE
> 
> This has been discussed before with passion:
> 
> http://archive.lwn.net:8080/linux-kernel/1C65422C-FFA4-4651-893B-300FAF9C49DE@lca.pw/T/
> 
> To me data_race() would be more appropriate but that would need a changelog with
> proper analysis of the tick_do_timer_cpu state machine.

Please also an analysis of why the compiler cannot do any destructive
optimizations in this case.  Maybe also comments.

> One more thing on my TODO list, but feel free to beat me at it :-)

I know that feeling!  ;-)

							Thanx, Paul
