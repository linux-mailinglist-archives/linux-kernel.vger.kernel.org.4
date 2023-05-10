Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22EC66FE803
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 01:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236801AbjEJXQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 19:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjEJXQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 19:16:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC4C1A1
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 16:16:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C58A635F4
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 23:16:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C3BAC433EF;
        Wed, 10 May 2023 23:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683760560;
        bh=rBmx1yXHlgjq29yI8RX3oTegeXm2Dm3PwYKq6C9UhEg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aC5k1PPm01evQ+iK2HeIF9cSXIKcxbEuUoyZCyR2X9VeCgMB2UgdJlegPSPTlDM0F
         cfImJwTp0zC1idPWGAMx8O2kL9CFFgxjiHNpFk6ySlazf+34mwRNFfk97WGsXQM/+w
         YMcAp7SqpzgUNMnjPNeIfi4PSm4MJ4Y8PFjtaAVlJIjoy1uzXupklJvDphyPIyY4KE
         EDoCkvhOSTSDEnuXi7H8achdOURjdtuNnzFJrJZhGgZq/q6/NRAtkV64envQw+3CK8
         6n39TVzTsKl/xb0IML5aOAsyqzJYNdh9YcL5FBrGsi9+I4EaXJic0+m1v2f50W06Ni
         gqzEhLRwJHUXQ==
Date:   Wed, 10 May 2023 16:15:59 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Peilin Ye <yepeilin.cs@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        Peilin Ye <peilin.ye@bytedance.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Vlad Buslov <vladbu@mellanox.com>,
        Pedro Tammela <pctammela@mojatatu.com>,
        Hillf Danton <hdanton@sina.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Cong Wang <cong.wang@bytedance.com>
Subject: Re: [PATCH net 6/6] net/sched: qdisc_destroy() old ingress and
 clsact Qdiscs before grafting
Message-ID: <20230510161559.2767b27a@kernel.org>
In-Reply-To: <ZFv6Z7hssZ9snNAw@C02FL77VMD6R.googleapis.com>
References: <cover.1683326865.git.peilin.ye@bytedance.com>
        <e6c4681dd9205d702ae2e6124e20c6210520e76e.1683326865.git.peilin.ye@bytedance.com>
        <20230508183324.020f3ec7@kernel.org>
        <ZFv6Z7hssZ9snNAw@C02FL77VMD6R.googleapis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 May 2023 13:11:19 -0700 Peilin Ye wrote:
> On Fri,  5 May 2023 17:16:10 -0700 Peilin Ye wrote:
> >   Thread 1 creates ingress Qdisc A (containing mini Qdisc a1 and a2), then
> >   adds a flower filter X to A.
> > 
> >   Thread 2 creates another ingress Qdisc B (containing mini Qdisc b1 and
> >   b2) to replace A, then adds a flower filter Y to B.
> > 
> >  Thread 1               A's refcnt   Thread 2
> >   RTM_NEWQDISC (A, RTNL-locked)
> >    qdisc_create(A)               1
> >    qdisc_graft(A)                9
> > 
> >   RTM_NEWTFILTER (X, RTNL-lockless)
> >    __tcf_qdisc_find(A)          10
> >    tcf_chain0_head_change(A)
> >    mini_qdisc_pair_swap(A) (1st)
> >             |
> >             |                         RTM_NEWQDISC (B, RTNL-locked)
> >            RCU                   2     qdisc_graft(B)
> >             |                    1     notify_and_destroy(A)
> >             |
> >    tcf_block_release(A)          0    RTM_NEWTFILTER (Y, RTNL-lockless)
> >    qdisc_destroy(A)                    tcf_chain0_head_change(B)
> >    tcf_chain0_head_change_cb_del(A)    mini_qdisc_pair_swap(B) (2nd)
> >    mini_qdisc_pair_swap(A) (3rd)                |
> >            ...                                 ...  
> 
> Looking at the code, I think there is no guarantee that (1st) cannot
> happen after (2nd), although unlikely?  Can RTNL-lockless RTM_NEWTFILTER
> handlers get preempted?

Right, we need qdisc_graft(B) to update the appropriate dev pointer 
to point to b1. With that the ordering should not matter. Probably
using the ->attach() callback?

> If (1st) happens later than (2nd), we will need to make (1st) no-op, by
> detecting that we are the "old" Qdisc.  I am not sure there is any
> (clean) way to do it.  I even thought about:
> 
>   (1) Get the containing Qdisc of "miniqp" we are working on, "qdisc";
>   (2) Test if "qdisc == qdisc->dev_queue->qdisc_sleeping".  If false, it
>       means we are the "old" Qdisc (have been replaced), and should do
>       nothing.
> 
> However, for clsact Qdiscs I don't know if "miniqp" is the ingress or
> egress one, so I can't container_of() during step (1) ...

And we can't be using multiple pieces of information to make 
the decision since AFAIU mini_qdisc_pair_swap() can race with
qdisc_graft().

My thinking was to make sure that dev->miniq_* pointers always point
to one of the miniqs of the currently attached qdisc. Right now, on 
a quick look, those pointers are not initialized during initial graft,
only when first filter is added, and may be cleared when filters are
removed. But I don't think that's strictly required, miniq with no
filters should be fine.

> Eventually I created [5,6/6].  It is a workaround indeed, in the sense
> that it changes sch_api.c to avoid a mini Qdisc issue.  However I think it
> makes the code correct in a relatively understandable way,

What's your benchmark for being understandable?

> without slowing down mini_qdisc_pair_swap() or sch_handle_*gress().

