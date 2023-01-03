Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77BFA65BF56
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 12:50:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237392AbjACLt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 06:49:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbjACLty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 06:49:54 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 18E16B7B;
        Tue,  3 Jan 2023 03:49:53 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 724111516;
        Tue,  3 Jan 2023 03:50:34 -0800 (PST)
Received: from [10.32.36.24] (e121896.Emea.Arm.com [10.32.36.24])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7666D3F587;
        Tue,  3 Jan 2023 03:49:48 -0800 (PST)
Message-ID: <5dad3c40-d4d2-57b8-e6f5-10fa5ef1a0b8@arm.com>
Date:   Tue, 3 Jan 2023 11:49:46 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 6/7] perf cs_etm: Record ts_source in AUXTRACE_INFO for
 ETMv4 and ETE
Content-Language: en-US
To:     Mike Leach <mike.leach@linaro.org>
Cc:     linux-perf-users@vger.kernel.org, tanmay@marvell.com,
        sgoutham@marvell.com, gcherian@marvell.com, lcherian@marvell.com,
        bbhushan2@marvell.com, German Gomez <german.gomez@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221222160328.3639989-1-james.clark@arm.com>
 <20221222160328.3639989-7-james.clark@arm.com>
 <CAJ9a7VjbF2DFRHOtdCt=3o+iNrA++swpJBx9v5-R9Ky8tc4Mvw@mail.gmail.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <CAJ9a7VjbF2DFRHOtdCt=3o+iNrA++swpJBx9v5-R9Ky8tc4Mvw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/12/2022 09:28, Mike Leach wrote:
> Hi,
> 
> There was a discussion some time ago in one of our coresight regular
> dev meetings about this.
> 
> Can we just use only the necessary bits that TS source needs and leave
> the remaining bits from the 64 as unused  for future expansion - i..e
> use this as a bitfield rather than have 64 bits occupied for what is
> effectively a 2 bit value.
> 
> Perhaps call the full value something other than TS_SOURCE and have a
> TS_SOURCE field with a known safe unset value.

If we did that, there wouldn't be any mechanism to detect if new values
that were added were the value 0, or just not set/implemented/saved in
the file. The current implementation of CS_ETM_NR_TRC_PARAMS allows us
to add new fields, and detect if they exist or not without bumping the
header version for each new sub field.

In this change HAS_PARAM() has been used to do this, but that can't be
expanded to sub fields in the same 64 bits. I don't think space or
performance are worth the extra complexity of dividing it up. And
because this is just one block saved once in the header, so I'm not sure
if it's worth it in this case. It would also make it harder to read the
values on the raw dump mode.

James

