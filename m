Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE78C642E11
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 18:00:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbiLERAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 12:00:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbiLERAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 12:00:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FBE7DF61
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 09:00:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C18D611E2
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 17:00:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70001C433D7;
        Mon,  5 Dec 2022 17:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670259611;
        bh=11dJgjFEdX9UVENkGoo1gDgYGaQdGrmHruVZ0tuXXOw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=QW0P/KwLs8tJxZDtYwgEamDRTxTMNoSPRBz8HK/WvTZuKluT90U22wdJB06KcT7X5
         vm5nucyrN1F2UyNlbyzWYB41sJxV7gXGXjp7/+SaixjKwZv0yH3MRRga98Zdz+UV0W
         NXhWj6cCIo1wppUOlJ9i44XAKusA2Kdh9v7oQpjB14JiOL/JqsuIMOxTd1JKp6XbUV
         F/wozyLY1CSE9y8Bxa/QgnMGY2vNbpjh+j6R1GqKsRATCjaEX3mYfpRnxK+votX9JS
         4/scRP6r99xVHVJsPmFNkozqs4tjVfIyMjkRV/Ui1kC/0JqdCt9qn7MqsMgLRdGft3
         oUPB8xzF8lzdA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 08B545C05C0; Mon,  5 Dec 2022 09:00:11 -0800 (PST)
Date:   Mon, 5 Dec 2022 09:00:11 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, ebiederm@xmission.com,
        tglx@linutronix.de, bigeasy@linutronix.de, luto@kernel.org,
        Liam.Howlett@Oracle.com, fenghua.yu@intel.com,
        peterz@infradead.org, joel@joelfernandes.org
Subject: Re: __put_task_struct() WARN_ON(!tsk->exit_state)?
Message-ID: <20221205170011.GA1462606@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221203192443.GA1270730@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221203192443.GA1270730@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PLING_QUERY,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 03, 2022 at 11:24:43AM -0800, Paul E. McKenney wrote:
> Hello!
> 
> One of last night's rcutorture TREE03 runs triggered the
> __put_task_struct() function's first WARN_ON() complaining that
> the tasks's ->exit_state was zero.  This was on mainline merged
> into RCU's "dev" branch.  There immediately follows a splat from
> refcount_warn_saturate(), so there are two interlaced stack dumps.  :-/
> 
> What I do have seems to implicate rt_mutex priority boosting triggered
> by RCU's prioritiy boosting.
> 
> Left to myself, my next steps are to try to reproduce this.  It happened
> once in 150 hours of TREE03, so who knows?
> 
> But I figured I should check to see if anyone else is hitting this.

And hammering this hard all weekend failed to reproduce.  1500 hours of
TREE03 and no failures.

Yet another thing going bump in the night.

Left to myself, my next step is to try out Joel's locktorture patches.

https://lore.kernel.org/lkml/20221123012104.3317665-3-joel@joelfernandes.org/

							Thanx, Paul
