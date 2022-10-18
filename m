Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFB0960237A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 06:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbiJREvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 00:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbiJREv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 00:51:27 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D32CD7A537;
        Mon, 17 Oct 2022 21:51:26 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29I4a4XA001537;
        Tue, 18 Oct 2022 04:51:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=pp1;
 bh=r0YBfDEHK2lim8rNHq3KqqHCkyhzMgzEfoVgC3OpJEs=;
 b=Ftj83N9sHmuIWD5Ra01wNSiYf2ylZmJmDolEbrNsvs4drC9/JdQ/4Vz0odWisZaOxwry
 tMYNnihDdk3IoPeSQb5IakP7H0f3ndMSB4lOInlmRzy6DkJqvCJ7v4RVIl89vtAwAZPF
 Mggd8otrNi6KfLdEGl4MesZzWyM1rM6PFw7QkqXamSUbtllzWSG3jAj5/W0PPtttpcbt
 +qK9aGbeo57XkvJ+2O+nyMJmg858Rbil8wet4Q0u0g/XUxOGOIAvYKYNEjpwQFjBV6+h
 M6lclRgqLzABwHO6FNkTZlH6h+dXrSneBXiBi5GpMGet1kTh2xspCy3axdjTtNVN/Wc5 uQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k9bkwf9d4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Oct 2022 04:51:01 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29I4ktW6011780;
        Tue, 18 Oct 2022 04:51:01 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k9bkwf9c2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Oct 2022 04:51:00 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29I4Zdsq003866;
        Tue, 18 Oct 2022 04:50:58 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06fra.de.ibm.com with ESMTP id 3k7m4jbe9v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Oct 2022 04:50:58 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29I4ouaA6095380
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Oct 2022 04:50:56 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2989DA405B;
        Tue, 18 Oct 2022 04:50:56 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2F324A4054;
        Tue, 18 Oct 2022 04:50:53 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.43.34.247])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 18 Oct 2022 04:50:52 +0000 (GMT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH 19/19] perf stat: Remove unused perf_counts.aggr field
From:   Athira Rajeev <atrajeev@linux.vnet.ibm.com>
In-Reply-To: <CAM9d7chfRg=bwHmjuuWJVHyRQctEwO3jzZNEX6sJeJBwAgGWUw@mail.gmail.com>
Date:   Tue, 18 Oct 2022 10:20:50 +0530
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <DB4FC7F1-A1F2-4FBA-84DA-597201DF5A84@linux.vnet.ibm.com>
References: <20221014061550.463644-1-namhyung@kernel.org>
 <20221014061550.463644-20-namhyung@kernel.org>
 <B51023CD-214D-4D85-8086-B7AA6B6701D8@linux.vnet.ibm.com>
 <CAM9d7chfRg=bwHmjuuWJVHyRQctEwO3jzZNEX6sJeJBwAgGWUw@mail.gmail.com>
