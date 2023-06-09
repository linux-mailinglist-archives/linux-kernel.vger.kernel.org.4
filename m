Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6E17728FFD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 08:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237663AbjFIGe4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 9 Jun 2023 02:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbjFIGey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 02:34:54 -0400
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F6E1BDF;
        Thu,  8 Jun 2023 23:34:53 -0700 (PDT)
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-3f9b7345fb1so11342121cf.1;
        Thu, 08 Jun 2023 23:34:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686292492; x=1688884492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=757w/GYtIJVf5G6kf1fLOjt4zEb+gvb0ojwbx25/leo=;
        b=d006ztU0hglG7pfECd2hAFCBq+OIN6ythZ/PJo0yErpl2PrTOFxvYv5PvNs8lrEDXN
         p6ww89YjA9ATOpTMMqaqaOqhwPDSOWoBKxOulzOpjeWnqtT5BoVc7ZfURbVP5NEpsFpP
         Qt3qGfR+AY4FApxdCwNxO9b+qsVEEa/cIUlcRx5lqOXRlOCv2pXTPOfnZmWsv0/floag
         2nq+mHU8PIiEW1DJUBl89UsWHC2avIJMm2OY55WxnGWI0N6981S0S+OL7OARv7NZHUbx
         AQsk0MJFb/THZFRdk0jLL5hWhAMfl0TM5UEx+hsncZAmtSZiiGMMCzUYsr9hM4DFM1lS
         4fIA==
X-Gm-Message-State: AC+VfDy4gWvVcplAtjgzkLEBBz53lu2Diws0DKZl7fZyZKHhjsoI86Os
        JtpFxkBihiL5yCNg3NKkFpk3/CsO6KZZtmyX2WU=
X-Google-Smtp-Source: ACHHUZ6pGhYq+nvvED5701ruXEf7KkgV0ZetViE2VkdBcVaZmnpIaMd5etFPL191/svPX4AFZPB/1htDKdd3nxfFRTg=
X-Received: by 2002:ac8:5b96:0:b0:3f7:fe24:d8c1 with SMTP id
 a22-20020ac85b96000000b003f7fe24d8c1mr820378qta.12.1686292492187; Thu, 08 Jun
 2023 23:34:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230609043240.43890-1-irogers@google.com>
In-Reply-To: <20230609043240.43890-1-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 8 Jun 2023 23:34:41 -0700
Message-ID: <CAM9d7ciyUQd4YBCxNsh_9CTCvNC5BQwezDcvrxM5M0fqS4+4MQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Bring back vmlinux.h generation
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@arm.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Yang Jihong <yangjihong1@huawei.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
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

Hi Ian,

On Thu, Jun 8, 2023 at 9:32 PM Ian Rogers <irogers@google.com> wrote:
>
> Commit 760ebc45746b ("perf lock contention: Add empty 'struct rq' to
> satisfy libbpf 'runqueue' type verification") inadvertently created a
> declaration of 'struct rq' that conflicted with a generated
> vmlinux.h's:
>
> ```
> util/bpf_skel/lock_contention.bpf.c:419:8: error: redefinition of 'rq'
> struct rq {};
>        ^
> /tmp/perf/util/bpf_skel/.tmp/../vmlinux.h:45630:8: note: previous definition is here
> struct rq {
>        ^
> 1 error generated.
> ```
>
> Fix the issue by moving the declaration to vmlinux.h. So this can't
> happen again, bring back build support for generating vmlinux.h then
> add build tests.
>
> v3. Address Namhyung's comments on filtering ELF files with readelf.
> v2. Rebase on perf-tools-next. Add Andrii's acked-by. Add patch to
>     filter out kernels that lack a .BTF section and cause the build to
>     break.
>
> Ian Rogers (4):
>   perf build: Add ability to build with a generated vmlinux.h
>   perf bpf: Move the declaration of struct rq
>   perf test: Add build tests for BUILD_BPF_SKEL
>   perf build: Filter out BTF sources without a .BTF section

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


>
>  tools/perf/Makefile.config                    |  4 ++
>  tools/perf/Makefile.perf                      | 39 ++++++++++++++++++-
>  tools/perf/tests/make                         |  4 ++
>  tools/perf/util/bpf_skel/.gitignore           |  1 +
>  .../perf/util/bpf_skel/lock_contention.bpf.c  |  2 -
>  .../util/bpf_skel/{ => vmlinux}/vmlinux.h     | 10 +++++
>  6 files changed, 57 insertions(+), 3 deletions(-)
>  rename tools/perf/util/bpf_skel/{ => vmlinux}/vmlinux.h (90%)
>
> --
> 2.41.0.162.gfafddb0af9-goog
>
