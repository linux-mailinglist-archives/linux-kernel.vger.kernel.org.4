Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B419070FD75
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 20:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236708AbjEXSFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 14:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236780AbjEXSFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 14:05:32 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94EDD3
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 11:05:28 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id e9e14a558f8ab-333eb36e453so2596155ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 11:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684951527; x=1687543527;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=44b0PKgEdAmvPMK/xx0MGvfJ3YhuyNSIZwFS/bsN7rE=;
        b=NCjxBpJKdVXzBcNpeQNaKFqGZ3CcKOMSs8JIQn8I72fsb3CUlC48hmAWn+M+pcjv63
         tCbPiacvRhMrRSaqWDD7TwGCNTsyH0A4FmVAbqlgSkWm/1M/pG11nRztUdsIrVb3UwQl
         uf3jtK3oAfw9aH0aC9QEygAHnWAbm8N26Dbw4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684951527; x=1687543527;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=44b0PKgEdAmvPMK/xx0MGvfJ3YhuyNSIZwFS/bsN7rE=;
        b=Ts9QIJyZW0suYxpHDw2SnEbooFwCiIKdckQZojtPrEwNX3ved6hApLaZj9qaadFutV
         sMrg0i1m9zBcBni81OFzEXuhJnv4FTFFlv5QSHf7+m2ZyA+m+hAI/TnM4rKJpZeHwUWz
         FH9aob7pukcgB2iw28moGrikDlPCS6Tm5TlGrzHsxQC5ePk8D3LFfGP/3SK5y+T3hPFN
         k/eTeApfpSIFlIFg4AQM3uXBKp6Q75NOpy+YEndgnwZA76CtUioQO+xgzHhFCYtUwVmi
         RAG+m4L0VB0HEYW1l5KAKSTAfYG5B/a2qZChx44mH6BNDuMypgkUDvM9zxBm0ILb/gE9
         DH8Q==
X-Gm-Message-State: AC+VfDxkOI2sull/4meduPKxPEZvt42pawyvzFgDoMrXG8Ci3h1s3R1S
        nQNlauyAQOS6fZ/ExbyXjko2N7Uqz58ZZHdDzHU=
X-Google-Smtp-Source: ACHHUZ50YLv5VDfXoL4sGcFW6eJh55VfsDILgLTeMct2fcavl/yxqPXT7W71gjrgmhi/m/qmFTeMbQ==
X-Received: by 2002:a92:c00f:0:b0:338:17de:8e5a with SMTP id q15-20020a92c00f000000b0033817de8e5amr11868540ild.22.1684951527524;
        Wed, 24 May 2023 11:05:27 -0700 (PDT)
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com. [209.85.166.181])
        by smtp.gmail.com with ESMTPSA id c2-20020a92cf42000000b003312915e615sm180323ilr.28.2023.05.24.11.05.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 May 2023 11:05:26 -0700 (PDT)
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-33164ec77ccso15595ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 11:05:26 -0700 (PDT)
X-Received: by 2002:a92:cd8b:0:b0:32e:561d:b42d with SMTP id
 r11-20020a92cd8b000000b0032e561db42dmr12623ilb.16.1684951526390; Wed, 24 May
 2023 11:05:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230523122324.1668396-1-trix@redhat.com> <CAD=FV=W5HrBFakvoX-cQ5G=4xV1upkFPZ6aSR8me+d+aCpirgg@mail.gmail.com>
In-Reply-To: <CAD=FV=W5HrBFakvoX-cQ5G=4xV1upkFPZ6aSR8me+d+aCpirgg@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 24 May 2023 11:05:15 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V_i5wR4oNy+xarA9e=VcgpH6i3U1uxFKtsaOe5AQX=Zw@mail.gmail.com>
Message-ID: <CAD=FV=V_i5wR4oNy+xarA9e=VcgpH6i3U1uxFKtsaOe5AQX=Zw@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, May 23, 2023 at 7:12=E2=80=AFAM Doug Anderson <dianders@chromium.or=
g> wrote:
>
> Hi,
>
> On Tue, May 23, 2023 at 5:23=E2=80=AFAM Tom Rix <trix@redhat.com> wrote:
> >
> > smatch reports
> > kernel/watchdog.c:40:19: warning: symbol
> >   'watchdog_hardlockup_user_enabled' was not declared. Should it be sta=
tic?
> > kernel/watchdog.c:41:19: warning: symbol
> >   'watchdog_softlockup_user_enabled' was not declared. Should it be sta=
tic?
> >
> > These variabled are only used in their defining file, so it should be s=
tatic.
>
> s/variabled/variables
>
> >
> > Signed-off-by: Tom Rix <trix@redhat.com>
> > ---
> >  kernel/watchdog.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
>
> While your fix is valid (thanks!), it's only half the fix.
>
> I wondered why smatch would have suddenly noticed this since the
> change that touched this variable recently was only a rename. When I
> dug deeper, I realized that the old names actually _were_ referenced
> outside this file and my rename missed them. The reason I missed them
> is that the only reference is an "extern" reference in
> `include/linux/nmi.h`. The references in `include/linux/nmi.h`
> probably should have been removed in commit dd0693fdf054 ("watchdog:
> move watchdog sysctl interface to watchdog.c")
>
> ...so a more complete fix would also remove references to the old
> names (nmi_watchdog_user_enabled and soft_watchdog_user_enabled) in
> `include/linux/nmi.h`.

FWIW, Petr has the other half of the fix at:

https://lore.kernel.org/r/ZG4TW--j-DdSsUO6@alley

Any chance you could send out a v2 and include that? If I don't see
something by tomorrow morning I'll try to send out a v2 for you that
squashes your and his changes.

-Doug
