Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE76669E5B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 17:40:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbjAMQkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 11:40:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbjAMQka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 11:40:30 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id E1213D2F3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 08:38:17 -0800 (PST)
Received: (qmail 25781 invoked by uid 1000); 13 Jan 2023 11:38:17 -0500
Date:   Fri, 13 Jan 2023 11:38:17 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Jonas Oberhauser <jonas.oberhauser@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "parri.andrea" <parri.andrea@gmail.com>, will <will@kernel.org>,
        "boqun.feng" <boqun.feng@gmail.com>, npiggin <npiggin@gmail.com>,
        dhowells <dhowells@redhat.com>,
        "j.alglave" <j.alglave@ucl.ac.uk>,
        "luc.maranget" <luc.maranget@inria.fr>, akiyks <akiyks@gmail.com>,
        dlustig <dlustig@nvidia.com>, joel <joel@joelfernandes.org>,
        urezki <urezki@gmail.com>,
        quic_neeraju <quic_neeraju@quicinc.com>,
        frederic <frederic@kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Internal vs. external barriers (was: Re: Interesting LKMM litmus
 test)
Message-ID: <Y8GI+dbJ3uadVzSb@rowland.harvard.edu>
References: <20220921173109.GA1214281@paulmck-ThinkPad-P17-Gen-1>
 <YytfFiMT2Xsdwowf@rowland.harvard.edu>
 <YywXuzZ/922LHfjI@hirez.programming.kicks-ass.net>
 <114ECED5-FED1-4361-94F7-8D9BC02449B7>
 <Y77rgeg+UgozV/oF@rowland.harvard.edu>
 <07579baee4b84532a76ea8b0b33052bb@huawei.com>
 <20230112215716.GS4028633@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230112215716.GS4028633@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 01:57:16PM -0800, Paul E. McKenney wrote:

> I will risk sharing the intuition behind the rcu-order counting rule.
> 
> In the code, an RCU read-side critical section begins with rcu_read_lock()
> and ends with the matching rcu_read_unlock().  RCU read-side critical
> section may be nested, in which case RCU cares only about the outermost
> of the nested set.
> 
> An RCU grace period includes at least one moment in time during which
> each and every process/CPU/task/whatever is not within an RCU read-side
> critical section.

Strictly speaking, this is not right.  It should say: For each 
process/CPU/task/whatever, an RCU grace period includes at least one 
moment in time during which that process is not within an RCU read-side 
critical section.  There does not have to be any single moment during 
which no processes are executing a critical section.

For example, the following is acceptable:

CPU 0:               start of synchronize_rcu()......end
CPU 1:  rcu_lock().....................rcu_unlock()
CPU 2:                    rcu_lock().......................rcu_unlock()

Alan
