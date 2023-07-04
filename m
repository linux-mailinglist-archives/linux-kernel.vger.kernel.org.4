Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29828747A0C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 00:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbjGDWFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 18:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbjGDWFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 18:05:01 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A61E76
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 15:05:00 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-c5ffb6cda23so656934276.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 15:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688508299; x=1691100299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nswOflL+ad3Rf8OdqQYDYHaGrkZ9dAMLf54yrOYBn/c=;
        b=uWDLDVCv+cij7Hgi1Dfyr9iYQ1IdZH68Kx0m/+1EN0oyYPmGjjkclXXBbFwVdPM2yH
         AVHBn4wuVtu2DZ9INL0uK6cnZInJcl2+pwwUCKHPvEP/M8v7Out/g1itOkKVHPIxwihZ
         xYI0wflgLgYZcwlVIYA07695rhSEHx0ncHS8v0w9o0or/zlXHzUtQM4S/DHuXuBqEjSX
         1MHEVGC+Sfa6ZZOytGkLjCZFflKm35xQw8zHDl0gDWv8dlF8PW1s3MHLfAxrNMfR6uMU
         Kay/b1fyx27XReXEAEcfb0D8ekyWpR8/l2wt4q2zbSSZqvlvA3J5k4wvwSnIgqYt4zFx
         7glQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688508299; x=1691100299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nswOflL+ad3Rf8OdqQYDYHaGrkZ9dAMLf54yrOYBn/c=;
        b=a9Xy5TbkeZ8nwJmIC+XzQ6jEH3RSYJbk39x4vi3a+OP7nF33IG7r+60dJCfP35ZSs5
         3O0PMxH9pLbpNV6wvO48Crdie/Rlv7L6YBN3vBseInoyQjOo1dnIeIHIPn0J3BYdDEGV
         F58r4d1cxBEw7ODJH8JATgcWH6BRrT+zDgXcZu2o9P2fB7DKw42JV3o6B9q9JdshrsvS
         +S+Ih2/euCRaul5qcGVz1uBmPRNH2Ddn4/Nz8B73SUtAAgMaH1fXT/KDDe2MkOLG3LK/
         wcvElofoDW+bJOLbSE7Ab2kB5Y/M9IvQa8P/U8f51EqsmscGDK/1bREKuAxp1qr/Zb3e
         wl8A==
X-Gm-Message-State: ABy/qLbD20kh1R97esiIjg0HFzHoOYfG/VunyCh3i4Qny5nLiiG2hm1Q
        waQ9PMJsikX5wq/byGotSS35HqKeQZAVL8ivAsOWCnx7yGCub2KW76I=
X-Google-Smtp-Source: APBJJlFn5VR+cnfVz1hYer80K/3NNixQJwpfU/KzY+2o39e/PwrqHafpMNiEhbiPGgr7TJ9T1M42aVv9KpISdV3ua7E=
X-Received: by 2002:a25:ac20:0:b0:c42:97f9:cda6 with SMTP id
 w32-20020a25ac20000000b00c4297f9cda6mr10984031ybi.29.1688508299539; Tue, 04
 Jul 2023 15:04:59 -0700 (PDT)
MIME-Version: 1.0
References: <facbfec3-837a-51ed-85fa-31021c17d6ef@gmail.com>
 <5c7455db-4ed8-b54f-e2d5-d2811908123d@leemhuis.info> <CAJuCfpH7BOBYGEG=op09bZrh1x3WA8HMcGBXXRhe6M5RJaen5A@mail.gmail.com>
 <CAJuCfpH7t7gCV2FkctzG2eWTUVTFZD7CtD14-WuHqBqOYBo1jA@mail.gmail.com>
 <2023070359-evasive-regroup-f3b8@gregkh> <CAJuCfpF=XPpPYqp2Y1Vu-GUL=RBj4fyhXoXzjBY4EKtBnYE_eQ@mail.gmail.com>
 <2023070453-plod-swipe-cfbf@gregkh> <20230704091808.aa2ed3c11a5351d9bf217ac9@linux-foundation.org>
 <CAJuCfpE_WjRQoDT1XnvBghCH-kpqk+pfcBJGyDnK7DZLMVG5Mw@mail.gmail.com> <20230704142846.524daa14ff921ed7eb534594@linux-foundation.org>
