Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5B061F494
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 14:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231949AbiKGNnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 08:43:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231795AbiKGNnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 08:43:33 -0500
X-Greylist: delayed 401 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Nov 2022 05:43:31 PST
Received: from second.openwall.net (second.openwall.net [193.110.157.125])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 14EBEC0F
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 05:43:30 -0800 (PST)
Received: (qmail 22500 invoked from network); 7 Nov 2022 13:36:47 -0000
Received: from localhost (HELO pvt.openwall.com) (127.0.0.1)
  by localhost with SMTP; 7 Nov 2022 13:36:47 -0000
Received: by pvt.openwall.com (Postfix, from userid 503)
        id 7B532AB3A4; Mon,  7 Nov 2022 14:36:28 +0100 (CET)
Date:   Mon, 7 Nov 2022 14:36:28 +0100
From:   Solar Designer <solar@openwall.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     wuqiang <wuqiang.matt@bytedance.com>, davem@davemloft.net,
        anil.s.keshavamurthy@intel.com, naveen.n.rao@linux.ibm.com,
        linux-kernel@vger.kernel.org, mattwu@163.com,
        Adam Zabrocki <pi3@pi3.com.pl>
Subject: Re: [PATCH] kretprobe events missing on 2-core KVM guest
Message-ID: <20221107133628.GA31649@openwall.com>
References: <20221025100117.18667-1-wuqiang.matt@bytedance.com> <20221026003315.266d59d5c0780c2817be3a0d@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221026003315.266d59d5c0780c2817be3a0d@kernel.org>
User-Agent: Mutt/1.4.2.3i
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 26, 2022 at 12:33:15AM +0900, Masami Hiramatsu wrote:
> On Tue, 25 Oct 2022 18:01:17 +0800
> wuqiang <wuqiang.matt@bytedance.com> wrote:
> 
> > Default value of maxactive is set as num_possible_cpus() for nonpreemptable
> > systems. For a 2-core system, only 2 kretprobe instances would be allocated
> > in default, then these 2 instances for execve kretprobe are very likely to
> > be used up with a pipelined command.
> > 
> > This patch increases the minimum of maxactive to 10.
> 
> This looks reasonable to me.
> 
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Reasonable yes, but:

Is 10 enough?  How exactly do those instances get used up without
preemption?  Perhaps because execve can sleep?  If so, perhaps we should
use the same logic without preemption that we do with preemption?  So
maybe just make this line unconditional? -

		rp->maxactive = max_t(unsigned int, 10, 2*num_possible_cpus());

Also, the behavior was documented in Documentation/trace/kprobes.rst, so
perhaps that file should be updated at the same time with the code.

> > Signed-off-by: wuqiang <wuqiang.matt@bytedance.com>
> > ---
> >  kernel/kprobes.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> > index 3220b0a2fb4a..b781dee3f552 100644
> > --- a/kernel/kprobes.c
> > +++ b/kernel/kprobes.c
> > @@ -2211,7 +2211,7 @@ int register_kretprobe(struct kretprobe *rp)
> >  #ifdef CONFIG_PREEMPTION
> >  		rp->maxactive = max_t(unsigned int, 10, 2*num_possible_cpus());
> >  #else
> > -		rp->maxactive = num_possible_cpus();
> > +		rp->maxactive = max_t(unsigned int, 10, num_possible_cpus());
> >  #endif
> >  	}
> >  #ifdef CONFIG_KRETPROBE_ON_RETHOOK
> > -- 
> > 2.34.1
> > 
> 
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,

Alexander
