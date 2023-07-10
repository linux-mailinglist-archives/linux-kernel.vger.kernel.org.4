Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE73C74DF57
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 22:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjGJUdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 16:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbjGJUdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 16:33:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A813DAD;
        Mon, 10 Jul 2023 13:33:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 439CE611DC;
        Mon, 10 Jul 2023 20:33:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D16EC433C7;
        Mon, 10 Jul 2023 20:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689021179;
        bh=DUlvTGQbRlgHfvUIq64vgJvepRuPbwJU9Mj7tz1rw0s=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=NI6WSYFz2jmNWfkEvf0+/P78If/lMk7teaGNbkY14oPG5LxNRAlbj3Bw7XgvDAri5
         aTMP2DQUhXpyDUvhmCsZHFCDg4mERmtcsk/aN5ClHpjAMGiEqGJUI5mLhbkJWuqDlc
         SbxjivQ/TM4XEcCIeRdi84/dubkMYys++Rwh3i7HMtTnHfeZwyoJfAKcAUvGbG/usx
         3zNzr4VpWHKOtZAMn2II9nS/fZjIb3xQtPk3UU2kNWxZn65BPj3s97gyQ6SeGZcBjh
         eHO4HbQmZGmXLK+WvCvL5++3LjQdtoLrEr1iTKyi2C1uGxWZ8YdaVYymu1V+lHmk0T
         6P2D1Ns9lM9jA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 213B7CE008B; Mon, 10 Jul 2023 13:32:59 -0700 (PDT)
Date:   Mon, 10 Jul 2023 13:32:59 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Zhen Lei <thunder.leizhen@huawei.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] rcu: Don't dump the stalled CPU on where RCU GP
 kthread last ran twice
Message-ID: <33ec8708-35be-446a-8cc5-58d366a6d75d@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230705073020.2030-1-thunder.leizhen@huawei.com>
 <20230705073020.2030-3-thunder.leizhen@huawei.com>
 <39430021-dc0d-4abd-8266-642e4e2dc7df@paulmck-laptop>
 <CAEXW_YR_t-x-eYKLFmruOLqZv91oi=AJKEEeuqYosejjdscn1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEXW_YR_t-x-eYKLFmruOLqZv91oi=AJKEEeuqYosejjdscn1g@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 03:55:16PM -0400, Joel Fernandes wrote:
> On Mon, Jul 10, 2023 at 3:06 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Wed, Jul 05, 2023 at 03:30:20PM +0800, Zhen Lei wrote:
> > > The stacks of all stalled CPUs will be dumped. If the CPU on where RCU GP
> > > kthread last ran is stalled, its stack does not need to be dumped again.
> > >
> > > Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> >
> > This one looks good.  Please feel free to rebase it before 1/2 and repost.
> 
> Just a small comment:
> I wondered if this would make it harder to identify which stack among
> the various CPU stacks corresponds to the one the GP kthread is
> running on. However, this line does print the CPU number of the
> thread, so it is perhaps not an issue:
> 
>                 pr_err("%s kthread starved for %ld jiffies! g%ld f%#x
> %s(%d) ->state=%#x ->cpu=%d\n",
> 
> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Thank you!  Zhen Lei, please feel free to add Joel's Reviewed-by on your
next posting.

							Thanx, Paul