In-Reply-To: <20230704142846.524daa14ff921ed7eb534594@linux-foundation.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 4 Jul 2023 15:04:48 -0700
Message-ID: <CAJuCfpFA3NudeyUyL65B3rnt-8sk1cnoh0uESYuS+LaDsGZu+g@mail.gmail.com>
Subject: Re: Fwd: Memory corruption in multithreaded user space program while
 calling fork
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jacob Young <jacobly.alt@gmail.com>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Memory Management <linux-mm@kvack.org>,
        Linux PowerPC <linuxppc-dev@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
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

On Tue, Jul 4, 2023 at 2:28=E2=80=AFPM Andrew Morton <akpm@linux-foundation=
.org> wrote:
>
> On Tue, 4 Jul 2023 13:22:54 -0700 Suren Baghdasaryan <surenb@google.com> =
wrote:
>
> > On Tue, Jul 4, 2023 at 9:18=E2=80=AFAM Andrew Morton <akpm@linux-founda=
tion.org> wrote:
> > >
> > > On Tue, 4 Jul 2023 09:00:19 +0100 Greg KH <gregkh@linuxfoundation.org=
> wrote:
> > >
> > > > > > > > Thanks! I'll investigate this later today. After discussing=
 with
> > > > > > > > Andrew, we would like to disable CONFIG_PER_VMA_LOCK by def=
ault until
> > > > > > > > the issue is fixed. I'll post a patch shortly.
> > > > > > >
> > > > > > > Posted at: https://lore.kernel.org/all/20230703182150.2193578=
-1-surenb@google.com/
> > > > > >
> > > > > > As that change fixes something in 6.4, why not cc: stable on it=
 as well?
> > > > >
> > > > > Sorry, I thought since per-VMA locks were introduced in 6.4 and t=
his
> > > > > patch is fixing 6.4 I didn't need to send it to stable for older
> > > > > versions. Did I miss something?
> > > >
> > > > 6.4.y is a stable kernel tree right now, so yes, it needs to be inc=
luded
> > > > there :)
> > >
> > > I'm in wait-a-few-days-mode on this.  To see if we have a backportabl=
e
> > > fix rather than disabling the feature in -stable.
> >
> > Ok, I think we have a fix posted at [2]  and it's cleanly applies to
> > 6.4.y stable branch as well. However fork() performance might slightly
> > regress, therefore disabling per-VMA locks by default for now seems to
> > be preferable even with this fix (see discussion at
> > https://lore.kernel.org/all/54cd9ffb-8f4b-003f-c2d6-3b6b0d2cb7d9@google=
.com/).
> > IOW, both [1] and [2] should be applied to 6.4.y stable. Both apply
> > cleanly and I CC'ed stable on [2]. Greg, should I send [1] separately
> > to stable@vger?
> >
> > [1] https://lore.kernel.org/all/20230703182150.2193578-1-surenb@google.=
com/
>
> This one isn't sufficient for .configs which already have
> PER_VMA_LOCK=3Dy.  Using `depends on BROKEN' would be better.
>
> > [2] https://lore.kernel.org/all/20230704200656.2526715-1-surenb@google.=
com/
> >
>
> We're still awaiting tester input on this?

Yeah, and it seems to be negative... Anyway, I'll post a dependency on BROK=
EN.

>
> I think a clean new fully-changelogged two-patch series would be the
> best way to handle this.  Please ensure that the [0/2] intro clearly
> explains what we're proposing here, and why.
>
> Also, "might slightly regress" is a bit weak.  These things are
> measurable, no?  Because a better solution would be to fix 6.4.x and
> mainline and leave it at that.
>
