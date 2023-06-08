Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7EAC7289F8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 23:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232938AbjFHVJb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 8 Jun 2023 17:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237021AbjFHVJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 17:09:27 -0400
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A88BB30D3;
        Thu,  8 Jun 2023 14:09:18 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-bacfa9fa329so1174508276.0;
        Thu, 08 Jun 2023 14:09:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686258558; x=1688850558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RSyw6qf+FqNzsYEWzuRM5QiQmAyiFWZ9iK/UDhMvxuA=;
        b=etsNKmEgF8KQfORpsEkKmYOkjsActJ0bOOB131/OGGz4I6+pXj71WZnVvD5M00ZgvE
         5QhkMsKP3UWWt4rhKKkKrSFc+iWqZEEruQK+ImoEqLBqVufPq6SRGcime4EFoM67Up6Y
         EBlzTbb+CMjBX9XcBlkVNb+gGGq4S4v/I3zZ85vwaIyavneqKG38CEjdqXVbMV8jqWcc
         MATf3UZAcJcWbNbsifYWTAMmQQk52pR0vpBOq035BU+JNJ9wvRD5zuVoc3zF9zgQD42l
         wdRsvL1BwJNAZPh5NgmcjiP9Phg6DFfO9vfdWmSPImSxLvvTRvB8WX2PHSpjKKod/Tfg
         41gg==
X-Gm-Message-State: AC+VfDwpRk8wkJm8voc8IE1vFqzZb9F4Ymptq96mC8N8LugITgtCodpB
        NgF42/FxPB0ZXuOs6mlo9sssKaWmDGSAGur14ObmqW0R
X-Google-Smtp-Source: ACHHUZ5t61NXy4P694dVP8XqYDtJ1I50buDty/yh8k/r9svoNIcqgPJcNQB3qlQ4h8YxC0kKH4hjTVxEv2qrwNXyKf0=
X-Received: by 2002:a25:37d2:0:b0:ba7:7cbe:1080 with SMTP id
 e201-20020a2537d2000000b00ba77cbe1080mr736104yba.62.1686258557687; Thu, 08
 Jun 2023 14:09:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230608084407.140323-1-asavkov@redhat.com>
In-Reply-To: <20230608084407.140323-1-asavkov@redhat.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 8 Jun 2023 14:09:06 -0700
Message-ID: <CAM9d7cgvtuqMeQx8ehLCLw_Ur9Ju-VzDrakzFJxnxvFjdsWk_g@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] perf tools: annotation browser from c2c tui
To:     Artem Savkov <asavkov@redhat.com>
Cc:     linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org
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

On Thu, Jun 8, 2023 at 1:44 AM Artem Savkov <asavkov@redhat.com> wrote:
>
> These patches add ability to start annotation browser from c2c report
> tui. The idea comes from Arnaldo's "Profiling Data Structures" talk [1].

I was thinking about how it works and realized that it didn't collect
samples by symbol.  Then I'm not sure if the result is meaningful.
I think it'd show a random symbol that touched the cache line
first.  The same cache line can be accessed from other locations
but it cannot know where they are.

Also different instructions in a function (symbol) would access a
different cache line.  The annotate output just shows any memory
access.  So it might be good to check the instruction at the point
but others should not be considered related.

Hmm.. I suspect even the same instruction will hit the different
cache lines at different times.  Then probably the annotation
won't work well in terms of correlating cache lines.

Thanks,
Namhyung

>
> [1]: http://vger.kernel.org/~acme/prez/linux-plumbers-2022/
>
> v1->v2: Addressed comments from Namhyung Kim
> - No longer saving evsel for each hist entry, using evlist__first
>   instead.
> - Factored out preparations to call annotation browser to do_annotate()
>   function
> - Other small fixes and adjustments.
>
> Artem Savkov (2):
>   perf util: move symbol__new_unresolved() to util/symbol.c
>   perf tools: allow running annotation browser from c2c-report
>
>  tools/perf/builtin-c2c.c       | 73 +++++++++++++++++++++++++++++++---
>  tools/perf/ui/browsers/hists.c | 22 ----------
>  tools/perf/util/symbol.c       | 22 ++++++++++
>  tools/perf/util/symbol.h       |  1 +
>  4 files changed, 91 insertions(+), 27 deletions(-)
>
> --
> 2.40.1
>
