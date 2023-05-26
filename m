Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42C48711C08
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 03:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232561AbjEZBGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 21:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbjEZBGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 21:06:07 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC1B125;
        Thu, 25 May 2023 18:06:02 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id ffacd0b85a97d-3093a778089so54629f8f.1;
        Thu, 25 May 2023 18:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685063161; x=1687655161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GjfAJc/vDf3Um7C9noINUOIK2Cbrxb4v+Y8oX39n4kg=;
        b=AjUrWK/5HPY7EHucm9EujcnMofUrD1UHwjKWdUfgdgu9qv0bVeQRuVjGdDMWXnh+5i
         F/3T578M9sbwZoD8Cn3o0O9So9BUIdlEAJN7AAT6ZEfIQowleZ7yZeP1omge3gTZilr9
         Dt4yTvbtZZ+hlaaagf4/M5U/FA9uIJXuM5fdvLTqUdUNDobpZKP+JovwYB7rm8Q9Fo05
         VdZpVJeoLwMZoENddqPfWEhPfOn+TyEv7bavX9lUj8YvZWDoombATdU+arTFLa5bW5nD
         OTJ5Vc8dyMXLV7O63uPHgdipppnpCORvgR7D9fqIa62JlmdctVcO8Z8/y42KhxSPpi6v
         NtVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685063161; x=1687655161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GjfAJc/vDf3Um7C9noINUOIK2Cbrxb4v+Y8oX39n4kg=;
        b=gOzqC7NyamhlMKC0gt9vIikq4+xgtz5baw/0XjDgHnTw7EbAQJbAoYpGkyk6tolNmn
         ih2YImeehfTnTC5QR8HhVAzwlr62sQPXB1hqt5InIECu6yjSf55aUrv/Bo+QLr6CKoV3
         Mk3sjsuaYkmPSNbc8ivc33oMK7sdGZoyE8MiYh9Qv+kHWbOufZfwz4W3A8LxUs2bvl2/
         jMVNTMVmvr4RMVzQDDAeQnHQqSUmOSWGjA0JJfYO0fSdXOmU+lvjXWoyN6fRju/2qTKO
         BxaNOZQvIVPNqZsYGdZ6km5Fiib6XCmstCiRr0ovmBOYfgapfCYdqvrXFGlupMQtRvCc
         RgrQ==
X-Gm-Message-State: AC+VfDyQMsFuq4c/m2tp/4jLqustE01hc1VgqNVpZMTvltxps32yEmpM
        jkSIRVJbNJHco3Gkt+ZIULf+CIv75c0w+vpD8/gJeH9A+m6v00A=
X-Google-Smtp-Source: ACHHUZ5V+Uy0gE609bt64VOiUno5b+O/zwj2jYS6/QwDH6ELzFziq0ShBDBMjUQo5hOuEawYwA33O/wbHlvrJysdHWI=
X-Received: by 2002:adf:f850:0:b0:306:3b39:9a3d with SMTP id
 d16-20020adff850000000b003063b399a3dmr74229wrq.15.1685063160565; Thu, 25 May
 2023 18:06:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230525054032.29392-1-sunliming@kylinos.cn> <20230525165329.GA82@W11-BEAU-MD.localdomain>
In-Reply-To: <20230525165329.GA82@W11-BEAU-MD.localdomain>
From:   sunliming <kelulanainsley@gmail.com>
Date:   Fri, 26 May 2023 09:05:49 +0800
Message-ID: <CAJncD7SnEr9FSz7VwDx3k9jeamDqAe0e1Ce+9TubjDEO3S0eJg@mail.gmail.com>
Subject: Re: [PATCH] tracing/user_events: Fix the order of the fields in the
 trace output
To:     Beau Belgrave <beaub@linux.microsoft.com>
Cc:     mhiramat@kernel.org, rostedt@goodmis.org,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
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

OK=EF=BC=8CI got it.

Beau Belgrave <beaub@linux.microsoft.com> =E4=BA=8E2023=E5=B9=B45=E6=9C=882=
6=E6=97=A5=E5=91=A8=E4=BA=94 00:53=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, May 25, 2023 at 01:40:32PM +0800, sunliming wrote:
> > Commit 4bec284cc0b9 ("tracing/user_events: Use print_format_fields() fo=
r
> > trace output") use print_event_fields() as safe and gives user readable
> > output. However, due to the insertion of the struct ftrace_event_field
> > structure into the field linked list from the header, the trace output
> > oder of fields of user events is reversed. Fix the problem by insertint
> > to the tail of field linked list.
> >
> > Signed-off-by: sunliming <sunliming@kylinos.cn>
> > ---
> >  kernel/trace/trace_events_user.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_even=
ts_user.c
> > index aacd22c1e9f8..e9e2ec3c7613 100644
> > --- a/kernel/trace/trace_events_user.c
> > +++ b/kernel/trace/trace_events_user.c
> > @@ -972,7 +972,7 @@ static int user_event_add_field(struct user_event *=
user, const char *type,
> >       if (filter_type =3D=3D FILTER_OTHER)
> >               field->filter_type =3D filter_assign_type(type);
> >
> > -     list_add(&field->link, &user->fields);
> > +     list_add_tail(&field->link, &user->fields);
> >
> >       /*
> >        * Min size from user writes that are required, this does not inc=
lude
> > --
> > 2.25.1
>
> Thanks for the patch, however, this breaks the tracefs format file. The
> fields are required to be put in backwards since it walks them
> backwards.
>
> Example using this:
> echo 'u:test u32 a; u32 b;' > dynamic_events
> cat /sys/kernel/tracing/events/user_events/test/format
>
> Before this change:
> name: test
> ...
> format:
>         field:unsigned short common_type;       offset:0;       size:2; s=
igned:0;
>         field:unsigned char common_flags;       offset:2;       size:1; s=
igned:0;
>         field:unsigned char common_preempt_count;       offset:3;       s=
ize:1; signed:0;
>         field:int common_pid;   offset:4;       size:4; signed:1;
>
>         field:u32 a;    offset:8;       size:4; signed:0;
>         field:u32 b;    offset:12;      size:4; signed:0;
>
> print fmt: "a=3D%u b=3D%u", REC->a, REC->b
>
> After this change:
> name: test
> ...
> format:
>         field:unsigned short common_type;       offset:0;       size:2; s=
igned:0;
>         field:unsigned char common_flags;       offset:2;       size:1; s=
igned:0;
>         field:unsigned char common_preempt_count;       offset:3;       s=
ize:1; signed:0;
>         field:int common_pid;   offset:4;       size:4; signed:1;
>
>         field:u32 b;    offset:12;      size:4; signed:0;
>         field:u32 a;    offset:8;       size:4; signed:0;
>
> print fmt: "b=3D%u a=3D%u", REC->b, REC->a
>
> I do agree though, that print_fields() is doing it backwards. Can you
> please fix the print_fields() function instead? (It should walk the list
> of fields backwards like tracefs format file does).
>
> Steven can then Ack that work, since it's isolated there.
>
> Thanks,
> -Beau
