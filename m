Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAF83634D84
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 02:58:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234919AbiKWB6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 20:58:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232445AbiKWB6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 20:58:31 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B71158C0B1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 17:58:30 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id b185so16038389pfb.9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 17:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iXu1zQrnjp/lS+bnY1uKt+7jp3qPlyv/bmFa7h/muvk=;
        b=h0JO7tRIHgqdyFOTX7K0lbAbzwTTkiud1nbKUHOSeXcUg+Fs7LliA9f79AuHBwjsQY
         eUhDRqXfXPfUW/oJKYpr3OE7bhPV+hALZisIF4jh0Dgx9++VswrAtY2Nh7dx8LnnXhiY
         y2ogHYEgUQ8BCgPFYqGK4Uo3w/dz15IrVy+4QeSjIS93p7UQmPxa8xtWKq9dalia6kBb
         n7sUX2GL0AOMr4rSkf26kAMe2quNHVExrRXFPk6y9aFYI/0s0Vrcq4xbDQt7oUBFH0Fe
         cSKSVdwhLUmVf+uE3hrCp+KXfqetldZrx+Y7mH4D53nQ+LNTO/efeU7lVVMgobGC964U
         ShpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iXu1zQrnjp/lS+bnY1uKt+7jp3qPlyv/bmFa7h/muvk=;
        b=IWVvGrKKNwKIayxhaPXatMkkkKX3VGCSarWYrXNV4HoiDcEaE3au23ifgzuIZWZVin
         uooOGzgUywT2cfz6wWFcMuwOIOG8suSMDybT6hkgEFrSDK2NboU0+aB4QLgWfA23FRLJ
         FCjUzTs0c6RVMl8dLGSncDja8MmTGOsN6DvB3KjNToOBy9SXnTxjcUHz55GCz+FV5F+8
         2b7uOJAJICjI+dcwu8mk7FopDXkiD6Z8lKlIY0zN2D6G3iMd07fWQpaQ6mAbKXVlwGv5
         s9gWCC51Q8p04geIS1yhXwBhwv7YXmNx0Sqto2N/7K55wR5o5T12SfMNkdzEi734cP7t
         IIjQ==
X-Gm-Message-State: ANoB5pktjQsjm3nX9lYy6sGltMX4m/Jr/iTSmGkcMsHH7ytyzw8EX6tF
        JZh998TAzxSEo0Ze1MyBAZvZJ7Cu4mf+oekL5Hs=
X-Google-Smtp-Source: AA0mqf60s4thaIY/8QgKd28z+Dxljt5qEdOpEnyEgsaAdxa92Kjy5IR95KQoHlJcPuuTmZQ4PnNSgTOLGC47wfsRymE=
X-Received: by 2002:a63:525e:0:b0:477:bca8:1cd9 with SMTP id
 s30-20020a63525e000000b00477bca81cd9mr458942pgl.581.1669168709423; Tue, 22
 Nov 2022 17:58:29 -0800 (PST)
MIME-Version: 1.0
References: <20221026132039.2236233-1-suagrfillet@gmail.com>
 <CAAYs2=iOvP-TxLs+_QFMLQHG86xi2PYK_CN_rXUWHBx=kY+1aw@mail.gmail.com> <20221122163225.76a19e1d@gandalf.local.home>
In-Reply-To: <20221122163225.76a19e1d@gandalf.local.home>
From:   Song Shuai <suagrfillet@gmail.com>
Date:   Wed, 23 Nov 2022 01:58:18 +0000
Message-ID: <CAAYs2=jZ=uR61QXB-m4+7ocuydn1diGv0yV6KWmm4jfZYvam8Q@mail.gmail.com>
Subject: Re: [PATCH] ftrace: avoid replacing the list func with itself
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt <rostedt@goodmis.org> =E4=BA=8E2022=E5=B9=B411=E6=9C=8822=E6=
=97=A5=E5=91=A8=E4=BA=8C 21:32=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, 22 Nov 2022 02:28:25 +0000
> Song Shuai <suagrfillet@gmail.com> wrote:
>
> > Song Shuai <suagrfillet@gmail.com> =E4=BA=8E2022=E5=B9=B410=E6=9C=8826=
=E6=97=A5=E5=91=A8=E4=B8=89 13:20=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > The list func (ftrace_ops_list_func) will be patched first
> > > before the transition between old and new calls are set,
> > > which fixed the race described in this commit `59338f75`.
> > >
> > > While ftrace_trace_function changes from the list func to a
> > > ftrace_ops func, like unregistering the klp_ops to leave the only
> > > global_ops in ftrace_ops_list, the ftrace_[regs]_call will be
> > > replaced with the list func although it already exists. So there
> > > should be a condition to avoid this.
> > >
> > > This patch backups saved_ftrace_func by saved_ftrace_func_old
> > > which will be compared with the list func before trying to patch it.
> > >
> > Ping...
>
> Wouldn't something like this be simpler and easier to manage (without
> adding another variable to keep track of)?
>
> -- Steve
>
Thanks for the corrections, this looks great to me.
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 65a5d36463e0..d04552c0c275 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -2763,6 +2763,19 @@ void __weak ftrace_arch_code_modify_post_process(v=
oid)
>  {
>  }
>
> +static int update_ftrace_func(ftrace_func_t func)
> +{
> +       static ftrace_func_t save_func;
> +
> +       /* Avoid updating if it hasn't changed */
> +       if (func =3D=3D save_func)
> +               return 0;
> +
> +       save_func =3D func;
> +
> +       return ftrace_update_ftrace_func(func);
> +}
> +
>  void ftrace_modify_all_code(int command)
>  {
>         int update =3D command & FTRACE_UPDATE_TRACE_FUNC;
> @@ -2783,7 +2796,7 @@ void ftrace_modify_all_code(int command)
>          * traced.
>          */
>         if (update) {
> -               err =3D ftrace_update_ftrace_func(ftrace_ops_list_func);
> +               err =3D update_ftrace_func(ftrace_ops_list_func);
>                 if (FTRACE_WARN_ON(err))
>                         return;
>         }
> @@ -2799,7 +2812,7 @@ void ftrace_modify_all_code(int command)
>                 /* If irqs are disabled, we are in stop machine */
>                 if (!irqs_disabled())
>                         smp_call_function(ftrace_sync_ipi, NULL, 1);
> -               err =3D ftrace_update_ftrace_func(ftrace_trace_function);
> +               err =3D update_ftrace_func(ftrace_trace_function);
>                 if (FTRACE_WARN_ON(err))
>                         return;
>         }
Thanks,
Song
