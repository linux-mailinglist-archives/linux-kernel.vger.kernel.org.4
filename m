Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF266A715E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 17:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbjCAQil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 11:38:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjCAQii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 11:38:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 546CD233FF;
        Wed,  1 Mar 2023 08:38:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ABC61B810C2;
        Wed,  1 Mar 2023 16:38:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32F34C433D2;
        Wed,  1 Mar 2023 16:38:17 +0000 (UTC)
Date:   Wed, 1 Mar 2023 11:38:13 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH] rcu: use try_cmpxchg in check_cpu_stall
Message-ID: <20230301113813.4f16a689@gandalf.local.home>
In-Reply-To: <CAFULd4aY3Y8tyLN70oebZDagBebvH0erwRxKDaEX8L83Xo8gYw@mail.gmail.com>
References: <20230228155121.3416-1-ubizjak@gmail.com>
        <Y/5mguXPPqdP3MZF@google.com>
        <20230228160324.2a7c1012@gandalf.local.home>
        <20230228212911.GX2948950@paulmck-ThinkPad-P17-Gen-1>
        <20230228164124.77c126d2@gandalf.local.home>
        <CAEXW_YQ515_DOLVUm48GvDADuaY2mSrYTaKa7u6jYDNqBncJww@mail.gmail.com>
        <20230228190846.79b06089@gandalf.local.home>
        <CAFULd4aY3Y8tyLN70oebZDagBebvH0erwRxKDaEX8L83Xo8gYw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Mar 2023 11:28:47 +0100
Uros Bizjak <ubizjak@gmail.com> wrote:

> These benefits are the reason the change to try_cmpxchg was accepted
> also in the linear code elsewhere in the linux kernel, e.g. [2,3] to
> name a few commits, with a thumbs-up and a claim that the new code is
> actually *clearer* at the merge commit [4].

I'll say it here too. I really like Joel's suggestion of having a
cmpxchg_success() that does not have the added side effect of modifying the
old variable.

I think that would allow for the arch optimizations that you are trying to
achieve, as well as remove the side effect that might cause issues down the
road.

-- Steve
