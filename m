Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 834B07031C5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 17:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241986AbjEOPpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 11:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjEOPpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 11:45:14 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43ADB1FCF
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 08:45:13 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-965d2749e2eso1954999866b.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 08:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1684165511; x=1686757511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XPEGaC+x0TYEuX7HHgeWtz7pyNM4DGEHBqF/DDq7Iw0=;
        b=gImqqK7Ez4ILwctNY0AcR7B6kOcnLZLrABJErDV0yJSdTCJO24RZwul28fa1YXP4J5
         bKoHYDUdz0GrdUt1uvyJRzrL7wHWnEE7CFgoVdIxKph77hkZpY5hXoE8CN2AnKNyhvPE
         1WD55DRKkWgfPnF1cu9nglLrdj/x+IQwngXX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684165511; x=1686757511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XPEGaC+x0TYEuX7HHgeWtz7pyNM4DGEHBqF/DDq7Iw0=;
        b=ZfdyG/DTGijqVVmC4Km6UQPcPwLk3wxCRotvq5ZZ92cpsrF0TfGtOENnItNpudxVBd
         74o7EP59koOSQiEZPX6O3BamoCFDGe7wlK9UlhD/rIXcItI/Xf4KPqk2kqSFwjSbZD8W
         RNHp72JHFtvDnr49ZWrpMNwVAsryBUDlxruWmDF67mzKzEGJDIzUPUKxuDTy4QLirInE
         vlmQhCwUlsq7J+klq2vxGoDUgiEOrVMQRJ+vp28GqIDB3dd61eSh95+NDXPPU5/y91Zf
         Jr99UodXMGRFuhbRZTIoRgAgtcZVKQMSd263kFVQWVQfjR/rosJutcnx5gT3SDZR+ZW/
         bGZg==
X-Gm-Message-State: AC+VfDyp8CRx1uARHak+GyewMi1gP2KJHPcIMlQ5uthFZzs+hsN6JYkJ
        I9sQAcFAeVIqq6vSHW4MovgQEAtxXdIQbocokEQS4w==
X-Google-Smtp-Source: ACHHUZ7XhtEAM1SW9fbWC/Rq6wBkVNyU7h9yWmfds6AIC1wnRChQajU7oj5QeWfZYiG92GUdz01ldw==
X-Received: by 2002:a17:907:1c9e:b0:96a:9c6:d75a with SMTP id nb30-20020a1709071c9e00b0096a09c6d75amr20164952ejc.24.1684165511184;
        Mon, 15 May 2023 08:45:11 -0700 (PDT)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id ib8-20020a1709072c6800b0094f67ea6598sm9711885ejc.193.2023.05.15.08.45.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 08:45:10 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-969f90d71d4so1250117766b.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 08:45:09 -0700 (PDT)
X-Received: by 2002:a17:907:70d:b0:94b:d57e:9d4b with SMTP id
 xb13-20020a170907070d00b0094bd57e9d4bmr30521770ejb.2.1684165509441; Mon, 15
 May 2023 08:45:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230202232517.8695-1-michael.christie@oracle.com>
 <20230202232517.8695-9-michael.christie@oracle.com> <aba6cca4-e66c-768f-375c-b38c8ba5e8a8@6wind.com>
 <CAHk-=wgadfsCnKHLON7op=Qs5t3w3PVz5ZDbvbKsfb=yBg=yjQ@mail.gmail.com>
 <78c5e150-26cf-7724-74ee-4a0b16b944b1@oracle.com> <48842e92-835e-bc3f-7118-48b8f415f532@leemhuis.info>
 <CAHk-=wicXCNR1bBioaAiBqEDgv-CoQD9z2RsM2VOTPzkK0xr8g@mail.gmail.com> <20230515-vollrausch-liebgeworden-2765f3ca3540@brauner>
In-Reply-To: <20230515-vollrausch-liebgeworden-2765f3ca3540@brauner>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 15 May 2023 08:44:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgXJ5VS1iBkfsG=HDjsyhn5XYDKt5xhQcNuz-e7VKyg8A@mail.gmail.com>
Message-ID: <CAHk-=wgXJ5VS1iBkfsG=HDjsyhn5XYDKt5xhQcNuz-e7VKyg8A@mail.gmail.com>
Subject: Re: [PATCH v11 8/8] vhost: use vhost_tasks for worker threads
To:     Christian Brauner <brauner@kernel.org>
Cc:     Thorsten Leemhuis <linux@leemhuis.info>,
        Mike Christie <michael.christie@oracle.com>,
        nicolas.dichtel@6wind.com,
        Linux kernel regressions list <regressions@lists.linux.dev>,
        hch@infradead.org, stefanha@redhat.com, jasowang@redhat.com,
        mst@redhat.com, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org, ebiederm@xmission.com,
        konrad.wilk@oracle.com, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2023 at 7:23=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> So I think we will be able to address (1) and (2) by making vhost tasks
> proper threads and blocking every signal except for SIGKILL and SIGSTOP
> and then having vhost handle get_signal() - as you mentioned - the same
> way io uring already does. We should also remove the ingore_signals
> thing completely imho. I don't think we ever want to do this with user
> workers.

Right. That's what IO_URING does:

        if (args->io_thread) {
                /*
                 * Mark us an IO worker, and block any signal that isn't
                 * fatal or STOP
                 */
                p->flags |=3D PF_IO_WORKER;
                siginitsetinv(&p->blocked, sigmask(SIGKILL)|sigmask(SIGSTOP=
));
        }

and I really think that vhost should basically do exactly what io_uring doe=
s.

Not because io_uring fundamentally got this right - but simply because
io_uring had almost all the same bugs (and then some), and what the
io_uring worker threads ended up doing was to basically zoom in on
"this works".

And it zoomed in on it largely by just going for "make it look as much
as possible as a real user thread", because every time the kernel
thread did something different, it just caused problems.

So I think the patch should just look something like the attached.
Mike, can you test this on whatever vhost test-suite?

I did consider getting rid of ".ignore_signals" entirely, and instead
just keying the "block signals" behavior off the ".user_worker" flag.
But this approach doesn't seem wrong either, and I don't think it's
wrong to make the create_io_thread() function say that
".ignore_signals =3D 1" thing explicitly, rather than key it off the
".io_thread" flag.

Jens/Christian - comments?

Slightly related to this all: I think vhost should also do
CLONE_FILES, and get rid of the whole ".no_files" thing. Again, if
vhost doesn't use any files, it shouldn't matter, and looking
different just to be different is wrong. But if vhost doesn't use any
files, the current situation shouldn't be a bug either.

                     Linus
