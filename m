Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45689745445
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 05:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbjGCDre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 23:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjGCDra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 23:47:30 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8221A1B2;
        Sun,  2 Jul 2023 20:47:29 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-40339ce8470so25150661cf.0;
        Sun, 02 Jul 2023 20:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688356048; x=1690948048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MM+zflEVNOse5qKPlU9YAWGILgdFd4pHTbSLnDFYDTA=;
        b=CX/We4TE6mhFd+LL1DFt5L2U7gOShiSxSr6IBvzuhBt05Z+NoJRl4EJy+STKKr8Gd2
         e7HV0HHoDi9qC785ItraCymzr6Sw39THwSxRRzGWqtLm7+n3KelgPZWuyjqntkfPnoia
         9a//RoB3F8L1Dhp3YgBp7Evyqcu8lRr970RxcTfuSZvzBIGx+8/wCNIKXuT2t1/GQ+4s
         +2zbcLgIvg8enki5CbkdOsomJJRfi0659eoe4sYvS/iVZ4dRCuLf/r8g11C7e/3Pl6HE
         AByVWV//Ly+KhfhcIAvxinsQ+c1P3LS+97hodO0ubb12GtuTfuzyUc0oTs3mQ0wSk9gV
         swig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688356048; x=1690948048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MM+zflEVNOse5qKPlU9YAWGILgdFd4pHTbSLnDFYDTA=;
        b=VSN3lB2jtCRrWpsVB6pi+nVAUXH7w0Du9bMMXQYbih9XrLt4mS5JNonWg+UnE7FNsJ
         fzD/gTMZ8YbOWK2rORGvoXghy4w6BGeUxsPqFTpfz35UZVIfpFJ+ZGweCp1DVPrrYred
         uWGTshse8FNuBVwFtMJ0tJz3+Xh9VvkIsiq0VdHei93ryvEl6mADXRedEdTkq3nS1Jeu
         j/xfHSTHZFFPFZbFml7kNH51FT1IUVLZLodEM7eOEb6lJGjOBx+ji4HglNsyCfn3E7iD
         EE+ZbftdRUlf6pXBlAs5cN0su+pRHxX2eJz/zGGxCV0tibEZhPxv9OKNpYUZHk+dEH3n
         OuLA==
X-Gm-Message-State: AC+VfDzB7tKc3suhBHOJI6YDIovy3qMplAH1oC6rpOuDlI8uS77B0POy
        WXf266dI08xcqw3LWOgDYYZmOGM8X7saXg6LGK6aZhYHXp8=
X-Google-Smtp-Source: ACHHUZ5+vFqjVZePH/fFm00Sxb3p5T7hUgh++yEc8uPSs2k8nKbp4dVhMNbEQbIJdG3rra+igurrIN71PeNDmCPPH7A=
X-Received: by 2002:ac8:5708:0:b0:400:7f00:47f5 with SMTP id
 8-20020ac85708000000b004007f0047f5mr13252817qtw.23.1688356048619; Sun, 02 Jul
 2023 20:47:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230630121627.833560-1-tz.stoyanov@gmail.com>
 <20230701090254.72323659@rorschach.local.home> <20230702235001.5bd26b8cd85028fc2bce94e6@kernel.org>
In-Reply-To: <20230702235001.5bd26b8cd85028fc2bce94e6@kernel.org>
From:   Tzvetomir Stoyanov <tz.stoyanov@gmail.com>
Date:   Mon, 3 Jul 2023 06:47:12 +0300
Message-ID: <CAPpZLN7=m=zMrLz9hwk4TcVJRC42ZsxuwRDjpkUPVxPpMW4v7w@mail.gmail.com>
Subject: Re: [PATCH v2] kernel/trace: Fix cleanup logic of enable_trace_eprobe
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, dan.carpenter@linaro.org,
        linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 2, 2023 at 5:50=E2=80=AFPM Masami Hiramatsu <mhiramat@kernel.or=
