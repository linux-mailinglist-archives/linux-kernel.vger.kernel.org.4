Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86D4064521B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 03:38:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiLGCiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 21:38:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiLGCiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 21:38:02 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05EAB31DF2
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 18:38:02 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id t17so16264226pjo.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 18:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nRN1WWpUuq4+/5SU9doiYyFO0GUK6IB6DN8Sn4Whmpo=;
        b=G4VLwxAv1r/l8/kyBABDU0pzTFs7RbdCFmbRYeAtoEoyMG1c3upwv84xA/O7qziQc+
         cbrtIAy9Hmkc8cbSDQEq3+A/ypaK0vjs+7cTvk3yE3WApKtpkTpVjtioDkkARKo4upPv
         znB8RDih92yjButlZQXqe0J60cmjBFSu9KDu3cLXBuWuAwv5c/KFa5EINNhLcFsqO9YK
         Muarc8x3k3r2C/HRSYZK6O4CpHVmPO76taihyWiwIgPhQd5l2igslUOaJgbVAkBwvI6q
         kP8p3Dk67OYRibfdWSlxUMIwGrDxyMlfHkwewjDvbFzpbIY8M+xRjKZgIW9Lh4uMnB/x
         YWdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nRN1WWpUuq4+/5SU9doiYyFO0GUK6IB6DN8Sn4Whmpo=;
        b=T+zIqNzHZ0rIghHm4KYpCz5cJoBY0wenkf1bEBxN0vIVzORKAp9/ERWg6eT7Ejrocz
         nvv8K1qK1XiSVMgrM3SBEMhNxXcK6UXqDnIiB0+S/LxEw8C10a213fzoR+2BFRubacjP
         jOUF9R5vs03Di9VnojfIY28ILBRW0JBEVsXLRFX9jPDRf30mhlN+mduPX/0TzIqF7+lG
         1uM0jioqZ27CKShUzRZlfhpGI9QvVREgYdJrCMaFySpYORSmumbT6w2ZQZFSWHKgSq3G
         MhEmF0BcmEIRZmIMczFAG4ix/mI3RYIPP0TzltyoqFpEILXJyzofazprvsm3ZnTBRHi4
         WN7A==
X-Gm-Message-State: ANoB5pkbj6Z2DlH/S3bg/rdQm6izjoHye4c4bnA11ioMEKVG0LpVtBBn
        xPeQUhxCXiQtAKqwLG9lTZoX0hTBl/wH+rkTAwQ=
X-Google-Smtp-Source: AA0mqf5VIk0fIbqqk2d8vb30YyLErPTq3NsEZBXkgRQtdtu+4dvoBKoY9TPDOXaIxCrTWogYNNnYifDrf7k5rLp+8m8=
X-Received: by 2002:a17:90a:1d5:b0:219:55d5:f30e with SMTP id
 21-20020a17090a01d500b0021955d5f30emr38519920pjd.107.1670380681537; Tue, 06
 Dec 2022 18:38:01 -0800 (PST)
MIME-Version: 1.0
References: <CAJNi4rOgYmmtOaXVqYB9sAxDmRhGhS_vVXmZbCbMjvFCQsdjCw@mail.gmail.com>
 <CAJhGHyD+oR8SeYeObJ2DSKfudqBtBOiL14jCsST3L5OG8WjT_g@mail.gmail.com>
 <CAJNi4rOs-=xx5qV-hQQYgSLQCz_q3JuFxJEd+wpPaao8Ej26yQ@mail.gmail.com>
 <CAJhGHyAVbCm6i7pTRDDXgdwS25d5O3uMCvKzyOcafRAdN-S7JQ@mail.gmail.com> <CAJNi4rNU0-GVnLMqdGFvHOsTb26eDEgjZJSE6Doo8QU6MYx+JQ@mail.gmail.com>
In-Reply-To: <CAJNi4rNU0-GVnLMqdGFvHOsTb26eDEgjZJSE6Doo8QU6MYx+JQ@mail.gmail.com>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Wed, 7 Dec 2022 10:37:49 +0800
Message-ID: <CAJhGHyC=-bD8L5KSYLp3_tN0WdoCYgtpwNaM_=oLb2c=Gsu+6A@mail.gmail.com>
Subject: Re: work item still be scheduled to execute after destroy_workqueue?
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

On Tue, Dec 6, 2022 at 5:20 PM richard clark
<richard.xnu.clark@gmail.com> wrote:
>
> On Tue, Dec 6, 2022 at 2:23 PM Lai Jiangshan <jiangshanlai@gmail.com> wrote:
> >
> > On Tue, Dec 6, 2022 at 12:35 PM richard clark
> > <richard.xnu.clark@gmail.com> wrote:
> >
> > > >
> > > A WARN is definitely reasonable and has its benefits. Can I try to
> > > submit the patch and you're nice to review as maintainer?
> > >
> > > Thanks,
> > > Richard
> > > >
> >
> > Sure, go ahead.
> >
> > What's in my mind is that the following code is wrapped in a new function:
> >
> >         mutex_lock(&wq->mutex);
> >         if (!wq->nr_drainers++)
> >                 wq->flags |= __WQ_DRAINING;
> >         mutex_unlock(&wq->mutex);
> >
> >
> > and the new function replaces the open code drain_workqueue() and
> > is also called in destroy_workqueue() (before calling drain_workqueue()).
> >
> Except that, do we need to defer the __WQ_DRAINING clean to the
> rcu_call, thus we still have a close-loop of the drainer's count, like
> this?

No, I don't think we need it. The wq is totally freed in rcu_free_wq.

Or we can just introduce __WQ_DESTROYING.

It seems using __WQ_DESTROYING is better.

>
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
>
> @@ -3528,6 +3526,9 @@ static void rcu_free_wq(struct rcu_head *rcu)
>
>         else
>                 free_workqueue_attrs(wq->unbound_attrs);
>
> +       if (!--wq->nr_drainers)
> +               wq->flags &= ~__WQ_DRAINING;
> +
>         kfree(wq);
>
> >
> > __WQ_DRAINING will cause the needed WARN on illegally queuing items on
> > destroyed workqueue.
>
> I will re-test it if there are no concerns about the above fix...
>
> >
> > Thanks
> > Lai
