Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51973718E5B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 00:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbjEaWVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 18:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjEaWVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 18:21:11 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 482079D
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 15:21:05 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-3f81ffc9065so32201cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 15:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685571664; x=1688163664;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BrD5owBPXSN90Q72mraGfuG2UGWmdUe7jEtgrSxWle8=;
        b=krY2uwkdkBMLvQI4cZ1+FFCudFdWJkUQkN86RlaSCFR+Fx/nt5V/6GmV6Iwpi4A3+h
         CqNtWNofj/v2ADt8t85VDpZONVS4ntpPSOL0GpzhjoKcpt780H3gBKii9XA44IhtfEvZ
         E48tU6eFwuUGdF+13jqlriIRWMJRGbp8L5diZkgfkybylbJ5DTVWqWarcRZvIz0Gey/8
         rtl1RTbECVuVp/k+SvfeJy5jE6RxjVAco27+g4gozjdun0Baje1vEXYsfJ8JO4LkJj8T
         lwd4K22nkK9+NJjdaIVgAbY6IgZDMusCLyVS97FS2uocaBVeCirM+6Y2Pafd60ropjNa
         2BTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685571664; x=1688163664;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BrD5owBPXSN90Q72mraGfuG2UGWmdUe7jEtgrSxWle8=;
        b=lcwRROpacFzU0CM5hXh9qoQenmrwsCSgCLWRp762klJAx9elZQcrpHvSmTHEKzlcqS
         8iUe+T9YnMK5ejoCt0g91EQYpBZTbPNjrFGKmdkY+ToJVDbOk0pxq1qqGNAvm/YBTwGK
         rxmlQzvQJ0zT4OfQeQR1dO8lOZR1tNEoEu243Z1BwbvyFvwQRNxpZIEJQwsZ3SLbI6Im
         5pMiBUgFt6iR8KNvljJAYsViPaJNxnFEwvqMUCgDl6p6K3jGvm8+60q/eysLaSQ9waXi
         W+2JZhqc78RFy2A3Q69gGq82ijtxGAyLZu2tXAvsfPU/lAlmanToA79K6EI//0OpN9ep
         lFAA==
X-Gm-Message-State: AC+VfDy93f+4RtcDcebxEoEbUIL99uytexJMic9XYuj6+KPR4ITJn+mQ
        YGPs4f6HhwlqvXy27DKpJbZuVY+ZRYgqRhXSlfL/Og==
X-Google-Smtp-Source: ACHHUZ6ljyaM1Wl/tcesG6wpIHFDDSNtLfZOCoJHv/UT+RfHhKwxzBAAaLrRqN31VikjgXWWcnuf+y5gdzXvPptkDIY=
X-Received: by 2002:a05:622a:164c:b0:3f8:23ca:ef3a with SMTP id
 y12-20020a05622a164c00b003f823caef3amr92895qtj.10.1685571664214; Wed, 31 May
 2023 15:21:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230531221302.1664613-1-yosryahmed@google.com>
In-Reply-To: <20230531221302.1664613-1-yosryahmed@google.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Wed, 31 May 2023 16:20:28 -0600
Message-ID: <CAOUHufYydC9vSAMjCajvAr4Ka2qESAtOi5ZX-iaWtHPPgD_dPQ@mail.gmail.com>
Subject: Re: [PATCH v2] mm: zswap: multiple zpools support
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Nhat Pham <nphamcs@gmail.com>,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
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

On Wed, May 31, 2023 at 4:13=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> Support using multiple zpools of the same type in zswap, for concurrency
> purposes. Add CONFIG_ZSWAP_NR_ZPOOLS_ORDER to control the number of
> zpools. The order is specific by the config rather than the absolute
> number to guarantee a power of 2. This is useful so that we can use
> deterministically link each entry to a zpool by hashing the zswap_entry
> pointer.
>
> On a setup with zswap and zsmalloc, comparing a single zpool (current
> default) to 32 zpools (by setting CONFIG_ZSWAP_NR_ZPOOLS_ORDER=3D32) show=
s
> improvements in the zsmalloc lock contention, especially on the swap out
> path.
>
> The following shows the perf analysis of the swapout path when 10
> workloads are simulatenously reclaiming and refaulting tmpfs pages.

simultaneously

> There are some improvements on the swap in path as well, but much less
> significant.

...

> ---
>  mm/Kconfig | 12 +++++++
>  mm/zswap.c | 91 ++++++++++++++++++++++++++++++++++++------------------
>  2 files changed, 73 insertions(+), 30 deletions(-)
>
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 92c30879bf67..de1da56d2c07 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -59,6 +59,18 @@ config ZSWAP_EXCLUSIVE_LOADS
>           The cost is that if the page was never dirtied and needs to be
>           swapped out again, it will be re-compressed.
>
> +config ZSWAP_NR_ZPOOLS_ORDER
> +       int "Number of zpools in zswap, as power of 2"
> +       default 0
> +       depends on ZSWAP
> +       help
> +         This options determines the number of zpools to use for zswap, =
it

option
