Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C75AB5F03FB
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 07:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbiI3E77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 00:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiI3E7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 00:59:54 -0400
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81419399DC;
        Thu, 29 Sep 2022 21:59:52 -0700 (PDT)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-131b7bb5077so4248996fac.2;
        Thu, 29 Sep 2022 21:59:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=eouRZA3yJ2rz1sAdNkk8ipLdjxkcaTNBWJyAvbZ4KPQ=;
        b=ofqfQ2vI8FlfaKtNuuvzoflEemuBUnH1MQQk//t1zqVh6cTh3QGyfKBXamjAcgn7JS
         k4lfa+psFwwpnUMruoNNEz2M6SpFyhxvlNftxbzuEx7xC7Ye1+bCpk7HmEa2hUIBzuAp
         y2P7W2iTBvhRu1pS/LDSun/0864gpezRty6gxdxUAwbyoW7s2smVD9dpIcTJe2hy60vz
         y2i0ybEpqFmqbhgNQvHq5ZQgwWomSlazXl0Wrh1Fpw+ykS/IIemaXpiDaJH/69Yoftdj
         wLUTlZ0dge2cOkVtMqO4UuYvmUrXjbr5BZx8ylNRPmcVBoktxgXBhn3NZOzUj6Xa5ke2
         1Pdw==
X-Gm-Message-State: ACrzQf33mGM7noKPofeP8J+rnK8ayilXwGy+5q2H2KG67cZ5e/EhJ8L8
        vuXgtbQGUEup/FLFmTnGaKwhq1FDzgbqA4nxZTE=
X-Google-Smtp-Source: AMsMyM7oiA7jP+oH9cKwq2o5TcX85aUq4W3yI8+vNomFpzb7r7TaDghjDJwABiQ5+oxas6b7uT6boo9a23nhZLqcHIw=
X-Received: by 2002:a05:6870:a70f:b0:127:666a:658 with SMTP id
 g15-20020a056870a70f00b00127666a0658mr3921859oam.218.1664513991796; Thu, 29
 Sep 2022 21:59:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220928095805.596-1-ravi.bangoria@amd.com> <20220928095805.596-7-ravi.bangoria@amd.com>
In-Reply-To: <20220928095805.596-7-ravi.bangoria@amd.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 29 Sep 2022 21:59:40 -0700
Message-ID: <CAM9d7cgDTZRR+eciX-4N0VZ5uoEYqikUOyiEE_hu3JTEBsONOQ@mail.gmail.com>
Subject: Re: [PATCH v3 06/15] perf/x86/amd: Support PERF_SAMPLE_PHY_ADDR
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>, Joe Mario <jmario@redhat.com>,
        Leo Yan <leo.yan@linaro.org>, alisaidi@amazon.com,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        dave.hansen@linux.intel.com, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Sandipan Das <sandipan.das@amd.com>, ananth.narayan@amd.com,
        Kim Phillips <kim.phillips@amd.com>, santosh.shukla@amd.com
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

On Wed, Sep 28, 2022 at 3:00 AM Ravi Bangoria <ravi.bangoria@amd.com> wrote:
>
> IBS_DC_PHYSADDR provides the physical data address for the tagged load/
> store operation. Populate perf sample physical address using it.
>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> ---
>  arch/x86/events/amd/ibs.c | 8 +++++++-
>  kernel/events/core.c      | 3 ++-
>  2 files changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
> index 0ad49105c154..3271735f0070 100644
> --- a/arch/x86/events/amd/ibs.c
> +++ b/arch/x86/events/amd/ibs.c
> @@ -989,6 +989,11 @@ static void perf_ibs_parse_ld_st_data(__u64 sample_type,
>                 data->addr = ibs_data->regs[ibs_op_msr_idx(MSR_AMD64_IBSDCLINAD)];
>                 data->sample_flags |= PERF_SAMPLE_ADDR;
>         }
> +
> +       if (sample_type & PERF_SAMPLE_PHYS_ADDR && op_data3.dc_phy_addr_valid) {
> +               data->phys_addr = ibs_data->regs[ibs_op_msr_idx(MSR_AMD64_IBSDCPHYSAD)];
> +               data->sample_flags |= PERF_SAMPLE_PHYS_ADDR;
> +       }
>  }
>
>  static int perf_ibs_get_offset_max(struct perf_ibs *perf_ibs, u64 sample_type,
> @@ -998,7 +1003,8 @@ static int perf_ibs_get_offset_max(struct perf_ibs *perf_ibs, u64 sample_type,
>             (perf_ibs == &perf_ibs_op &&
>              (sample_type & PERF_SAMPLE_DATA_SRC ||
>               sample_type & PERF_SAMPLE_WEIGHT_TYPE ||
> -             sample_type & PERF_SAMPLE_ADDR)))
> +             sample_type & PERF_SAMPLE_ADDR ||
> +             sample_type & PERF_SAMPLE_PHYS_ADDR)))
>                 return perf_ibs->offset_max;
>         else if (check_rip)
>                 return 3;
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index e1ffdb861b53..49bc3b5e6c8a 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -7435,7 +7435,8 @@ void perf_prepare_sample(struct perf_event_header *header,
>                 header->size += size;
>         }
>
> -       if (sample_type & PERF_SAMPLE_PHYS_ADDR)
> +       if (sample_type & PERF_SAMPLE_PHYS_ADDR &&
> +           filtered_sample_type & PERF_SAMPLE_PHYS_ADDR)

It'd be enough to check the filtered_sample_type only.

Thanks,
Namhyung


>                 data->phys_addr = perf_virt_to_phys(data->addr);
>
>  #ifdef CONFIG_CGROUP_PERF
> --
> 2.31.1
>
