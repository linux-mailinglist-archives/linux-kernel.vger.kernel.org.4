Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2D9744ACD
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 20:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbjGASNq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 1 Jul 2023 14:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjGASNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 14:13:45 -0400
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC2D1BC6;
        Sat,  1 Jul 2023 11:13:44 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-be30cbe88b3so3164985276.1;
        Sat, 01 Jul 2023 11:13:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688235224; x=1690827224;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D4wue8LL+TgYf3QfbzqCOd+bCBl/YM/OaJxPurIPIJo=;
        b=P6XQhHL/Cna3X3S5JeufEczqNHw3UvYLg4IZmoY+Sww+64Q6oyDMRUKQ59zewJFqP7
         Eu5lodJjU7qHZ4NBMAj/U1pKkQu5VAhFsOOd8QFx3CFVxdrLnKv3UD4p5WxxxODu74Lo
         seJh4mVfsd7MdUamquvHbl01zkkfMWNMXkHVjTifiUu9wP3osPf3M1ZMp6kmNGa7A+7j
         3NAWmfGE/Aq56iV2JScQWq0eR2Dw5ShC6mSFxH0ZTIZK4kp47hz0qpvBiK+5RGeMdzON
         KiSK9D/uMU+V0hsfgVKzVZknQsps+qmLUhjvut3z0Hpp1vsE48narod0B5rz59J7duYK
         82uA==
X-Gm-Message-State: ABy/qLaIhpyiIx+wG0bGwD5F1Gv1DoE2Ts+MZvgjZIERd87m66NbtMq7
        tHZg8LTPWDnFnNkJRVh6KTdHEycNIcWemRSPFC8=
X-Google-Smtp-Source: APBJJlG/nisR8Rhl5SbxuV09n0RgTROs/hfk+Dz6JACD4Joiyoom9JiJt1Wo2x8VjFbJzTelkQK6RH5CyqFhirDQ6Ro=
X-Received: by 2002:a25:74d4:0:b0:bc9:f1a3:71d7 with SMTP id
 p203-20020a2574d4000000b00bc9f1a371d7mr5889098ybc.60.1688235223829; Sat, 01
 Jul 2023 11:13:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230630-perf-libdw-symfs-v2-1-469760dd4d5b@axis.com>
In-Reply-To: <20230630-perf-libdw-symfs-v2-1-469760dd4d5b@axis.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Sat, 1 Jul 2023 11:13:32 -0700
Message-ID: <CAM9d7cjF+g5Ww22bDviHqFa42dC1JjhGw1cM7POvTziY2wyCgA@mail.gmail.com>
Subject: Re: [PATCH v2] perf: unwind: Fix symfs with libdw
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@axis.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, Jun 30, 2023 at 2:11 AM Vincent Whitchurch
<vincent.whitchurch@axis.com> wrote:
>
> Pass the full path including the symfs (if any) to libdw.  Without this
> unwinding fails with errors like this when a symfs is used:
>
>   unwind: failed with 'No such file or directory'"
>
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> ---
> I posted this last year but didn't receive any comments.  This patch is
> still needed in current mainline so here is a rebased version, fixing
> some merge conflicts.

Sorry that you didn't get any feedback.  Looks like a real problem.

>
> Changes in v2:
> - Rebased to v6.4.
> - Link to v1: https://lore.kernel.org/lkml/20221125112743.2285759-1-vincent.whitchurch@axis.com/

In general, you'd better base your perf tools changes on the
perf/perf-tools (for fixes) or perf/perf-tools-next (for new features)
in git.kernel.org.  But it seems this change applies cleanly.

> ---
>  tools/perf/util/unwind-libdw.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/util/unwind-libdw.c b/tools/perf/util/unwind-libdw.c
> index bdccfc511b7e2..30a63d819d74e 100644
> --- a/tools/perf/util/unwind-libdw.c
> +++ b/tools/perf/util/unwind-libdw.c
> @@ -66,9 +66,13 @@ static int __report_module(struct addr_location *al, u64 ip,
>                         mod = 0;
>         }
>
> -       if (!mod)
> -               mod = dwfl_report_elf(ui->dwfl, dso->short_name, dso->long_name, -1,
> +       if (!mod) {
> +               char filename[PATH_MAX];
> +
> +               __symbol__join_symfs(filename, sizeof(filename), dso->long_name);

As __symbol__join_symfs() will have dso->long_name when symfs
is not set, I don't think it changes the behavior, so

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> +               mod = dwfl_report_elf(ui->dwfl, dso->short_name, filename, -1,
>                                       map__start(al->map) - map__pgoff(al->map), false);
> +       }
>         if (!mod) {
>                 char filename[PATH_MAX];
>
>
> ---
> base-commit: 6995e2de6891c724bfeb2db33d7b87775f913ad1
> change-id: 20230630-perf-libdw-symfs-9adb29f4df7d
>
> Best regards,
> --
> Vincent Whitchurch <vincent.whitchurch@axis.com>
>
