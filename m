Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 353C164BE72
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 22:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236652AbiLMVcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 16:32:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236256AbiLMVb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 16:31:58 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6932248D0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 13:31:56 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id w15so17161767wrl.9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 13:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+/koqlmEnYtwMnvjdPo/jyVVzdAIk2r7pe0MYh1qUgU=;
        b=AhmlOzkpEAAsHzce1WbSOiZ0NaMXR4ItFqTykkUtDA8oHCb8varZkhEAoco2CGE/ag
         IV6awrv0Tm2WwmCAWP9d21A3JJaYDmoRKG9bl7VtNd9+JyKjz66VRpo6ETjiJOEDSTMF
         qNDcVuAulhVnW0qERRGOSVbDPZGXGYLsT8JChJmtOoW92kpyv4Z4YH3CDzIrtGccRm5H
         TOSWtZ1iy2JOfNM+EtSFbMPJUs8u3J9Gw267OzxO6n8zBTDQDhexZtk7RRyFKxZluZCy
         rcf9CjALIcSC15Qegy4Ajq0N+db0Hqy7enzdiSg54ZgxropE/4NQ5EWvpmUcoc1K99OD
         +k4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+/koqlmEnYtwMnvjdPo/jyVVzdAIk2r7pe0MYh1qUgU=;
        b=fm6vm0zTQsYrRfHqERwoA2MhaosR/eoN5HikfhJURWA81O7J9IT28WhVaCBweK/jWq
         ycy1xgrrpzig0wH4kXk4kLG6SiYkE3fENcaLzdEnDezIb0Ot1iLy8s0p3/Jk6L4E2zYe
         L50IJAc1eV48xd2R1kqKaF/UZf3ep/PtJsJ/Gm4Xih/Z37YCOYNiqtSSD+0Iw83+BW00
         +FZIlWLQBdES3ZO6CjLvJe7CDeaFZz847JbQObdBsl+Lq9/jCUFnnhBeTI0/dn8nDCl9
         bEwoYmKdhuRJ1kyUhLfAk9fWpKNwvfHhZc7DZUq76J9e3SWKOO2tOGBgrFY0KVr6APR2
         VXiA==
X-Gm-Message-State: ANoB5pnypoF9f2A5VXa64vc5H2NGqXLfAq2n+X9TM+MaQn9RbSrzrVuD
        PXjwbaZQz/ilpeoBRHZ1+y2z7KGPeAmTWi/uXP2EBw==
X-Google-Smtp-Source: AA0mqf6u6lhGgX83By8MX9imp5hKBk2V1tX1MIy8IpS3+GyVYm4LHXnqv41xKCQsdhgqOBsG4sli9s6EEvbHoTPKUiE=
X-Received: by 2002:a5d:4acb:0:b0:242:78b7:6bf3 with SMTP id
 y11-20020a5d4acb000000b0024278b76bf3mr6524388wrs.375.1670967115262; Tue, 13
 Dec 2022 13:31:55 -0800 (PST)
MIME-Version: 1.0
References: <20221202045743.2639466-1-irogers@google.com> <Y5ePpm3HKts3b+gJ@fjasle.eu>
In-Reply-To: <Y5ePpm3HKts3b+gJ@fjasle.eu>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 13 Dec 2022 13:31:43 -0800
Message-ID: <CAP-5=fWjdA0Qpapfg_Vk287Skd+bNwn=5VPJcaPxqx-vkPTdzw@mail.gmail.com>
Subject: Re: [PATCH 0/5] Improvements to incremental builds
To:     Nicolas Schier <nicolas@fjasle.eu>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org, llvm@lists.linux.dev,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 12, 2022 at 12:31 PM Nicolas Schier <nicolas@fjasle.eu> wrote:
>
> On Thu, Dec 01, 2022 at 08:57:38PM -0800 Ian Rogers wrote:
> > Switching to using install_headers caused incremental builds to always
> > rebuild most targets. This was caused by the headers always being
> > reinstalled and then getting new timestamps causing dependencies to be
> > rebuilt. Follow the convention in libbpf where the install targets are
> > separated and trigger when the target isn't present or is out-of-date.
> >
> > Further, fix an issue in the perf build with libpython where
> > python/perf.so was also regenerated as the target name was incorrect.
> >
> > Ian Rogers (5):
> >   tools lib api: Add dependency test to install_headers
> >   tools lib perf: Add dependency test to install_headers
> >   tools lib subcmd: Add dependency test to install_headers
> >   tools lib symbol: Add dependency test to install_headers
> >   perf build: Fix python/perf.so library's name
> >
> >  tools/lib/api/Makefile     | 38 ++++++++++++++++++++++-----------
> >  tools/lib/perf/Makefile    | 43 +++++++++++++++++++-------------------
> >  tools/lib/subcmd/Makefile  | 23 +++++++++++---------
> >  tools/lib/symbol/Makefile  | 21 ++++++++++++-------
> >  tools/perf/Makefile.config |  4 +++-
> >  tools/perf/Makefile.perf   |  2 +-
> >  6 files changed, 79 insertions(+), 52 deletions(-)
> >
> > --
> > 2.39.0.rc0.267.gcb52ba06e7-goog
>
> Hi Ian,
>
> which tree is your patch set based on?  At least it doesn't apply on the
> current kbuild trees.
>
> Kind regards,
> Nicolas

Hi Nicolas,

for the perf tool the branch to follow is Arnaldo's perf/core one:
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/?h=3Dperf%2F=
core

I may have done this work on Arnaldo's tmp.perf/core branch, which is
used for work-in-progress merges.

Thanks,
Ian

> --
> epost|xmpp: nicolas@fjasle.eu          irc://oftc.net/nsc
> =E2=86=B3 gpg: 18ed 52db e34f 860e e9fb  c82b 7d97 0932 55a0 ce7f
>      -- frykten for herren er opphav til kunnskap --
