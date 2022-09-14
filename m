Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 254FF5B829B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 10:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbiINIE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 04:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbiINIER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 04:04:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB3D4F399
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 01:04:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 71E32B81180
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 08:04:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BF35C433C1;
        Wed, 14 Sep 2022 08:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663142647;
        bh=WzqqgSgzUFWOkOjIplcFxh7on/nwjcTWKKddQ0+s+KY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KWUoZ6/UySZmgNgzT1dSbBtIMaa3WjDd3S+vKfIU4fGqRSadPoNcHzSvhzPlqJi+B
         Q4QUJkfdVbMv1K3WlGMvPPHWasNL4nptfRUb1wQk96O6B+4pV72zM9jOoQcD0spUyh
         YEvTOtTH9E8gOazRwVxaMClI5F/WXi0us/+9ZFfs+kBsboe2UYaJqtmCffCvAuIsAh
         d1q2rpwALHlFYDJGm3cy59PwQliqSsCQhOQ+dKJzczSSrcR8a9mlpK3jtEtm47I920
         VUlbDxlOKkyNRm5euKKgiGbRTQSrc/C3ul1mcd6B+jaVxIG5p61QPfUlUMWLQmctv6
         Z0O//8w+HR9nA==
From:   SeongJae Park <sj@kernel.org>
To:     Kaixu Xia <xiakaixu1987@gmail.com>
Cc:     SeongJae Park <sj@kernel.org>, akpm@linux-foundation.org,
        damon@lists.linux.dev, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Kaixu Xia <kaixuxia@tencent.com>
Subject: Re: [PATCH 4/4] mm/damon/vaddr: indicate the target is invalid when 'nr_regions' is zero
Date:   Wed, 14 Sep 2022 08:04:04 +0000
Message-Id: <20220914080404.58913-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAGjdHu=8pGmyBpVMpf-V=6w7hZHLmG4WH5EsNchn_+GqikTDxQ@mail.gmail.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Sep 2022 12:02:05 +0800 Kaixu Xia <xiakaixu1987@gmail.com> wrote:

> On Tue, Sep 13, 2022 at 11:11 PM SeongJae Park <sj@kernel.org> wrote:
> >
> > On Tue, 13 Sep 2022 17:11:27 +0800 xiakaixu1987@gmail.com wrote:
> >
> > > From: Kaixu Xia <kaixuxia@tencent.com>
> > >
> > > When 'init()' and 'update()' DAMON operations failed and the number
> > > of the damon_target regions is zero,
> >
> > Well, I think that could be a temporal failure.  In the case, later call of
> > 'update()' could success?
> >
> Yeah, the kdamond while() loop calls 'update()' periodically to fix this
> temporary failure. But for extreme scenarios that 'update()' continues to fail,
> we should have some ways to detect this case.

Even in the case, kdamond will do nothing but continuing the main loop while
sleeping sample_aggr interval (5ms by default) for each iteration, and calling
'update()' for every update interval (100ms by default).  Waste is waste, but I
don't think that's a real issue.  Further, continuous 'update()' failures mean
the process is in some weird state anyway, so I'd assume the process would be
finished soon.  kdamond will also finish as soon as the process finishes.
Users could also find the strange situation (nothing in the monitoring results)
and finish kdamond on their own.

Anything I'm missing?


Andrew, I found you merged this patch in mm-unstable.  Could you please hold it
until we finish this discussion?


Thanks,
SJ

> 
> Thanks,
> Kaixu
> >
> > Thanks,
> > SJ
> >
> > > the kdamond would do nothing
> > > to this monitoring target in this case. It makes no sense to run
> > > kdamond when all of monitoring targets have no regions. So add the
> > > judgement in 'target_valid()' operation to indicate the target is
> > > invalid when 'nr_regions' is zero.
> >
> > >
> > > Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
> > > ---
> > >  mm/damon/vaddr.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> > > index 39ea48d9cc15..65ff98d49ec0 100644
> > > --- a/mm/damon/vaddr.c
> > > +++ b/mm/damon/vaddr.c
> > > @@ -598,6 +598,9 @@ static bool damon_va_target_valid(void *target)
> > >       struct damon_target *t = target;
> > >       struct task_struct *task;
> > >
> > > +     if (!damon_nr_regions(t))
> > > +             return false;
> > > +
> > >       task = damon_get_task_struct(t);
> > >       if (task) {
> > >               put_task_struct(task);
> > > --
> > > 2.27.0
> 
