Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF3E71628F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 15:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbjE3Nu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 09:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232716AbjE3NuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 09:50:08 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56E89E8;
        Tue, 30 May 2023 06:50:05 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QVtyb5x5Cz6D8wn;
        Tue, 30 May 2023 21:48:23 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 30 May
 2023 14:50:02 +0100
Date:   Tue, 30 May 2023 14:50:01 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Namhyung Kim <namhyung@kernel.org>
CC:     Liang Kan <kan.liang@linux.intel.com>, <linux-cxl@vger.kernel.org>,
        <peterz@infradead.org>, <mark.rutland@arm.com>, <will@kernel.org>,
        <dan.j.williams@intel.com>, <mingo@redhat.com>, <acme@kernel.org>,
        <linuxarm@huawei.com>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Dave Jiang" <dave.jiang@intel.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v7 4/5] perf: CXL Performance Monitoring Unit driver
Message-ID: <20230530145001.00002560@Huawei.com>
In-Reply-To: <CAM9d7cgYZs4DqLmjPZCYDVrp-KVYoZYDyJHLwB1fOM7ZdzM2Pg@mail.gmail.com>
References: <20230526095824.16336-1-Jonathan.Cameron@huawei.com>
        <20230526095824.16336-5-Jonathan.Cameron@huawei.com>
        <CAM9d7cgYZs4DqLmjPZCYDVrp-KVYoZYDyJHLwB1fOM7ZdzM2Pg@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Tidied up the typos. Thanks,

> > +static int cxl_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
> > +{
> > +       struct cxl_pmu_info *info = hlist_entry_safe(node, struct cxl_pmu_info, node);
> > +       unsigned int target;
> > +
> > +       if (info->on_cpu != cpu)
> > +               return 0;
> > +
> > +       info->on_cpu = -1;
> > +       target = cpumask_any_but(cpu_online_mask, cpu);
> > +       if (target >= nr_cpu_ids) {
> > +               dev_err(info->pmu.dev, "Unable to find a suitable CPU\n");
> > +               return 0;
> > +       }
> > +
> > +       perf_pmu_migrate_context(&info->pmu, cpu, target);
> > +       info->on_cpu = target;
> > +       /*
> > +        * CPU HP lock is held so we should be guaranteed that this CPU hasn't yet
> > +        * gone away.
> > +        */
> > +       WARN_ON(irq_set_affinity(info->irq, cpumask_of(target)));
> > +
> > +       return 0;
> > +}  
> 
> IIUC a CXL PMU hardware (say cxl_pmu_mem0.0) is shared across
> all CPUs and it would return the same value when read from any CPU,
> right?

Correct, it will return the same value when used from any CPU.
I'm not sure what issue you are indicating.

My understanding is that, even for such cases, perf uses percpu
variables that mean we still have to ensure that the interrupt
handling occurs on the CPU we have migrated the context to.

There are a lot of similar driver in perf already from a quick
git grep cpumask_any_but\(cpu_online_mask, 

It might be nice to enable perf to operate for these devices without
the percpu context though. I haven't looked into whether that
is worth doing.

Jonathan




> 
> Thanks,
> Namhyung
> 
> 
> > +
> > +static __init int cxl_pmu_init(void)
> > +{
> > +       int rc;
> > +
> > +       rc = cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN,
> > +                                    "AP_PERF_CXL_PMU_ONLINE",
> > +                                    cxl_pmu_online_cpu, cxl_pmu_offline_cpu);
> > +       if (rc < 0)
> > +               return rc;
> > +       cxl_pmu_cpuhp_state_num = rc;
> > +
> > +       rc = cxl_driver_register(&cxl_pmu_driver);
> > +       if (rc)
> > +               cpuhp_remove_multi_state(cxl_pmu_cpuhp_state_num);
> > +
> > +       return rc;
> > +}
> > +
> > +static __exit void cxl_pmu_exit(void)
> > +{
> > +       cxl_driver_unregister(&cxl_pmu_driver);
> > +       cpuhp_remove_multi_state(cxl_pmu_cpuhp_state_num);
> > +}
> > +
> > +MODULE_LICENSE("GPL");
> > +MODULE_IMPORT_NS(CXL);
> > +module_init(cxl_pmu_init);
> > +module_exit(cxl_pmu_exit);
> > +MODULE_ALIAS_CXL(CXL_DEVICE_PMU);
> > --
> > 2.39.2
> >  
> 

