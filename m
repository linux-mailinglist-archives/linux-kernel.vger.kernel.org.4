Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E66D72331D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 00:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbjFEWZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 18:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjFEWZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 18:25:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7BBBF4
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 15:25:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C1F4622BD
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 22:25:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21917C433D2;
        Mon,  5 Jun 2023 22:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686003936;
        bh=s8/kkstSBxgPDYSY23EyfYDmhW5ZHJc98RUffgqvWog=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hXT5vZubjHO/n6kjop3dK/E1x8VHvvRzOMJRiGeQqtP790zofD2Iby2VD6ORIIi1U
         TbFBSc5YqdcYQcy/CfD3KKtHyZQ7A+FOGc3cXWz5PWelFExdNrp9vCPw/FgHAcFGRr
         ia9X1lGuu9w/voozatrDC55s8zR3WOFbxx0wd/U91sYEKOE1feEq3qaHu2YR5Tzx0S
         QRZuKxhDbA2zHi7OZ1PXt+VlxrYpJhHfPKokScmMnOZoRWILBhv6HEPi2OSYOpzZ/t
         9k8fSiMLQqloWzZbTrwRM5c+rNRKL7k5RTNYyewVJcnzEwlQmWh08hCPp7Ap0/nPw7
         4qFNDcGYEHIFQ==
Date:   Tue, 6 Jun 2023 00:25:33 +0200
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
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH v7 08/21] workqueue: Use global variant for add_timer()
Message-ID: <ZH5g3R3znZ8un-rx@localhost.localdomain>
References: <20230524070629.6377-1-anna-maria@linutronix.de>
 <20230524070629.6377-9-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230524070629.6377-9-anna-maria@linutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Wed, May 24, 2023 at 09:06:16AM +0200, Anna-Maria Behnsen a écrit :
> The implementation of the NOHZ pull at expiry model will change the timer
> bases per CPU. Timers, that have to expire on a specific CPU, require the
> TIMER_PINNED flag. If the CPU doesn't matter, the TIMER_PINNED flag must be
> dropped. This is required for call sites which use the timer alternately as
> pinned and not pinned timer like workqueues do.
> 
> Therefore use add_timer_global() to make sure TIMER_PINNED flag is dropped.
> 
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
> Acked-by: Tejun Heo <tj@kernel.org>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Lai Jiangshan <jiangshanlai@gmail.com>

Getting confused between v6 and v7...

Anyway:

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
