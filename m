Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7A46A63D2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 00:34:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjB1Xen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 18:34:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjB1Xem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 18:34:42 -0500
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD1322DE2;
        Tue, 28 Feb 2023 15:34:40 -0800 (PST)
Received: by mail-io1-f50.google.com with SMTP id bf15so4715917iob.7;
        Tue, 28 Feb 2023 15:34:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677627280;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FeueFgms68iXpT/krDtL0yaSU3HkmD5uN8iaU1zZO2k=;
        b=dxC1QWxYFDvVrSJTyrYO2BE5hUSIU5oaAh0ip44UqxgL/YrGp8nsVxoYYxvtbb9Vw9
         v7IRIbTfVcwlDp0YzV0kztDNO6BM0gWiF0EB0lBqtkEBFlzokxynWflrUuchVqFy45TK
         CnETiz4elIcSstWjasjwUxIkt07TRziWLKKRa4ybRZquSj0goBXUId6XN48JmT4bxQ1T
         fVPw0AEr0xMbN8FTYY6KQ9m9NUhUGJ/pr6MufWAJ7lm1mpbghoET79GTpmjXY3/OUT73
         R9WXSIYAuxkZa5OOVbxyMb/cJ/uRIlZpNjSHJOaa7RD3zydpAbvc/Bp331s4jFlW8+zt
         vhLw==
X-Gm-Message-State: AO0yUKXaWpcJNt2ZC7ye+DdSp2Tvns7SG3zB8f2KvtZeqlL5V68EKpug
        6qUZHZLCK5jqwe9FqesgR9CJyKKPYJfnpAdxgHE=
X-Google-Smtp-Source: AK7set/EkmZ5lfHMe26IBDK9XcJOKP0KCYSlYbcf3h5369Pdb9l4dIKRs+nTuOGR+uosRTCsiVE8AUYOFmT30UTpYa8=
X-Received: by 2002:a6b:ee19:0:b0:745:405d:b703 with SMTP id
 i25-20020a6bee19000000b00745405db703mr2088843ioh.3.1677627279880; Tue, 28 Feb
 2023 15:34:39 -0800 (PST)
MIME-Version: 1.0
References: <20230228115125.144172-1-leo.yan@linaro.org> <20230228115125.144172-9-leo.yan@linaro.org>
In-Reply-To: <20230228115125.144172-9-leo.yan@linaro.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 28 Feb 2023 15:34:28 -0800
Message-ID: <CAM9d7cgEZ4ugAfef8hDKOr11xF7QP1w7-Ax3mnDr4XXmYr0DoQ@mail.gmail.com>
Subject: Re: [PATCH v3 08/14] perf kvm: Add dimensions for KVM event statistics
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leo,

On Tue, Feb 28, 2023 at 3:53 AM Leo Yan <leo.yan@linaro.org> wrote:
>
> To support KVM event statistics, this patch firstly registers histograms
> columns and sorting fields; every column or field has its own format
> structure, the format structure is dereferenced to access the dimension,
> finally the dimension provides the comparison callback for sorting
> result.
>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> Reviewed-by: James Clark <james.clark@arm.com>
> ---
>  tools/perf/builtin-kvm.c   | 239 +++++++++++++++++++++++++++++++++++--
>  tools/perf/util/kvm-stat.h |   2 +
>  2 files changed, 234 insertions(+), 7 deletions(-)
>
> diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
> index a9f467926bdd..da84f5063d4d 100644
> --- a/tools/perf/builtin-kvm.c
> +++ b/tools/perf/builtin-kvm.c
> @@ -70,9 +70,9 @@ static int cmp_event_ ## func(struct kvm_event *one,                  \
>                get_event_ ##func(two, vcpu);                            \
>  }
>
> -GET_EVENT_KEY(time, time);
> -GET_EVENT_KEY(max, stats.max);
> -GET_EVENT_KEY(min, stats.min);
> +COMPARE_EVENT_KEY(time, time);
> +COMPARE_EVENT_KEY(max, stats.max);
> +COMPARE_EVENT_KEY(min, stats.min);
>  COMPARE_EVENT_KEY(count, stats.n);
>  COMPARE_EVENT_KEY(mean, stats.mean);
>
> @@ -90,13 +90,238 @@ struct kvm_hists {
>         struct perf_hpp_list    list;
>  };
>
> +struct kvm_dimension {
> +       const char *name;
> +       int64_t (*cmp)(struct perf_hpp_fmt *fmt, struct hist_entry *left,
> +                      struct hist_entry *right);
> +};
> +
> +struct kvm_fmt {
> +       struct perf_hpp_fmt     fmt;
> +       struct kvm_dimension    *dim;
> +};
> +
>  static struct kvm_hists kvm_hists;
>
> -static int kvm_hists__init(void)
> +static int64_t
> +empty_cmp(struct perf_hpp_fmt *fmt __maybe_unused,
> +         struct hist_entry *left __maybe_unused,
> +         struct hist_entry *right __maybe_unused)
> +{
> +       return 0;
> +}
> +
> +static struct kvm_dimension dim_event = {
> +       .name           = "name",
> +       .cmp            = empty_cmp,
> +};

