Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9287A5FC8DA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 18:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbiJLQGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 12:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiJLQGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 12:06:51 -0400
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2950D895EE;
        Wed, 12 Oct 2022 09:06:50 -0700 (PDT)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-1364357a691so13464056fac.7;
        Wed, 12 Oct 2022 09:06:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ukt7vGP6CsiYiD8LNPDRe24U+aWDDsk6nJCXZF6ming=;
        b=dhVePhRzLkFbgYy/8Cn56wTqmpOCk9ULCSbzIcYNZPuwTV2gHyPl2Kfp/jHzxOfqSA
         siu4oJbkpu3JkwNhvtn7Q0tGnfBBohqbjjSNyTaICuUyp+lVNZUeyvhLZ0d7iomc7e3u
         IHez4gGmKMc1fGPn5b5gKchBcysdxGZgdNT5/nUlU1wRsXxoLoverwgT6w1MjfR8y+sx
         dEOVOQFdTZmctZb2hVS5snkiciXnaIgJJUq3CIM7mWLveqC55gclr9e0bc1B7IbIKnH5
         HZ+KYooVhawb/MhDoIqgrzoVy00dCDawMdtBJyzIxSodBxRg4Z/13UtbcmDT4a0zO0+V
         dE5w==
X-Gm-Message-State: ACrzQf1mJTE81Yk8AofBxLwz6SBOUSNhGj+RGRbj/rJ2s+O7fMjlloUc
        KV/z21NDZoDrbKi6cDdOLzEsds/rZ5vH8YuPGHvxOvCzMhQ=
X-Google-Smtp-Source: AMsMyM61djge6d8lMJXZNa7E55BAzX+NGb7o2YesC2pZscEK25B3HBT5xy24+E4kk+ZVjitjMUsWqO+mYGSgOkxQfMk=
X-Received: by 2002:a05:6870:82ac:b0:133:34b:6f10 with SMTP id
 q44-20020a05687082ac00b00133034b6f10mr2933403oae.218.1665590799120; Wed, 12
 Oct 2022 09:06:39 -0700 (PDT)
