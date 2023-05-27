Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFBAB7132D0
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 08:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbjE0G0l convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 27 May 2023 02:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjE0G0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 02:26:36 -0400
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD9F1116;
        Fri, 26 May 2023 23:26:34 -0700 (PDT)
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-786470fd7a3so443942241.3;
        Fri, 26 May 2023 23:26:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685168794; x=1687760794;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K1Vo/4/ITtOwqXGKuD1nMtQeDHz1HuSSJxIWcuEXzLo=;
        b=TbAdKBIgSrv3BNl1t5qhDNT8Y4YVzdBt7yOxDRkjk1eLHXJWSXRUoxnosuQM5G8zRI
         /lnKEnZ7hNYqj7tjLTT6tsW5LBdtnAP0sVBJ5VmvNT4F89rbqpFxRgJ01EgQZFUdnUMM
         vYS3AEUOTIPrIFAL1kTaLRQS0i6RymhjsAnXMkRHbYBatqhuJ10Xcdy+JlBH7ENbnEXx
         23foDNEdnvqZn1KNLdGrsBLoG74B7WoJt95pv7PrVZotOtETDfbHoc6kkcTysmz7qxXh
         w45e/Tle3JAubrNN4EePjFFreWaurTYtoSwhzb1CrjWys5FhrgzobHFUUBIpz+byhms3
         2b3w==
X-Gm-Message-State: AC+VfDxJnS1OB4tusxKwSZMer55TA8+Ovr7unZ+VKaIPK3RF0SzQei3p
        lgMpRCpziUrn/iK44QlWlpTI3zrgZQenf+5qXSBduaED
X-Google-Smtp-Source: ACHHUZ4qiF9t3D55NoKQ9D5GwJSNuwvnwC0H6JaWL4e3r96sJzQGoM3aFS2cNc5htnvlCr58J7n6PEi7SwemCwUAnv8=
X-Received: by 2002:a1f:cac6:0:b0:45a:8582:126d with SMTP id
 a189-20020a1fcac6000000b0045a8582126dmr438138vkg.8.1685168793866; Fri, 26 May
 2023 23:26:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230526095824.16336-1-Jonathan.Cameron@huawei.com> <20230526095824.16336-5-Jonathan.Cameron@huawei.com>
In-Reply-To: <20230526095824.16336-5-Jonathan.Cameron@huawei.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 26 May 2023 23:26:22 -0700
Message-ID: <CAM9d7cgYZs4DqLmjPZCYDVrp-KVYoZYDyJHLwB1fOM7ZdzM2Pg@mail.gmail.com>
Subject: Re: [PATCH v7 4/5] perf: CXL Performance Monitoring Unit driver
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Liang Kan <kan.liang@linux.intel.com>, linux-cxl@vger.kernel.org,
        peterz@infradead.org, mark.rutland@arm.com, will@kernel.org,
        dan.j.williams@intel.com, mingo@redhat.com, acme@kernel.org,
        linuxarm@huawei.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        Stephane Eranian <eranian@google.com>
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

On Fri, May 26, 2023 at 3:00 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> CXL rev 3.0 introduces a standard performance monitoring hardware
> block to CXL. Instances are discovered using CXL Register Locator DVSEC
> entries. Each CXL component may have multiple PMUs.
>
> This initial driver supports a subset of types of counter.
> It supports counters that are either fixed or configurable, but requires
> that they support the ability to freeze and write value whilst frozen.
>
> Development done with QEMU model which will be posted shortly.
>
> Example:
>
> $ perf stat -a -e cxl_pmu_mem0.0/h2d_req_snpcur/ -e cxl_pmu_mem0.0/h2d_req_snpdata/ -e cxl_pmu_mem0.0/clock_ticks/ sleep 1
>
> Performance counter stats for 'system wide':
>
> 96,757,023,244,321      cxl_pmu_mem0.0/h2d_req_snpcur/
> 96,757,023,244,365      cxl_pmu_mem0.0/h2d_req_snpdata/
> 193,514,046,488,653      cxl_pmu_mem0.0/clock_ticks/
>
>        1.090539600 seconds time elapsed
>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
> v7: THanks to Namhyung and Stephane for reviews
>  - Set the cpu for an event only after validation checks.
>  - Added -a to make perf default of all CPUs explicit in command line.
>  - Fix wrong event names in example.
> ---

