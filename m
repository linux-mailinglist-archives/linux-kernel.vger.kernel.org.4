Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00D8273BAB6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 16:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbjFWOwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 10:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231742AbjFWOwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 10:52:04 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DCE81BF7
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 07:51:59 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-40079b6fc56so203561cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 07:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687531918; x=1690123918;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iEJbSFvNN4ys2MvYB/VG/wP8CLMdILQxxLkq8QKT/dU=;
        b=3LFYnCqFnpdhz5S9qfYXi4Rt4Wl3RLV0YYDjUzpfeP3Ai+3x8X7HZXhqcdFwjXBfKr
         l6EPMGTIUAspmGCSajp8+kCjBx6lCxGu5Vd2zd/3HAgRQPWqs8o3Rk4ljY1kO3O/wDLS
         PZOea6JiANK4DJjfiZ20sP8E1+W075KyQwL7ycOhOlF5gaGSq0pLqexyOzeebLxjpZv9
         /oY6f3yURgATwvrOkM5MwhPOqylUJGfhCXimyLtNzhH/NpMltFPhIqNP1FNKAHMs+a3t
         31qjr3Vk5IgYPVf/eZUlO8UglOgMZRDZ4sdR2tpYxVeD2AKndehmvAW29aJ6VhEHdLrB
         OkxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687531918; x=1690123918;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iEJbSFvNN4ys2MvYB/VG/wP8CLMdILQxxLkq8QKT/dU=;
        b=Sze1hShXwDtFXX+QZ5lQrxEHwMSP/oY9VA1aIGyiEZ1MGtk3Z7FlsKObmgeJyazNCz
         rFymGPxvA82Hqs2mqxpS33H7hTM0MSqXcXezYWdMTMbgDRVkBNN30+t/U+Ij838+ei+y
         2NXmQuqt+uCFIwpFX09IJZOaWLboMfRvVFJdFZdlVT/NQKVnOnm9QrRE9QdIZdhPjnKX
         w+C9jUJfKiXNOoAEL1qMXuej12DRZOoJBUeZ/783dL90LmvvrK2Q1MqG70ubQmvgYUDO
         i1TqAR+H11Z2jEhsfoBgjVfju9xQbhaaeYbQA5y1oylUw3WLxLircAUnGh4FruSsls5o
         vvHQ==
X-Gm-Message-State: AC+VfDxfH1Dvn6DDxXvYhEaXpQbKlTO74/c56JmHy5ubJvJqDaUwEVCl
        16uVKzf2D01hd/NqNxF941rT5DWCDUBRbGp6WqwZvQ5PRpSpqocN3hg=
X-Google-Smtp-Source: ACHHUZ52oEyK48t2OKNsWraLNsiRHXFideUjUsgd6a64lJcGSP/FlVUHc2gs1n7WEHiUCWwSN1ZI6jfYy06uner0sh0=
X-Received: by 2002:a05:622a:40c:b0:3f8:175a:4970 with SMTP id
 n12-20020a05622a040c00b003f8175a4970mr161039qtx.18.1687531918131; Fri, 23 Jun
 2023 07:51:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230623142054.3945121-1-kyletso@google.com> <2023062359-moody-bunch-3011@gregkh>
In-Reply-To: <2023062359-moody-bunch-3011@gregkh>
From:   Kyle Tso <kyletso@google.com>
Date:   Fri, 23 Jun 2023 22:51:41 +0800
Message-ID: <CAGZ6i=1a+fz0p2pkxv3zGKgDgcaTtGQgoo-zfU-SYhq+rVsJJA@mail.gmail.com>
Subject: Re: [PATCH] sysfs: Replace %p with %pK in the warning of sysfs_emit*
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     rafael@kernel.org, badhri@google.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2023 at 10:30=E2=80=AFPM Greg KH <gregkh@linuxfoundation.or=
g> wrote:
>
> On Fri, Jun 23, 2023 at 10:20:54PM +0800, Kyle Tso wrote:
> > According to Documentation/core-api/printk-formats.rst, kernel pointers
> > need to be printed with %pK format specifier to respect kptr_restrict i=
n
> > sysctl.
> >
> > Also replace the function names in the strings with %s and __func__ as
> > checkpatch.pl suggested.
> >
> > Signed-off-by: Kyle Tso <kyletso@google.com>
> > ---
> >  fs/sysfs/file.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
> > index a12ac0356c69..56712f0886ef 100644
> > --- a/fs/sysfs/file.c
> > +++ b/fs/sysfs/file.c
> > @@ -732,7 +732,7 @@ int sysfs_emit(char *buf, const char *fmt, ...)
> >       int len;
> >
> >       if (WARN(!buf || offset_in_page(buf),
> > -              "invalid sysfs_emit: buf:%p\n", buf))
> > +              "invalid %s: buf:%pK\n", __func__, buf))
>
> Wait, no, these are not going out in sysfs files, as they are still
> going to dmesg, right?
>
> So I think this line in the documentation matters:
>         This modifier is *only* intended when producing content of a file=
 read by
>         userspace from e.g. procfs or sysfs, not for dmesg. Please refer =
to the
>         section about %p above for discussion about how to manage hashing=
 pointers
>         in printk().
>
> so %p should still be ok here, the hashed value will end up in the
> kernerl log, which is what we want, and the WARN() traceback will show
> the problem properly, right?
>
> >               return 0;
> >
> >       va_start(args, fmt);
> > @@ -760,7 +760,7 @@ int sysfs_emit_at(char *buf, int at, const char *fm=
t, ...)
> >       int len;
> >
> >       if (WARN(!buf || offset_in_page(buf) || at < 0 || at >=3D PAGE_SI=
ZE,
> > -              "invalid sysfs_emit_at: buf:%p at:%d\n", buf, at))
> > +              "invalid %s: buf:%pK at:%d\n", __func__, buf, at))
>
>
> Same here, %p should be correct.
>
> Sorry for missing this before.
>
> greg k-h

Yes, you are right. Sorry for the noise.

Kyle
