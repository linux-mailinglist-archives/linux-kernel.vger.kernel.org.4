Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D70EF658CAC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 13:26:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233182AbiL2M0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 07:26:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiL2M0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 07:26:17 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F00AF2618;
        Thu, 29 Dec 2022 04:26:15 -0800 (PST)
Received: from dggpeml100012.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NjSJR40vkzmWwG;
        Thu, 29 Dec 2022 20:24:55 +0800 (CST)
Received: from localhost.localdomain (10.67.175.61) by
 dggpeml100012.china.huawei.com (7.185.36.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 29 Dec 2022 20:26:14 +0800
From:   Zheng Yejian <zhengyejian1@huawei.com>
To:     <frederic@kernel.org>
CC:     <jiangshanlai@gmail.com>, <joel@joelfernandes.org>,
        <josh@joshtriplett.org>, <linux-kernel@vger.kernel.org>,
        <mathieu.desnoyers@efficios.com>, <paulmck@kernel.org>,
        <quic_neeraju@quicinc.com>, <rcu@vger.kernel.org>,
        <rostedt@goodmis.org>, <zhengyejian1@huawei.com>,
        <mhiramat@kernel.org>
Subject: Re: [PATCH] rcu: Fix kernel stack overflow caused by kprobe on rcu_irq_enter_check_tick()
Date:   Thu, 29 Dec 2022 12:27:31 +0000
Message-ID: <20221229122731.1603031-1-zhengyejian1@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221205132353.GB1796992@lothringen>
References: <20221205132353.GB1796992@lothringen>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.175.61]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml100012.china.huawei.com (7.185.36.121)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Dec 2022 14:23:53 +0100, Frederic Weisbecker wrote:
> On Mon, Nov 21, 2022 at 11:57:03AM -0800, Paul E. McKenney wrote:
> > On Sat, Nov 19, 2022 at 12:00:49PM +0800, Zheng Yejian wrote:
> > > Register kprobe on __rcu_irq_enter_check_tick() can cause kernel stack
> > > overflow [1]. This issue is first found in v5.10 and can be reproduced
> > > by enabling CONFIG_NO_HZ_FULL and doing like:
> > >   # cd /sys/kernel/debug/tracing/
> > >   # echo 'p:mp1 __rcu_irq_enter_check_tick' >> kprobe_events
> > >   # echo 1 > events/kprobes/enable
> > > 
> > > So __rcu_irq_enter_check_tick() should not be kprobed, mark it as noinstr.
> > 
> > Good catch!
> > 
> > I am inclined to queue this, but noticed that one of its callers need
> > it to be noinstr but that the others do not.
> > 
> > Need noinstr:
> > 
> > o	enter_from_kernel_mode() -> __enter_from_kernel_mode() ->
> >	rcu_irq_enter_check_tick() -> __rcu_irq_enter_check_tick()
> > 
> > Doesn't need noinstr:
> > 
> > o	ct_nmi_enter() -> rcu_irq_enter_check_tick() ->
> >	__rcu_irq_enter_check_tick(), courtesy of the call to
> >	instrumentation_begin() in ct_nmi_enter() that precedes the call
> >	to rcu_irq_enter_check_tick().
> > 
> > o	irqentry_enter() -> rcu_irq_enter_check_tick() ->
> >	__rcu_irq_enter_check_tick(), courtesy of the call to
> >	instrumentation_begin() in irqentry_enter() that precedes the
> >	call to rcu_irq_enter_check_tick().
> > 
> > Is tagging __rcu_irq_enter_check_tick() with noinstr as
> > proposed in this patch the right thing to do, or should there
> > be calls to instrumentation_begin() and instrumentation_end() in
> > enter_from_kernel_mode()?  Or something else entirely?
> 
> Tagging as noinstr doesn't look right as there are functions in
> __rcu_irq_enter_check_tick() that can be traced anyway. Also that
> function has the constraint that it can't be called while RCU is idle
> so it's up to the caller to call instrumentation_begin()/end().

This problem is due to __rcu_irq_enter_check_tick() being kprobe-ed, so
how about adding __rcu_irq_enter_check_tick() into kprobe blacklist by
tagging with NOKPROBE_SYMBOL:

  diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
  index cf34a961821a..41606d3ed083 100644
  --- a/kernel/rcu/tree.c
  +++ b/kernel/rcu/tree.c
  @@ -659,6 +659,7 @@ void __rcu_irq_enter_check_tick(void)
          }
          raw_spin_unlock_rcu_node(rdp->mynode);
   }
  +NOKPROBE_SYMBOL(__rcu_irq_enter_check_tick);
   #endif /* CONFIG_NO_HZ_FULL */

+Cc: <mhiramat@kernel.org>

--
Best regards,
Zheng Yejian
