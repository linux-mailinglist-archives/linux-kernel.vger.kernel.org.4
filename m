Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3D87674DB9
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 08:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjATHFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 02:05:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjATHFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 02:05:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFDA760CB1;
        Thu, 19 Jan 2023 23:05:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B19561E2C;
        Fri, 20 Jan 2023 07:05:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 475CBC433D2;
        Fri, 20 Jan 2023 07:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1674198325;
        bh=Z7MvmukRBMOVCQZwdpuSlmuG3oETlfTsg97FPGsKsW4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ELxaULdROdpnsoiiTjLMFRuMi2tAln5DRtvohbDMTeLsFWw7tAfEVM+PIdmRbEcDF
         wr2LmmRjggIz3pf9A47KnGvEU01CbQLdM64WnawYfNEC9qaM07yFzlZisMhAS1501m
         NrTgWi2wElf9kJw2rry23r53muU4dzGXpqwtM4So=
Date:   Fri, 20 Jan 2023 08:05:22 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Zhouyi Zhou <zhouzhouyi@gmail.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        rcu <rcu@vger.kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] tick/nohz: Fix cpu_is_hotpluggable() by checking with
 nohz subsystem
Message-ID: <Y8o9Mh1ktK0jdQy9@kroah.com>
References: <20230119204434.4017605-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119204434.4017605-1-joel@joelfernandes.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 08:44:35PM +0000, Joel Fernandes (Google) wrote:
> For CONFIG_NO_HZ_FULL systems, the tick_do_timer_cpu cannot be offlined.
> However, cpu_is_hotpluggable() still returns true for those CPUs. This causes
> torture tests that do offlining to end up trying to offline this CPU causing
> test failures. Such failure happens on all architectures.
> 
> Fix it by asking the opinion of the nohz subsystem on whether the CPU can
> be hotplugged.
> 
> [ Apply Frederic Weisbecker feedback on refactoring tick_nohz_cpu_down(). ]
> 
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Zhouyi Zhou <zhouzhouyi@gmail.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: rcu <rcu@vger.kernel.org>
> Fixes: 2987557f52b9 ("driver-core/cpu: Expose hotpluggability to the rest of the kernel")
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Also want to cc: stable on the patch?

Anyway, for the driver core portion:

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
