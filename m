Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 943E567A9CA
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 05:56:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234019AbjAYE4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 23:56:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjAYE4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 23:56:36 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92D74442DD;
        Tue, 24 Jan 2023 20:56:30 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30P12O6A001128;
        Wed, 25 Jan 2023 04:55:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Ek4ViFzg+L03Mc5P/M4v2C+tRZPLaPHa8rW/eFrxnwg=;
 b=gU5VuJTEr7iJC4Ffg5FwnOdJiUaZa0wWfSXxALBwh7QayOar6JQuBkASYS1dAG0nJ4eO
 8Sm2o1JbaB7bZKT2BIlVlKqpm4JlUiCDTfN8sKr9OELSomuOS3qAFxI3LO3Qvc5nuNJP
 oqL29cGmh3mkEOQXAFYI3289I8O9+RH8g+hA/a43YBe9OxnIU1ynpfPbVLp/9I7pUFTs
 I662tv9ZWnYa3YVF/4g/zguX23vOGw86W8u4B6nV7b+AB9cdZSmBXL5e68Y1EfISm9yE
 9sfotJ76W5lfgXftwNKezqlPC3m2TraKsw4brVsonuWd+5WwWwyMxHp5VVCVEuY4zuBp Wg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nacg19j8w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 04:55:32 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30P4tVUH025163;
        Wed, 25 Jan 2023 04:55:31 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nacg19j89-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 04:55:31 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30P0cds4022756;
        Wed, 25 Jan 2023 04:55:28 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma01fra.de.ibm.com (PPS) with ESMTPS id 3n87p6bb6e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 04:55:28 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30P4tQFP24052368
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Jan 2023 04:55:26 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 354C02004B;
        Wed, 25 Jan 2023 04:55:26 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C3C9D20043;
        Wed, 25 Jan 2023 04:55:18 +0000 (GMT)
Received: from [9.43.112.104] (unknown [9.43.112.104])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 25 Jan 2023 04:55:18 +0000 (GMT)
Message-ID: <f9d26106-95d2-69ae-b7ed-1b47449dacd1@linux.ibm.com>
Date:   Wed, 25 Jan 2023 10:25:17 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 01/11] perf jevents metric: Correct Function equality
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Rob Herring <robh@kernel.org>,
        Kang Minchul <tegongkang@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sandipan Das <sandipan.das@amd.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        linuxppc-dev@lists.ozlabs.org
Cc:     Stephane Eranian <eranian@google.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>
References: <20230124063320.668917-1-irogers@google.com>
 <20230124063320.668917-2-irogers@google.com>
From:   kajoljain <kjain@linux.ibm.com>
In-Reply-To: <20230124063320.668917-2-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: H6q3uzCcb05eZCYrpofTEMW9O5tQk3l7
X-Proofpoint-GUID: J2kNzcWzCCLoXPTMiPA2OWng92lTLNZ6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-25_01,2023-01-24_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0 malwarescore=0
 clxscore=1011 impostorscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301250039
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/24/23 12:03, Ian Rogers wrote:
> rhs may not be defined, say for source_count, so add a guard.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/pmu-events/metric.py | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/pmu-events/metric.py b/tools/perf/pmu-events/metric.py
> index 4797ed4fd817..2f2fd220e843 100644
> --- a/tools/perf/pmu-events/metric.py
> +++ b/tools/perf/pmu-events/metric.py
> @@ -261,8 +261,10 @@ class Function(Expression):
>  
>    def Equals(self, other: Expression) -> bool:
>      if isinstance(other, Function):
> -      return self.fn == other.fn and self.lhs.Equals(
> -          other.lhs) and self.rhs.Equals(other.rhs)
> +      result = self.fn == other.fn and self.lhs.Equals(other.lhs)
> +      if self.rhs:
> +        result = result and self.rhs.Equals(other.rhs)
> +      return result
>      return False
>  
>  

Patch looks good to me.

Reviewed-by: Kajol Jain<kjain@linux.ibm.com>

Thanks,
Kajol Jain