g> wrote:
>
> On Sat, 1 Jul 2023 09:02:54 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
>
> > On Fri, 30 Jun 2023 15:16:27 +0300
> > "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com> wrote:
> >
> >
> > Hi Tzvetomir,
> >
> > FYI, linux-trace-devel is for the tracing user space code, please Cc to
> > linux-trace-kernel for kernel patches. That makes it fall into the
> > proper patchwork.
> >
> > I noticed this because I couldn't find your patch in:
> >
> >   https://patchwork.kernel.org/project/linux-trace-kernel/list/
> >
> > Also, the Subject should just start with "tracing:".
> >
> > > The enable_trace_eprobe() function enables all event probes, attached
> > > to given trace probe. If an error occurs in enabling one of the event
> > > probes, all others should be roll backed. There is a bug in that roll
> > > back logic - instead of all event probes, only the failed one is
> > > disabled.
> > >
> > > Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > > Fixes: 7491e2c44278 ("tracing: Add a probe that attaches to trace eve=
nts")
> > > Signed-off-by: Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
> > > ---
> > > v2: Added one-time warning, as suggested by Steven Rostedt.
> >
> > It's always a nice touch (optional, but something I always do) to
> > add a link to the previous version:
> >
> >  Changes since v2: https://lore.kernel.org/all/20230628121811.338655-1-=
tz.stoyanov@gmail.com/
> >      - Added one-time warning (Steven Rostedt)
> >
> > >
> > >  kernel/trace/trace_eprobe.c | 14 ++++++++++++--
> > >  1 file changed, 12 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.=
c
> > > index 67e854979d53..6629fa217c99 100644
> > > --- a/kernel/trace/trace_eprobe.c
> > > +++ b/kernel/trace/trace_eprobe.c
> > > @@ -702,8 +702,18 @@ static int enable_trace_eprobe(struct trace_even=
t_call *call,
> > >
> > >     if (ret) {
> > >             /* Failed to enable one of them. Roll back all */
> > > -           if (enabled)
> > > -                   disable_eprobe(ep, file->tr);
> > > +           if (enabled) {
> > > +                   /*
> > > +                    * It's a bug if one failed for something other t=
han memory
> > > +                    * not being available but another eprobe succeed=
ed.
> > > +                    */
> > > +                   WARN_ON_ONCE(ret !=3D -ENOMEM);
> > > +
> > > +                   list_for_each_entry(pos, trace_probe_probe_list(t=
p), list) {
> > > +                           ep =3D container_of(pos, struct trace_epr=
obe, tp);
> > > +                           disable_eprobe(ep, file->tr);
> > > +                   }
> >
> > I think we may need the counter again ;-)
> >
> > But for another reason. We only want to call disable for what we
> > enabled, to avoid any unforeseen side effects.
> >
> >
> >       cnt =3D 0;
> >         list_for_each_entry(pos, trace_probe_probe_list(tp), list) {
> >                 ep =3D container_of(pos, struct trace_eprobe, tp);
> >                 ret =3D enable_eprobe(ep, file);
> >                 if (ret)
> >                         break;
> >                 enabled =3D true;
> >               cnt++;
> >         }
> >
> >         if (ret) {
> >                 /* Failed to enable one of them. Roll back all */
> >                 if (enabled) {
> >                       list_for_each_entry(pos, trace_probe_probe_list(t=
p), list) {
> >                               ep =3D container_of(pos, struct trace_epr=
obe, tp);
> >                               disable_eprobe(ep, file->tr);
> >                               if (!--cnt)
> >                                       break;
> >                       }
> >               }
>
> +1. It seems that enable_eprobe() doesn't change ep, we need a counter to
> count how many eprobes are enabled in the first loop for roll-back the
> already enabled eprobes in the 2nd loop.
>

Ok, I'll send v3 with the counter, although I think it is a bit
overengineering - that optimization is in code that is unlikely to be
executed.

> Thank you,
>
>
> >
> > Thoughts?
> >
> > -- Steve
> >
> >
> >
> > > +           }
> > >             if (file)
> > >                     trace_probe_remove_file(tp, file);
> > >             else
> >
>
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>



--=20
Tzvetomir (Ceco) Stoyanov
VMware Open Source Technology Center
