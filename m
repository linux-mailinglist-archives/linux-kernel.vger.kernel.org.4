Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 200E56825F3
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 08:56:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbjAaH4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 02:56:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjAaH4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 02:56:36 -0500
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B17E92196A
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 23:56:35 -0800 (PST)
Received: by mail-vs1-xe29.google.com with SMTP id j7so15173577vsl.11
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 23:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gZE4Rw4WAl0DbXf1XIE/1Pog7lYhmCuNhpIN6qjVZog=;
        b=fvvAhvR/2IMpHtcAVaiyHU0OWStMNquCpX4GvypppyBq370Fnshmoc1ff4FrQCIX2b
         JMzkdFlTuXBUOXCT/lwaVb6ivYr0VULq5BXC1f1d6UbAAYS9+Com0DKfksTACnO0pGWw
         lcpcOD2UlfZ2V/O9tRUiMzBhlKni2QkqwHuoY5rBt8IqC7Fc69wyJcTjYDjzpGoGb3sD
         UePMWd49PCzEFuhs+b9tE9Nu/xC6fbLU3SzHI77xLGGkmchaKrdtbSOjYa/BbHWJg44c
         sDa2JfNqQNqxHcPdK5fYEmZXDpWd8cIt2qhvpv+UQOlvijzmMtVO4wHXh/ntuLcl4fsW
         ZE5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gZE4Rw4WAl0DbXf1XIE/1Pog7lYhmCuNhpIN6qjVZog=;
        b=JVWr+q2RyFTRPrVUMtsnHBxznQo2/vmor7YTmjhiEZhKhT2wM+l42x3ghDCoZ97Rm5
         e6QZ1vx+M6laEFHolud5eikya1me+R/cu/DqFP0BK3CDyLMfW8ZAJB1ek8mPM5C7PyAo
         3F3IxvJolETKrDeBpcR+6hoRFVDLDrrRnTDizcp7wju0Nb3GxjBACom+OxNRNtWxzsAH
         sbdA/Oz7N6GRz/C0h9/YlFt43lbcRKWUsnGBhDItiSZT6gZGp8+Aj4PSRjzXVEd8i67I
         bE55znqrKEHaLhtNNQrzEmKDRGWt5BDVHBQ6XtziD29nbLorKeHHy0l78emYl/MMJNck
         Bwtg==
X-Gm-Message-State: AO0yUKX0BWZUqU7NRc70CnCynr94FQLOJdxtAlVAY7rj76EppPEMUD01
        Ux4S7hlnrj68IUXHUbaa36zfdMQxLZgYoV6kng0wV9Ap
X-Google-Smtp-Source: AK7set91Au0hOLm5EddC4KhEd2SmJOF49eVC2r8gZruYHOJDKawUz59MnUvBzm6vc4BC7yK7QPUop2YOheSxUZPP0t8=
X-Received: by 2002:a67:e007:0:b0:3ef:e545:1a45 with SMTP id
 c7-20020a67e007000000b003efe5451a45mr2093332vsl.70.1675151794735; Mon, 30 Jan
 2023 23:56:34 -0800 (PST)
MIME-Version: 1.0
References: <Y7/QOZYvOFjbP3wu@zwp-5820-Tower> <Y8FgGev2HPX/ksUS@alley>
 <CAA70yB4MJoe3a7+yKPTA7XzS7c1FsMS-nyFmsiu3c7pJK-WcOQ@mail.gmail.com> <Y9ebzUL+fqGeQuAj@alley>
In-Reply-To: <Y9ebzUL+fqGeQuAj@alley>
From:   Weiping Zhang <zwp10758@gmail.com>
Date:   Tue, 31 Jan 2023 15:56:23 +0800
Message-ID: <CAA70yB4yQqH+2TydC2nQR5aeipJTggV6JesA09h6Q-_fzW6qdA@mail.gmail.com>
Subject: Re: [RFC PATCH] hung_task: show sysctl_hung_task_warnings
To:     Petr Mladek <pmladek@suse.com>, fuyuanli@didiglobal.com
Cc:     akpm@linux-foundation.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org
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

