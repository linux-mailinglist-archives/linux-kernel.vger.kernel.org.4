Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E07BA6FFD37
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 01:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239506AbjEKXUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 19:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239311AbjEKXUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 19:20:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A345BBD
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 16:20:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E62AD65229
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 23:20:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5E9AC433EF;
        Thu, 11 May 2023 23:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683847225;
        bh=heb/Ae+vtqZAI/LR/adpb91zjfMyByllNRGWtN+x6Us=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FLaFHom8eejodz/0W9plf6HpJILhurJIeBRhNxSwBfBXInmfaBQucQfvWVEJfAw30
         1znJdGNjJD8USba4FGByWD5jWXaiGeBeFm2Q4P5fszb09ojRbX5wKmgitKlDlHZRmu
         bV7t6gjofHMYRChisOWaPXZeNTwAlAfRZgHXhGgxAFt1xAhzIj6KDJe1oazhmCcN05
         nZ86GrdBnn7U8aWfvxR7ovUP7rxigDBkNFzXjMzqHGJwC/dAi4zlu6F/D/ca0Kyl+S
         9O4ekKRL207Hj0mzYBbV6WCTtD0YBalKBwxkG1nJ5/u8SQqfhYqVuI7QvEeq1rudsm
         KdXgP24DPqbEQ==
Date:   Thu, 11 May 2023 16:20:23 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Peilin Ye <yepeilin.cs@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Peilin Ye <peilin.ye@bytedance.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Vlad Buslov <vladbu@mellanox.com>,
        Pedro Tammela <pctammela@mojatatu.com>,
        Hillf Danton <hdanton@sina.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Cong Wang <cong.wang@bytedance.com>
Subject: Re: [PATCH net 6/6] net/sched: qdisc_destroy() old ingress and
 clsact Qdiscs before grafting
Message-ID: <20230511162023.3651970b@kernel.org>
In-Reply-To: <ZF1SqomxfPNfccrt@C02FL77VMD6R.googleapis.com>
References: <cover.1683326865.git.peilin.ye@bytedance.com>
        <e6c4681dd9205d702ae2e6124e20c6210520e76e.1683326865.git.peilin.ye@bytedance.com>
        <20230508183324.020f3ec7@kernel.org>
        <ZFv6Z7hssZ9snNAw@C02FL77VMD6R.googleapis.com>
        <20230510161559.2767b27a@kernel.org>
        <ZF1SqomxfPNfccrt@C02FL77VMD6R.googleapis.com>
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

On Thu, 11 May 2023 13:40:10 -0700 Peilin Ye wrote:
> On Wed, May 10, 2023 at 04:15:59PM -0700, Jakub Kicinski wrote:
> > My thinking was to make sure that dev->miniq_* pointers always point
> > to one of the miniqs of the currently attached qdisc. Right now, on
> > a quick look, those pointers are not initialized during initial graft,
> > only when first filter is added, and may be cleared when filters are
> > removed. But I don't think that's strictly required, miniq with no
> > filters should be fine.  
> 
> Ah, I see, thanks for explaining, I didn't think of that.  Looking at
> sch_handle_ingress() BTW, currently mini Qdisc stats aren't being updated
> (mini_qdisc_bstats_cpu_update()) if there's no filters, is this intended?
> Should I keep this behavior by:
> 
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 735096d42c1d..9016481377e0 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -5116,7 +5116,7 @@ sch_handle_ingress(struct sk_buff *skb, struct packet_type **pt_prev, int *ret,
>          * that are not configured with an ingress qdisc will bail
>          * out here.
>          */
> -       if (!miniq)
> +       if (!miniq || !miniq->filter_list)
>                 return skb;
> 
>         if (*pt_prev) {

Good question, maybe Jiri or Daniel can answer?

> On Wed, May 10, 2023 at 04:15:59PM -0700, Jakub Kicinski wrote:
> > On Wed, 10 May 2023 13:11:19 -0700 Peilin Ye wrote:  
> > > Looking at the code, I think there is no guarantee that (1st) cannot
> > > happen after (2nd), although unlikely?  Can RTNL-lockless RTM_NEWTFILTER
> > > handlers get preempted?  
> >
> > Right, we need qdisc_graft(B) to update the appropriate dev pointer
> > to point to b1. With that the ordering should not matter. Probably
> > using the ->attach() callback?  
> 
> ->attach() is later than dev_graft_qdisc().  We should get ready for  
> concurrent filter requests (i.e. have dev pointer pointing to b1) before
> grafting (publishing) B. 

I thought even for "unlocked" filter operations the start of it is
under the lock, but the lock gets dropped after qdisc/block are found.
I could be misremembering, I haven't looked at the code.

> Also currently qdisc_graft() doesn't call
> ->attach() for ingress and clsact Qdiscs.  
> 
> But I see your point, thanks for the suggestion!  I'll try ->init() and
> create v2.

->init() may be too early, aren't there any error points which could
prevent the Qdisc from binding after ->init() was called?
