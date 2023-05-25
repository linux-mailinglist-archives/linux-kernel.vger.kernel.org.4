Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 232AC711AB0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 01:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235946AbjEYXbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 19:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjEYXbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 19:31:43 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE13E7
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 16:31:42 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id ca18e2360f4ac-7749357e71cso7626739f.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 16:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685057499; x=1687649499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=933jogByZjFXfrSwxO0fL0eFHLLZdKhikZdYJRLBaaU=;
        b=m0HAFNNwZ7r7aFlnWXkhEBfDHpXn7AFaFX80ZQHiQnyOD0C2sbVxD4bk1sfLY5aqyH
         zhpV/iwMLS1hrc5/YXdyIGAgsjGPXr/R7/Thh6Rrw1ILzNKciGHlHgDcQovN3U6nMThn
         60ME40ZchrFQ6aNn+T2PfQw/suebMckBSTo+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685057499; x=1687649499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=933jogByZjFXfrSwxO0fL0eFHLLZdKhikZdYJRLBaaU=;
        b=hqZ1hxsCWc62es0w5u/OxkIeA+JmODX1KEqsw5QLhUDhn3AA8cbfD3Wtr0tkKVHkPu
         0khTr/4M7/dE6cP0dGJZBkWYJFYZQyPTPBTvakN9HfQrTzYrCNwGN+oeY08f2wHt58l1
         H+NS3Y+8HKkxtHRnSP5aYUnCzdOJrb//0lk/zbetIPxrMvqYeDcZCbXkKA6UdUKyI3kb
         XIvS+UK75YgXDoNUzne6UyrenRDRU7N7k5xYmx374UUqCd/q09R746oR+2mXKoDSr3DZ
         2EP1Vz7vlyI8IXmeUwEAuyI+BzF5Sp4UxgBARN42EP7s1RMei4v/D9QQYNxsVM4B0zbI
         ZN2w==
X-Gm-Message-State: AC+VfDxJlwOBeaU1g1uGi/+Me2sPfJ5EyNGGsh59+Tg262RMCmJQg873
        IO6FAbCRhb6wfsDbgh1zxGBsSr5SV9w0oSLo9fk=
X-Google-Smtp-Source: ACHHUZ7gih4DZjJtgfzzl1adoytlYtiofll3jpDjyNQraL1uJapWeNqysiIb3MfhoQ7tlisVKx6l2g==
X-Received: by 2002:a5d:9913:0:b0:76c:6c78:5144 with SMTP id x19-20020a5d9913000000b0076c6c785144mr848311iol.17.1685057499280;
        Thu, 25 May 2023 16:31:39 -0700 (PDT)
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com. [209.85.166.174])
        by smtp.gmail.com with ESMTPSA id j4-20020a02cb04000000b0040fc9317650sm759969jap.62.2023.05.25.16.31.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 May 2023 16:31:38 -0700 (PDT)
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-33164ec77ccso58825ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 16:31:38 -0700 (PDT)
X-Received: by 2002:a92:c56f:0:b0:338:3b6a:4719 with SMTP id
 b15-20020a92c56f000000b003383b6a4719mr1722ilj.17.1685057497786; Thu, 25 May
 2023 16:31:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230523122324.1668396-1-trix@redhat.com> <CAD=FV=W5HrBFakvoX-cQ5G=4xV1upkFPZ6aSR8me+d+aCpirgg@mail.gmail.com>
 <CAD=FV=V_i5wR4oNy+xarA9e=VcgpH6i3U1uxFKtsaOe5AQX=Zw@mail.gmail.com>
In-Reply-To: <CAD=FV=V_i5wR4oNy+xarA9e=VcgpH6i3U1uxFKtsaOe5AQX=Zw@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 25 May 2023 16:31:25 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Xo4tXtT5jJtEX2tvTZBhnnrYOurNz8Uio6_1YOkLUNEQ@mail.gmail.com>
Message-ID: <CAD=FV=Xo4tXtT5jJtEX2tvTZBhnnrYOurNz8Uio6_1YOkLUNEQ@mail.gmail.com>
Subject: Re: [PATCH] watchdog: set variables watchdog_soft,hardlockup_user_enabled
 storage-class-specifier to static
To:     Tom Rix <trix@redhat.com>
Cc:     akpm@linux-foundation.org, pmladek@suse.com, kernelfans@gmail.com,
        lecopzer.chen@mediatek.com, ldufour@linux.ibm.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, May 24, 2023 at 11:05=E2=80=AFAM Doug Anderson <dianders@chromium.o=
rg> wrote:
>
> Hi,
>
> On Tue, May 23, 2023 at 7:12=E2=80=AFAM Doug Anderson <dianders@chromium.=
org> wrote:
> >
> > Hi,
> >
> > On Tue, May 23, 2023 at 5:23=E2=80=AFAM Tom Rix <trix@redhat.com> wrote=
:
> > >
> > > smatch reports
> > > kernel/watchdog.c:40:19: warning: symbol
> > >   'watchdog_hardlockup_user_enabled' was not declared. Should it be s=
tatic?
> > > kernel/watchdog.c:41:19: warning: symbol
> > >   'watchdog_softlockup_user_enabled' was not declared. Should it be s=
tatic?
> > >
> > > These variabled are only used in their defining file, so it should be=
 static.
> >
> > s/variabled/variables
> >
> > >
> > > Signed-off-by: Tom Rix <trix@redhat.com>
> > > ---
> > >  kernel/watchdog.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > While your fix is valid (thanks!), it's only half the fix.
> >
> > I wondered why smatch would have suddenly noticed this since the
> > change that touched this variable recently was only a rename. When I
> > dug deeper, I realized that the old names actually _were_ referenced
> > outside this file and my rename missed them. The reason I missed them
> > is that the only reference is an "extern" reference in
> > `include/linux/nmi.h`. The references in `include/linux/nmi.h`
> > probably should have been removed in commit dd0693fdf054 ("watchdog:
> > move watchdog sysctl interface to watchdog.c")
> >
> > ...so a more complete fix would also remove references to the old
> > names (nmi_watchdog_user_enabled and soft_watchdog_user_enabled) in
> > `include/linux/nmi.h`.
>
> FWIW, Petr has the other half of the fix at:
>
> https://lore.kernel.org/r/ZG4TW--j-DdSsUO6@alley
>
> Any chance you could send out a v2 and include that? If I don't see
> something by tomorrow morning I'll try to send out a v2 for you that
> squashes your and his changes.

Maybe it's still morning somewhere. In any case, I squashed and posted:

https://lore.kernel.org/r/20230525162822.1.I0fb41d138d158c9230573eaa37dc56a=
fa2fb14ee@changeid

Assuming that looks OK it should be considered as superseding $SUBJECT patc=
h.
