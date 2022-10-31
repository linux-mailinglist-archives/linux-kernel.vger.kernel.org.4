Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE50613E01
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 20:03:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbiJaTDe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 31 Oct 2022 15:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiJaTDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 15:03:31 -0400
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A9A5D57;
        Mon, 31 Oct 2022 12:03:30 -0700 (PDT)
Received: by mail-oi1-f172.google.com with SMTP id r76so7197038oie.13;
        Mon, 31 Oct 2022 12:03:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PrACHCXTgI6KhnSmfV8BnCwgxOijfG3ClYDgUf87v8k=;
        b=leqGdMZyv6qASgIS6PWWIsscN1+zSrY3hMUs1/qYgyjlyB7f9W1XP1Z4qia/AZlCyP
         mlmatj8eqT3h8TwhdokcEA965Pz/MGTs52iTdwvrCXqm/AmHJO1PGPOc+8SWN9qPxEdd
         3f/D4S/ZHjhWDCaZsfqytQS18ukuL8fZY1dF/6l+Dcp0GkVzFsL1oo9a70Qk7Xx2rjvn
         RJujB5gGuG2dMn8YGsg4XJnDZcSbA20RnVe9UbS5L1XzSWYCjSaYXgivQtih73G3O5BJ
         08V9eYNgyEZ1lwreaSRvhS2Blf8PeU1n8/GrkuC51cukRndo+0YyGW92yaGrNxhrUafF
         JJcQ==
X-Gm-Message-State: ACrzQf0DtRDBhjs5SPUCEuke3rGMlMLwROoFR1DSAPZrEgWz+wkpOiJq
        cwQj+Ds84j+s1PfxGgj+vTDkPjiAv+ke38pRkdk=
X-Google-Smtp-Source: AMsMyM7Ewupj28lX4TIsCjnUHYcWcTWdhJDDfDnpoy8k9qHa7VbtJcCz6IZu37ypGDnNMxAsMHgv6HNLREFScY0LeHI=
X-Received: by 2002:aca:ac82:0:b0:359:d662:5bfb with SMTP id
 v124-20020acaac82000000b00359d6625bfbmr7726817oie.218.1667243009659; Mon, 31
 Oct 2022 12:03:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220415050003.3257645-1-mattst88@gmail.com> <20221019232952.2212729-1-mattst88@gmail.com>
In-Reply-To: <20221019232952.2212729-1-mattst88@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 31 Oct 2022 12:03:18 -0700
Message-ID: <CAM9d7cgxOmtw=djorzjBnfqgLm04r9bVoGm31C8uMA-SRQTa4w@mail.gmail.com>
Subject: Re: [PATCH v2] tools: port perf ui from GTK 2 to GTK 3
To:     Matt Turner <mattst88@gmail.com>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Jelle van der Waa <jvanderwaa@redhat.com>
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

Hello,

On Wed, Oct 19, 2022 at 4:30 PM Matt Turner <mattst88@gmail.com> wrote:
>
> From: Jelle van der Waa <jvanderwaa@redhat.com>
>
> GTK 2 is a legacy API and the newer version is GTK 3 which changes a few
> API functions. gtk_tree_view_set_rules_hint is no longer required since
> theme's are now responsible to handle this, gtk_vbox_new is deprecated
> and replaced by passing the orientation to gtk_box_new. Apart from these
> changes the accessing of the screen changed in GTK which requires using
> new functions for getting geometry. Lastly the GTK_STOCK_OK define is
> deprecated in GTK 3.
>
> Signed-off-by: Jelle van der Waa <jvanderwaa@redhat.com>
> Signed-off-by: Matt Turner <mattst88@gmail.com>
> ---
> Originally sent in 2019. I've rebased it and given it a test.
>
> One problem I've noticed is that C++ symbol names are often broken.
> E.g.:
>
> (perf:3254940): Gtk-WARNING **: 21:47:46.663: Failed to set text from
> markup due to error parsing markup: Error on line 1 char 95:
> “std::char_traits<char” is not a valid name: “<”
>
> Presumably we need to call g_markup_escape_text() somewhere, but I
> struggled to find the right place.
>
> Without the patch, the GTK-2 version repeatedly segfaults, so this is an
> improvement regardless.

Thanks for working on this.

>
> v2: Dropped changes to test-all.c. I don't know how to build that
>     apparently.
>
>  tools/build/Makefile.feature                  |  5 +++--
>  tools/build/feature/Makefile                  | 12 +++++-----
>  ...est-gtk2-infobar.c => test-gtk3-infobar.c} |  0
>  .../feature/{test-gtk2.c => test-gtk3.c}      |  0
>  tools/perf/Documentation/perf-report.txt      |  2 +-
>  tools/perf/Makefile                           |  2 +-
>  tools/perf/Makefile.config                    | 22 +++++++++----------
>  tools/perf/Makefile.perf                      |  6 ++---
>  tools/perf/builtin-report.c                   |  2 +-
>  tools/perf/builtin-version.c                  |  1 +
>  tools/perf/tests/make                         | 12 +++++-----
>  tools/perf/ui/gtk/annotate.c                  |  2 +-
>  tools/perf/ui/gtk/browser.c                   | 16 ++++++++------
>  tools/perf/ui/gtk/hists.c                     |  6 +----
>  tools/perf/ui/gtk/progress.c                  |  2 +-
>  tools/perf/ui/setup.c                         |  2 +-
>  16 files changed, 46 insertions(+), 46 deletions(-)
>  rename tools/build/feature/{test-gtk2-infobar.c => test-gtk3-infobar.c} (100%)
>  rename tools/build/feature/{test-gtk2.c => test-gtk3.c} (100%)
>
> diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
> index 57619f240b56..967b8be96b65 100644
> --- a/tools/build/Makefile.feature
> +++ b/tools/build/Makefile.feature
> @@ -80,8 +80,8 @@ FEATURE_TESTS_EXTRA :=                  \
>           compile-32                     \
>           compile-x32                    \
>           cplus-demangle                 \
> -         gtk2                           \
> -         gtk2-infobar                   \
> +         gtk3                           \
> +         gtk3-infobar                   \

I don't think gtk3-inforbar check is necessary anymore.  IIRC the infobar
was introduced in the middle of gtk2 so it needs to check if the current
version supports it or not.  But I guess gtk3 should support it by default.

Thanks,
Namhyung


>           hello                          \
>           libbabeltrace                  \
>           libbfd-liberty                 \
> @@ -119,6 +119,7 @@ FEATURE_DISPLAY ?=              \
>           dwarf                  \
>           dwarf_getlocations     \
>           glibc                  \
> +         gtk3                   \
>           libbfd                 \
>           libbfd-buildid                \
>           libcap                 \
