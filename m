Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB026747EA7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 09:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232350AbjGEHzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 03:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231985AbjGEHzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 03:55:00 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8B2B210DD;
        Wed,  5 Jul 2023 00:54:58 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5849C165C;
        Wed,  5 Jul 2023 00:55:40 -0700 (PDT)
Received: from [192.168.1.100] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9F5A53F73F;
        Wed,  5 Jul 2023 00:54:55 -0700 (PDT)
Message-ID: <e642f261-3f4a-37a5-921a-2ac2f4ff682f@arm.com>
Date:   Wed, 5 Jul 2023 08:54:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 2/2] perf test: Fix event parsing test when
 PERF_PMU_CAP_EXTENDED_HW_TYPE isn't supported.
To:     Ian Rogers <irogers@google.com>
Cc:     linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org
References: <20230704143628.1177124-1-james.clark@arm.com>
 <20230704143628.1177124-2-james.clark@arm.com>
 <CAP-5=fWt7jrRhS3CU6H-CqWJixnX4tZY+X=+oKhKwCjYcYZWwA@mail.gmail.com>
Content-Language: en-US
From:   James Clark <james.clark@arm.com>
In-Reply-To: <CAP-5=fWt7jrRhS3CU6H-CqWJixnX4tZY+X=+oKhKwCjYcYZWwA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/07/2023 18:12, Ian Rogers wrote:
> On Tue, Jul 4, 2023 at 7:38 AM James Clark <james.clark@arm.com> wrote:
>>
>> Arm has multiple PMU types for heterogeneous systems, but doesn't
>> currently support PERF_PMU_CAP_EXTENDED_HW_TYPE. Make the tests
>> support both scenarios so that they pass on Arm, and will still pass
>> once PERF_PMU_CAP_EXTENDED_HW_TYPE support is added.
>>
>> Fixes: 27c9fcfc1e14 ("perf test: Update parse-events expectations to test for multiple events")
>> Signed-off-by: James Clark <james.clark@arm.com>
>> ---
>>  tools/perf/tests/parse-events.c | 86 +++++++++++++++++++--------------
>>  1 file changed, 50 insertions(+), 36 deletions(-)
>>
>> diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
>> index 21f79aa31233..454b667e144b 100644
>> --- a/tools/perf/tests/parse-events.c
>> +++ b/tools/perf/tests/parse-events.c
>> @@ -20,6 +20,20 @@
>>  #define PERF_TP_SAMPLE_TYPE (PERF_SAMPLE_RAW | PERF_SAMPLE_TIME | \
>>                              PERF_SAMPLE_CPU | PERF_SAMPLE_PERIOD)
>>
>> +static int num_entries(void)
> 
> Thanks James! A nit, I'd prefer a function name that is a little less
> ambiguous, perhaps num_core_events_per_event which is too long,
> perhaps num_core_entries. Other than that:
> 
> Acked-by: Ian Rogers <irogers@google.com>
> 

Sure, will change and re-send. Thanks for the review.

