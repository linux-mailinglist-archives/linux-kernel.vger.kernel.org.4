Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9C1E6C1EB3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 18:58:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbjCTR6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 13:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbjCTR54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 13:57:56 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 074C95B9C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 10:52:49 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-3e0965f70ecso201601cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 10:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679334671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N73sqeWtcmiMT11zk6Xguucktfja74ge8kCnKLo8Z3g=;
        b=JoAClhnDEoJsOhMwe4R3A3SZCW9sDQ5iYxrpSGAHufIciA1FL1Fu8v4ZR0dItI3jqp
         QO5eDZTh/yObIEY016SdvROxbKuPQyQsAHb5vVJmGRplmy1xQgVPD0UZGsu7H+/ZhEkk
         ikytFEf9CmEHx2Kx++cL3z0HL07mH8uvUgtscoGH7kanoIxEU1VWWDJpRS2D7X2QnR8d
         LcV6E9C0knWaKIVUrFNY/n0q13oEknUePQzGSq5crtVhtAhL2u5NlR83nfu+DMVnUeNk
         cQbcEpnDACeiYR0nJCsuw1BQnY9mx/yZJmHsAdDJIEV8XeAgPYlDV8dQnP9K2SxH4ml8
         7r3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679334671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N73sqeWtcmiMT11zk6Xguucktfja74ge8kCnKLo8Z3g=;
        b=S/5VHrxltOh86tamLPMUImYFpgGacrJv29OXyAMHHtB9nj3lEtOgZ6LLEaDRhaJD5Y
         1+0OaStG6Jme0PQzaldbSq/YrcKXoikv3OyncojjLcTxhS1vfl0pfy3kIZleGw2qR5zy
         uucPxzFeDygCrCVy5WlTdWh0w07L/XYjJaQsOW1uB/jlk2X3AZnXhXtQD18rOGjXnyTw
         1kLW11KgOGk5JYPaPb6JkmewvWs5nZPSlWu3q4n8ZglU7akMaNfg4p1xeQR1DJlD3nUT
         3Jen7hCVAxtWo46Mo8kMRM9PXc8e+31xsS43LDGW/BNfyTqC3kY0Qp3rzNwf5dg/QRM5
         30JQ==
X-Gm-Message-State: AO0yUKWy+y8Z5RhJ1Yn0PL7drLHhWIybaOhN+ooZwyE4O2IaY14v75HL
        i6WONiRx4zVFYasAacZgUWgxWdaK+i42OVuLm5GT3g==
X-Google-Smtp-Source: AK7set8xoH+ERmG9f0Rp3Mohcu4SaYNCUDnLF6OBvXBKzCJI6SY5u8RMK6lG77DVgaf4qy+IOQp7a6aRVcLjtVZZcLM=
X-Received: by 2002:a05:622a:8:b0:3d4:1f4a:3b52 with SMTP id
 x8-20020a05622a000800b003d41f4a3b52mr12922qtw.6.1679334670611; Mon, 20 Mar
 2023 10:51:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230320151509.1137462-1-james.clark@arm.com>
In-Reply-To: <20230320151509.1137462-1-james.clark@arm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 20 Mar 2023 10:50:59 -0700
Message-ID: <CAP-5=fUz_u8BODDn3OK5hh9xSbXbMZU0fiCJUdpoS3AFQGQ9GA@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Enable display of partial and empty SVE predicates
 from Arm SPE data
To:     James Clark <james.clark@arm.com>
Cc:     linux-perf-users@vger.kernel.org, Anshuman.Khandual@arm.com,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 8:15=E2=80=AFAM James Clark <james.clark@arm.com> w=
rote:
>
> Changes since v1:
>  * Rebase onto perf/core because it no longer applied cleanly
>
> ------------
>
> Hi,
>
> I'm submitting this on behalf of German who moved on to work on other
> things in Arm before he could finish it off.
>
> The predicate information is available on SPE samples from
> Armv8.3 (FEAT_SPEv1p1), this could be useful info for profiling SVE
> code as partial and empty predicates indicate that the full vector
> width isn't being used. There is a good example in the last commit
> message.
>
> Though currently, there isn't a suitable field to store the info
> on Perf samples, so this change also adds a new SIMD field.
> This field could be used by other architectures, but currently there
> is only one bit reserved to identify SVE. It's only added to
> struct perf_sample on the userspace side, and isn't part of the kernel
> ABI, so it doesn't survive a perf inject. Although this is the
> same behavior for some other fields like branch flags, so I don't
> think it should be an issue to do something similar here. Perhaps in
> the future we could make sure everything that is synthesised from
> auxtrace data also makes it back into the new Perf inject file without
> being lost.

Series:
Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> German Gomez (4):
>   perf event: Add simd_flags field to perf_sample
>   perf arm-spe: Refactor arm-spe to support operation packet type
>   perf arm-spe: Add SVE flags to the SPE samples
>   perf report: Add 'simd' sort field
>
>  tools/perf/Documentation/perf-report.txt      |  1 +
>  .../util/arm-spe-decoder/arm-spe-decoder.c    | 30 ++++++++++--
>  .../util/arm-spe-decoder/arm-spe-decoder.h    | 47 +++++++++++++++----
>  tools/perf/util/arm-spe.c                     | 28 +++++++++--
>  tools/perf/util/hist.c                        |  1 +
>  tools/perf/util/hist.h                        |  1 +
>  tools/perf/util/sample.h                      | 13 +++++
>  tools/perf/util/sort.c                        | 47 +++++++++++++++++++
>  tools/perf/util/sort.h                        |  2 +
>  9 files changed, 152 insertions(+), 18 deletions(-)
>
>
> base-commit: 96d541699e5c50b1bc2d50c83cd7145994d5f071
> --
> 2.34.1
>
