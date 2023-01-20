Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D45F2675617
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 14:44:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbjATNox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 08:44:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjATNou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 08:44:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924E86CCF2;
        Fri, 20 Jan 2023 05:44:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2CFDA61F50;
        Fri, 20 Jan 2023 13:44:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A2F3C433EF;
        Fri, 20 Jan 2023 13:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1674222288;
        bh=Vx0Ly4/3FYSIZHj8WshPhEigMtjpQJssbX6/OvRC0Vs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uhcNop+tkx4/VgWHWf2r7USeTlryrpu4HsZOfu1C7MIAzxx8Z0XZvoKeej1TQk+b6
         yLs5DpWsgsZRryoNWPjnQ+SyTZzDcdUrkCtK1ehSEvS1Avws+S9Qa3ihwX6P21gMCt
         A2L7qKgmYb5MQZmFAQ32FKHbITcI4wsesDTbPn6A=
Date:   Fri, 20 Jan 2023 14:44:46 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Joel Fernandes <joel@joelfernandes.org>
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
Message-ID: <Y8qazpmqk4dmw37F@kroah.com>
References: <Y8o9Mh1ktK0jdQy9@kroah.com>
 <37171A49-82E9-4008-9B5B-1CEEDC9B653E@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <37171A49-82E9-4008-9B5B-1CEEDC9B653E@joelfernandes.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2023 at 08:32:30AM -0500, Joel Fernandes wrote:
> 
> 
> > On Jan 20, 2023, at 2:05 AM, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > 
> > ﻿On Thu, Jan 19, 2023 at 08:44:35PM +0000, Joel Fernandes (Google) wrote:
> >> For CONFIG_NO_HZ_FULL systems, the tick_do_timer_cpu cannot be offlined.
> >> However, cpu_is_hotpluggable() still returns true for those CPUs. This causes
> >> torture tests that do offlining to end up trying to offline this CPU causing
> >> test failures. Such failure happens on all architectures.
> >> 
> >> Fix it by asking the opinion of the nohz subsystem on whether the CPU can
> >> be hotplugged.
> >> 
> >> [ Apply Frederic Weisbecker feedback on refactoring tick_nohz_cpu_down(). ]
> >> 
> >> Cc: Frederic Weisbecker <frederic@kernel.org>
> >> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> >> Cc: Zhouyi Zhou <zhouzhouyi@gmail.com>
> >> Cc: Will Deacon <will@kernel.org>
> >> Cc: Marc Zyngier <maz@kernel.org>
> >> Cc: rcu <rcu@vger.kernel.org>
> >> Fixes: 2987557f52b9 ("driver-core/cpu: Expose hotpluggability to the rest of the kernel")
> >> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > 
> > Also want to cc: stable on the patch?
> 
> Oh sure, sorry. For some reason I thought Sasha and your AI scripts
> were looking at the Linux-kernel list as well. Or are they, and a Cc
> to stable is just to be doubly sure?

As per the rules we have had for the last 15+ years, always add a cc:
stable to be sure that the patch will be considered for stable releases.
If not, you are on you own and sometimes we might notice it, others not.

See:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for the details.

thanks,

greg k-h
