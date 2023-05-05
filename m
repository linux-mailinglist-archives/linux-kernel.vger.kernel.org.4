Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 483426F8482
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 16:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232784AbjEEOG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 10:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232243AbjEEOG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 10:06:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E2511B74;
        Fri,  5 May 2023 07:06:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C63963E62;
        Fri,  5 May 2023 14:06:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 719E7C433EF;
        Fri,  5 May 2023 14:06:23 +0000 (UTC)
Date:   Fri, 5 May 2023 10:06:21 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang1.zhang@intel.com>, rcu@vger.kernel.org
Subject: Re: [RFC PATCH 3/4] rculist.h: Fix parentheses around macro pointer
 parameter use
Message-ID: <20230505100621.5d468f95@gandalf.local.home>
In-Reply-To: <CAEXW_YRoqwX1Z3OcRJKxDZ+jAN6Woby+avC9FTdP_8+xyuYqCQ@mail.gmail.com>
References: <20230504012914.1797355-1-mathieu.desnoyers@efficios.com>
        <20230504012914.1797355-3-mathieu.desnoyers@efficios.com>
        <CAEXW_YRoqwX1Z3OcRJKxDZ+jAN6Woby+avC9FTdP_8+xyuYqCQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 May 2023 12:19:38 -0400
Joel Fernandes <joel@joelfernandes.org> wrote:

> >   void f(void)
> >   {
> >           struct test *t1;
> >           struct test **t2 = &t1;
> >
> >           list_for_each_entry_rcu((*t2), &testlist, node) {       /* works */
> >                   //...
> >           }
> >           list_for_each_entry_rcu(*t2, &testlist, node) { /* broken */
> >                   //...
> >           }  
> 
> Yeah it is not clear why anyone would ever want to use it like this.
> Why don't they just pass t1 to list_for_each_entry_rcu() ? I would
> rather it break them and they re-think their code ;).

Remember interfaces should not be enforcing policy unless it's key to the
way the interface works.

-- Steve
