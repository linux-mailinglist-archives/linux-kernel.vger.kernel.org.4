Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AEF574625B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 20:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbjGCS1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 14:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbjGCS1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 14:27:32 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D9E9E3
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 11:27:31 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-be49ca27e1fso5274143276.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 11:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688408851; x=1691000851;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0isKEjHX7MEXue9Pz1Ccur/ZC63GmueF0VlBtGm8EoI=;
        b=w1rSlYr2bJam65DS0lPRCw3JfxRfPJVIeGkLawuH0QVACpcv1cEbmN3yS/9d9Jhd2y
         gWuA/6yRdVojMzVcjWIoMQnCRFrBdHsUCri4YQmwmCGqvmVgnRUjcImEV42CF9p2HNUt
         RNIJjoJMpBM8Yqs72KNbG+Q7Vclm2QBRCgMhwvmKmKBAHfyzQgGK9V+bBOc5xngTKVY+
         R4t792TUWP12OJYQgjh6dTgC1nO4V6mOoZVzPzmVhbvkDRUxjx7H8hIFK+KllI/p1SSS
         NKySvyUZum+exg7sN4tpowuv7DwRGfJ+F1AbKfbFzZFthr0ez+mTc3XlVxhYkdNO0qgi
         O3+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688408851; x=1691000851;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0isKEjHX7MEXue9Pz1Ccur/ZC63GmueF0VlBtGm8EoI=;
        b=WW/9D/Lzxhk4FPJwi3HwrxDlJ09rR5LH3wYSsLkOjkH0VtRFnhpQvyEjaT18qGGZlC
         iOWf+fIbyDHDQ9rJd7pnvASy1dgQ+1zW96NFpHoimaf1Dfyy15OFpjINvvvzrWX11JBn
         4Sui/FjoBswp/jTk3d9Pfnpy7QLel0Qk1nwa802yqT6OJlFJTD1n0wZQnNApG53AEhwW
         OFUw0xNpMOwLygojBfD19Sg9gJGONmb/FaEC1TD31KstxP67fmPmwUAYnz0HsHpBo7CC
         dQn80oe9b5JBFsZwvsAlEefoPfHCto9ys5vmGR2s01fRHy84XTg4VGTTBsT6A4P4smlb
         LWrA==
X-Gm-Message-State: ABy/qLar57Z7EnOf41wPPzoyB1Xd4NdP0tRzlT0BxbbLCtcWHDPC0qWj
        3qbuO39BePdib5RVTrAzn6jVFqSxWryCtbTFFne1LWw+B26fvlrtIqqFoA==
X-Google-Smtp-Source: APBJJlEcsiSJampqWvnjg3CAmKUIwmDnEsqWjNRvFLw+nAO0EpYIPr1eboqaZF2mndFRhRVNL+SZzDgLqiS3KzAbWO4=
X-Received: by 2002:a05:6902:603:b0:c40:e589:7c09 with SMTP id
 d3-20020a056902060300b00c40e5897c09mr9113458ybt.26.1688408850615; Mon, 03 Jul
 2023 11:27:30 -0700 (PDT)
MIME-Version: 1.0
References: <facbfec3-837a-51ed-85fa-31021c17d6ef@gmail.com>
 <5c7455db-4ed8-b54f-e2d5-d2811908123d@leemhuis.info> <CAJuCfpH7BOBYGEG=op09bZrh1x3WA8HMcGBXXRhe6M5RJaen5A@mail.gmail.com>
In-Reply-To: <CAJuCfpH7BOBYGEG=op09bZrh1x3WA8HMcGBXXRhe6M5RJaen5A@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 3 Jul 2023 11:27:19 -0700
Message-ID: <CAJuCfpH7t7gCV2FkctzG2eWTUVTFZD7CtD14-WuHqBqOYBo1jA@mail.gmail.com>
Subject: Re: Fwd: Memory corruption in multithreaded user space program while
 calling fork
To:     Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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

On Mon, Jul 3, 2023 at 11:08=E2=80=AFAM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Mon, Jul 3, 2023 at 2:53=E2=80=AFAM Linux regression tracking (Thorste=
n
> Leemhuis) <regressions@leemhuis.info> wrote:
> >
> > On 02.07.23 14:27, Bagas Sanjaya wrote:
> > > I notice a regression report on Bugzilla [1]. Quoting from it:
> > >
> > >> After upgrading to kernel version 6.4.0 from 6.3.9, I noticed freque=
nt but random crashes in a user space program.  After a lot of reduction, I=
 have come up with the following reproducer program:
> > > [...]
> > >> After tuning the various parameters for my computer, exit code 2, wh=
ich indicates that memory corruption was detected, occurs approximately 99%=
 of the time.  Exit code 1, which occurs approximately 1% of the time, mean=
s it ran out of statically-allocated memory before reproducing the issue, a=
nd increasing the memory usage any more only leads to diminishing returns. =
 There is also something like a 0.1% chance that it segfaults due to memory=
 corruption elsewhere than in the statically-allocated buffer.
> > >>
> > >> With this reproducer in hand, I was able to perform the following bi=
section:
> > > [...]
> > >
> > > See Bugzilla for the full thread.
> >
> > Additional details from
> > https://bugzilla.kernel.org/show_bug.cgi?id=3D217624#c5 :
> >
> > ```
> > I can confirm that v6.4 with 0bff0aaea03e2a3ed6bfa302155cca8a432a1829
> > reverted no longer causes any memory corruption with either my
> > reproducer or the original program.
> > ```
> >
> > FWIW: 0bff0aaea03 ("x86/mm: try VMA lock-based page fault handling
> > first") [merged for v6.4-rc1, authored by Suren Baghdasaryan [already C=
Ced]]
> >
> > That's the same commit that causes build problems with go:
> >
> > https://lore.kernel.org/all/dbdef34c-3a07-5951-e1ae-e9c6e3cdf51b@kernel=
.org/
>
> Thanks! I'll investigate this later today. After discussing with
> Andrew, we would like to disable CONFIG_PER_VMA_LOCK by default until
> the issue is fixed. I'll post a patch shortly.

Posted at: https://lore.kernel.org/all/20230703182150.2193578-1-surenb@goog=
le.com/

>
> >
> > Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat=
)
> > --
> > Everything you wanna know about Linux kernel regression tracking:
> > https://linux-regtracking.leemhuis.info/about/#tldr
> > If I did something stupid, please tell me, as explained on that page.
> >
> > #regzbot introduced: 0bff0aaea03e2a3
