Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D94A463A010
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 04:24:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbiK1DYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 22:24:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiK1DYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 22:24:52 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5556BCA3
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 19:24:51 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id z4so14766703wrr.3
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 19:24:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6dzHFw1mGm+Rw4TXL5W8A90UrAs/0kqwGAh+X5UIO2I=;
        b=G/ZjVJk7BAuUyY0Yyj72GVBMagw78ImStDh6+5Dw7RH6NGt/ZOUQKDOiPiBHj3k0C6
         ViWH3IUlqo1QID2ZGqEiUSIbL5d/C6RAF2CqdQScwRIwM5jqPSAoYbWaISmyWtO1qQ7x
         HGygHW+ue7FUH8LBVxFfLrwyfV9jyMZOVkQxCo7bRozyWwHlYTufPhseWGcoy17BmKxT
         6q7wyfv25hYEqJxK3JAco37m0nn/5PpIMyEiAw4N97ZknPQwARdjIVa6jmN9J/7M365D
         KzYegC5x5P27VzwIe1+RSzGI/vWs0f4Ocq5kUymPFobmJicoKi0D0MHwYal2errtQD7w
         cJ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6dzHFw1mGm+Rw4TXL5W8A90UrAs/0kqwGAh+X5UIO2I=;
        b=WH7JzTE3bJ8kIAXSjL3HKsC82OdvoiUEwyUzLrN/U2b2O6ep12uUDOuF+SgGFHYpnQ
         /m3DG3wXmo9jeV4EkIdehoKVeqDuAlTvbMV7no57lhfoUyC73kTn/d1cLsmlD/O99yKs
         vHUwwj2K1SoCIXJWujZmcAMQS9jltHFBVmmTZVr/39cs+JhMe4ToeJiZ2pFDpJyiNTzp
         qLaxsAZLjDg+n1O17F3zTbZquLDXj6lf+v8NPEtPrwhxkA7DABfv3n0xhk1s2cPgwlzB
         PlcfccMU+EcrzO1ATsM61/lw6AoCtHi3hz+WF71E2aM1v8dZZ+P9dxSi+ZK3qhnkj3bF
         DMFg==
X-Gm-Message-State: ANoB5pmQwUE1jrPpB3WVmpQ44dOBZzfh6VrvTGWHasLGB2kMl60Shoo5
        LVJesIfYtcaaAjheTqDIkH4D1LwVplCeDvKyd/0KP0zy13c=
X-Google-Smtp-Source: AA0mqf7VfrRyhor5RlkOBAGx12y1p84qknysU2rv2uBtDA9N57/9zBHGAWsElaePHodR/UDYTC1TTdD2V+dIQpbroKU=
X-Received: by 2002:a5d:6947:0:b0:242:17a5:ee80 with SMTP id
 r7-20020a5d6947000000b0024217a5ee80mr1309493wrw.628.1669605889758; Sun, 27
 Nov 2022 19:24:49 -0800 (PST)
MIME-Version: 1.0
References: <20221123095058.669684-1-richard.xnu.clark@gmail.com> <CAJNi4rMbZZbCCKu-Mth3YF-YubHkcgi=VHsd=FyWc77a54pKYA@mail.gmail.com>
In-Reply-To: <CAJNi4rMbZZbCCKu-Mth3YF-YubHkcgi=VHsd=FyWc77a54pKYA@mail.gmail.com>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Mon, 28 Nov 2022 11:24:38 +0800
Message-ID: <CAJhGHyCPbmEY_Azx056ePxO0B-GzUY3KXs3_UT6Z9XUAfVqS0A@mail.gmail.com>
Subject: Re: [PATCH] workqueue: Remove the unbound release work from the
 per-cpu type
To:     richard clark <richard.xnu.clark@gmail.com>
Cc:     tj@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 25, 2022 at 11:02 AM richard clark
<richard.xnu.clark@gmail.com> wrote:
>
> Hi Tejun,
>
> Would you pls help take a look at this? Or point to someone who is
> maintaining the workqueue subsystem, I can ping him/her...
>
> Richard

Hello, Richard

Thank you for reviewing the code of workqueue and trying to improve it.

But INIT_WORK() has no unwanted effect and it is better to initialize
the field even if it is unused.

The patch would not be accepted.

Thanks.
Lai

>
> On Wed, Nov 23, 2022 at 5:51 PM Richard Clark
> <richard.xnu.clark@gmail.com> wrote:
> >
> > Both the per-cpu and unbound workqueue will call init_pwq(...) currently,
> > the latter will init an unbound release work for the pwq which is unnecessary
> > for the per-cpu type workqueue.
> > This commit will remove this work item from the per-cpu workqueue by checking the
> > wq->flags in init_pwq(...), the work is still reserved for the unbound workqueue.
> >
> > Signed-off-by: Richard Clark <richard.xnu.clark@gmail.com>
> > Cc: Tejun Heo <tj@kernel.org>
> > Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> > ---
> >  kernel/workqueue.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> > index 7cd5f5e7e0a1..01bdfb74081e 100644
> > --- a/kernel/workqueue.c
> > +++ b/kernel/workqueue.c
> > @@ -3807,7 +3807,8 @@ static void init_pwq(struct pool_workqueue *pwq, struct workqueue_struct *wq,
> >         INIT_LIST_HEAD(&pwq->inactive_works);
> >         INIT_LIST_HEAD(&pwq->pwqs_node);
> >         INIT_LIST_HEAD(&pwq->mayday_node);
> > -       INIT_WORK(&pwq->unbound_release_work, pwq_unbound_release_workfn);
> > +       if (wq->flags & WQ_UNBOUND)
> > +               INIT_WORK(&pwq->unbound_release_work, pwq_unbound_release_workfn);
> >  }
> >
> >  /* sync @pwq with the current state of its associated wq and link it */
> > --
> > 2.37.2
> >
