Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 744416EAD8F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 16:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233052AbjDUO5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 10:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232212AbjDUO5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 10:57:47 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B09639EED
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 07:57:35 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-5055141a8fdso2518203a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 07:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1682089054; x=1684681054;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2tGOts3QoCJkBrTh/elI0w5gRAXfGN6PXECZof4lKmE=;
        b=WYm/u6je/yQrVcdxaM21rxEZ0+GXTk8XaxTEQOkETzAnYXRJnQgamFUHVTTAMyw+w1
         3+rbI16Nbl7j0JK/T/VYMCfo1xsFJxbxyBEsS7Z7Li9VJv9YNQTCFzykz8UP200xICu8
         8ja7sQj9zZZ4b8tbUrtpD/NA9+e5aM9ZE3RqSYihq4tPCJtf4oPf+o4n5X6wE7X/XJVD
         qh41TZI1OXMriBxEiTxTI0FpFwFGTz2WtrmkcpSLA9co23FWI0R8YWUmrLp2OrkpzIeo
         3nfcR3CRqre9dJ5ci8wSoEvzZzEb/VS0v6gHSga7GIk59vh/KSr8e/SHphyLG0tc+fap
         Fayw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682089054; x=1684681054;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2tGOts3QoCJkBrTh/elI0w5gRAXfGN6PXECZof4lKmE=;
        b=UyO962P6olWl4Ofy/aXbMET2xXlfi2N9zU25UWEvLITZHC905AdwIQyK5qxgPbkLhY
         l394aB3hrI9HdhX4GhgCcbHpU+HSsOfI21oT1Duh/MtlBmCtxBPKUflFYwKm+m3K6GZk
         8aXsb+KsfxoPjtVc2rBM6X5K7k5FoEGQL1Xv9mfxRaobCIJ8s0wFSSgC0Z6I9PxofiOJ
         lX9JXk/2KqKJrzZfHEdC9bGjzOFfGIoWmIjqt3HZALBpeIXgGgoInbPz7npJH0HjizCu
         j+M3ORQiPOKGb+3Uqv/0iAFXQFL9Cc1xqBxcHdhQybQc/Nk8BrdXwGUCYfvi9QLz3ndX
         vjKA==
X-Gm-Message-State: AAQBX9ejbQ+yPwF/lrpC7708Poi4pG9mpSWqJcdfikCdqNN/2BtAN7K1
        TH2zvi8TF/w1Gl8zsB6/L7f/B7faZEhztUvBZ4VF1Q==
X-Google-Smtp-Source: AKy350YOqjCAd20DbcXBhENwSsKheuT7lUuo2ljQofZhsNS/wOOp3VDL8h65sMreevD+PCzHnCnp1uqIlwwd4A0NSNg=
X-Received: by 2002:a17:907:86ac:b0:94f:3804:5cd6 with SMTP id
 qa44-20020a17090786ac00b0094f38045cd6mr2991499ejc.66.1682089054218; Fri, 21
 Apr 2023 07:57:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230411082248.1020719-1-yizhou.tang@shopee.com> <20230411112130.7zswqnyifgjhshif@quack3>
In-Reply-To: <20230411112130.7zswqnyifgjhshif@quack3>
From:   Tang Yizhou <yizhou.tang@shopee.com>
Date:   Fri, 21 Apr 2023 22:57:22 +0800
Message-ID: <CACuPKx=+g_bhLKH1d9M4WOUVyRRKGj+sP0q4td1gRE9ghtVYog@mail.gmail.com>
Subject: Re: [PATCH v2] mm: Fix memcg writeback for rt tasks
To:     Jan Kara <jack@suse.cz>
Cc:     neilb@suse.com, tj@kernel.org, wufengguang@huawei.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, hch@lst.de,
        mhocko@suse.com, tangyeechou@gmail.com, chunguang.xu@shopee.com,
        yue.zhao@shopee.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CC Christoph Hellwig and Michal Hocko.


On Tue, Apr 11, 2023 at 7:21=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Tue 11-04-23 16:22:48, yizhou.tang@shopee.com wrote:
> > From: Tang Yizhou <yizhou.tang@shopee.com>
> >
> > In domain_dirty_limits(), the calculation of the thresh and bg_thresh
> > variable needs to consider whether it's for global dirtypage writeback
> > or memcg dirtypage writeback. However, in the rt_task branch, the
> > accumulation of both variables only considers the global_wb_domain,
> > which seems strange to me.
> >
> > I find the accumulation was introduced in the commit a53eaff8c119 ("MM:
> > increase safety margin provided by PF_LESS_THROTTLE"). IMHO, realtime
> > tasks are given a higher page cache limit because they require higher
> > responsiveness, but we also need to consider whether the writeback of
> > realtime tasks occurs in the global dirtypage writeback or in the memcg
> > dirtypage writeback scenario.
> >
> > Later Neil said he didn't know what was wanted for realtime in the
> > commit message of commit a37b0715ddf3 ("mm/writeback: replace
> > PF_LESS_THROTTLE with PF_LOCAL_THROTTLE"). I guess he made this small
> > mistake since the commit a53eaff8c119 ("MM: increase safety margin
> > provided by PF_LESS_THROTTLE").
> >
> > Fixes: a53eaff8c119 ("MM: increase safety margin provided by PF_LESS_TH=
ROTTLE")
> > CC: NeilBrown <neilb@suse.com>
> > CC: Tejun Heo <tj@kernel.org>
> > CC: Fengguang Wu <wufengguang@huawei.com>
> > Signed-off-by: Tang Yizhou <yizhou.tang@shopee.com>
>
> Thanks for the patch! Was this found just by code inspection or is there
> any practical problem you are trying to fix with this patch?
>
> > diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> > index 516b1aa247e8..7d92de73360e 100644
> > --- a/mm/page-writeback.c
> > +++ b/mm/page-writeback.c
> > @@ -419,8 +419,8 @@ static void domain_dirty_limits(struct dirty_thrott=
le_control *dtc)
> >               bg_thresh =3D thresh / 2;
> >       tsk =3D current;
> >       if (rt_task(tsk)) {
> > -             bg_thresh +=3D bg_thresh / 4 + global_wb_domain.dirty_lim=
it / 32;
> > -             thresh +=3D thresh / 4 + global_wb_domain.dirty_limit / 3=
2;
> > +             bg_thresh +=3D bg_thresh / 4 + dtc_dom(dtc)->dirty_limit =
/ 32;
> > +             thresh +=3D thresh / 4 + dtc_dom(dtc)->dirty_limit / 32;
>
> This makes sense but I'm not 100% sure this does not reintroduce the
> problem a53eaff8c119 was trying to fix. Reading the changelog, it seems t=
he
> extra term you are fixing is there specifically to deal with ratelimiting=
,
> which is global (and not per-memcg), of calls to balance_dirty_pages() an=
d
> hence using global_wb_domain.dirty_limit is indeed correct. Neil?
>
>                                                                 Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
