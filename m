Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F70071F35C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 22:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbjFAUFY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 1 Jun 2023 16:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjFAUFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 16:05:22 -0400
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B86CA133;
        Thu,  1 Jun 2023 13:05:20 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-bad010e1e50so1337379276.1;
        Thu, 01 Jun 2023 13:05:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685649920; x=1688241920;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S7ybGJR51tiJdbi6kkpyvQG8Yr1ailpxWvd45KdWn10=;
        b=kPcWuflZSeaNcCwMXJKOn4Hq6t2mtf1iD9bFbf1iquT78prP2Mcz9IJj8DCliTcs6k
         2qP70Xl0v+uufgCeLV2nTe2l7ZHqfX5tzWhxeAjRJDgIVKBT0y35bkHM+AgGRZFHzUAn
         NmUcPmXpchyFMLYIAvSMo5FBoyhVjxyJkuAvZJevKX4KQUJKdYfKB96f2sG5K3v9VC48
         p0WPsBL7ZEYTxiIbLwGGjM0aMywofCu0Z1BstYaC6cl92VV3oHB3y804qFu3OGIfcXjn
         TrWtk7m05MfqOfo3pfSMlmWs5f8kFkqZrvdN9XjEEVC58575zahaqD7LEipQD3EfiIpA
         4Xzg==
X-Gm-Message-State: AC+VfDziEQLPzh/HFXTxNYnHvyJqNhtIh5X4fqg58TJk/VgTgmeIbW4K
        MrGioX1MY5PHkkjnNKp1fRNsMoVOfO8dJywwer4=
X-Google-Smtp-Source: ACHHUZ5WNr9YQErwu6PWtvQsRdu1d1vFTuOFh6tkYs7KWigc/QinTq9gpxNk6CThU+yUFAuHRB07+ziC5OkTQEheIL0=
X-Received: by 2002:a25:e312:0:b0:ba8:fe6:8e3f with SMTP id
 z18-20020a25e312000000b00ba80fe68e3fmr961071ybd.5.1685649919797; Thu, 01 Jun
 2023 13:05:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230601023644.587584-1-irogers@google.com> <20230601023644.587584-2-irogers@google.com>
