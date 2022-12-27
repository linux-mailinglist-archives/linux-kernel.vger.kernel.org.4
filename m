Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8A1656EA1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 21:30:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbiL0UaG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 27 Dec 2022 15:30:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiL0UaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 15:30:04 -0500
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98EBD63FE;
        Tue, 27 Dec 2022 12:30:03 -0800 (PST)
Received: by mail-il1-f173.google.com with SMTP id y2so7253290ily.5;
        Tue, 27 Dec 2022 12:30:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qmLwJ+PWqbcorDCwxmocOdJgeZdtJDX23RvZXns5ir0=;
        b=yib27nWOshfewB/9gcylNZJw/CTBxvoQrqoQDeFFsNQJHD27Zuko60Pawy7Su05/bM
         czvh2wpmNsZpqO4aNIPWjDXdZnLR5l0atN3IE+tj4uH/6vhfipWyNXZZugW4wOVhY26U
         chlQe3LJyf49V4iLKq5PVs1rf6dcgAEN8NCAHBJRoWDC4LKNroHwpJwTubRd7hapLVqX
         t0qmxV+5Tm3PqCds2hTXSe/SSKeFIDNAxnJTwZjG613q24LlJskARxuSn8lx9YTduEtl
         KHfrut6yNPfRPY21hS28sgjm+U1Ofs4h4cU60GvL1NPC63tdw8KOXfdwnZ3FlOQL9iKX
         d4Ng==
X-Gm-Message-State: AFqh2kqtLIDY2mpGKEKgbPZiuDBV9t55BRvwcQBowoJ/S5nL/62Dk3uZ
        hbu3advhM7+6M65I9oUhvZcKU1aCGXJ3Sr0RMyw=
X-Google-Smtp-Source: AMrXdXsB3MLS/ng1XsIcpRzLrbjLFZqQgfrh6A4j+8oJXGChl1QcIpglgU/EebkQKql8MqlNf5aeD7JKett5RkenJh8=
X-Received: by 2002:a92:da4f:0:b0:30b:e5e7:9854 with SMTP id
 p15-20020a92da4f000000b0030be5e79854mr1406536ilq.180.1672173002819; Tue, 27
 Dec 2022 12:30:02 -0800 (PST)
MIME-Version: 1.0
References: <20221226193517.qynxfceqgzvr4qwu@tarta.nabijaczleweli.xyz> <20221226195015.venelpockrns7uk4@tarta.nabijaczleweli.xyz>
In-Reply-To: <20221226195015.venelpockrns7uk4@tarta.nabijaczleweli.xyz>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 27 Dec 2022 12:29:51 -0800
Message-ID: <CAM9d7cgJr4-LvH_xFJfmMu_7Zj+BB_n0jyE_=CDY+gR+EhGxtg@mail.gmail.com>
Subject: Re: [PATCH 2/1] perf tools: don't include signature in version strings
To:     =?UTF-8?Q?Ahelenia_Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 26, 2022 at 11:50 AM Ahelenia Ziemiańska
<nabijaczleweli@nabijaczleweli.xyz> wrote:
>
> This explodes the build if HEAD is signed, since the generated version
> is gpg: Signature made Mon 26 Dec 2022 20:34:48 CET, then a few more
> lines, then the SHA.
>
> Signed-off-by: Ahelenia Ziemiańska <nabijaczleweli@nabijaczleweli.xyz>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> ---
>  tools/perf/Documentation/Makefile | 2 +-
>  tools/perf/util/PERF-VERSION-GEN  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/Documentation/Makefile b/tools/perf/Documentation/Makefile
> index 6e7b88917ca0..ba5d942e4c6a 100644
> --- a/tools/perf/Documentation/Makefile
> +++ b/tools/perf/Documentation/Makefile
> @@ -267,7 +267,7 @@ $(OUTPUT)%.xml : %.txt
>         $(ASCIIDOC) -b docbook -d manpage \
>                 $(ASCIIDOC_EXTRA) -aperf_version=$(PERF_VERSION) \
>                 -aperf_date=$(shell git log -1 --pretty="format:%cd" \
> -                               --date=short $<) \
> +                               --date=short --no-show-signature $<) \
>                 -o $@+ $< && \
>         mv $@+ $@
>
> diff --git a/tools/perf/util/PERF-VERSION-GEN b/tools/perf/util/PERF-VERSION-GEN
> index 3cc42821d9b3..d7dc7c28508c 100755
> --- a/tools/perf/util/PERF-VERSION-GEN
> +++ b/tools/perf/util/PERF-VERSION-GEN
> @@ -19,7 +19,7 @@ TAG=
>  if test -d ../../.git -o -f ../../.git
>  then
>         TAG=$(MAKEFLAGS= make -sC ../.. kernelversion)
> -       CID=$(git log -1 --abbrev=12 --pretty=format:"%h" 2>/dev/null) && CID="-g$CID"
> +       CID=$(git log -1 --abbrev=12 --pretty=format:"%h" --no-show-signature 2>/dev/null) && CID="-g$CID"
>  elif test -f ../../PERF-VERSION-FILE
>  then
>         TAG=$(cut -d' ' -f3 ../../PERF-VERSION-FILE | sed -e 's/\"//g')
> --
> 2.30.2
