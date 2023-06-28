Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CAF97408C3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 05:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbjF1DB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 23:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjF1DBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 23:01:53 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EAC8171A;
        Tue, 27 Jun 2023 20:01:51 -0700 (PDT)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QrRB06rrrzlWJK;
        Wed, 28 Jun 2023 10:59:04 +0800 (CST)
Received: from [10.67.111.205] (10.67.111.205) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 28 Jun 2023 11:01:48 +0800
Subject: Re: [PATCH v1] perf pmus: Add placeholder core PMU
To:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Rob Herring <robh@kernel.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230627182834.117565-1-irogers@google.com>
From:   Yang Jihong <yangjihong1@huawei.com>
Message-ID: <344a8de1-469d-a8f9-100e-9a67e562939b@huawei.com>
Date:   Wed, 28 Jun 2023 11:01:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20230627182834.117565-1-irogers@google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.205]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 2023/6/28 2:28, Ian Rogers wrote:
> If loading a core PMU fails, legacy hardware/cache events may segv due
> to there being no PMU. Create a placeholder empty PMU for this
> case. This was discussed in:
> https://lore.kernel.org/lkml/20230614151625.2077-1-yangjihong1@huawei.com/
> 
> Reported-by: Yang Jihong <yangjihong1@huawei.com>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>   tools/perf/util/pmu.c  | 25 +++++++++++++++++++++++++
>   tools/perf/util/pmu.h  |  1 +
>   tools/perf/util/pmus.c |  7 ++++++-
>   3 files changed, 32 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 8d5ecd4ff1a9..7f984a7f16ca 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -928,6 +928,31 @@ struct perf_pmu *perf_pmu__lookup(struct list_head *pmus, int dirfd, const char
>   	return NULL;
>   }
>   
> +/* Creates the PMU when sysfs scanning fails. */
> +struct perf_pmu *perf_pmu__create_placeholder_core_pmu(struct list_head *core_pmus)
> +{
> +	struct perf_pmu *pmu = zalloc(sizeof(*pmu));
> +
> +	if (!pmu)
> +		return NULL;
> +
> +	pmu->name = strdup("cpu");
> +	if (!pmu->name) {
> +		free(pmu);
> +		return NULL;
> +	}
> +
> +	pmu->is_core = true;
> +	pmu->type = PERF_TYPE_RAW;
> +	pmu->cpus = cpu_map__online();
> +
> +	INIT_LIST_HEAD(&pmu->format);
> +	INIT_LIST_HEAD(&pmu->aliases);
> +	INIT_LIST_HEAD(&pmu->caps);
> +	list_add_tail(&pmu->list, core_pmus);
> +	return pmu;
> +}
> +
>   void perf_pmu__warn_invalid_formats(struct perf_pmu *pmu)
>   {
>   	struct perf_pmu_format *format;
> diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
> index 8807a624e918..203b92860e3c 100644
> --- a/tools/perf/util/pmu.h
> +++ b/tools/perf/util/pmu.h
> @@ -286,6 +286,7 @@ int perf_pmu__event_source_devices_fd(void);
>   int perf_pmu__pathname_fd(int dirfd, const char *pmu_name, const char *filename, int flags);
>   
>   struct perf_pmu *perf_pmu__lookup(struct list_head *pmus, int dirfd, const char *lookup_name);
> +struct perf_pmu *perf_pmu__create_placeholder_core_pmu(struct list_head *core_pmus);
>   void perf_pmu__delete(struct perf_pmu *pmu);
>   
>   #endif /* __PMU_H */
> diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
> index 0866dee3fc62..3cd9de42139e 100644
> --- a/tools/perf/util/pmus.c
> +++ b/tools/perf/util/pmus.c
> @@ -153,7 +153,12 @@ static void pmu_read_sysfs(bool core_only)
>   
>   	closedir(dir);
>   	if (core_only) {
> -		read_sysfs_core_pmus = true;
> +		if (!list_empty(&core_pmus))
> +			read_sysfs_core_pmus = true;
> +		else {
> +			if (perf_pmu__create_placeholder_core_pmu(&core_pmus))
> +				read_sysfs_core_pmus = true;
> +		}
>   	} else {
>   		read_sysfs_core_pmus = true;
>   		read_sysfs_all_pmus = true;
> 
Great. This patch solves the problem, the test results are shown in [1].

Tested-by: Yang Jihong <yangjihong1@huawei.com>

[1]:
# perf --debug verbose=2 record true
<SNIP>
------------------------------------------------------------
perf_event_attr:
   size                             136
   { sample_period, sample_freq }   4000
   sample_type                      IP|TID|TIME|PERIOD
   read_format                      ID|LOST
   disabled                         1
   inherit                          1
   mmap                             1
   comm                             1
   freq                             1
   enable_on_exec                   1
   task                             1
   precise_ip                       3
   sample_id_all                    1
   mmap2                            1
   comm_exec                        1
   ksymbol                          1
   bpf_event                        1
------------------------------------------------------------
sys_perf_event_open: pid 703  cpu 0  group_fd -1  flags 0x8
sys_perf_event_open failed, error -2
decreasing precise_ip by one (2)
------------------------------------------------------------
perf_event_attr:
   size                             136
   { sample_period, sample_freq }   4000
   sample_type                      IP|TID|TIME|PERIOD
   read_format                      ID|LOST
   disabled                         1
   inherit                          1
   mmap                             1
   comm                             1
   freq                             1
   enable_on_exec                   1
   task                             1
   precise_ip                       2
   sample_id_all                    1
   mmap2                            1
   comm_exec                        1
   ksymbol                          1
   bpf_event                        1
------------------------------------------------------------
sys_perf_event_open: pid 703  cpu 0  group_fd -1  flags 0x8
sys_perf_event_open failed, error -2
decreasing precise_ip by one (1)
------------------------------------------------------------
perf_event_attr:
   size                             136
   { sample_period, sample_freq }   4000
   sample_type                      IP|TID|TIME|PERIOD
   read_format                      ID|LOST
   disabled                         1
   inherit                          1
   mmap                             1
   comm                             1
   freq                             1
   enable_on_exec                   1
   task                             1
   precise_ip                       1
   sample_id_all                    1
   mmap2                            1
   comm_exec                        1
   ksymbol                          1
   bpf_event                        1
------------------------------------------------------------
sys_perf_event_open: pid 703  cpu 0  group_fd -1  flags 0x8
sys_perf_event_open failed, error -2
decreasing precise_ip by one (0)
------------------------------------------------------------
perf_event_attr:
   size                             136
   { sample_period, sample_freq }   4000
   sample_type                      IP|TID|TIME|PERIOD
   read_format                      ID|LOST
   disabled                         1
   inherit                          1
   mmap                             1
   comm                             1
   freq                             1
   enable_on_exec                   1
   task                             1
   sample_id_all                    1
   mmap2                            1
   comm_exec                        1
   ksymbol                          1
   bpf_event                        1
------------------------------------------------------------
sys_perf_event_open: pid 703  cpu 0  group_fd -1  flags 0x8
sys_perf_event_open failed, error -2
Warning:
The cycles event is not supported, trying to fall back to cpu-clock-ticks
------------------------------------------------------------
perf_event_attr:
   type                             1
   size                             136
   { sample_period, sample_freq }   4000
   sample_type                      IP|TID|TIME|PERIOD
   read_format                      ID|LOST
   disabled                         1
   inherit                          1
   mmap                             1
   comm                             1
   freq                             1
   enable_on_exec                   1
   task                             1
   precise_ip                       3
   sample_id_all                    1
   mmap2                            1
   comm_exec                        1
   ksymbol                          1
   bpf_event                        1
------------------------------------------------------------
sys_perf_event_open: pid 703  cpu 0  group_fd -1  flags 0x8 = 5
sys_perf_event_open: pid 703  cpu 1  group_fd -1  flags 0x8 = 6
sys_perf_event_open: pid 703  cpu 2  group_fd -1  flags 0x8 = 7
sys_perf_event_open: pid 703  cpu 3  group_fd -1  flags 0x8 = 9
sys_perf_event_open: pid 703  cpu 4  group_fd -1  flags 0x8 = 10
sys_perf_event_open: pid 703  cpu 5  group_fd -1  flags 0x8 = 11
sys_perf_event_open: pid 703  cpu 6  group_fd -1  flags 0x8 = 12
sys_perf_event_open: pid 703  cpu 7  group_fd -1  flags 0x8 = 13
<SNIP>
[ perf record: Captured and wrote 0.006 MB perf.data (116 samples) ]

Thanks,
Yang
