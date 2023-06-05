Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD9F7232FD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 00:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232609AbjFEWMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 18:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232455AbjFEWMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 18:12:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A902DAF
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 15:12:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A6AB62B48
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 22:12:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEF7EC433D2;
        Mon,  5 Jun 2023 22:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686003159;
        bh=8D6dKhwDM7qry1wqP8+wGLdVPUuxlLg1wYJTAvnn3Ks=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TehbIDvZ8XnjrJ2PvtfLRcrjGdDGhBX//s9xdPWN3gZd4o/FZc6ZM8Yodu79Grlzx
         r2m3qYS/e85FaAE0Xt0psTynwNi3RFrG+zKFHTf8JB2BrWFwoVNYDu2VIQFu1sWQg9
         we6X3Sot0rwwsVK5dBdDO6t2j1qC/t/tRX5VnNpMIVL5hcK/D0rcQj4E7RjNPKFOCK
         9JeiBjPkGA9Nh2QnoH0sKwIvLGOC+C7zYlommRaBoE62rUT1kkoMjT+BYcLLXmtDAp
         kjuQcXuZeBMPy7CrwwFwVBRb1bo17uFKuhdbS9+oZrIYL9YUo4D9vKdfvnIiwv5M0D
         LcYPvKzM10ttw==
Date:   Tue, 6 Jun 2023 00:12:36 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eric Dumazet <edumazet@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Arjan van de Ven <arjan@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Rik van Riel <riel@surriel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Lukasz Luba <lukasz.luba@arm.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>
Subject: Re: [PATCH v6 09/21] timer: add_timer_on(): Make sure TIMER_PINNED
 flag is set
Message-ID: <ZH5d1D_ci42zujmi@localhost.localdomain>
References: <20230510072817.116056-1-anna-maria@linutronix.de>
 <20230510072817.116056-10-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230510072817.116056-10-anna-maria@linutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Wed, May 10, 2023 at 09:28:05AM +0200, Anna-Maria Behnsen a écrit :
> When adding a timer to the timer wheel using add_timer_on(), it is an
> implicitly pinned timer. With the timer pull at expiry time model in place,
> TIMER_PINNED flag is required to make sure timers end up in proper base.
> 
> Add TIMER_PINNED flag unconditionally when add_timer_on() is executed.
> 
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

The current users of add_timer_on() don't seem to play nasty
games. Those who use mixes of add_timer_on() and mod_timer()
at least have set TIMER_PINNED on setup time, so looks good.

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
