Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD146A58D5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 13:07:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbjB1MHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 07:07:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231284AbjB1MHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 07:07:14 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F092ED7D;
        Tue, 28 Feb 2023 04:07:12 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31SBkMoC008349;
        Tue, 28 Feb 2023 12:06:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=izKyXe2UDxz2yir9ujhMQk5iVvDmRvNlJZRQ2MHtVFc=;
 b=XdYOx/8HIRks4NVgkOZ30pNCBp5uRKi0Wvs4eLmsY5Hwea6oc9TaP49Pq3VBhKuY9q+v
 +ZNJbLj5i9WfKzAhTUHgqL9y9JztLST0s7chSfVKFaAeg2dM2/0FABZRLFUke7169u3p
 zWXcQEwe1FiBvx3ZVhNi3RHI7a4jX4hx16O+vumWWRW2vdGXRVccdZe0TP22/BjV5jf/
 8/de8874d5D8vtVCcH3yCXoqvFv9rNTQdk1UsjowjOjjHCMRDTefgarYN04LWwqfb9nv
 p6DaTmrcegJDwnFDJKr/bTWkwLO7XRJ3Sc2f41Weo+qrDkIQ0O4qe+Bs/jZ31NBhRsVe wg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p1h1k0fub-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Feb 2023 12:06:27 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31SBn0VM021171;
        Tue, 28 Feb 2023 12:06:26 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p1h1k0ft8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Feb 2023 12:06:26 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31S7OMtn028341;
        Tue, 28 Feb 2023 12:06:24 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma02fra.de.ibm.com (PPS) with ESMTPS id 3nybe2j6g8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Feb 2023 12:06:24 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31SC6Lti41550146
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Feb 2023 12:06:21 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 949B320043;
        Tue, 28 Feb 2023 12:06:21 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6F0AE20040;
        Tue, 28 Feb 2023 12:06:15 +0000 (GMT)
Received: from [9.43.45.146] (unknown [9.43.45.146])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 28 Feb 2023 12:06:15 +0000 (GMT)
Message-ID: <64e12c5d-13a9-12c7-34a6-4df91e45a881@linux.ibm.com>
Date:   Tue, 28 Feb 2023 17:36:14 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v1 01/51] perf tools: Ensure evsel name is initialized
To:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Sandipan Das <sandipan.das@amd.com>,
        James Clark <james.clark@arm.com>,
        John Garry <john.g.garry@oracle.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Florian Fischer <florian.fischer@muhq.space>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Sean Christopherson <seanjc@google.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>
Cc:     Stephane Eranian <eranian@google.com>
References: <20230219092848.639226-1-irogers@google.com>
 <20230219092848.639226-2-irogers@google.com>
Content-Language: en-US
From:   kajoljain <kjain@linux.ibm.com>
In-Reply-To: <20230219092848.639226-2-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: evA0cCFcMe9tjB-KOGxCro6zsukEc4No
X-Proofpoint-ORIG-GUID: bxhl4fw-H0g6X9RdFw3TgnG1g8qL6Itm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-28_07,2023-02-28_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 suspectscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 mlxscore=0
 bulkscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302280093
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/19/23 14:57, Ian Rogers wrote:
> Use the evsel__name accessor as otherwise name may be NULL resulting
> in a segv. This was observed with the perf stat shell test.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/synthetic-events.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
> index 9ab9308ee80c..6def01036eb5 100644
> --- a/tools/perf/util/synthetic-events.c
> +++ b/tools/perf/util/synthetic-events.c
> @@ -2004,7 +2004,7 @@ int perf_event__synthesize_event_update_name(struct perf_tool *tool, struct evse
>  					     perf_event__handler_t process)
>  {
>  	struct perf_record_event_update *ev;
> -	size_t len = strlen(evsel->name);
> +	size_t len = strlen(evsel__name(evsel));
>  	int err;
>  

Patch looks fine to me

Reviewed-by: Kajol Jain <kjain@linux.ibm.com>

>  	ev = event_update_event__new(len + 1, PERF_EVENT_UPDATE__NAME, evsel->core.id[0]);
