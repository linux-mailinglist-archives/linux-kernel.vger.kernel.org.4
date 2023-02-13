Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C75F26954EC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 00:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbjBMXpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 18:45:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjBMXo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 18:44:58 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8A31259D
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 15:44:57 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id lf10so4133532ejc.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 15:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FPU+TxVqOVPUWz+jZ7DhiZnsDF26w5Ucxuoa+g1D5Kk=;
        b=iIzV+cP6PbvZ66rm2QyF3rzyATwjZ67NbDLj2d7eGEBYwhijeOQvlYC+Sss7owDePY
         9733fL6DsZo/krOunfe+drw9mJ52wBsPxSJn8Q98/XWt4UHG4EHHk3qjEZ1b5OgHl/BY
         3uOaIXtxUMpkFpjqXJEBUR0gJpyPJiAT8dYfXiEVVV+aKOaDEXHOhWfC2j1cpkgJpt6m
         NhatX8Iq24b9DsiqBPcyJRIuTh+MUTk3A9rxg23wv7jrs5/XvX9Tjmx1tgxSU356NcmE
         c0rWgsMdOU8tkStLgZmuOZ4XmQUZn5l9ATE+IVY7slWGweHttQ58sDnMeg8IyVtHPN/F
         2S2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FPU+TxVqOVPUWz+jZ7DhiZnsDF26w5Ucxuoa+g1D5Kk=;
        b=rYTcwFqyotUzUtRWDdfOmmFmrEq2orUfWjUZ61y32L0SUugmUMmOT0gjasVieopBPL
         NXRs6emTd1etLyFTAoAX5mcCr4KSOtkSG3vz4/D3mPT4Izbz605m/qTA4++uwLsIMiaN
         Jknne3zW4jglFkoBIKoFvZoU1iWrlqr45JcWwSK1HrzpHHCDFSgMTButBGvnrT1rMORd
         tOYuOzOHLa+NjUTlVGiNYFBlR4P7+a4OF+jGmPxQxsjEGTSXoe61lITgM3c+43CDNVsb
         gB0RobpYSd2wm1cEFaCXdjDVPPrSSGIor0WPFQZDvyd28DhwkoWyVFaWX6o+8hRkmTox
         6Z2w==
X-Gm-Message-State: AO0yUKXMViofluWnEnrwpoBtyeDOnPBboNZA7Qwrhmk3OpopO8RGB0yT
        bvP8FSNGT/4sOeD6pnYtWp2vF6Q7JxK2RbrKyLOY6BRSDOg=
X-Google-Smtp-Source: AK7set94vw+Jwff76BdYCZBAmgZ7V+oiD9k5u22V9NmYCvNXuqo3FIVYX4P7qU9VIlGbppRLZ5fjDc4Zo5IHmSwO8TU=
X-Received: by 2002:a17:907:984a:b0:87b:dce7:c245 with SMTP id
 jj10-20020a170907984a00b0087bdce7c245mr359765ejc.3.1676331895853; Mon, 13 Feb
 2023 15:44:55 -0800 (PST)
MIME-Version: 1.0
References: <CAHOvCC5Tde6aTtcAeHig1eoAp_9FZGTd4XtFGbmrhy-NoV7zDA@mail.gmail.com>
 <Y+oMND+7L7S9mByY@hirez.programming.kicks-ass.net>
In-Reply-To: <Y+oMND+7L7S9mByY@hirez.programming.kicks-ass.net>
From:   JaeJoon Jung <rgbi3307@gmail.com>
Date:   Tue, 14 Feb 2023 08:44:43 +0900
Message-ID: <CAHOvCC4Fq6W00BO_w8+nC4SuQBeSX5eMBFMe9bgwpihCPH7TCw@mail.gmail.com>
Subject: Re: [kernel/sched/core.c] Review and Modified of the prio_less()
 about sched class priority.
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for answering.
Is it going to be reflected in your patch?

JaeJoon Jung.

On Mon, 13 Feb 2023 at 19:08, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Feb 13, 2023 at 10:11:04AM +0900, JaeJoon Jung wrote:
> > The sched_class structure is defined to be sorted by pointer size.
> > @@ -176,22 +161,18 @@ static inline int __task_prio(struct task_struct *p)
> >  /* real prio, less is less */
> >  static inline bool prio_less(struct task_struct *a, struct
> > task_struct *b, bool in_fi)
> >  {
> > +        int less = a->sched_class - b->sched_class;
> >
> > +        if (less == 0) {
> > +                if (a->sched_class == &dl_sched_class)
> > +                        return !dl_time_before(a->dl.deadline, b->dl.deadline);
> >
> > +                else if (a->sched_class == &fair_sched_class)
> > +                        return cfs_prio_less(a, b, in_fi);
> > +                else
> > +                        return false;
> > +        } else
> > +                return (less > 0) ? true : false;
> >  }
> >
> > If the prio_less() function is modified as above, the __task_prio()
> > function is not required.
>
> Yeah, except your patch is whitespace mangled..
