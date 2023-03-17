Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1D4D6BECA0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 16:13:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbjCQPN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 11:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbjCQPNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 11:13:50 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09BFAC3CDC;
        Fri, 17 Mar 2023 08:13:26 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PdSKh1zSkz6J6pL;
        Fri, 17 Mar 2023 23:12:24 +0800 (CST)
Received: from localhost (10.48.148.142) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Fri, 17 Mar
 2023 15:13:23 +0000
Date:   Fri, 17 Mar 2023 15:13:22 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Jie Zhan <zhanjie9@hisilicon.com>
CC:     <will@kernel.org>, <mark.rutland@arm.com>,
        <mathieu.poirier@linaro.org>, <suzuki.poulose@arm.com>,
        <mike.leach@linaro.org>, <leo.yan@linaro.org>,
        <john.g.garry@oracle.com>, <james.clark@arm.com>,
        <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <corbet@lwn.net>, <zhangshaokun@hisilicon.com>,
        <shenyang39@huawei.com>, <hejunhao3@huawei.com>,
        <yangyicong@hisilicon.com>, <prime.zeng@huawei.com>,
        <suntao25@huawei.com>, <jiazhao4@hisilicon.com>,
        <linuxarm@huawei.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-perf-users@vger.kernel.org>
Subject: Re: [RFC PATCH v1 3/4] perf tool: Add HiSilicon PMCU data recording
 support
Message-ID: <20230317151322.000034eb@Huawei.com>
In-Reply-To: <20230206065146.645505-4-zhanjie9@hisilicon.com>
References: <20230206065146.645505-1-zhanjie9@hisilicon.com>
        <20230206065146.645505-4-zhanjie9@hisilicon.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.148.142]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Feb 2023 14:51:45 +0800
Jie Zhan <zhanjie9@hisilicon.com> wrote:

> Support for HiSilicon PMCU data recording using 'perf-record'.
> 
> Users can start PMCU profiling through 'perf-record'. Event numbers are
> passed by a sysfs interface. The following optional parameters can be
> passed through 'perf-record':
> - nr_sample: number of samples to take
> - sample_period_ms: time in ms for PMU counters to stay on for an event
> - pmccfiltr: bits[31-24] of system register PMCCFILTR_EL0
> 
> Example usage:
> 
> 1. Enter event numbers in the 'user_events' file:
> 
> 	echo "0x10 0x11" > /sys/devices/hisi_pmcu_sccl3/user_events
> 
> 2. Start the sampling with 'perf-record':
> 
> 	perf record -e hisi_pmcu_sccl3/nr_sample=1000,sample_period_ms=1/
> 
> In this example, the PMCU takes 1000 samples of event 0x0010 and 0x0011
> with a sampling period of 1ms. Data will be written to a 'perf.data' file.
> 
> Co-developed-by: Yang Shen <shenyang39@huawei.com>
> Signed-off-by: Yang Shen <shenyang39@huawei.com>
> Signed-off-by: Jie Zhan <zhanjie9@hisilicon.com>

I'm not particularly knowledgeable about perf tool so just some superficial comments
from me.

> ---

> diff --git a/tools/perf/arch/arm64/util/hisi-pmcu.c b/tools/perf/arch/arm64/util/hisi-pmcu.c
> new file mode 100644
> index 000000000000..7c33abf1182d
> --- /dev/null
> +++ b/tools/perf/arch/arm64/util/hisi-pmcu.c

> +struct hisi_pmcu_record {
> +	struct auxtrace_record itr;
> +	struct perf_pmu *hisi_pmcu_pmu;
> +	struct evlist *evlist;
> +};

...

> +struct auxtrace_record *hisi_pmcu_recording_init(int *err,
> +						 struct perf_pmu *hisi_pmcu_pmu)
> +{

...

> +	pmcu_record->hisi_pmcu_pmu = hisi_pmcu_pmu;
> +	pmcu_record->itr.recording_options = hisi_pmcu_recording_options;
> +	pmcu_record->itr.info_priv_size = hisi_pmcu_info_priv_size;
> +	pmcu_record->itr.info_fill = hisi_pmcu_info_fill;
> +	pmcu_record->itr.free = hisi_pmcu_record_free;
> +	pmcu_record->itr.reference = hisi_pmcu_reference;
> +	pmcu_record->itr.read_finish = auxtrace_record__read_finish;
> +	pmcu_record->itr.alignment = HISI_PMCU_DATA_ALIGNMENT;
> +	pmcu_record->itr.pmu = hisi_pmcu_pmu;

Maybe a local variable for itr - or if you can rely on c99 in perf tool
a compound literal to use structure field names etc.

	pmcu_record->itr = (struct xxx){
		.recording_options = ,
etc


> +
> +	*err = 0;
> +	return &pmcu_record->itr;
> +}

> diff --git a/tools/perf/util/hisi-pmcu.h b/tools/perf/util/hisi-pmcu.h
> new file mode 100644
> index 000000000000..d46d523a3aee
> --- /dev/null
> +++ b/tools/perf/util/hisi-pmcu.h
> @@ -0,0 +1,17 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * HiSilicon Performance Monitor Control Unit (PMCU) support
> + *
> + * Copyright (C) 2022 HiSilicon Limited

Probably want to update the dates if any substantial changes for v2.