In-Reply-To: <20230601023644.587584-2-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 1 Jun 2023 13:05:08 -0700
Message-ID: <CAM9d7cgN8qNHUog9uUx91BuQk_koce1DGu_Aw+nbVp6LWvtRTg@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] perf pmu: Warn about invalid config for all PMUs
 and configs
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Rob Herring <robh@kernel.org>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Wed, May 31, 2023 at 7:36 PM Ian Rogers <irogers@google.com> wrote:
>
> Don't just check the raw PMU type, the only core PMU on homogeneous
> x86, check raw and all dynamically added PMUs. Extend the
> perf_pmu__warn_invalid_config to check all 4 config values. Rather
> than process the format list once per event, store the computed masks
> for each config value. Don't ignore the mask being zero, which is
> likely for config2 and config3, add config_masks_present so config
> values can be ignored only when no format information is present.
>
> Signed-off-by: Ian Rogers <irogers@google.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> ---
>  tools/perf/util/parse-events.c | 13 +++++++++---
>  tools/perf/util/pmu.c          | 38 ++++++++++++++++++++++++----------
>  tools/perf/util/pmu.h          | 13 +++++++++++-
>  3 files changed, 49 insertions(+), 15 deletions(-)
>
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index 7f047ac11168..9f60607b0d86 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -245,9 +245,16 @@ __add_event(struct list_head *list, int *idx,
>         if (pmu)
>                 perf_pmu__warn_invalid_formats(pmu);
>
> -       if (pmu && attr->type == PERF_TYPE_RAW)
> -               perf_pmu__warn_invalid_config(pmu, attr->config, name);
> -
> +       if (pmu && (attr->type == PERF_TYPE_RAW || attr->type >= PERF_TYPE_MAX)) {
> +               perf_pmu__warn_invalid_config(pmu, attr->config, name,
> +                                             PERF_PMU_FORMAT_VALUE_CONFIG, "config");
> +               perf_pmu__warn_invalid_config(pmu, attr->config1, name,
> +                                             PERF_PMU_FORMAT_VALUE_CONFIG1, "config1");
> +               perf_pmu__warn_invalid_config(pmu, attr->config2, name,
> +                                             PERF_PMU_FORMAT_VALUE_CONFIG2, "config2");
> +               perf_pmu__warn_invalid_config(pmu, attr->config3, name,
> +                                             PERF_PMU_FORMAT_VALUE_CONFIG3, "config3");
> +       }
>         if (init_attr)
>                 event_attr_init(attr);
>
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 204ce3f02e63..b0443406fd57 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -1611,37 +1611,53 @@ int perf_pmu__caps_parse(struct perf_pmu *pmu)
>         return pmu->nr_caps;
>  }
>
> -void perf_pmu__warn_invalid_config(struct perf_pmu *pmu, __u64 config,
> -                                  const char *name)
> +static void perf_pmu__compute_config_masks(struct perf_pmu *pmu)
>  {
>         struct perf_pmu_format *format;
> -       __u64 masks = 0, bits;
> -       char buf[100];
> -       unsigned int i;
> +
> +       if (pmu->config_masks_computed)
> +               return;
>
>         list_for_each_entry(format, &pmu->format, list) {
> -               if (format->value != PERF_PMU_FORMAT_VALUE_CONFIG)
> +               unsigned int i;
> +               __u64 *mask;
> +
> +               if (format->value >= PERF_PMU_FORMAT_VALUE_CONFIG_END)
>                         continue;
>
> +               pmu->config_masks_present = true;
> +               mask = &pmu->config_masks[format->value];
> +
>                 for_each_set_bit(i, format->bits, PERF_PMU_FORMAT_BITS)
> -                       masks |= 1ULL << i;
> +                       *mask |= 1ULL << i;
>         }
> +       pmu->config_masks_computed = true;
> +}
> +
> +void perf_pmu__warn_invalid_config(struct perf_pmu *pmu, __u64 config,
> +                                  const char *name, int config_num,
> +                                  const char *config_name)
> +{
> +       __u64 bits;
> +       char buf[100];
> +
> +       perf_pmu__compute_config_masks(pmu);
>
>         /*
>          * Kernel doesn't export any valid format bits.
>          */
> -       if (masks == 0)
> +       if (!pmu->config_masks_present)
>                 return;
>
> -       bits = config & ~masks;
> +       bits = config & ~pmu->config_masks[config_num];
>         if (bits == 0)
>                 return;
>
>         bitmap_scnprintf((unsigned long *)&bits, sizeof(bits) * 8, buf, sizeof(buf));
>
> -       pr_warning("WARNING: event '%s' not valid (bits %s of config "
> +       pr_warning("WARNING: event '%s' not valid (bits %s of %s "
>                    "'%llx' not supported by kernel)!\n",
> -                  name ?: "N/A", buf, config);
> +                  name ?: "N/A", buf, config_name, config);
>  }
>
>  int perf_pmu__match(char *pattern, char *name, char *tok)
> diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
> index 7a1535dc1f12..d98b0feec022 100644
> --- a/tools/perf/util/pmu.h
> +++ b/tools/perf/util/pmu.h
> @@ -81,6 +81,10 @@ struct perf_pmu {
>          * perf_event_attr once.
>          */
>         bool formats_checked;
> +       /** @config_masks_present: Are there config format values? */
> +       bool config_masks_present;
> +       /** @config_masks_computed: Set when masks are lazily computed. */
> +       bool config_masks_computed;
>         /**
>          * @max_precise: Number of levels of :ppp precision supported by the
>          * PMU, read from
> @@ -125,6 +129,12 @@ struct perf_pmu {
>         /** @list: Element on pmus list in pmu.c. */
>         struct list_head list;
>
> +       /**
> +        * @config_masks: Derived from the PMU's format data, bits that are
> +        * valid within the config value.
> +        */
> +       __u64 config_masks[PERF_PMU_FORMAT_VALUE_CONFIG_END];
> +
>         /**
>          * @missing_features: Features to inhibit when events on this PMU are
>          * opened.
> @@ -255,7 +265,8 @@ int perf_pmu__convert_scale(const char *scale, char **end, double *sval);
>  int perf_pmu__caps_parse(struct perf_pmu *pmu);
>
>  void perf_pmu__warn_invalid_config(struct perf_pmu *pmu, __u64 config,
> -                                  const char *name);
> +                                  const char *name, int config_num,
> +                                  const char *config_name);
>  void perf_pmu__warn_invalid_formats(struct perf_pmu *pmu);
>
>  int perf_pmu__match(char *pattern, char *name, char *tok);
> --
> 2.41.0.rc0.172.g3f132b7071-goog
>
