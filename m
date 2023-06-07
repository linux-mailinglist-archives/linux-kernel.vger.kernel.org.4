Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD58725506
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 09:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238634AbjFGHFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 03:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235562AbjFGHEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 03:04:50 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E66D138
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 00:04:47 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-5151934a4e3so712142a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 00:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1686121486; x=1688713486;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0p+TSFNVv5FXtju55va0ALmUKjM4M5e7S84HkiGtatA=;
        b=qYgyVxs0WMn1vKG+jxJ0y4mvKv3Thpo/ZhAqR7byxJEP5PqKStJJVS5ZMi2PW0ziFT
         TWI66pPrbWo31SXzDgMDJ73f7Pour9PbD95N3OOCPOqVNtbf6D49U6vAd5Sy4if6rCGj
         zzecH4IC0qpn242+M0y+Axo6gmqGLEwwif0No=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686121486; x=1688713486;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0p+TSFNVv5FXtju55va0ALmUKjM4M5e7S84HkiGtatA=;
        b=jK+EpUhxFQamJDRyZQbuxw+0C5Y7M5DI6UljfFbDrgfkAFVzKv/Azpl9kefnASyluo
         IET0DMzRxKMEwXYrUIbM3Wz5t8viE6cz6D+qqT235OcvqgJOcn0fb2nXCRadBHKsh3rh
         ujcHoZID7dXGmEzLUnRUiZ2jCn/C2ffcZgP07+IZRzuy3hTWSrV2Y8UoX5o2AOTdFeDp
         KY7DSVkbXMcZwPtvSYlPFJqcr3NXIkx/XYvQE5iKXYO79gBGwoblTW5pGDo12Z622+ze
         cRE4VShB0BpooOc5idG8DZcJNghEKhJ2+yDI2RTyN3nzopify+CKCmVl689R/B1P7v/O
         KDJw==
X-Gm-Message-State: AC+VfDzg7gCO22mFUaWByWSBm7AAqqTOC9/YVL8U+XtIe4J5vV04TnFM
        Pkf9vkv/1/SdYgAel8xPKilkU7ooKwBSsgOwHDx6IraZQ/Ho+Lds
X-Google-Smtp-Source: ACHHUZ5O6P6Ctx7whsn/LVb52iLqxk9/bHPsrMe7SCaDvKVr1BfKXx/PamP+VSeiiK4bba/5uhaRCaR/7Mc3d8baZ+8=
X-Received: by 2002:a17:906:5d0b:b0:974:4457:b6f with SMTP id
 g11-20020a1709065d0b00b0097444570b6fmr6450613ejt.23.1686121486050; Wed, 07
 Jun 2023 00:04:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAPnZJGDWUT0D7cT_kWa6W9u8MHwhG8ZbGpn=uY4zYRWJkzZzjA@mail.gmail.com>
 <CAJfpeguZX5pF8-UNsSfJmMhpgeUFT5XyG_rDzMD-4pB+MjkhZA@mail.gmail.com> <871qiopekm.fsf@vostro.rath.org>
In-Reply-To: <871qiopekm.fsf@vostro.rath.org>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 7 Jun 2023 09:04:34 +0200
Message-ID: <CAJfpegvMNqZiNp9wWvqtgOiBHGd48C1+2ZtMt1i_gtE6v+X7fA@mail.gmail.com>
Subject: Re: [fuse-devel] [PATCH 0/6] vfs: provide automatic kernel freeze / resume
To:     Miklos Szeredi via fuse-devel <fuse-devel@lists.sourceforge.net>,
        Askar Safin <safinaskar@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>, linux-pm@vger.kernel.org,
        Bernd Schubert <bernd.schubert@fastmail.fm>,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Jun 2023 at 21:37, Nikolaus Rath <Nikolaus@rath.org> wrote:
>
> On Jun 06 2023, Miklos Szeredi via fuse-devel <fuse-devel@lists.sourcefor=
ge.net> wrote:
> > On Sun, 14 May 2023 at 00:04, Askar Safin <safinaskar@gmail.com> wrote:
> >>
> >> Will this patch fix a long-standing fuse vs suspend bug? (
> >> https://bugzilla.kernel.org/show_bug.cgi?id=3D34932 )
> >
> > No.
> >
> > The solution to the fuse issue is to freeze processes that initiate
> > fuse requests *before* freezing processes that serve fuse requests.
> >
> > The problem is finding out which is which.  This can be complicated by
> > the fact that a process could be both serving requests *and*
> > initiating them (even without knowing).
> >
> > The best idea so far is to let fuse servers set a process flag
> > (PF_FREEZE_LATE) that is inherited across fork/clone.
>
> Is that the same as what userspace calls PR_SET_IO_FLUSHER? From
> prctl(2):
>
>    PR_SET_IO_FLUSHER (since Linux 5.6)
>           If a user process is involved in the block layer or filesystem =
I/O  path,  and
>           can allocate memory while processing I/O requests it must set a=
rg2 to 1.  This
>           will put the process in the IO_FLUSHER state, which allows it  =
special  treat=E2=80=90
>           ment  to make progress when allocating memory. [..]
>
>           The calling process must have the CAP_SYS_RESOURCE capability.[=
...]

This is the issue.   We want suspend to work without needing privileges.

>
>           Examples  of  IO_FLUSHER  applications are FUSE daemons, SCSI d=
evice emulation
>           daemons, and daemons that perform error handling like multipath=
 path  recovery
>           applications.

This looks incorrect.  FUSE shouldn't need this because it manages
writeback in a way not to require such special treatment.

It might make sense to use the prctl(2) API for this, but honestly I
prefer pseudo fs interfaces for such knobs.

Thanks,
Miklos