On Mon, Jan 30, 2023 at 6:28 PM Petr Mladek <pmladek@suse.com> wrote:
>
> On Sun 2023-01-29 17:08:29, Weiping Zhang wrote:
> > Sorry for the late reply.
> >
> > On Fri, Jan 13, 2023 at 9:43 PM Petr Mladek <pmladek@suse.com> wrote:
> > >
> > > On Thu 2023-01-12 17:17:45, Weiping Zhang wrote:
> > > > This patch try to add more debug info to detect lost kernel log or no
> > > > hung task was detected.
> > > >
> > > > The user set 10 to the hung_task_timeout_secs, the kernel log:
> > > >
> > > > [ 3942.642220] INFO: task mount:19066 blocked for more than 10 seconds.
> > > > [ 3952.876768] INFO: task kworker/u81:0:7 blocked for more than 10 seconds.
> > > > [ 3952.877088] INFO: task scsi_eh_0:506 blocked for more than 10 seconds.
> > > > [ 3952.878212] INFO: task mount:19066 blocked for more than 10 seconds.
> > > > [ 3963.116805] INFO: task kworker/u81:0:7 blocked for more than 10 seconds.
> > > > [ 3963.117137] INFO: task scsi_eh_0:506 blocked for more than 10 seconds.
> > > > [ 3963.118275] INFO: task mount:19066 blocked for more than 10 seconds.
> > > > [ 3973.356837] INFO: task kworker/u81:0:7 blocked for more than 10 seconds.
> > > > [ 3973.357148] INFO: task scsi_eh_0:506 blocked for more than 10 seconds.
> > > > [ 3973.358247] INFO: task mount:19066 blocked for more than 10 seconds.
> >
> > Expect but no hung task log at this moment.
> >
> > > > [ 3993.836899] INFO: task kworker/u81:0:7 blocked for more than 10 seconds.
> > > > [ 3993.837238] INFO: task scsi_eh_0:506 blocked for more than 10 seconds.
> > > > [ 3993.838356] INFO: task mount:19066 blocked for more than 10 seconds.
> > > >
> > > > There is no any log at about 3983, it's hard to know if kernel log was
> > > > lost or there is no hung task was detected at that moment. So this patch
> > > > print sysctl_hung_task_warnings to distinguish the above two cases.
> > > >
> > > > Signed-off-by: Weiping Zhang <zhangweiping@didiglobal.com>
> > > > ---
> > > >  kernel/hung_task.c | 5 ++++-
> > > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/kernel/hung_task.c b/kernel/hung_task.c
> > > > index c71889f3f3fc..ca917931473d 100644
> > > > --- a/kernel/hung_task.c
> > > > +++ b/kernel/hung_task.c
> > > > @@ -127,8 +127,11 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
> > > >        * complain:
> > > >        */
> > > >       if (sysctl_hung_task_warnings) {
> > > > -             if (sysctl_hung_task_warnings > 0)
> > > > +             if (sysctl_hung_task_warnings > 0) {
> > > >                       sysctl_hung_task_warnings--;
> > > > +                     pr_err("sysctl_hung_task_warnings: %d\n",
> > > > +                             sysctl_hung_task_warnings);
> > > > +             }
> > >
> > > It is too much noise. But it might make sense to report it when
> > > the counter gets down to zero. Something like:
> > >
> > >                 if (sysctl_hung_task_warnings)
> > >                         pr_info("Future hung task reports are suppressed, see sysctl kernel.hung_task_warnings\n");
> > >
> > > and move this down after printing all the details for this hung task report.
> > I'm fine to print this warning when it gets down to 0.
>
> I prefer this variant.
It's ok, Yuanli will submit a patch for this.
>
> > The warning counter is useful to detect kernel log lost or not, if add
> > a new line to print this count is too noise,
> > how about append this counter at the end of the following line:
> >         pr_err("INFO: task %s:%d blocked for more than %ld seconds,
> > sysctl_hung_task_warnings: %d\n",
> >                 t->comm, t->pid, (jiffies - t->last_switch_time) / HZ,
> > sysctl_hung_task_warnings);
>
> Is it really important to print this on every line, please? IMHO, most people
> do not care. IMHO. it would add more harm (confusion, noise) than good.
>
Thanks
> Best Regards,
> Petr
