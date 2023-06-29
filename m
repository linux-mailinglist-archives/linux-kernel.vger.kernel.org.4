Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B91D742869
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 16:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbjF2Obr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 10:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjF2Obn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 10:31:43 -0400
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A8B12122;
        Thu, 29 Jun 2023 07:31:42 -0700 (PDT)
Received: by mail-ua1-x935.google.com with SMTP id a1e0cc1a2514c-786e637f06dso270967241.2;
        Thu, 29 Jun 2023 07:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688049101; x=1690641101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LKLBYSEdJ5sXV4EBLGg0oAJi8UayRb2mLq76mINGpUA=;
        b=rdZyKmqkLl5oe3BwYEQFBNy3lDMrmZxCZq/pMHDzOhK+pPG8SznVdQyqNBDMigHPMi
         2M1a/G5o1B8kFoYp7Y/s6/ktUnmSrs3ljP9+HBQNIbnvaRHbagCBJqd9anJoA/bmKJw3
         qlPMQXhUkmVgc/99VrKlRptcyvVePtxw/EI0+g0NG2CGg0HxoXzVB8sF3MhaKNjg2hMN
         AHisWtr20a8+bocV6c35s6n5uV/XTt57jAxOD9L/dFruG3n1LG3xhZ9b+b/7MMxyjdtR
         YgY+jvqiu597EsIMpJYEbFDW4PB/qxRE30Z9hg9Iyk/fl/WOUc1bCIRPhw0yRhmoTxpX
         NeIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688049101; x=1690641101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LKLBYSEdJ5sXV4EBLGg0oAJi8UayRb2mLq76mINGpUA=;
        b=k6ooPUrcdX5cjkmBo94omNB0kzQXIs4f8p8HqHqeSP+oBhuiI9s1DdUdzITeutB1Tm
         8aasX/kZlOTsM5bJHbd1DXdmTiyh38y/jez1Go8bKeqwMmiK8JxkAnbl6WrLm9dO83se
         om0jTT/lE4doYS5WGBlrI2NPcb9qK9S1TpbjYMeImjrlXAKLO0BBFTRHx1bxir/4tY1H
         Yaydxs6yhyQvC+cDv7M9mal9DZJDUfFSlLxTpSEo+RoLrHSZkv2aEkCJFngGo/v4SGZE
         JKy96FlvrLDEQ5MJG51M6aFusgyV0l5m/3rUXFWGAT9Q2xzCPHXRnlAAFoqW12zkSWRH
         uy4w==
X-Gm-Message-State: AC+VfDwA15ilw6Xg+Zead4vQnr0CfhHbNzdNYP9rz0sdSw0ErtbaMtI0
        RXEEkFm1q+ScPk+x7MvOTjp2udg47YgFH5CUx8qI+jGfPRI=
X-Google-Smtp-Source: ACHHUZ4xnAkcpMY72iUPcwnGryX3PkLB9JM29IAfVQPJbmq8i05u6E2etSLfxd0NQgm35eszZZhQwfBBofppo1lF3OU=
X-Received: by 2002:a67:bc04:0:b0:443:68b1:3bf5 with SMTP id
 t4-20020a67bc04000000b0044368b13bf5mr7984029vsn.23.1688049101154; Thu, 29 Jun
 2023 07:31:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230628121811.338655-1-tz.stoyanov@gmail.com> <20230628084428.7bb32d65@rorschach.local.home>
In-Reply-To: <20230628084428.7bb32d65@rorschach.local.home>
From:   Tzvetomir Stoyanov <tz.stoyanov@gmail.com>
Date:   Thu, 29 Jun 2023 17:31:24 +0300
Message-ID: <CAPpZLN6dCMzHyUhjSN3+9Um+-mS2TJiDPObUeO8NxyqpQS3k=g@mail.gmail.com>
Subject: Re: [PATCH] kernel/trace: Fix cleanup logic of enable_trace_eprobe
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mhiramat@kernel.org, dan.carpenter@linaro.org,
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

On Wed, Jun 28, 2023 at 3:44=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Wed, 28 Jun 2023 15:18:11 +0300
> "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com> wrote:
>
> > The enable_trace_eprobe() function enables all event probes, attached
> > to given trace probe. If an error occurs in enabling one of the event
> > probes, all others should be roll backed. There is a bug in that roll
> > back logic - instead of all event probes, only the failed one is
> > disabled.
> >
> > Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > Fixes: 7491e2c44278 ("tracing: Add a probe that attaches to trace event=
s")
> > Signed-off-by: Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
> > ---
> >  kernel/trace/trace_eprobe.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
> > index 67e854979d53..ba9a28bc773f 100644
> > --- a/kernel/trace/trace_eprobe.c
> > +++ b/kernel/trace/trace_eprobe.c
> > @@ -702,8 +702,12 @@ static int enable_trace_eprobe(struct trace_event_=
call *call,
> >
> >       if (ret) {
> >               /* Failed to enable one of them. Roll back all */
> > -             if (enabled)
> > -                     disable_eprobe(ep, file->tr);
> > +             if (enabled) {
>
> If one was enabled and the second one failed, that should only happen
> if there's a bug in the kernel (unless the failure was due to a memory
> problem).
>
> I wonder if we should add:
>
>                         int cnt =3D 0;
>
> > +                     list_for_each_entry(pos, trace_probe_probe_list(t=
p), list) {
>
>                                 /*
>                                  * It's a bug if one failed for something=
 other than memory
>                                  * not being available but another eprobe=
 succeeded.
>                                  */
>                                 WARN_ON_ONCE(cnt++ && ret !=3D -ENOMEM);

That makes sense, I can send v2 with it. What is the idea of this cnt
counter, why not just:
                                 WARN_ON_ONCE(ret !=3D -ENOMEM);
outside of the loop? If enabled is true and ret is not ENOMEM, the bug
is already there.

>
> -- Steve
>
>
> > +                             ep =3D container_of(pos, struct trace_epr=
obe, tp);
> > +                             disable_eprobe(ep, file->tr);
> > +                     }
> > +             }
> >               if (file)
> >                       trace_probe_remove_file(tp, file);
> >               else
>


--=20
Tzvetomir (Ceco) Stoyanov
VMware Open Source Technology Center