To:     Namhyung Kim <namhyung@kernel.org>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: NXYNQbmbJl0VHt4_XJMFnZ8BxnQmkhY9
X-Proofpoint-ORIG-GUID: ks9_pt3O5bqFXrL7ZxiCXd5LknnO8CN4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-17_13,2022-10-17_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2209130000 definitions=main-2210180025
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 18-Oct-2022, at 5:01 AM, Namhyung Kim <namhyung@kernel.org> wrote:
>=20
> Hello,
>=20
> On Sun, Oct 16, 2022 at 6:33 AM Athira Rajeev
> <atrajeev@linux.vnet.ibm.com> wrote:
>>=20
>>=20
>>=20
>>> On 14-Oct-2022, at 11:45 AM, Namhyung Kim <namhyung@kernel.org> =
wrote:
>>>=20
>>> The aggr field in the struct perf_counts is to keep the aggregated =
value
>>> in the AGGR_GLOBAL for the old code.  But it's not used anymore.
>>>=20
>>> Acked-by: Ian Rogers <irogers@google.com>
>>> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
>>> ---
>>> tools/perf/util/counts.c |  1 -
>>> tools/perf/util/counts.h |  1 -
>>> tools/perf/util/stat.c   | 35 ++---------------------------------
>>> 3 files changed, 2 insertions(+), 35 deletions(-)
>>>=20
>>> diff --git a/tools/perf/util/counts.c b/tools/perf/util/counts.c
>>> index 7a447d918458..11cd85b278a6 100644
>>> --- a/tools/perf/util/counts.c
>>> +++ b/tools/perf/util/counts.c
>>> @@ -48,7 +48,6 @@ void perf_counts__reset(struct perf_counts =
*counts)
>>> {
>>>      xyarray__reset(counts->loaded);
>>>      xyarray__reset(counts->values);
>>> -     memset(&counts->aggr, 0, sizeof(struct perf_counts_values));
>>> }
>>>=20
>>> void evsel__reset_counts(struct evsel *evsel)
>>> diff --git a/tools/perf/util/counts.h b/tools/perf/util/counts.h
>>> index 5de275194f2b..42760242e0df 100644
>>> --- a/tools/perf/util/counts.h
>>> +++ b/tools/perf/util/counts.h
>>> @@ -11,7 +11,6 @@ struct evsel;
>>>=20
>>> struct perf_counts {
>>>      s8                        scaled;
>>> -     struct perf_counts_values aggr;
>>>      struct xyarray            *values;
>>>      struct xyarray            *loaded;
>>> };
>>> diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
>>> index 14c45f4cfdd3..6ab9c58beca7 100644
>>> --- a/tools/perf/util/stat.c
>>> +++ b/tools/perf/util/stat.c
>>> @@ -308,8 +308,6 @@ static void evsel__copy_prev_raw_counts(struct =
evsel *evsel)
>>>                              *perf_counts(evsel->prev_raw_counts, =
idx, thread);
>>>              }
>>>      }
>>> -
>>> -     evsel->counts->aggr =3D evsel->prev_raw_counts->aggr;
>>> }
>>>=20
>>> void evlist__copy_prev_raw_counts(struct evlist *evlist)
>>> @@ -320,26 +318,6 @@ void evlist__copy_prev_raw_counts(struct evlist =
*evlist)
>>>              evsel__copy_prev_raw_counts(evsel);
>>> }
>>>=20
>>> -void evlist__save_aggr_prev_raw_counts(struct evlist *evlist)
>>> -{
>>> -     struct evsel *evsel;
>>> -
>>> -     /*
>>> -      * To collect the overall statistics for interval mode,
>>> -      * we copy the counts from evsel->prev_raw_counts to
>>> -      * evsel->counts. The perf_stat_process_counter creates
>>> -      * aggr values from per cpu values, but the per cpu values
>>> -      * are 0 for AGGR_GLOBAL. So we use a trick that saves the
>>> -      * previous aggr value to the first member of perf_counts,
>>> -      * then aggr calculation in process_counter_values can work
>>> -      * correctly.
>>> -      */
>>> -     evlist__for_each_entry(evlist, evsel) {
>>> -             *perf_counts(evsel->prev_raw_counts, 0, 0) =3D
>>> -                     evsel->prev_raw_counts->aggr;
>>> -     }
>>> -}
>>> -
>>> static size_t pkg_id_hash(const void *__key, void *ctx =
__maybe_unused)
>>> {
>>>      uint64_t *key =3D (uint64_t *) __key;
>>> @@ -423,7 +401,6 @@ process_counter_values(struct perf_stat_config =
*config, struct evsel *evsel,
>>>                     int cpu_map_idx, int thread,
>>>                     struct perf_counts_values *count)
>>> {
>>> -     struct perf_counts_values *aggr =3D &evsel->counts->aggr;
>>>      struct perf_stat_evsel *ps =3D evsel->stats;
>>>      static struct perf_counts_values zero;
>>>      bool skip =3D false;
>>> @@ -493,12 +470,6 @@ process_counter_values(struct perf_stat_config =
*config, struct evsel *evsel,
>>>              }
>>>      }
>>>=20
>>> -     if (config->aggr_mode =3D=3D AGGR_GLOBAL) {
>>> -             aggr->val +=3D count->val;
>>> -             aggr->ena +=3D count->ena;
>>> -             aggr->run +=3D count->run;
>>> -     }
>>> -
>>>      return 0;
>>> }
>>>=20
>>> @@ -523,13 +494,10 @@ static int process_counter_maps(struct =
perf_stat_config *config,
>>> int perf_stat_process_counter(struct perf_stat_config *config,
>>>                            struct evsel *counter)
>>> {
>>> -     struct perf_counts_values *aggr =3D &counter->counts->aggr;
>>>      struct perf_stat_evsel *ps =3D counter->stats;
>>> -     u64 *count =3D counter->counts->aggr.values;
>>> +     u64 *count;
>>>      int ret;
>>>=20
>>> -     aggr->val =3D aggr->ena =3D aggr->run =3D 0;
>>> -
>>>      if (counter->per_pkg)
>>>              evsel__zero_per_pkg(counter);
>>>=20
>>> @@ -540,6 +508,7 @@ int perf_stat_process_counter(struct =
perf_stat_config *config,
>>>      if (config->aggr_mode !=3D AGGR_GLOBAL)
>>>              return 0;
>>>=20
>>> +     count =3D ps->aggr[0].counts.values;
>>=20
>> Hi Namhyung,
>>=20
>> We are using ps->aggr[0] here always. Can you please clarify on why =
first index is used here always.
>=20
> Sure, the AGGR_GLOBAL should have a single entry map because
> theaggr_cpu_id__global() always returns the same value.  So we
> can use the index 0 safely.  I'll add a comment.

Hi Namhyung,
Sure, Thanks for the clarification.

Athira
>=20
> Thanks,
> Namhyung

