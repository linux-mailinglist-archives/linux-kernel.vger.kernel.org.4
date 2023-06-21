Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32448737BB7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 09:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbjFUHEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 03:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjFUHEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 03:04:05 -0400
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A24ECDD
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 00:04:04 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id a1e0cc1a2514c-78cdb90aa66so1998535241.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 00:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687331044; x=1689923044;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DZkHfp4tV94i9NTvQ3Qk2n4CpRzZ00rCA1jUemN32yM=;
        b=VLd89J2VBCLEliMIUHRzbTXL6Yj9ED3LW04MQzGs/m8Jy4Fuewd0gpLoDMZnA3tH6x
         QtbgclUdAir0CRVqxOXax9Zem2XazRWk4IR7nEvjFjQPSULPP1wIEqUxVJEjhr6t9xLX
         6ml5U0rR3U3q5cnjamGxpW75HHJpeaSb/Ff6jDdHhmFEjDRlU+X6ZbDP1xVQC+1jG7xg
         MV2NVBwYbUjfUmEz63E50C24e6XM5jq1WG4Ubi1RAeJnxbGyGn6ZDGH8zyzthqu6nWs0
         f8AnsQZ8Yx4RmbH/9XdSTaipJS4IN7yTIwuurcavxZR1sth/ZVmIZNeQLJkHRFseajOo
         UqSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687331044; x=1689923044;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DZkHfp4tV94i9NTvQ3Qk2n4CpRzZ00rCA1jUemN32yM=;
        b=iUV5oK8Z8ov7i3sM8jMeulT4ptkJt98fnzV59GA3SQbcOlqZSGuVqp8Sv9WeKFSEVU
         Gw6U+XKKOFUlnQQjFQ6i1zSgQ6/ps2P5HTBSDxLniUJbhqdHJsI55ahY2RCCp/1YKt68
         WrnI40kFpzWNjYkVlwor6b6f2u62nuv0R4ZHYT5pQkfoJeK+dE7fMuCG5CtKn2KN6VWJ
         fyX8mwL+sTYXW3sZh5Uz+QyAQiRnU5kouiGKFanriUtoR+fpSsXkC+aoJcLWE4MlMfbR
         SEesFE/MlWpGpbizY0eWtunZ7mJZL/FtpjNPqSODxFc0w7WlYt4ynxLTLh8ECUs0coVv
         ETLA==
X-Gm-Message-State: AC+VfDw+42wzaCjVskYWZuPkdKCgG50Jrk86/4ojiaLMrgKtY4sy2zwd
        dg1xCP+aZbJXPNf+R3WKjEIZHlZx7CD0h8Q65HA=
X-Google-Smtp-Source: ACHHUZ43ttIuFJA0tq13ftbFfQCC7hv4/NWWz3lHgpfWG5y1ZXedfh+hUl6GzKehxFC68R0bgIrZhJZLqcQ3LN6Is3s=
X-Received: by 2002:a67:f297:0:b0:440:bf7f:f46f with SMTP id
 m23-20020a67f297000000b00440bf7ff46fmr3858606vsk.4.1687331043641; Wed, 21 Jun
 2023 00:04:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230607195143.1473802-1-yosryahmed@google.com> <ZJKgThENoFlkJQmB@fedora>
In-Reply-To: <ZJKgThENoFlkJQmB@fedora>
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
Date:   Wed, 21 Jun 2023 16:03:52 +0900
Message-ID: <CAB=+i9TyX11=30yNiEq5UKfLJ9aBRuJEF6yQAQAnybhzkReLSg@mail.gmail.com>
Subject: Re: [BUG mm-unstable] "kernel BUG at mm/swap.c:393!" on commit b9c91c43412f2e
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Nhat Pham <nphamcs@gmail.com>,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        Yu Zhao <yuzhao@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 4:01=E2=80=AFPM Hyeonggon Yoo <42.hyeyoo@gmail.com>=
 wrote:
>
> On Wed, Jun 07, 2023 at 07:51:43PM +0000, Yosry Ahmed wrote:
> > Commit 71024cb4a0bf ("frontswap: remove frontswap_tmem_exclusive_gets")
> > removed support for exclusive loads from frontswap as it was not used.
> > Bring back exclusive loads support to frontswap by adding an "exclusive=
"
> > output parameter to frontswap_ops->load.
> >
> > On the zswap side, add a module parameter to enable/disable exclusive
> > loads, and a config option to control the boot default value.
> > Refactor zswap entry invalidation in zswap_frontswap_invalidate_page()
> > into zswap_invalidate_entry() to reuse it in zswap_frontswap_load() if
> > exclusive loads are enabled.
> >
> > With exclusive loads, we avoid having two copies of the same page in
> > memory (compressed & uncompressed) after faulting it in from zswap. On
> > the other hand, if the page is to be reclaimed again without being
> > dirtied, it will be re-compressed. Compression is not usually slow, and
> > a page that was just faulted in is less likely to be reclaimed again
> > soon.
> >
> > Suggested-by: Yu Zhao <yuzhao@google.com>
> > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> > ---
> >
> > v1 -> v2:
> > - Add a module parameter to control whether exclusive loads are enabled
> >   or not, the config option now controls the default boot value instead=
.
> >   Replaced frontswap_ops->exclusive_loads by an output parameter to
> >   frontswap_ops->load() (Johannes Weiner).
> > ---
>
> Hi Yosry, I was testing the latest mm-unstable and encountered a bug.
> It was bisectable and this is the first bad commit.

Oh, I forgot to mention how I was able to reproduce this:

$ stress-ng --bigheap 12
(my box have 24 cores)

>
> Attached config file and bisect log.
> The oops message is available at:
>
> https://social.kernel.org/media/eace06d71655b3cc76411366573e4a8ce240ad65b=
8fd20977d7c73eec9dc2253.jpg
>
> (the head commit is b9c91c43412f2e07 "mm: zswap: support exclusive loads"=
)
> (it's an image because I tested it on real machine)
>
>
> This is what I have as swap space:
>
> $ cat /proc/swaps
> Filename                                Type            Size            U=
sed            Priority
> /var/swap                               file            134217724       0=
               -2
> /dev/zram0                              partition       8388604         0=
               100
