Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41A407509B5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 15:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232359AbjGLNig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 09:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232401AbjGLNic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 09:38:32 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 777171BC5;
        Wed, 12 Jul 2023 06:38:27 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 92A58D75;
        Wed, 12 Jul 2023 06:39:09 -0700 (PDT)
Received: from [192.168.1.3] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 606A03F67D;
        Wed, 12 Jul 2023 06:38:24 -0700 (PDT)
Message-ID: <516face0-fc2f-453c-df9a-f6ebe47c687f@arm.com>
Date:   Wed, 12 Jul 2023 14:38:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 2/5] perf jevents: Match on highest version of Arm json
 file available
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>
Cc:     linux-perf-users@vger.kernel.org, renyu.zj@linux.alibaba.com,
        john.g.garry@oracle.com, namhyung@kernel.org, acme@kernel.org,
        Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Nick Forrington <nick.forrington@arm.com>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230711100218.1651995-1-james.clark@arm.com>
 <20230711100218.1651995-3-james.clark@arm.com>
 <CAP-5=fUJavikRkhm601ws+=yB3As1X0Au9Fr-5Z=BemGW9xjyw@mail.gmail.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <CAP-5=fUJavikRkhm601ws+=yB3As1X0Au9Fr-5Z=BemGW9xjyw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/07/2023 01:39, Ian Rogers wrote:
