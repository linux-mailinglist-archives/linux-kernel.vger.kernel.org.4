Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4BB723328
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 00:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232046AbjFEW0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 18:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjFEW0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 18:26:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E14CF4
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 15:26:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE19E623A4
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 22:26:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06D27C433EF;
        Mon,  5 Jun 2023 22:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686004007;
        bh=YIwfXvg4q6J7jd/eIT5QQdzHc7eogd+DIP1UaAuLMGw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d+uXaU5SEQrwejEfoTI6ifBMT+0QpNYl34FL5Le+SbfPzs1A/tv8SVEN3lSwBoHM/
         ucTj1s1v1UdY+Uoi1J+RlEhljBZbq4J1NzmkDGA6a3QFF5TqnE9kt99v0KDc2W79C1
         Ty/Xo5nziGrDIjzjzfJATz5rw5NH4cLOZTwhTTEEE0j9XNrC5lwxZ9UIOyH2VSFUDj
         yakbks7bBKJNTsR5Y2WBa0AU5F/goV2MlPbCq9C63MT3QorDSzbU4ZlExlw1Ugktry
         YtiF2999yU46dmv9O3vyAon7dHLhnZhBiE3uphX0G6Y4NU4eC++F6av8QCQ8kyH8rr
         ki50l1nIawpAg==
Date:   Tue, 6 Jun 2023 00:26:44 +0200
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
Subject: Re: [PATCH v7 09/21] timer: add_timer_on(): Make sure TIMER_PINNED
 flag is set
Message-ID: <ZH5hJCS4nBfZhjRy@localhost.localdomain>
References: <20230524070629.6377-1-anna-maria@linutronix.de>
 <20230524070629.6377-10-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230524070629.6377-10-anna-maria@linutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Wed, May 24, 2023 at 09:06:17AM +0200, Anna-Maria Behnsen a écrit :
> When adding a timer to the timer wheel using add_timer_on(), it is an
> implicitly pinned timer. With the timer pull at expiry time model in place,
> TIMER_PINNED flag is required to make sure timers end up in proper base.
> 
> Add TIMER_PINNED flag unconditionally when add_timer_on() is executed.
> 
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

So, as in v6 obviously:

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
