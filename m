Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A96272A0B4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 18:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjFIQzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 12:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjFIQzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 12:55:49 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C671993
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 09:55:48 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-543b599054dso815100a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 09:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686329748; x=1688921748;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JUDu/7DgpcEGYUfH66KF8LpEOa4YLrtNbTWtCaGIav4=;
        b=ONSRNQw5ZwRQNGUqQHq+j4pU5Ha8C0gKwcZ3tD5oLOjzGBRHgFACfAQprE0Q+TYg/P
         lf+3dNuqjPAt+6bwiyXizp0lNbypl7beDWmiXlNGIWMkLLAjabVD1wTly667BXz+g/1/
         L0qmBswoM4J2Qj7ObeKL7y1aiscGksRuGZGH+y0qRi/2Z2Sd22x2JWyc8VPhIiC75xmV
         um25gWcuJx/L65W+dXsFYQdrBRAaW8fT9PQY1fIL/dI8i3qz+DerYhTj+/L4zpj2zMjx
         FEriPApZU9uFQzNGhOvbKQRUGKr0Cqa6V3KXZjEuijTtKk53SdH5gRt/Bbqu82iTjBaU
         oKGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686329748; x=1688921748;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JUDu/7DgpcEGYUfH66KF8LpEOa4YLrtNbTWtCaGIav4=;
        b=Jo/fhVkSQ3EnvWUF28XgYTzstXmkxT8WUGwyq5APOieds5nt4ffma8sZ006pHkNUQB
         f2vH/WmLXhtVL23Og6fr/mL5dvC8hq4yFmMnrNlyHS4RRy4XUF3I7Db+SPxhNiJuZg9f
         Utb4HE3zyNOL0J+zmttAXf6ohEO1HQutUUVPD7eblcX0uRpCUqKMbe1CPCoLnVD2LRxG
         U55dhZZbPAbPX9W41bTuOPfm1D4mEA4aDVhgPYSpqtUqZky7uNt2sc4q7jSsAhetIbnr
         4+7dt0WVCgeXvCGlnDfEgoJyIPQqBLebNRqjWH/LdhMdQiBwu2T18bDYa6Bmu6z1sL3g
         2HgQ==
X-Gm-Message-State: AC+VfDyPytY/Jx+2/F+b6++VG9E/1kd/zBP2QaImFQcELL2xcf2a2V1h
        CojoVAOkxZA26/brS0TTj1UZ6IRu6xW/kxLZI9bGhg==
X-Google-Smtp-Source: ACHHUZ6HxN+lrJGAlL2C5V8qEiwPCFNyTuGmy18Ac5XNglz/yS9yLUF2jkuplc7nJeYWFDXq58+6+ZWVXbHGpZ6st18=
X-Received: by 2002:a17:90a:ca97:b0:256:3191:640f with SMTP id
 y23-20020a17090aca9700b002563191640fmr6690924pjt.4.1686329747571; Fri, 09 Jun
 2023 09:55:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAEf4Bzb2_THiWkqNRnbN5LsOif6+9=GY7LrtEbQf6o24cihhMQ@mail.gmail.com>
 <20230609093625.727490-1-zhangmingyi5@huawei.com>
In-Reply-To: <20230609093625.727490-1-zhangmingyi5@huawei.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Fri, 9 Jun 2023 09:55:36 -0700
Message-ID: <CAKH8qBu0AiB_0SZgU5N8EOmm4=hp5BRe=Yp5PHbyT1ZbRjdeOw@mail.gmail.com>
Subject: Re: [PATCH] libbpf:fix use empty function pointers in ringbuf_poll
To:     zhangmingyi <zhangmingyi5@huawei.com>
Cc:     andrii.nakryiko@gmail.com, andrii@kernel.org, ast@kernel.org,
        bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net,
        edumazet@google.com, hsinweih@uci.edu, jakub@cloudflare.com,
        john.fastabend@gmail.com, kongweibin2@huawei.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, liuxin350@huawei.com,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzbot+49f6cef45247ff249498@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com, wuchangye@huawei.com,
        xiesongyang@huawei.com, yanan@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 9, 2023 at 2:38=E2=80=AFAM zhangmingyi <zhangmingyi5@huawei.com=
> wrote:
>
> On Fri, Jun 9, 2023 at 1:39 AM Andrii Nakryiko <andrii.nakryiko@gmail.com=
> wrote:
>
> > On Thu, Jun 8, 2023 at 9:27=E2=80=AFAM Stanislav Fomichev <sdf@google.c=
om> wrote:
> > >
> > > On Thu, Jun 8, 2023 at 6:00=E2=80=AFAM zhangmingyi <zhangmingyi5@huaw=
ei.com> wrote:
> > > >
> > > > On 06/06,Stanislav Fomichev wrote:
> > > >
> > > > > On 06/05, Xin Liu wrote:
> > > > > > From: zhangmingyi <zhangmingyi5@huawei.com>
> > > > >
> > > > > > The sample_cb of the ring_buffer__new interface can transfer NU=
LL. However,
> > > > > > the system does not check whether sample_cb is NULL during
> > > > > > ring_buffer__poll, null pointer is used.
> > > >
> > > > > What is the point of calling ring_buffer__new with sample_cb =3D=
=3D NULL?
> > > >
> > > > Yes, as you said, passing sample_cb in ring_buffer__new to NULL doe=
sn't
> > > > make sense, and few people use it that way, but that doesn't preven=
t this
> > > > from being a allowed and supported scenario. And when ring_buffer__=
poll is
> > > > called, it leads to a segmentation fault (core dump), which I think=
 needs
> > > > to be fixed to ensure the security quality of libbpf.
> > >
> > > I dunno. I'd argue that passing a NULL to ring_buffer__new is an API
> > > misuse. Maybe ring_buffer__new should return -EINVAL instead when
> > > passed NULL sample_cb? Although, we don't usually have those checks
> > > for the majority of the arguments in libbpf...
> >
> > Right. I'd say we should add a proper doc comment specifying all
> > arguments and which ones are optional or not. And make it explicit
> > that callback is not optional. If we start checking every possible
> > pointer for NULL, libbpf will be littered with NULL checks, I'm not
> > sure that's good.
>
> I agree, we should add a proper doc comment specifying all
> arguments and which ones are optional or not.
> However, why does the external interface API in libbpf not verify input
> parameters or add verification where risky operations may exist?
> What's more, i think sample_cb=3DNULL is not strictly a mistake or
> prohibited use, and is meaningless.

It's not really customary in C to do it? So maybe you can follow up
with the update to the doc?

The kindergarten is over, you pass NULL you get SIGSEGV :-D
