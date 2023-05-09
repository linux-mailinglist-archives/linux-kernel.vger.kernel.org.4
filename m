Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D51A86FBC88
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 03:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232894AbjEIBda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 21:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjEIBd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 21:33:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E064494
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 18:33:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0BC6362CE4
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 01:33:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA099C433D2;
        Tue,  9 May 2023 01:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683596006;
        bh=Ezq1uBXtkHMJMAu0MHKbIyYUPpeNC5x1Kp/DxAAAx0I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iFUxhCiLyuEiZWBD6LV+RXw5/W/DF5lUrqtC/oT+tR2EdYDBYRowcoj3KDfrKFx4C
         4DhGyLNoCfVmeSZcTdx/skad/uJGoNw986S7GNGwxJ/Mfi7seMDuD0B/L3VKrBukLW
         8jeMwAmhBTob+TtXg1buB2TCMBZIMOg/2OdijfO1Fg+uxLL5/ezTjx9tEpTn4GcPOJ
         Fd+vIuXzxPHaiHtFh2HjQI7Ta5/9UQG5hWCjiZTErQ+ej4KSx21j9AK4StwEHshDR4
         rqDHGY7ue2qMPQH1znVDhD+XfF5w4/FcIK2ZIXz8e8WoWcLSvv+V2v7cmZQZLWc8co
         5RQ30Hz2o+A4w==
Date:   Mon, 8 May 2023 18:33:24 -0700
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
        John Fastabend <john.r.fastabend@intel.com>,
        Vlad Buslov <vladbu@mellanox.com>,
        Pedro Tammela <pctammela@mojatatu.com>,
        Hillf Danton <hdanton@sina.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Cong Wang <cong.wang@bytedance.com>
Subject: Re: [PATCH net 6/6] net/sched: qdisc_destroy() old ingress and
 clsact Qdiscs before grafting
Message-ID: <20230508183324.020f3ec7@kernel.org>
In-Reply-To: <e6c4681dd9205d702ae2e6124e20c6210520e76e.1683326865.git.peilin.ye@bytedance.com>
References: <cover.1683326865.git.peilin.ye@bytedance.com>
        <e6c4681dd9205d702ae2e6124e20c6210520e76e.1683326865.git.peilin.ye@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  5 May 2023 17:16:10 -0700 Peilin Ye wrote:
>   Thread 1 creates ingress Qdisc A (containing mini Qdisc a1 and a2), then
>   adds a flower filter X to A.
> 
>   Thread 2 creates another ingress Qdisc B (containing mini Qdisc b1 and
>   b2) to replace A, then adds a flower filter Y to B.
> 
>  Thread 1               A's refcnt   Thread 2
>   RTM_NEWQDISC (A, RTNL-locked)
>    qdisc_create(A)               1
>    qdisc_graft(A)                9
> 
>   RTM_NEWTFILTER (X, RTNL-lockless)
>    __tcf_qdisc_find(A)          10
>    tcf_chain0_head_change(A)
>    mini_qdisc_pair_swap(A) (1st)
>             |
>             |                         RTM_NEWQDISC (B, RTNL-locked)
>            RCU                   2     qdisc_graft(B)
>             |                    1     notify_and_destroy(A)
>             |
>    tcf_block_release(A)          0    RTM_NEWTFILTER (Y, RTNL-lockless)
>    qdisc_destroy(A)                    tcf_chain0_head_change(B)
>    tcf_chain0_head_change_cb_del(A)    mini_qdisc_pair_swap(B) (2nd)
>    mini_qdisc_pair_swap(A) (3rd)                |
>            ...                                 ...
> 
> Here, B calls mini_qdisc_pair_swap(), pointing eth0->miniq_ingress to its
> mini Qdisc, b1.  Then, A calls mini_qdisc_pair_swap() again during
> ingress_destroy(), setting eth0->miniq_ingress to NULL, so ingress packets
> on eth0 will not find filter Y in sch_handle_ingress().
> 
> This is just one of the possible consequences of concurrently accessing
> net_device::miniq_{in,e}gress pointers.  The point is clear, however:
> B's first call to mini_qdisc_pair_swap() should take place after A's
> last call, in qdisc_destroy().

Great analysis, thanks for squashing this bug.

Have you considered creating a fix more localized to the miniq
implementation? It seems that having per-device miniq pointers is
incompatible with using reference counted objects. So miniq is 
a more natural place to solve the problem. Otherwise workarounds 
in the core keep piling up (here qdisc_graft()).

Can we replace the rcu_assign_pointer in (3rd) with a cmpxchg()?
If active qdisc is neither a1 nor a2 we should leave the dev state
alone.
