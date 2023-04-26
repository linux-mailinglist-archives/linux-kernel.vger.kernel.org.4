Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC9646EFC4A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 23:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239415AbjDZVRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 17:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjDZVRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 17:17:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 297BF26A6;
        Wed, 26 Apr 2023 14:17:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B65E263441;
        Wed, 26 Apr 2023 21:17:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B7D5C433D2;
        Wed, 26 Apr 2023 21:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682543824;
        bh=pyR8etJ8lQqzGGZ35EU50KdUAefCugLRG9HniYy5mT8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=cr96P0qg5DUaul3Dh3Pl/GhoQZ8LxBQ+Zhj66onz5Snbhz1JWnw/aVmUp6i147ASZ
         sT0ErMJhtibZumxamsaPbg2KaUu60uhPUyry+BYp2vwiLRbu8WjnjNyPGl7slc8j6H
         6hHM9IZ8LPLP8cTXJcQulsmHSmWIcTtj/pVYENvbOJnMlRPBVA7An+rumhDt68KOhc
         ycoJ/nn2MrmF8u/2xzlCrQrezm5r0LRQJhqkgGSaSobsJhqkOG2NX1Uei28WMcXmIt
         D0iJLYqkdb3r5VVWXKbj5N6MYhrs4uyfXcuXRmHCpZ7cBW72Uz2qQ1YVhBj8auzwgp
         RQVqtcxrarJUQ==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id A3B1A15404B7; Wed, 26 Apr 2023 14:17:03 -0700 (PDT)
Date:   Wed, 26 Apr 2023 14:17:03 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, rostedt@goodmis.org, riel@surriel.com
Subject: Re: [PATCH RFC rcu] Stop rcu_tasks_invoke_cbs() from using
 never-online CPUs
Message-ID: <1713f8f6-88d6-41f1-bbc6-045b2e017289@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <83d037d1-ef12-4b31-a7b9-7b1ed6c3ae42@paulmck-laptop>
 <ZEmBy0H5T5vQJDUW@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZEmBy0H5T5vQJDUW@slm.duckdns.org>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 26, 2023 at 09:55:55AM -1000, Tejun Heo wrote:
> Hello, Paul.
> 
> On Wed, Apr 26, 2023 at 10:26:38AM -0700, Paul E. McKenney wrote:
> > The rcu_tasks_invoke_cbs() relies on queue_work_on() to silently fall
> > back to WORK_CPU_UNBOUND when the specified CPU is offline.  However,
> > the queue_work_on() function's silent fallback mechanism relies on that
> > CPU having been online at some time in the past.  When queue_work_on()
> > is passed a CPU that has never been online, workqueue lockups ensue,
> > which can be bad for your kernel's general health and well-being.
> > 
> > This commit therefore checks whether a given CPU is currently online,
> > and, if not substitutes WORK_CPU_UNBOUND in the subsequent call to
> > queue_work_on().  Why not simply omit the queue_work_on() call entirely?
> > Because this function is flooding callback-invocation notifications
> > to all CPUs, and must deal with possibilities that include a sparse
> > cpu_possible_mask.
> > 
> > Fixes: d363f833c6d88 rcu-tasks: Use workqueues for multiple rcu_tasks_invoke_cbs() invocations
> > Reported-by: Tejun Heo <tj@kernel.org>
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> I don't understand the code at all but wonder whether it can do sth similar
> to cpumask_any_distribute() which RR's through the specified cpumask. Would
> it make sense to change rcu_tasks_invoke_cbs() to do something similar
> against cpu_online_mask?

It might.

But the idea here is to spread the load of queueing the work as well as
spreading the load of invoking the callbacks.

I suppose that I could allocate an array of ints, gather the online CPUs
into that array, and do a power-of-two distribution across that array.
But RCU Tasks allows CPUs to go offline with queued callbacks, so this
array would also need to include those CPUs as well as the ones that
are online.

Given that the common-case system has a dense cpus_online_mask, I opted
to keep it simple, which is optimal in the common case.

Or am I missing a trick here?

							Thanx, Paul
