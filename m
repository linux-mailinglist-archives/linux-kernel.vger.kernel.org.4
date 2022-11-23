Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D52B6634F97
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 06:32:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235865AbiKWFc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 00:32:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235828AbiKWFcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 00:32:03 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2565ED720;
        Tue, 22 Nov 2022 21:31:36 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id q71so15874173pgq.8;
        Tue, 22 Nov 2022 21:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5QCt3Hc0DdWG2SFWo5TOdl096cfyVUT4sQj3R5lWjYc=;
        b=i7Zsq+uIkpqATZusgTRS764we1OMv/xibQCzGnbyXAyFytjlIdIEhIYIJjaiVtEpup
         xAlVg0Go0HQNjQaqYGVtNnMlU/AuRAXcB30Bheyk6TLhMQa6bob6rc4fCAFk4IsIzq8N
         5CnTn/yDDmipP0LZn6re6GtqZbCbzWFNTUAnNdL600ssoH572+P3VcZZJpuX/aKblDMQ
         +WSMIbeI9wAKviydar+0W3HEHHPufroQBFfLOpASF2LOYmQ9qt4jSga88JK/puDJ1JkN
         VTHZXyReUglfswUdmhWn7M3tSVYLEOCDzIpOES5KUOra6ynYq6zdoygt3jhHYHxcJCPe
         6s+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5QCt3Hc0DdWG2SFWo5TOdl096cfyVUT4sQj3R5lWjYc=;
        b=W8O1oB4XpjJFDUyA3BRmgtkAVkH39fZptCdp0GoUBO+zTF13GGrsXqEib+ubmauefr
         4cJ416M8HiV/NNNFraKvjdkFEHr1ziALp/WvhnVl6LnhpYsJm9OmBbz0qlnLH+ujJIMC
         uHtTi2jFtp+nQDepBe5isZgdhqn8/ElJ+cwQkUA4I8o9MeIxH0bgQjHekvJdJH1LTVDy
         hZFxmPCdSGZ1fWDhHTFoZtiW09+bNakbLN2ou8gwhofV+mkJ+izDqTt/uivgTImFZhZz
         yshzXSYMOltNZmToqABuqbiBFsynXK5Z+WIF3rXgckmt9Oyl9+aY0RYj4kArW3VwHtYt
         A0Ww==
X-Gm-Message-State: ANoB5pksJxnUqB2mxmlcPFZxHQjIWpr/sEFWYsXFylBW2SW5RtVipLoJ
        C/HfzHDBSDBhPoOIqDThr46XffcHsgzZqtd9nK8=
X-Google-Smtp-Source: AA0mqf6NEBzeB0G000YRmycM71U2skP3+tFC/ZXDmhl/w6497td01SFJJukYTqmSYpimyKrxS2+a0THe2xg7c+z0fxs=
X-Received: by 2002:a65:694e:0:b0:474:6749:407d with SMTP id
 w14-20020a65694e000000b004746749407dmr5986576pgq.425.1669181496288; Tue, 22
 Nov 2022 21:31:36 -0800 (PST)
MIME-Version: 1.0
References: <20221122180905.737b6f52@gandalf.local.home> <CAAYs2=jdy7zrRDyTidUW1tFbKDLycLOZjSDt0_Ra7CbB6O1L2Q@mail.gmail.com>
 <20221122221711.402b360f@rorschach.local.home>
In-Reply-To: <20221122221711.402b360f@rorschach.local.home>
From:   Song Shuai <suagrfillet@gmail.com>
Date:   Wed, 23 Nov 2022 05:31:24 +0000
Message-ID: <CAAYs2=jHMLBApdU_VSaeh8ypi62T_dNCVSL0GKGRQgPhiRBQSg@mail.gmail.com>
Subject: Re: [PATCH] ftrace: Avoid needless updates of the ftrace function call
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
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

Steven Rostedt <rostedt@goodmis.org> =E4=BA=8E2022=E5=B9=B411=E6=9C=8823=E6=
=97=A5=E5=91=A8=E4=B8=89 03:17=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, 23 Nov 2022 10:29:28 +0800
> Song Shuai <suagrfillet@gmail.com> wrote:
>
> > > @@ -2783,7 +2796,7 @@ void ftrace_modify_all_code(int command)
> > >          * traced.
> > >          */
> > >         if (update) {
> > > -               err =3D ftrace_update_ftrace_func(ftrace_ops_list_fun=
c);
> > > +               err =3D update_ftrace_func(ftrace_ops_list_func);
> > >                 if (FTRACE_WARN_ON(err))
> > >                         return;
> > >         }
> > > @@ -2799,7 +2812,7 @@ void ftrace_modify_all_code(int command)
> > >                 /* If irqs are disabled, we are in stop machine */
> > >                 if (!irqs_disabled())
> > >                         smp_call_function(ftrace_sync_ipi, NULL, 1);
> > > -               err =3D ftrace_update_ftrace_func(ftrace_trace_functi=
on);
> > > +               err =3D update_ftrace_func(ftrace_trace_function);
> > The helper function should only serve the ftrace_ops_list_func.
> >
> > And ftrace_trace_function is always different in this function with
> > FTRACE_UPDATE_TRACE_FUNC command.
> >
> > So this place should be left as it is.
>
> But it is needed to update the static variable. Without this change,
> then save_func will get set to ftrace_ops_list_func and never change
> after that and then the update to ftrace_ops_list_func will stop happenin=
g.
>
> -- Steve
Yes, you're right. Thx for your explanation.
-- Song
