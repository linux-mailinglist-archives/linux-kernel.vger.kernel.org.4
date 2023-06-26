Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8373573EE8D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 00:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbjFZWQ0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 26 Jun 2023 18:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbjFZWQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 18:16:11 -0400
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92CA32729;
        Mon, 26 Jun 2023 15:15:15 -0700 (PDT)
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-44357f34e2dso620340137.3;
        Mon, 26 Jun 2023 15:15:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687817714; x=1690409714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sBTU3bSkJsZYHidxKUw6bezPRH0mHvAIcWPR5hMhfp0=;
        b=TQ4VCxHUyKs++cOBTB3tC+0p6i+rKM2E2piLFm2/DQifSuVcuSF6/PjLjGjFJpjh5Y
         hMm9DWnVAzQVx2M6QufwCGHTZ4E3D0tz1itRSkn3j/C+/zAkEpiup4nAyfLpNrPc8ksA
         p3Uw8GFbSmnvNU++Vhdo8nVDQVGq5Yvuh2UhF9KCRjocXPHf6dWNP/eArMXH/EmkrTD9
         E4nhd6haCdW+379p+cYnCnubytyusg3XXViONanQxQGznyFsbtU+CmDC1gf22Owd13nO
         myoD9L8HEl6dIFQGn5QqaIH4FLBF1cLoS6qXOzryFUeCk2OEt2ff7RZPTSduUaB57X3F
         HOSQ==
X-Gm-Message-State: AC+VfDwf3/JvFMfmCsXTVOtx6jEsONZOkn2jaId6+nypd4/0WCaGa+zM
        qpMPSf/TMt/oivD8ghsnth/DTGT4Zcgkkr22PyQ6FY7/
X-Google-Smtp-Source: ACHHUZ6Xriv1+IpDgIMwYF2u+SPTqxO8SUqTUa01WvUDpZlZgsYOWrP4UtGxnf+7I39VE5YrxW9sTMVJsCFGJ/AVNnQ=
X-Received: by 2002:a05:6102:ce:b0:443:69fd:3628 with SMTP id
 u14-20020a05610200ce00b0044369fd3628mr1875394vsp.13.1687817714410; Mon, 26
 Jun 2023 15:15:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230626053048.257959-1-irogers@google.com>
In-Reply-To: <20230626053048.257959-1-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 26 Jun 2023 15:15:03 -0700
Message-ID: <CAM9d7cgrVEUBrmF4+w02ENQwSG-Ek6H_O7B0cUgPxv_wvsj5MQ@mail.gmail.com>
Subject: Re: [PATCH v1] perf pmu: Correct auto_merge_stats test
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
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

On Sun, Jun 25, 2023 at 10:31 PM Ian Rogers <irogers@google.com> wrote:
>
> The original logic was:
> https://lore.kernel.org/all/20230527072210.2900565-35-irogers@google.com/
> return !is_pmu_hybrid(pmu->name)
>
> is_pmu_hybrid was removed but with the incorrect condition which was
> fixed for core PMUs but not uncore. This change fixes both.
>
> Fixes: e23421426e13 ("perf pmu: Correct perf_pmu__auto_merge_stats() affecting hybrid")
> Signed-off-by: Ian Rogers <irogers@google.com>

Tested-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> ---
>  tools/perf/util/pmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 64fa568a5426..8d5ecd4ff1a9 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -1427,7 +1427,7 @@ bool perf_pmu__supports_legacy_cache(const struct perf_pmu *pmu)
>
>  bool perf_pmu__auto_merge_stats(const struct perf_pmu *pmu)
>  {
> -       return pmu->is_core && perf_pmus__num_core_pmus() == 1;
> +       return !pmu->is_core || perf_pmus__num_core_pmus() == 1;
>  }
>
>  bool perf_pmu__have_event(const struct perf_pmu *pmu, const char *name)
> --
> 2.41.0.162.gfafddb0af9-goog
>