[SNIP]
> +static void cxl_pmu_event_start(struct perf_event *event, int flags)
> +{
> +       struct cxl_pmu_info *info = pmu_to_cxl_pmu_info(event->pmu);
> +       struct hw_perf_event *hwc = &event->hw;
> +       void __iomem *base = info->base;
> +       u64 cfg;
> +
> +       /*
> +        * All paths to here should either set these flags directly or
> +        * call cxl_pmu_event_stop() which will ensure the correct state.
> +        */
> +       if (WARN_ON_ONCE(!(hwc->state & PERF_HES_STOPPED)))
> +               return;
> +
> +       WARN_ON_ONCE(!(hwc->state & PERF_HES_UPTODATE));
> +       hwc->state = 0;
> +
> +       /*
> +        * Currently only hdm filter control is implemnted, this code will

Typo: implemented

> +        * want generalizing when more filters are added.
> +        */
> +       if (info->filter_hdm) {
> +               if (cxl_pmu_config1_hdm_filter_en(event))
> +                       cfg = cxl_pmu_config2_get_hdm_decoder(event);
> +               else
> +                       cfg = GENMASK(15, 0); /* No filtering if 0xFFFF_FFFF */
> +               writeq(cfg, base + CXL_PMU_FILTER_CFG_REG(hwc->idx, 0));
> +       }
> +
> +       cfg = readq(base + CXL_PMU_COUNTER_CFG_REG(hwc->idx));
> +       cfg |= FIELD_PREP(CXL_PMU_COUNTER_CFG_INT_ON_OVRFLW, 1);
> +       cfg |= FIELD_PREP(CXL_PMU_COUNTER_CFG_FREEZE_ON_OVRFLW, 1);
> +       cfg |= FIELD_PREP(CXL_PMU_COUNTER_CFG_ENABLE, 1);
> +       cfg |= FIELD_PREP(CXL_PMU_COUNTER_CFG_EDGE,
> +                         cxl_pmu_config1_get_edge(event) ? 1 : 0);
> +       cfg |= FIELD_PREP(CXL_PMU_COUNTER_CFG_INVERT,
> +                         cxl_pmu_config1_get_invert(event) ? 1 : 0);
> +
> +       /* Fixed purpose counters have next two fields RO */
> +       if (test_bit(hwc->idx, info->conf_counter_bm)) {
> +               cfg |= FIELD_PREP(CXL_PMU_COUNTER_CFG_EVENT_GRP_ID_IDX_MSK,
> +                                 hwc->event_base);
> +               cfg |= FIELD_PREP(CXL_PMU_COUNTER_CFG_EVENTS_MSK,
> +                                 cxl_pmu_config_get_mask(event));
> +       }
> +       cfg &= ~CXL_PMU_COUNTER_CFG_THRESHOLD_MSK;
> +       /*
> +        * For events that generate only 1 count per clock the CXL 3.0 spec
> +        * states the threshold shall be set to 1 but if set to 0 it will
> +        * count the raw value anwyay?

Typo: anyway?

> +        * There is no definition of what events will count multiple per cycle
> +        * and hence to which non 1 values of threshold can apply.
> +        * (CXL 3.0 8.2.7.2.1 Counter Configuration - threshold field definition)
> +        */
> +       cfg |= FIELD_PREP(CXL_PMU_COUNTER_CFG_THRESHOLD_MSK,
> +                         cxl_pmu_config1_get_threshold(event));
> +       writeq(cfg, base + CXL_PMU_COUNTER_CFG_REG(hwc->idx));
> +
> +       local64_set(&hwc->prev_count, 0);
> +       writeq(0, base + CXL_PMU_COUNTER_REG(hwc->idx));
> +
> +       perf_event_update_userpage(event);
> +}
> +

[SNIP]
> +
> +static int cxl_pmu_online_cpu(unsigned int cpu, struct hlist_node *node)
> +{
> +       struct cxl_pmu_info *info = hlist_entry_safe(node, struct cxl_pmu_info, node);
> +
> +       if (info->on_cpu != -1)
> +               return 0;
> +
> +       info->on_cpu = cpu;
> +       /*
> +        * CPU HP lock is held so we should be guaranteed that the CPU hasn't yet
> +        * gone away again.
> +        */
> +       WARN_ON(irq_set_affinity(info->irq, cpumask_of(cpu)));
> +
> +       return 0;
> +}
> +
> +static int cxl_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
> +{
> +       struct cxl_pmu_info *info = hlist_entry_safe(node, struct cxl_pmu_info, node);
> +       unsigned int target;
> +
> +       if (info->on_cpu != cpu)
> +               return 0;
> +
> +       info->on_cpu = -1;
> +       target = cpumask_any_but(cpu_online_mask, cpu);
> +       if (target >= nr_cpu_ids) {
> +               dev_err(info->pmu.dev, "Unable to find a suitable CPU\n");
> +               return 0;
> +       }
> +
> +       perf_pmu_migrate_context(&info->pmu, cpu, target);
> +       info->on_cpu = target;
> +       /*
> +        * CPU HP lock is held so we should be guaranteed that this CPU hasn't yet
> +        * gone away.
> +        */
> +       WARN_ON(irq_set_affinity(info->irq, cpumask_of(target)));
> +
> +       return 0;
> +}

IIUC a CXL PMU hardware (say cxl_pmu_mem0.0) is shared across
all CPUs and it would return the same value when read from any CPU,
right?

Thanks,
Namhyung


> +
> +static __init int cxl_pmu_init(void)
> +{
> +       int rc;
> +
> +       rc = cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN,
> +                                    "AP_PERF_CXL_PMU_ONLINE",
> +                                    cxl_pmu_online_cpu, cxl_pmu_offline_cpu);
> +       if (rc < 0)
> +               return rc;
> +       cxl_pmu_cpuhp_state_num = rc;
> +
> +       rc = cxl_driver_register(&cxl_pmu_driver);
> +       if (rc)
> +               cpuhp_remove_multi_state(cxl_pmu_cpuhp_state_num);
> +
> +       return rc;
> +}
> +
> +static __exit void cxl_pmu_exit(void)
> +{
> +       cxl_driver_unregister(&cxl_pmu_driver);
> +       cpuhp_remove_multi_state(cxl_pmu_cpuhp_state_num);
> +}
> +
> +MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS(CXL);
> +module_init(cxl_pmu_init);
> +module_exit(cxl_pmu_exit);
> +MODULE_ALIAS_CXL(CXL_DEVICE_PMU);
> --
> 2.39.2
>
