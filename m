Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8392B60685D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 20:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbiJTSoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 14:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiJTSoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 14:44:09 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C1F20882E
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 11:44:08 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id l22so879599edj.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 11:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YAXDkl5OHacYtnMU6aGNdSp9H5dDI+zvMIbdfENsliM=;
        b=rlYy4fmtLo89IDWwDGER07KU5thlGrVVG812rEBXzPLpS5/T+u5s4cKMiYG6mTMqbQ
         tA4xjRxoMwCTt/KTHkfrF/fGdlkyXjAANAsdrGu6zZoxCjWuYq3JFp80VmZF+gm4OG7R
         gVit8sq4JJ35CZpcap30Vy75/b8e7maJzrHjVdqX6Afet39FY5+ys84qd8T7aLwX6Evf
         PSAVSDhTKfUYcJGG7qPckTkU8/QCBAaZEsieWu0waM9ruHcxI731GBECWteofd6aDXPP
         T5RopbyVNp7showNJ5pBUswOmKNsIbnyD6T9soLZ6pChbsu6KtD5tNT4C0AIuaBg00Nv
         cUEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YAXDkl5OHacYtnMU6aGNdSp9H5dDI+zvMIbdfENsliM=;
        b=BLMle+KVE+CBwRNwxGrydpcZ2NcnN6+t4hWO1hlCaDoZfj0haoSLCBjxasgIzQ9qvD
         O8bGDLteGA2myt2QCqNa6tV2divpgHOVM71K9gw/MRtt5kHQkkpoo2TbyZqKco4JunmC
         KhxRnE/8kYntEeLTASvDXjjNkfyWwt4sGo6rPeAFYlw5kxwJL4kgrXeADbPXR2ycJTXM
         rik43mTIitREFH9GGeqAditp4RSRbPNz8iL7ozfCTqqiNmQp255dUigw1lj6XKn89Fek
         hsXvpSpqIJZjuvM6py9zD8lKbQtE4OX+6aZmf9VfNI0X9ByrUZ9YSij9oUbMIuhjibQR
         hAhw==
X-Gm-Message-State: ACrzQf1ZPhETDkkuNssSTx2PlwSxG+ktloTOOUumKmi3kNX4WAb7gF6R
        8Edqra8KGM43ljvxaGfeJuDT9cCKa7AFiJWzUpwB1g==
X-Google-Smtp-Source: AMsMyM4x8PfivOxX0Gf6vX8/VO4WEJSCX2468LHbcQPBeAz2NWKjPDb8tJKEW31AWTyh/F0Dc2pFuxIeMjviaXhJ/Q8=
X-Received: by 2002:aa7:dcc5:0:b0:45c:7613:65f6 with SMTP id
 w5-20020aa7dcc5000000b0045c761365f6mr13975208edu.142.1666291446527; Thu, 20
 Oct 2022 11:44:06 -0700 (PDT)
MIME-Version: 1.0
References: <20221003214501.2050087-1-connoro@google.com> <20221003214501.2050087-6-connoro@google.com>
 <xhsmhr0z3wx5z.mognet@vschneid.remote.csb>
In-Reply-To: <xhsmhr0z3wx5z.mognet@vschneid.remote.csb>
From:   "Connor O'Brien" <connoro@google.com>
Date:   Thu, 20 Oct 2022 11:43:54 -0700
Message-ID: <CALE1s+NqyXziXaFbWdwG8SvP0WFrUaDSB+b9_u3uFL61B89=8g@mail.gmail.com>
Subject: Re: [RFC PATCH 05/11] sched: Split scheduler execution context
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        John Stultz <jstultz@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 10:17 AM Valentin Schneider <vschneid@redhat.com> wrote:
>
> On 03/10/22 21:44, Connor O'Brien wrote:
> > @@ -1303,7 +1303,7 @@ static u64 grub_reclaim(u64 delta, struct rq *rq, struct sched_dl_entity *dl_se)
> >   */
> >  static void update_curr_dl(struct rq *rq)
> >  {
> > -     struct task_struct *curr = rq->curr;
> > +     struct task_struct *curr = rq->proxy;
>
> I found a note pointing out that Juri has a patch to unify the
> update_curr*() functions as part of the deadline servers thing; I think it
> could be picked as a standalone to at least unify the curr = rq->proxy
> trickery - this will also (hopefully) remove redundancy for whatever we do
> to expose sane runtime values to userspace.
>
> Last iteration I could find is:
>
> https://lore.kernel.org/all/20200807095051.385985-2-juri.lelli@redhat.com/

That makes sense, thanks for the pointer to this patch.