> Ian
> 
>> +{
>> +       /*
>> +        * If the kernel supports extended type, expect events to be
>> +        * opened once for each PMU type. Otherwise fall back to the legacy
>> +        * behavior of opening only one event even though there are multiple
>> +        * PMUs
>> +        */
>> +       if (perf_pmus__supports_extended_type())
>> +               return perf_pmus__num_core_pmus();
>> +
>> +       return 1;
>> +}
>> +
>>  static bool test_config(const struct evsel *evsel, __u64 expected_config)
>>  {
>>         __u32 type = evsel->core.attr.type;
>> @@ -339,7 +353,7 @@ static int test__checkevent_symbolic_name_modifier(struct evlist *evlist)
>>         struct perf_evsel *evsel;
>>
>>         TEST_ASSERT_VAL("wrong number of entries",
>> -                       evlist->core.nr_entries == perf_pmus__num_core_pmus());
>> +                       evlist->core.nr_entries == num_entries());
>>
>>         perf_evlist__for_each_entry(&evlist->core, evsel) {
>>                 TEST_ASSERT_VAL("wrong exclude_user", evsel->attr.exclude_user);
>> @@ -842,11 +856,11 @@ static int test__group1(struct evlist *evlist)
>>         struct evsel *evsel, *leader;
>>
>>         TEST_ASSERT_VAL("wrong number of entries",
>> -                       evlist->core.nr_entries == (perf_pmus__num_core_pmus() * 2));
>> +                       evlist->core.nr_entries == (num_entries() * 2));
>>         TEST_ASSERT_VAL("wrong number of groups",
>> -                       evlist__nr_groups(evlist) == perf_pmus__num_core_pmus());
>> +                       evlist__nr_groups(evlist) == num_entries());
>>
>> -       for (int i = 0; i < perf_pmus__num_core_pmus(); i++) {
>> +       for (int i = 0; i < num_entries(); i++) {
>>                 /* instructions:k */
>>                 evsel = leader = (i == 0 ? evlist__first(evlist) : evsel__next(evsel));
>>                 TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
>> @@ -885,7 +899,7 @@ static int test__group2(struct evlist *evlist)
>>         struct evsel *evsel, *leader = NULL;
>>
>>         TEST_ASSERT_VAL("wrong number of entries",
>> -                       evlist->core.nr_entries == (2 * perf_pmus__num_core_pmus() + 1));
>> +                       evlist->core.nr_entries == (2 * num_entries() + 1));
>>         /*
>>          * TODO: Currently the software event won't be grouped with the hardware
>>          * event except for 1 PMU.
>> @@ -1051,11 +1065,11 @@ static int test__group4(struct evlist *evlist __maybe_unused)
>>         struct evsel *evsel, *leader;
>>
>>         TEST_ASSERT_VAL("wrong number of entries",
>> -                       evlist->core.nr_entries == (perf_pmus__num_core_pmus() * 2));
>> +                       evlist->core.nr_entries == (num_entries() * 2));
>>         TEST_ASSERT_VAL("wrong number of groups",
>> -                       perf_pmus__num_core_pmus() == evlist__nr_groups(evlist));
>> +                       num_entries() == evlist__nr_groups(evlist));
>>
>> -       for (int i = 0; i < perf_pmus__num_core_pmus(); i++) {
>> +       for (int i = 0; i < num_entries(); i++) {
>>                 /* cycles:u + p */
>>                 evsel = leader = (i == 0 ? evlist__first(evlist) : evsel__next(evsel));
>>                 TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
>> @@ -1096,11 +1110,11 @@ static int test__group5(struct evlist *evlist __maybe_unused)
>>         struct evsel *evsel = NULL, *leader;
>>
>>         TEST_ASSERT_VAL("wrong number of entries",
>> -                       evlist->core.nr_entries == (5 * perf_pmus__num_core_pmus()));
>> +                       evlist->core.nr_entries == (5 * num_entries()));
>>         TEST_ASSERT_VAL("wrong number of groups",
>> -                       evlist__nr_groups(evlist) == (2 * perf_pmus__num_core_pmus()));
>> +                       evlist__nr_groups(evlist) == (2 * num_entries()));
>>
>> -       for (int i = 0; i < perf_pmus__num_core_pmus(); i++) {
>> +       for (int i = 0; i < num_entries(); i++) {
>>                 /* cycles + G */
>>                 evsel = leader = (i == 0 ? evlist__first(evlist) : evsel__next(evsel));
>>                 TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
>> @@ -1131,7 +1145,7 @@ static int test__group5(struct evlist *evlist __maybe_unused)
>>                 TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 1);
>>                 TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
>>         }
>> -       for (int i = 0; i < perf_pmus__num_core_pmus(); i++) {
>> +       for (int i = 0; i < num_entries(); i++) {
>>                 /* cycles:G */
>>                 evsel = leader = evsel__next(evsel);
>>                 TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
>> @@ -1161,7 +1175,7 @@ static int test__group5(struct evlist *evlist __maybe_unused)
>>                 TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
>>                 TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 1);
>>         }
>> -       for (int i = 0; i < perf_pmus__num_core_pmus(); i++) {
>> +       for (int i = 0; i < num_entries(); i++) {
>>                 /* cycles */
>>                 evsel = evsel__next(evsel);
>>                 TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
>> @@ -1182,11 +1196,11 @@ static int test__group_gh1(struct evlist *evlist)
>>         struct evsel *evsel = NULL, *leader;
>>
>>         TEST_ASSERT_VAL("wrong number of entries",
>> -                       evlist->core.nr_entries == (2 * perf_pmus__num_core_pmus()));
>> +                       evlist->core.nr_entries == (2 * num_entries()));
>>         TEST_ASSERT_VAL("wrong number of groups",
>> -                       evlist__nr_groups(evlist) == perf_pmus__num_core_pmus());
>> +                       evlist__nr_groups(evlist) == num_entries());
>>
>> -       for (int i = 0; i < perf_pmus__num_core_pmus(); i++) {
>> +       for (int i = 0; i < num_entries(); i++) {
>>                 /* cycles + :H group modifier */
>>                 evsel = leader = (i == 0 ? evlist__first(evlist) : evsel__next(evsel));
>>                 TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
>> @@ -1223,11 +1237,11 @@ static int test__group_gh2(struct evlist *evlist)
>>         struct evsel *evsel = NULL, *leader;
>>
>>         TEST_ASSERT_VAL("wrong number of entries",
>> -                       evlist->core.nr_entries == (2 * perf_pmus__num_core_pmus()));
>> +                       evlist->core.nr_entries == (2 * num_entries()));
>>         TEST_ASSERT_VAL("wrong number of groups",
>> -                       evlist__nr_groups(evlist) == perf_pmus__num_core_pmus());
>> +                       evlist__nr_groups(evlist) == num_entries());
>>
>> -       for (int i = 0; i < perf_pmus__num_core_pmus(); i++) {
>> +       for (int i = 0; i < num_entries(); i++) {
>>                 /* cycles + :G group modifier */
>>                 evsel = leader = (i == 0 ? evlist__first(evlist) : evsel__next(evsel));
>>                 TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
>> @@ -1264,11 +1278,11 @@ static int test__group_gh3(struct evlist *evlist)
>>         struct evsel *evsel = NULL, *leader;
>>
>>         TEST_ASSERT_VAL("wrong number of entries",
>> -                       evlist->core.nr_entries == (2 * perf_pmus__num_core_pmus()));
>> +                       evlist->core.nr_entries == (2 * num_entries()));
>>         TEST_ASSERT_VAL("wrong number of groups",
>> -                       evlist__nr_groups(evlist) == perf_pmus__num_core_pmus());
>> +                       evlist__nr_groups(evlist) == num_entries());
>>
>> -       for (int i = 0; i < perf_pmus__num_core_pmus(); i++) {
>> +       for (int i = 0; i < num_entries(); i++) {
>>                 /* cycles:G + :u group modifier */
>>                 evsel = leader = (i == 0 ? evlist__first(evlist) : evsel__next(evsel));
>>                 TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
>> @@ -1305,11 +1319,11 @@ static int test__group_gh4(struct evlist *evlist)
>>         struct evsel *evsel = NULL, *leader;
>>
>>         TEST_ASSERT_VAL("wrong number of entries",
>> -                       evlist->core.nr_entries == (2 * perf_pmus__num_core_pmus()));
>> +                       evlist->core.nr_entries == (2 * num_entries()));
>>         TEST_ASSERT_VAL("wrong number of groups",
>> -                       evlist__nr_groups(evlist) == perf_pmus__num_core_pmus());
>> +                       evlist__nr_groups(evlist) == num_entries());
>>
>> -       for (int i = 0; i < perf_pmus__num_core_pmus(); i++) {
>> +       for (int i = 0; i < num_entries(); i++) {
>>                 /* cycles:G + :uG group modifier */
>>                 evsel = leader = (i == 0 ? evlist__first(evlist) : evsel__next(evsel));
>>                 TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
>> @@ -1346,9 +1360,9 @@ static int test__leader_sample1(struct evlist *evlist)
>>         struct evsel *evsel = NULL, *leader;
>>
>>         TEST_ASSERT_VAL("wrong number of entries",
>> -                       evlist->core.nr_entries == (3 * perf_pmus__num_core_pmus()));
>> +                       evlist->core.nr_entries == (3 * num_entries()));
>>
>> -       for (int i = 0; i < perf_pmus__num_core_pmus(); i++) {
>> +       for (int i = 0; i < num_entries(); i++) {
>>                 /* cycles - sampling group leader */
>>                 evsel = leader = (i == 0 ? evlist__first(evlist) : evsel__next(evsel));
>>                 TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
>> @@ -1398,9 +1412,9 @@ static int test__leader_sample2(struct evlist *evlist __maybe_unused)
>>         struct evsel *evsel = NULL, *leader;
>>
>>         TEST_ASSERT_VAL("wrong number of entries",
>> -                       evlist->core.nr_entries == (2 * perf_pmus__num_core_pmus()));
>> +                       evlist->core.nr_entries == (2 * num_entries()));
>>
>> -       for (int i = 0; i < perf_pmus__num_core_pmus(); i++) {
>> +       for (int i = 0; i < num_entries(); i++) {
>>                 /* instructions - sampling group leader */
>>                 evsel = leader = (i == 0 ? evlist__first(evlist) : evsel__next(evsel));
>>                 TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
>> @@ -1437,9 +1451,9 @@ static int test__checkevent_pinned_modifier(struct evlist *evlist)
>>         struct evsel *evsel = NULL;
>>
>>         TEST_ASSERT_VAL("wrong number of entries",
>> -                       evlist->core.nr_entries == perf_pmus__num_core_pmus());
>> +                       evlist->core.nr_entries == num_entries());
>>
>> -       for (int i = 0; i < perf_pmus__num_core_pmus(); i++) {
>> +       for (int i = 0; i < num_entries(); i++) {
>>                 evsel = (i == 0 ? evlist__first(evlist) : evsel__next(evsel));
>>                 TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
>>                 TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
>> @@ -1455,9 +1469,9 @@ static int test__pinned_group(struct evlist *evlist)
>>         struct evsel *evsel = NULL, *leader;
>>
>>         TEST_ASSERT_VAL("wrong number of entries",
>> -                       evlist->core.nr_entries == (3 * perf_pmus__num_core_pmus()));
>> +                       evlist->core.nr_entries == (3 * num_entries()));
>>
>> -       for (int i = 0; i < perf_pmus__num_core_pmus(); i++) {
>> +       for (int i = 0; i < num_entries(); i++) {
>>                 /* cycles - group leader */
>>                 evsel = leader = (i == 0 ? evlist__first(evlist) : evsel__next(evsel));
>>                 TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
>> @@ -1500,9 +1514,9 @@ static int test__exclusive_group(struct evlist *evlist)
>>         struct evsel *evsel = NULL, *leader;
>>
>>         TEST_ASSERT_VAL("wrong number of entries",
>> -                       evlist->core.nr_entries == (3 * perf_pmus__num_core_pmus()));
>> +                       evlist->core.nr_entries == 3 * num_entries());
>>
>> -       for (int i = 0; i < perf_pmus__num_core_pmus(); i++) {
>> +       for (int i = 0; i < num_entries(); i++) {
>>                 /* cycles - group leader */
>>                 evsel = leader = (i == 0 ? evlist__first(evlist) : evsel__next(evsel));
>>                 TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
>> @@ -1574,7 +1588,7 @@ static int test__checkevent_precise_max_modifier(struct evlist *evlist)
>>         struct evsel *evsel = evlist__first(evlist);
>>
>>         TEST_ASSERT_VAL("wrong number of entries",
>> -                       evlist->core.nr_entries == (1 + perf_pmus__num_core_pmus()));
>> +                       evlist->core.nr_entries == 1 + num_entries());
>>         TEST_ASSERT_VAL("wrong type", PERF_TYPE_SOFTWARE == evsel->core.attr.type);
>>         TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_SW_TASK_CLOCK));
>>         return TEST_OK;
>> --
>> 2.34.1
>>
