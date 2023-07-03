Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02718745851
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 11:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbjGCJ1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 05:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjGCJ07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 05:26:59 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C09F192;
        Mon,  3 Jul 2023 02:26:58 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-51d885b0256so5483057a12.2;
        Mon, 03 Jul 2023 02:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688376417; x=1690968417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P11oD5Wt8lVLUJsAnVFWdlZQbTH5DYoOiFhKucDw5A0=;
        b=h0gcHvLyFxZey4lxC2a6scRwqHOGqGkCOjh4sHkD/VgtfdS2owQdPP46w7anuw2jtX
         NJwGRqLqYK6mxsQSqPuq49PQPDQ2ofYOnucAo588Q7m4cboFkazrAViBOFTN8hcNzrU9
         xiPdKvtEPII1/AjNRyhlJvfkEsVuPfp22S6S9baKumVuLtutkjh+jAUDqFezj25pirUC
         uikRt3ubxgMurq4K2RrnonuuEll+G7d9XOmX/zk4KnpjpCEmwa6UoxnN3m6PvEcXx663
         r7HqY0DswsgCvNu+RDdEkHMgLJu9DWzx8/VoDkzP4BnMG5GEQjYifZ0osKKUWh7/xoHH
         1VCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688376417; x=1690968417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P11oD5Wt8lVLUJsAnVFWdlZQbTH5DYoOiFhKucDw5A0=;
        b=T+ARnBWbf9pXL0eHacDgJKOoQzFB43RaMtxxnFSxIf8wH+omwZ7+hYWq57C2S680JL
         MS18ixjMkczO7zjuXF6B7kXwJOTZkczCqhrAj5Mv7GxWfm/gbs3UaJUVlhRCz76c/KPH
         yitBcHm519OqzcecPpSdYOtFR3HTkf3ryEE1OcKJJU/4jHG6iZAEn5gwtbNYYF9fjLBI
         Ufaq40rWc54b463C4eLvDdg0ieU6KAn7ziixQeuUK3HgUYBA7PO+tH1WD98YOuZvzckr
         0XyONAAm/KGlZkl9ugQlgnURB4TQ80piYQtUoKzW9qSg6UT7/0jcheWK53Nia83XS+JR
         7OIA==
X-Gm-Message-State: ABy/qLa57oiQgHAqmRjlKfHXgAZwCiEbIR3x+9nIwKVWGb0OvQEYUpiu
        RYi37FIV0aHjONyT29i+rQIOFKpsw1k4jub4BMdJLjAQa54=
X-Google-Smtp-Source: APBJJlHyHNwggpF1PcSXCuUun/GxWAWV8ovGHcquXnyNDlBQK7cD4+CYZ5vFk5d8L4JpUXDFM9IMo3juIDqbDpaHMSg=
X-Received: by 2002:aa7:d617:0:b0:51e:166a:ac7f with SMTP id
 c23-20020aa7d617000000b0051e166aac7fmr853741edr.28.1688376417058; Mon, 03 Jul
 2023 02:26:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230703071640.106204-1-zegao@tencent.com> <20230703171905.ef83b1a7f4db82012db471fc@kernel.org>
In-Reply-To: <20230703171905.ef83b1a7f4db82012db471fc@kernel.org>
From:   Ze Gao <zegao2021@gmail.com>
Date:   Mon, 3 Jul 2023 17:26:45 +0800
Message-ID: <CAD8CoPBRQ1cU1+DngGd5wyvAxZgk78zmfMUM9WeuUZ2S-UHdYw@mail.gmail.com>
Subject: Re: [PATCH] fprobe: add unlock to match a succeeded ftrace_test_recursion_trylock
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, Ze Gao <zegao@tencent.com>,
        Yafang <laoar.shao@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good suggestion! Will amend and push v2 ASAP.

Thanks,
Ze

On Mon, Jul 3, 2023 at 4:19=E2=80=AFPM Masami Hiramatsu <mhiramat@kernel.or=
g> wrote:
>
> On Mon,  3 Jul 2023 15:16:40 +0800
> Ze Gao <zegao2021@gmail.com> wrote:
>
> Good catch! but please add description here, something like;
>
> ----
> Unlock ftrace recursion lock when fprobe_kprobe_handler() is failed
> because another kprobe is running.
> ----
>
> The code itself is OK to me.
>
>
> > Fixes: 3cc4e2c5fbae ("fprobe: make fprobe_kprobe_handler recursion free=
")
> > Reported-by: Yafang <laoar.shao@gmail.com>
> > Closes: https://lore.kernel.org/linux-trace-kernel/CALOAHbC6UpfFOOibdDi=
C7xFc5YFUgZnk3MZ=3D3Ny6we=3DAcrNbew@mail.gmail.com/
> > Signed-off-by: Ze Gao <zegao@tencent.com>
> > ---
> >  kernel/trace/fprobe.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> > index 18d36842faf5..93b3e361bb97 100644
> > --- a/kernel/trace/fprobe.c
> > +++ b/kernel/trace/fprobe.c
> > @@ -102,12 +102,14 @@ static void fprobe_kprobe_handler(unsigned long i=
p, unsigned long parent_ip,
> >
> >       if (unlikely(kprobe_running())) {
> >               fp->nmissed++;
> > -             return;
> > +             goto recursion_unlock;
> >       }
> >
> >       kprobe_busy_begin();
> >       __fprobe_handler(ip, parent_ip, ops, fregs);
> >       kprobe_busy_end();
> > +
> > +recursion_unlock:
> >       ftrace_test_recursion_unlock(bit);
> >  }
> >
> > --
> > 2.40.1
> >
>
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>