MIME-Version: 1.0
References: <20221012094633.21669-1-james.clark@arm.com> <20221012094633.21669-2-james.clark@arm.com>
In-Reply-To: <20221012094633.21669-2-james.clark@arm.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 12 Oct 2022 09:06:27 -0700
Message-ID: <CAM9d7ci-o4fzBLaLB5pcKA2=GAUVFt8PJofnuy6RjG7bibJE-w@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] perf test: Fix attr tests for PERF_FORMAT_LOST
To:     James Clark <james.clark@arm.com>
Cc:     linux-perf-users <linux-perf-users@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Oct 12, 2022 at 2:47 AM James Clark <james.clark@arm.com> wrote:
>
> Since PERF_FORMAT_LOST was added, the default read format has that bit
> set, so add it to the tests. Keep the old value as well so that the test
> still passes on older kernels.
>
> This fixes the following failure:
>
>   expected read_format=0|4, got 20
>   FAILED './tests/attr/test-record-C0' - match failure
>
> Fixes: 85b425f31c88 ("perf record: Set PERF_FORMAT_LOST by default")
> Signed-off-by: James Clark <james.clark@arm.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> ---
>  tools/perf/tests/attr/base-record                | 2 +-
>  tools/perf/tests/attr/system-wide-dummy          | 2 +-
>  tools/perf/tests/attr/test-record-group          | 4 ++--
>  tools/perf/tests/attr/test-record-group-sampling | 6 +++---
>  tools/perf/tests/attr/test-record-group1         | 4 ++--
>  tools/perf/tests/attr/test-record-group2         | 4 ++--
>  6 files changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/tools/perf/tests/attr/base-record b/tools/perf/tests/attr/base-record
> index 8c10955eff93..3ef07a12aa14 100644
> --- a/tools/perf/tests/attr/base-record
> +++ b/tools/perf/tests/attr/base-record
> @@ -9,7 +9,7 @@ size=128
>  config=0
>  sample_period=*
>  sample_type=263
> -read_format=0|4
> +read_format=0|4|20
>  disabled=1
>  inherit=1
>  pinned=0
> diff --git a/tools/perf/tests/attr/system-wide-dummy b/tools/perf/tests/attr/system-wide-dummy
> index 86a15dd359d9..8fec06eda5f9 100644
> --- a/tools/perf/tests/attr/system-wide-dummy
> +++ b/tools/perf/tests/attr/system-wide-dummy
> @@ -11,7 +11,7 @@ size=128
>  config=9
>  sample_period=4000
>  sample_type=455
> -read_format=4
> +read_format=4|20
>  # Event will be enabled right away.
>  disabled=0
>  inherit=1
> diff --git a/tools/perf/tests/attr/test-record-group b/tools/perf/tests/attr/test-record-group
> index 14ee60fd3f41..6c1cff8aae8b 100644
> --- a/tools/perf/tests/attr/test-record-group
> +++ b/tools/perf/tests/attr/test-record-group
> @@ -7,14 +7,14 @@ ret     = 1
>  fd=1
>  group_fd=-1
>  sample_type=327
> -read_format=4
> +read_format=4|20
>
>  [event-2:base-record]
>  fd=2
>  group_fd=1
>  config=1
>  sample_type=327
> -read_format=4
> +read_format=4|20
>  mmap=0
>  comm=0
>  task=0
> diff --git a/tools/perf/tests/attr/test-record-group-sampling b/tools/perf/tests/attr/test-record-group-sampling
> index 300b9f7e6d69..97e7e64a38f0 100644
> --- a/tools/perf/tests/attr/test-record-group-sampling
> +++ b/tools/perf/tests/attr/test-record-group-sampling
> @@ -7,7 +7,7 @@ ret     = 1
>  fd=1
>  group_fd=-1
>  sample_type=343
> -read_format=12
> +read_format=12|28
>  inherit=0
>
>  [event-2:base-record]
> @@ -21,8 +21,8 @@ config=3
>  # default | PERF_SAMPLE_READ
>  sample_type=343
>
> -# PERF_FORMAT_ID | PERF_FORMAT_GROUP
> -read_format=12
> +# PERF_FORMAT_ID | PERF_FORMAT_GROUP  | PERF_FORMAT_LOST
> +read_format=12|28
>  task=0
>  mmap=0
>  comm=0
> diff --git a/tools/perf/tests/attr/test-record-group1 b/tools/perf/tests/attr/test-record-group1
> index 3ffe246e0228..eeb1db392bc9 100644
> --- a/tools/perf/tests/attr/test-record-group1
> +++ b/tools/perf/tests/attr/test-record-group1
> @@ -7,7 +7,7 @@ ret     = 1
>  fd=1
>  group_fd=-1
>  sample_type=327
> -read_format=4
> +read_format=4|20
>
>  [event-2:base-record]
>  fd=2
> @@ -15,7 +15,7 @@ group_fd=1
>  type=0
>  config=1
>  sample_type=327
> -read_format=4
> +read_format=4|20
>  mmap=0
>  comm=0
>  task=0
> diff --git a/tools/perf/tests/attr/test-record-group2 b/tools/perf/tests/attr/test-record-group2
> index 6b9f8d182ce1..cebdaa8e64e4 100644
> --- a/tools/perf/tests/attr/test-record-group2
> +++ b/tools/perf/tests/attr/test-record-group2
> @@ -9,7 +9,7 @@ group_fd=-1
>  config=0|1
>  sample_period=1234000
>  sample_type=87
> -read_format=12
> +read_format=12|28
>  inherit=0
>  freq=0
>
> @@ -19,7 +19,7 @@ group_fd=1
>  config=0|1
>  sample_period=6789000
>  sample_type=87
> -read_format=12
> +read_format=12|28
>  disabled=0
>  inherit=0
>  mmap=0
> --
> 2.28.0
>