I guess you can name it as 'dim_name' to reduce the confusion.
Also it can compare event names using strcmp() in case users
want to see event names in alphabetical order.

[SNIP]
> +
> +static int kvm_hists__init_output(struct perf_hpp_list *hpp_list, char *name)
> +{
> +       struct kvm_fmt *kvm_fmt = get_format(name);
> +
> +       if (!kvm_fmt) {
> +               reset_dimensions();
> +               return output_field_add(hpp_list, name);

Hmm.. do you plan to support these generic output fields too?
I'm not sure you need reset_dimensions() here.

> +       }
> +
> +       perf_hpp_list__column_register(hpp_list, &kvm_fmt->fmt);
> +       return 0;
> +}
> +
> +static int kvm_hists__init_sort(struct perf_hpp_list *hpp_list, char *name)
> +{
> +       struct kvm_fmt *kvm_fmt = get_format(name);
> +
> +       if (!kvm_fmt) {
> +               reset_dimensions();
> +               return sort_dimension__add(hpp_list, name, NULL, 0);

Ditto.

> +       }
> +
> +       perf_hpp_list__register_sort_field(hpp_list, &kvm_fmt->fmt);
> +       return 0;
> +}
> +
> +static int kvm_hpp_list__init(char *list,
> +                             struct perf_hpp_list *hpp_list,
> +                             int (*fn)(struct perf_hpp_list *hpp_list,
> +                                       char *name))
> +{
> +       char *tmp, *tok;
> +       int ret;
> +
> +       if (!list || !fn)
> +               return 0;
> +
> +       for (tok = strtok_r(list, ", ", &tmp); tok;
> +            tok = strtok_r(NULL, ", ", &tmp)) {
> +               ret = fn(hpp_list, tok);
> +               if (!ret)
> +                       continue;
> +
> +               /* Handle errors */
> +               if (ret == -EINVAL)
> +                       pr_err("Invalid field key: '%s'", tok);
> +               else if (ret == -ESRCH)
> +                       pr_err("Unknown field key: '%s'", tok);
> +               else
> +                       pr_err("Fail to initialize for field key: '%s'", tok);
> +
> +               break;
> +       }
> +
> +       return ret;
> +}
> +
> +static int kvm_hpp_list__parse(struct perf_hpp_list *hpp_list,
> +                              const char *output_, const char *sort_)
> +{
> +       char *output = output_ ? strdup(output_) : NULL;
> +       char *sort = sort_ ? strdup(sort_) : NULL;
> +       int ret;
> +
> +       ret = kvm_hpp_list__init(output, hpp_list, kvm_hists__init_output);
> +       if (ret)
> +               goto out;
> +
> +       ret = kvm_hpp_list__init(sort, hpp_list, kvm_hists__init_sort);
> +       if (ret)
> +               goto out;
> +
> +       /* Copy sort keys to output fields */
> +       perf_hpp__setup_output_field(hpp_list);

I think you also need perf_hpp__append_sort_keys() as in
setup_sorting() to have secondary sort keys in case the
given sort key cannot determine the ordering.

Thanks,
Namhyung


> +
> +out:
> +       free(output);
> +       free(sort);
> +       return ret;
> +}
> +
> +static int kvm_hists__init(struct perf_kvm_stat *kvm)
> +{
> +       const char *output_columns = "name,sample,time,max_t,min_t,mean_t";
> +
>         __hists__init(&kvm_hists.hists, &kvm_hists.list);
>         perf_hpp_list__init(&kvm_hists.list);
> -       return 0;
> +       return kvm_hpp_list__parse(&kvm_hists.list, output_columns,
> +                                  kvm->sort_key);
>  }
>
>  static const char *get_filename_for_perf_kvm(void)
> @@ -979,7 +1204,7 @@ static int kvm_events_live_report(struct perf_kvm_stat *kvm)
>         set_term_quiet_input(&save);
>         init_kvm_event_record(kvm);
>
> -       kvm_hists__init();
> +       kvm_hists__init(kvm);
>
>         signal(SIGINT, sig_handler);
>         signal(SIGTERM, sig_handler);
> @@ -1176,7 +1401,7 @@ static int kvm_events_report_vcpu(struct perf_kvm_stat *kvm)
>         init_kvm_event_record(kvm);
>         setup_pager();
>
> -       kvm_hists__init();
> +       kvm_hists__init(kvm);
>
>         ret = read_events(kvm);
>         if (ret)
> diff --git a/tools/perf/util/kvm-stat.h b/tools/perf/util/kvm-stat.h
> index 80d5c5a9ae31..ca5796959f66 100644
> --- a/tools/perf/util/kvm-stat.h
> +++ b/tools/perf/util/kvm-stat.h
> @@ -40,6 +40,8 @@ struct kvm_event {
>         #define DEFAULT_VCPU_NUM 8
>         int max_vcpu;
>         struct kvm_event_stats *vcpu;
> +
> +       struct hist_entry he;
>  };
>
>  typedef int (*key_cmp_fun)(struct kvm_event*, struct kvm_event*, int);
> --
> 2.34.1
>