> On Tue, Jul 11, 2023 at 3:02 AM James Clark <james.clark@arm.com> wrote:
>>
>> Currently variant and revision fields are masked out of the MIDR so
>> there can only be one set of jsons per CPU. In a later commit multiple
>> revisions of Neoverse N2 json files will be provided. This can be used
>> when a change is made to a new CPU version that fixes an event or metric
>> formula.
>>
>> The highest valid version of json files should be used. For example if
>> r0p0 and r1p0 JSON files are both provided, then r0p0 files will be used
>> for all CPU versions up to (not including) r1p0, and then from r1p0
>> onwards the r1p0 files will be used. To make this work the mapfile has
>> to be reverse sorted on the CPUID field so that the highest is found
>> first. It's possible, but error prone, to do this manually so instead
>> add an explicit sort into jevents.py. If the CPUID is a string then the
>> rows are string sorted rather than numerically.
>>
>> Signed-off-by: James Clark <james.clark@arm.com>
>> ---
>>  tools/perf/arch/arm64/util/header.c          | 61 +++++++++++++++-----
>>  tools/perf/pmu-events/arch/arm64/mapfile.csv | 12 +++-
>>  tools/perf/pmu-events/jevents.py             | 49 +++++++++-------
>>  tools/perf/tests/pmu-events.c                | 34 +++++++++++
>>  4 files changed, 119 insertions(+), 37 deletions(-)
>>
>> diff --git a/tools/perf/arch/arm64/util/header.c b/tools/perf/arch/arm64/util/header.c
>> index 80b9f6287fe2..637ad21721c2 100644
>> --- a/tools/perf/arch/arm64/util/header.c
>> +++ b/tools/perf/arch/arm64/util/header.c
>> @@ -1,3 +1,6 @@
>> +#include <linux/kernel.h>
>> +#include <linux/bits.h>
>> +#include <linux/bitfield.h>
>>  #include <stdio.h>
>>  #include <stdlib.h>
>>  #include <perf/cpumap.h>
>> @@ -10,14 +13,12 @@
>>
>>  #define MIDR "/regs/identification/midr_el1"
>>  #define MIDR_SIZE 19
>> -#define MIDR_REVISION_MASK      0xf
>> -#define MIDR_VARIANT_SHIFT      20
>> -#define MIDR_VARIANT_MASK       (0xf << MIDR_VARIANT_SHIFT)
>> +#define MIDR_REVISION_MASK      GENMASK(3, 0)
>> +#define MIDR_VARIANT_MASK      GENMASK(23, 20)
>>
>>  static int _get_cpuid(char *buf, size_t sz, struct perf_cpu_map *cpus)
>>  {
>>         const char *sysfs = sysfs__mountpoint();
>> -       u64 midr = 0;
>>         int cpu;
>>
>>         if (!sysfs || sz < MIDR_SIZE)
>> @@ -44,21 +45,11 @@ static int _get_cpuid(char *buf, size_t sz, struct perf_cpu_map *cpus)
>>                 }
>>                 fclose(file);
>>
>> -               /* Ignore/clear Variant[23:20] and
>> -                * Revision[3:0] of MIDR
>> -                */
>> -               midr = strtoul(buf, NULL, 16);
>> -               midr &= (~(MIDR_VARIANT_MASK | MIDR_REVISION_MASK));
>> -               scnprintf(buf, MIDR_SIZE, "0x%016lx", midr);
>>                 /* got midr break loop */
>>                 break;
>>         }
>>
>>         perf_cpu_map__put(cpus);
>> -
>> -       if (!midr)
>> -               return EINVAL;
>> -
>>         return 0;
>>  }
>>
>> @@ -99,3 +90,45 @@ char *get_cpuid_str(struct perf_pmu *pmu)
>>
>>         return buf;
>>  }
>> +
>> +
>> +int strcmp_cpuid_str(const char *mapcpuid, const char *idstr)
>> +{
>> +       u64 map_id = strtoull(mapcpuid, NULL, 16);
>> +       char map_id_variant = FIELD_GET(MIDR_VARIANT_MASK, map_id);
>> +       char map_id_revision = FIELD_GET(MIDR_REVISION_MASK, map_id);
>> +       u64 id = strtoull(idstr, NULL, 16);
>> +       char id_variant = FIELD_GET(MIDR_VARIANT_MASK, id);
>> +       char id_revision = FIELD_GET(MIDR_REVISION_MASK, id);
>> +       u64 id_fields = ~(MIDR_VARIANT_MASK | MIDR_REVISION_MASK);
>> +
>> +       /* Compare without version first */
>> +       if ((map_id & id_fields) != (id & id_fields))
>> +               return 1;
>> +
>> +       /*
>> +        * ID matches, now compare version.
>> +        *
>> +        * Arm revisions (like r0p0) are compared here like two digit semver
>> +        * values eg. 1.3 < 2.0 < 2.1 < 2.2. The events json file with the
>> +        * highest matching version is used.
>> +        *
>> +        *  r = high value = 'Variant' field in MIDR
>> +        *  p = low value  = 'Revision' field in MIDR
>> +        *
>> +        * Because the Variant field is further to the left, iterating through a
>> +        * reverse sorted mapfile.csv gives the correct comparison behavior.
>> +        * This relies on jevents.py sorting the list in print_mapping_table().
>> +        */
>> +       if (id_variant > map_id_variant)
>> +               return 0;
>> +
>> +       if (id_variant == map_id_variant && id_revision >= map_id_revision)
>> +               return 0;
>> +
>> +       /*
>> +        * variant is less than mapfile variant or variants are the same but
>> +        * the revision doesn't match. Return no match.
>> +        */
>> +       return 1;
>> +}
>> diff --git a/tools/perf/pmu-events/arch/arm64/mapfile.csv b/tools/perf/pmu-events/arch/arm64/mapfile.csv
>> index 32674ddd2b63..3a90fe650863 100644
>> --- a/tools/perf/pmu-events/arch/arm64/mapfile.csv
>> +++ b/tools/perf/pmu-events/arch/arm64/mapfile.csv
>> @@ -3,7 +3,17 @@
>>  #
>>  # where
>>  #      MIDR    Processor version
>> -#              Variant[23:20] and Revision [3:0] should be zero.
>> +#              Variant[23:20] and Revision [3:0] should be set to the
>> +#               lowest supported version for that set of JSON files.
>> +#               Multiple versions of the same CPU can be provided and
>> +#               the highest version JSON files available will be used.
>> +#
>> +#               For example for a single set of JSONs, if variant and
>> +#               revision are both set to 0 then the JSONs will match all
>> +#               CPU versions. If another set is provided with variant
>> +#               set to 1, the previous JSONs will match all versions up
>> +#               to r1p0, and then r1p0 CPUs and above will start to
>> +#               match the next set of JSONs provided.
>>  #      Version could be used to track version of of JSON file
>>  #              but currently unused.
>>  #      JSON/file/pathname is the path to JSON file, relative
>> diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
>> index 12e80bb7939b..c6a848f8d93a 100755
>> --- a/tools/perf/pmu-events/jevents.py
>> +++ b/tools/perf/pmu-events/jevents.py
>> @@ -620,28 +620,34 @@ const struct pmu_events_map pmu_events_map[] = {
>>  },
>>  """)
>>      else:
>> +      def int_or_string_key(row):
>> +        try:
>> +          return int(row[0], 0)
>> +        except:
>> +          return row[0]
>>        with open(f'{_args.starting_dir}/{arch}/mapfile.csv') as csvfile:
>> -        table = csv.reader(csvfile)
>> -        first = True
>> -        for row in table:
>> -          # Skip the first row or any row beginning with #.
>> -          if not first and len(row) > 0 and not row[0].startswith('#'):
>> -            event_tblname = file_name_to_table_name('pmu_events_', [], row[2].replace('/', '_'))
>> -            if event_tblname in _event_tables:
>> -              event_size = f'ARRAY_SIZE({event_tblname})'
>> -            else:
>> -              event_tblname = 'NULL'
>> -              event_size = '0'
>> -            metric_tblname = file_name_to_table_name('pmu_metrics_', [], row[2].replace('/', '_'))
>> -            if metric_tblname in _metric_tables:
>> -              metric_size = f'ARRAY_SIZE({metric_tblname})'
>> -            else:
>> -              metric_tblname = 'NULL'
>> -              metric_size = '0'
>> -            if event_size == '0' and metric_size == '0':
>> -              continue
>> -            cpuid = row[0].replace('\\', '\\\\')
>> -            _args.output_file.write(f"""{{
>> +        table = [row for row in csv.reader(csvfile)]
>> +      # Strip the first row or any row beginning with #.
>> +      table = [row for row in table[1:] if len(row) > 0 and not row[0].startswith('#')]
>> +      # Sort on CPUID field for predictable >= version comparisons later on
>> +      table = sorted(table, key=int_or_string_key, reverse=True)
>> +      for row in table:
> 
> nit: kind of weird diff is seeing this as changed, the rest is
> explainable by the switch to the list comprehension.
> 

It's just because I copy the whole table first so technically everything
doesn't need to be inside the 'with' block anymore. But it doesn't
really matter to leave it in the block and the diff will be much smaller
so I can undo that change.

>> +        event_tblname = file_name_to_table_name('pmu_events_', [], row[2].replace('/', '_'))
>> +        if event_tblname in _event_tables:
>> +          event_size = f'ARRAY_SIZE({event_tblname})'
>> +        else:
>> +          event_tblname = 'NULL'
>> +          event_size = '0'
>> +        metric_tblname = file_name_to_table_name('pmu_metrics_', [], row[2].replace('/', '_'))
>> +        if metric_tblname in _metric_tables:
>> +          metric_size = f'ARRAY_SIZE({metric_tblname})'
>> +        else:
>> +          metric_tblname = 'NULL'
>> +          metric_size = '0'
>> +        if event_size == '0' and metric_size == '0':
>> +          continue
>> +        cpuid = row[0].replace('\\', '\\\\')
>> +        _args.output_file.write(f"""{{
>>  \t.arch = "{arch}",
>>  \t.cpuid = "{cpuid}",
>>  \t.event_table = {{
>> @@ -654,7 +660,6 @@ const struct pmu_events_map pmu_events_map[] = {
>>  \t}}
>>  }},
>>  """)
>> -          first = False
>>
>>    _args.output_file.write("""{
>>  \t.arch = 0,
>> diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
>> index 64383fc34ef1..e730d4792bbe 100644
>> --- a/tools/perf/tests/pmu-events.c
>> +++ b/tools/perf/tests/pmu-events.c
>> @@ -14,6 +14,7 @@
>>  #include "util/evlist.h"
>>  #include "util/expr.h"
>>  #include "util/hashmap.h"
>> +#include "util/header.h"
>>  #include "util/parse-events.h"
>>  #include "metricgroup.h"
>>  #include "stat.h"
>> @@ -1027,6 +1028,38 @@ static int test__parsing_threshold(struct test_suite *test __maybe_unused,
>>         return pmu_for_each_sys_metric(test__parsing_threshold_callback, NULL);
>>  }
>>
>> +static int test__cpuid_match(struct test_suite *test __maybe_unused,
>> +                                      int subtest __maybe_unused)
>> +{
>> +#ifdef __aarch64__
> 
> This feels like it should be in: tools/perf/arch/arm64/tests/
> 
> Thanks,
> Ian
> 

Yep that works, I will move it there.

James

>> +       /* midr with no leading zeros matches */
>> +       if (strcmp_cpuid_str("0x410fd0c0", "0x00000000410fd0c0"))
>> +               return -1;
>> +       /* Upper case matches */
>> +       if (strcmp_cpuid_str("0x410fd0c0", "0x00000000410FD0C0"))
>> +               return -1;
>> +       /* r0p0 = r0p0 matches */
>> +       if (strcmp_cpuid_str("0x00000000410fd480", "0x00000000410fd480"))
>> +               return -1;
>> +       /* r0p1 > r0p0 matches */
>> +       if (strcmp_cpuid_str("0x00000000410fd480", "0x00000000410fd481"))
>> +               return -1;
>> +       /* r1p0 > r0p0 matches*/
>> +       if (strcmp_cpuid_str("0x00000000410fd480", "0x00000000411fd480"))
>> +               return -1;
>> +       /* r0p0 < r0p1 doesn't match */
>> +       if (!strcmp_cpuid_str("0x00000000410fd481", "0x00000000410fd480"))
>> +               return -1;
>> +       /* r0p0 < r1p0 doesn't match */
>> +       if (!strcmp_cpuid_str("0x00000000411fd480", "0x00000000410fd480"))
>> +               return -1;
>> +       /* Different CPU doesn't match */
>> +       if (!strcmp_cpuid_str("0x00000000410fd4c0", "0x00000000430f0af0"))
>> +               return -1;
>> +#endif
>> +       return 0;
>> +}
>> +
>>  static struct test_case pmu_events_tests[] = {
>>         TEST_CASE("PMU event table sanity", pmu_event_table),
>>         TEST_CASE("PMU event map aliases", aliases),
>> @@ -1034,6 +1067,7 @@ static struct test_case pmu_events_tests[] = {
>>                          "some metrics failed"),
>>         TEST_CASE("Parsing of PMU event table metrics with fake PMUs", parsing_fake),
>>         TEST_CASE("Parsing of metric thresholds with fake PMUs", parsing_threshold),
>> +       TEST_CASE("CPUID matching", cpuid_match),
>>         { .name = NULL, }
>>  };
>>
>> --
>> 2.34.1
>>
