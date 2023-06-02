Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF96D71F9A6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 07:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233527AbjFBF2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 01:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232239AbjFBF2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 01:28:37 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 229AC19A
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 22:28:35 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-39a3f2668bdso1428643b6e.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 22:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685683714; x=1688275714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H3yguWcDHp3HLYdAxdeptyJ3CkNZ6M9GRuZ7B/u1X6w=;
        b=KKWcz7UfwgP72dpVB95zSx1sd+Em82Bq60iNgh5lzFwkckh80zYkPldNI9K8Bq9ohr
         gCUnuWVN06ab0zOBVqEOWtpAjQZVecxxJyhfu/XJVnjti6QneNjxHsy9x9aEIxv9ioe6
         PNZxGGxj0txJlr//UkqUguIomrBjjYWVRAxk4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685683714; x=1688275714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H3yguWcDHp3HLYdAxdeptyJ3CkNZ6M9GRuZ7B/u1X6w=;
        b=K9fdQjbA9yusmaCXZkOVNd1w/GfOtHTvkHdSOFfN1eFF+Dbjs6LYGkOck3IJLYZr71
         vA78dqsTrA77RZnpxoXDhCMUEkHtclgZAee/sv3vL6HBySL38/QgClePsvpCS8yQp882
         6F/qYaBUj5DNVioj2ICjya5MIkFjGaSRpC7+ULEAXIw6emsEz9e3N2/fT/fOW5Sp8Zlz
         xlc4Zv809LcFQyTzyMQEU69YbpiM43qbAXPfmmzWXDB+52yJRh646c6PlFM7NFhnwnBn
         b2h26AAHrJN+4QqpfOWgy82GMCNfPqwTdeTYdTeZ7IQA+l7EM+JKRmhhbILeXXL/k+Z2
         Xb/A==
X-Gm-Message-State: AC+VfDwFqYkoEqR7lX2DJ/bkLY/3dy6crDfXZj7rsNpBoZ3Smqp2CCQK
        pfCgVNYAW9M8ZiUqYx9o7HF7jqZruN2SmcZuxfNNcQ==
X-Google-Smtp-Source: ACHHUZ4RBj8RdQRMXKt0yi/3THXJYYH7DAO+2dOrybJ3S9KNhKezTwszBYa3IWOpXD3BhZNx0LUIT9mNZtof0dGQq+s=
X-Received: by 2002:aca:1a06:0:b0:399:169:75d8 with SMTP id
 a6-20020aca1a06000000b00399016975d8mr1472040oia.35.1685683714512; Thu, 01 Jun
 2023 22:28:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230204183355.never.877-kees@kernel.org> <Y96/SUlPUl7xH1NO@gallifrey>
 <63e1486a.050a0220.7001.ca15@mx.google.com> <Y+FaEp2blurmgVlH@gallifrey> <202306010954.23972A710A@keescook>
In-Reply-To: <202306010954.23972A710A@keescook>
From:   Jeff Xu <jeffxu@chromium.org>
Date:   Thu, 1 Jun 2023 22:28:22 -0700
Message-ID: <CABi2SkUsirqw2AagHSRTSy-Re8V0rnUkYVgh1Ag2WcsqLZS54Q@mail.gmail.com>
Subject: Re: [PATCH] jfs: Use unsigned variable for length calculations
To:     Kees Cook <keescook@chromium.org>
Cc:     "Dr. David Alan Gilbert" <linux@treblig.org>,
        Dave Kleikamp <shaggy@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 1, 2023 at 9:55=E2=80=AFAM Kees Cook <keescook@chromium.org> wr=
ote:
>
> On Mon, Feb 06, 2023 at 07:50:42PM +0000, Dr. David Alan Gilbert wrote:
> > * Kees Cook (keescook@chromium.org) wrote:
> > > On Sat, Feb 04, 2023 at 08:25:45PM +0000, Dr. David Alan Gilbert wrot=
e:
> > > > * Kees Cook (keescook@chromium.org) wrote:
> > > > > To avoid confusing the compiler about possible negative sizes, sw=
itch
> > > > > "ssize" which can never be negative from int to u32.  Seen with G=
CC 13:
> > > > >
> > > > > ../fs/jfs/namei.c: In function 'jfs_symlink': ../include/linux/fo=
rtify-string.h:57:33: warning: '__builtin_memcpy' pointer overflow between =
offset 0 and size [-2147483648, -1]
> > > > > [-Warray-bounds=3D]
> > > > >    57 | #define __underlying_memcpy     __builtin_memcpy
> > > > >       |                                 ^
> > > > > ...
> > > > > ../fs/jfs/namei.c:950:17: note: in expansion of macro 'memcpy'
> > > > >   950 |                 memcpy(ip->i_link, name, ssize);
> > > > >       |                 ^~~~~~
> > > > >
> > > > > Cc: Dave Kleikamp <shaggy@kernel.org>
> > > > > Cc: Christian Brauner <brauner@kernel.org>
> > > > > Cc: Dave Chinner <dchinner@redhat.com>
> > > > > Cc: jfs-discussion@lists.sourceforge.net
> > > > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > > > > ---
> > > > >  fs/jfs/namei.c | 6 +++---
> > > > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > > >
> > > > > diff --git a/fs/jfs/namei.c b/fs/jfs/namei.c
> > > > > index b29d68b5eec5..494b9f4043cf 100644
> > > > > --- a/fs/jfs/namei.c
> > > > > +++ b/fs/jfs/namei.c
> > > > > @@ -876,7 +876,7 @@ static int jfs_symlink(struct mnt_idmap *idma=
p, struct inode *dip,
> > > > >         tid_t tid;
> > > > >         ino_t ino =3D 0;
> > > > >         struct component_name dname;
> > > > > -       int ssize;              /* source pathname size */
> > > > > +       u32 ssize;              /* source pathname size */
> > > >
> > > > Had you considered using size_t - this is set from a strlen and use=
d by a memcpy
> > > > that both talk size_t.
> > >
> > > I considered that, but I've had other maintainers upset about doublin=
g
> > > the variable size.
> >
> > I bet at least on some platforms it's cheaper as the 64 bit.
> >
> > > I opted to keep the variable 32-bit here, so the
> > > machine code would only change to lose signed-ness.
> >
> > Fair enough.
>
> Thread ping. Can someone pick this up (or Ack it for my tree), please?
>
Acked-by: Jeff Xu <jeffxu@chromium.org>

In case you ask someone to look at code, which I did.
Best
-Jeff


> Thanks!
>
> -Kees
>
> --
> Kees Cook
