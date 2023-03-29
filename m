Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E78E16CD488
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 10:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbjC2IY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 04:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbjC2IYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 04:24:11 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF6A59FA
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 01:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nTIJlxppJIAd74PmqdXD5+j2Dw+VegQUjf44O0/+rS0=; b=Z76hMZJagOEcvpbshbhpoxS/yy
        XFBO9YxpGQikJzgwRKO8U4dAesBwLF4Lc6r4qFZ3hgxXpCx5l5B5CMe/XSOT3s2aa2Osee4rYLMAp
        aQt+l45Rx77lLOZub51fibyssVu1bYB95GMYQV/U5qsGrk+Mq01R94XvmDfNO9vrPPq4r5HeHq5ZM
        zDmfx8X94Je5eIYMrLUnVGRicE116K0EEhQZ8fPJc1afy+rDdiVFMjbkEB5YQNni+Ce8D21VziFeY
        AYEnsSzTthQnjFtz8tDfMPkE92oHyHLPo75uCXnI42JN/quJTWT0rZG/Fix7FINnBoG8U+XkVJ+li
        4czwBqTA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1phR4n-006nnB-16;
        Wed, 29 Mar 2023 08:22:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DA3B4300237;
        Wed, 29 Mar 2023 10:22:35 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BFEEF201D9959; Wed, 29 Mar 2023 10:22:35 +0200 (CEST)
Date:   Wed, 29 Mar 2023 10:22:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Don <joshdon@google.com>
Cc:     mingo@kernel.org, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, corbet@lwn.net,
        qyousef@layalina.io, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, pjt@google.com, pavel@ucw.cz,
        qperret@google.com, tim.c.chen@linux.intel.com, timj@gnu.org,
        kprateek.nayak@amd.com, yu.c.chen@intel.com,
        youssefesmat@chromium.org, joel@joelfernandes.org, efault@gmx.de
Subject: Re: [PATCH 08/17] sched/fair: Implement an EEVDF like policy
Message-ID: <20230329082235.GA38236@hirez.programming.kicks-ass.net>
References: <20230328092622.062917921@infradead.org>
 <20230328110354.141543852@infradead.org>
 <CABk29Nt4T67S+L9Qs1qeOUyo5gY1Qy5KuOwuCYNM74E58J81Eg@mail.gmail.com>
 <20230329080646.GL4253@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230329080646.GL4253@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 10:06:46AM +0200, Peter Zijlstra wrote:
> On Tue, Mar 28, 2023 at 06:26:51PM -0700, Josh Don wrote:
> > > +static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq)
> > > +{
> > > +       struct rb_node *node = cfs_rq->tasks_timeline.rb_root.rb_node;
> > > +       struct sched_entity *curr = cfs_rq->curr;
> > > +       struct sched_entity *best = NULL;
> > > +
> > > +       if (curr && (!curr->on_rq || !entity_eligible(cfs_rq, curr)))
> > > +               curr = NULL;
> > > +
> > > +       while (node) {
> > > +               struct sched_entity *se = __node_2_se(node);
> > > +
> > > +               /*
> > > +                * If this entity is not eligible, try the left subtree.
> > > +                */
> > > +               if (!entity_eligible(cfs_rq, se)) {
> > > +                       node = node->rb_left;
> > > +                       continue;
> > > +               }
> > > +
> > > +               /*
> > > +                * If this entity has an earlier deadline than the previous
> > > +                * best, take this one. If it also has the earliest deadline
> > > +                * of its subtree, we're done.
> > > +                */
> > > +               if (!best || deadline_gt(deadline, best, se)) {
> > > +                       best = se;
> > > +                       if (best->deadline == best->min_deadline)
> > > +                               break;
> > 
> > Isn't it possible to have a child with less vruntime (ie. rb->left)
> > but with the same deadline? Wouldn't it be preferable to choose the
> > child instead since the deadlines are equivalent but the child has
> > received less service time?
> 
> Possible, yes I suppose. But given this is ns granular virtual time,
> somewhat unlikely. You can modify the last (validation) patch and have
> it detect the case, see if you can trigger it.
> 
> Doing that will make the pick always do a full decent of the tree
> through, which is a little more expensive. Not sure it's worth the
> effort.

Hmm, maybe not, if there is no smaller-or-equal deadline then the
min_deadline of the child will be greater and we can terminate the
decent right there.