> 
> Thanks
> 
> Mike
> 
> On Thu, 22 Dec 2022 at 16:07, James Clark <james.clark@arm.com> wrote:
>>
>> From: German Gomez <german.gomez@arm.com>
>>
>> Read the value of ts_source exposed by the driver and store it in the
>> ETMv4 and ETE header. If the interface doesn't exist (such as in older
>> Kernels), defaults to a safe value of -1.
>>
>> Signed-off-by: German Gomez <german.gomez@arm.com>
>> Signed-off-by: James Clark <james.clark@arm.com>
>> ---
>>  tools/perf/arch/arm/util/cs-etm.c | 48 +++++++++++++++++++++++++++++++
>>  tools/perf/util/cs-etm-base.c     |  2 ++
>>  tools/perf/util/cs-etm.h          |  2 ++
>>  3 files changed, 52 insertions(+)
>>
>> diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
>> index b526ffe550a5..481e170cd3f1 100644
>> --- a/tools/perf/arch/arm/util/cs-etm.c
>> +++ b/tools/perf/arch/arm/util/cs-etm.c
>> @@ -53,6 +53,7 @@ static const char * const metadata_etmv4_ro[] = {
>>         [CS_ETMV4_TRCIDR2]              = "trcidr/trcidr2",
>>         [CS_ETMV4_TRCIDR8]              = "trcidr/trcidr8",
>>         [CS_ETMV4_TRCAUTHSTATUS]        = "mgmt/trcauthstatus",
>> +       [CS_ETMV4_TS_SOURCE]            = "ts_source",
>>  };
>>
>>  static const char * const metadata_ete_ro[] = {
>> @@ -62,6 +63,7 @@ static const char * const metadata_ete_ro[] = {
>>         [CS_ETE_TRCIDR8]                = "trcidr/trcidr8",
>>         [CS_ETE_TRCAUTHSTATUS]          = "mgmt/trcauthstatus",
>>         [CS_ETE_TRCDEVARCH]             = "mgmt/trcdevarch",
>> +       [CS_ETE_TS_SOURCE]              = "ts_source",
>>  };
>>
>>  static bool cs_etm_is_etmv4(struct auxtrace_record *itr, int cpu);
>> @@ -613,6 +615,32 @@ static int cs_etm_get_ro(struct perf_pmu *pmu, int cpu, const char *path)
>>         return val;
>>  }
>>
>> +static int cs_etm_get_ro_signed(struct perf_pmu *pmu, int cpu, const char *path)
>> +{
>> +       char pmu_path[PATH_MAX];
>> +       int scan;
>> +       int val = 0;
>> +
>> +       /* Get RO metadata from sysfs */
>> +       snprintf(pmu_path, PATH_MAX, "cpu%d/%s", cpu, path);
>> +
>> +       scan = perf_pmu__scan_file(pmu, pmu_path, "%d", &val);
>> +       if (scan != 1)
>> +               pr_err("%s: error reading: %s\n", __func__, pmu_path);
>> +
>> +       return val;
>> +}
>> +
>> +static bool cs_etm_pmu_path_exists(struct perf_pmu *pmu, int cpu, const char *path)
>> +{
>> +       char pmu_path[PATH_MAX];
>> +
>> +       /* Get RO metadata from sysfs */
>> +       snprintf(pmu_path, PATH_MAX, "cpu%d/%s", cpu, path);
>> +
>> +       return perf_pmu__file_exists(pmu, pmu_path);
>> +}
>> +
>>  #define TRCDEVARCH_ARCHPART_SHIFT 0
>>  #define TRCDEVARCH_ARCHPART_MASK  GENMASK(11, 0)
>>  #define TRCDEVARCH_ARCHPART(x)    (((x) & TRCDEVARCH_ARCHPART_MASK) >> TRCDEVARCH_ARCHPART_SHIFT)
>> @@ -654,6 +682,16 @@ static void cs_etm_save_etmv4_header(__u64 data[], struct auxtrace_record *itr,
>>                                                metadata_etmv4_ro[CS_ETMV4_TRCIDR8]);
>>         data[CS_ETMV4_TRCAUTHSTATUS] = cs_etm_get_ro(cs_etm_pmu, cpu,
>>                                                      metadata_etmv4_ro[CS_ETMV4_TRCAUTHSTATUS]);
>> +
>> +       /* Kernels older than 5.19 may not expose ts_source */
>> +       if (cs_etm_pmu_path_exists(cs_etm_pmu, cpu, metadata_etmv4_ro[CS_ETMV4_TS_SOURCE]))
>> +               data[CS_ETMV4_TS_SOURCE] = (__u64) cs_etm_get_ro_signed(cs_etm_pmu, cpu,
>> +                               metadata_etmv4_ro[CS_ETMV4_TS_SOURCE]);
>> +       else {
>> +               pr_warning("[%03d] pmu file 'ts_source' not found. Fallback to safe value (-1)\n",
>> +                          cpu);
>> +               data[CS_ETMV4_TS_SOURCE] = (__u64) -1;
>> +       }
>>  }
>>
>>  static void cs_etm_save_ete_header(__u64 data[], struct auxtrace_record *itr, int cpu)
>> @@ -679,6 +717,16 @@ static void cs_etm_save_ete_header(__u64 data[], struct auxtrace_record *itr, in
>>         /* ETE uses the same registers as ETMv4 plus TRCDEVARCH */
>>         data[CS_ETE_TRCDEVARCH] = cs_etm_get_ro(cs_etm_pmu, cpu,
>>                                                 metadata_ete_ro[CS_ETE_TRCDEVARCH]);
>> +
>> +       /* Kernels older than 5.19 may not expose ts_source */
>> +       if (cs_etm_pmu_path_exists(cs_etm_pmu, cpu, metadata_ete_ro[CS_ETE_TS_SOURCE]))
>> +               data[CS_ETE_TS_SOURCE] = (__u64) cs_etm_get_ro_signed(cs_etm_pmu, cpu,
>> +                               metadata_ete_ro[CS_ETE_TS_SOURCE]);
>> +       else {
>> +               pr_warning("[%03d] pmu file 'ts_source' not found. Fallback to safe value (-1)\n",
>> +                          cpu);
>> +               data[CS_ETE_TS_SOURCE] = (__u64) -1;
>> +       }
>>  }
>>
>>  static void cs_etm_get_metadata(int cpu, u32 *offset,
>> diff --git a/tools/perf/util/cs-etm-base.c b/tools/perf/util/cs-etm-base.c
>> index 282042c6e944..5f48b756c4cf 100644
>> --- a/tools/perf/util/cs-etm-base.c
>> +++ b/tools/perf/util/cs-etm-base.c
>> @@ -36,6 +36,7 @@ static const char * const cs_etmv4_priv_fmts[] = {
>>         [CS_ETMV4_TRCIDR2]      = "     TRCIDR2                        %llx\n",
>>         [CS_ETMV4_TRCIDR8]      = "     TRCIDR8                        %llx\n",
>>         [CS_ETMV4_TRCAUTHSTATUS] = "    TRCAUTHSTATUS                  %llx\n",
>> +       [CS_ETMV4_TS_SOURCE]    = "     TS_SOURCE                      %lld\n",
>>  };
>>
>>  static const char * const cs_ete_priv_fmts[] = {
>> @@ -50,6 +51,7 @@ static const char * const cs_ete_priv_fmts[] = {
>>         [CS_ETE_TRCIDR8]        = "     TRCIDR8                        %llx\n",
>>         [CS_ETE_TRCAUTHSTATUS]  = "     TRCAUTHSTATUS                  %llx\n",
>>         [CS_ETE_TRCDEVARCH]     = "     TRCDEVARCH                     %llx\n",
>> +       [CS_ETE_TS_SOURCE]      = "     TS_SOURCE                      %lld\n",
>>  };
>>
>>  static const char * const param_unk_fmt =
>> diff --git a/tools/perf/util/cs-etm.h b/tools/perf/util/cs-etm.h
>> index c5925428afa9..ad790930bcbc 100644
>> --- a/tools/perf/util/cs-etm.h
>> +++ b/tools/perf/util/cs-etm.h
>> @@ -71,6 +71,7 @@ enum {
>>         CS_ETMV4_TRCIDR2,
>>         CS_ETMV4_TRCIDR8,
>>         CS_ETMV4_TRCAUTHSTATUS,
>> +       CS_ETMV4_TS_SOURCE,
>>         CS_ETMV4_PRIV_MAX,
>>  };
>>
>> @@ -92,6 +93,7 @@ enum {
>>         CS_ETE_TRCIDR8,
>>         CS_ETE_TRCAUTHSTATUS,
>>         CS_ETE_TRCDEVARCH,
>> +       CS_ETE_TS_SOURCE,
>>         CS_ETE_PRIV_MAX
>>  };
>>
>> --
>> 2.25.1
>>
> 
> 
