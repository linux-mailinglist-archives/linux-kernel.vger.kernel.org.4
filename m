Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD171603284
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 20:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbiJRSbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 14:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbiJRSbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 14:31:08 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D95691BB;
        Tue, 18 Oct 2022 11:31:02 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29IIORNm028328;
        Tue, 18 Oct 2022 18:30:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=pp1;
 bh=0JtFDXn/7sexO9bf9hyr9d9GHOIRTbp5Go+DoUK5pEE=;
 b=MZjiITIEonJQbVsX75zoD3EsbBWI17bXiUuj4VV/nfAIGa5m5EpFJphAhW1I+RqCl0Dr
 6I4VunqDX2oe2HzcrHc6Fr/nuiKS1To9K74GNc8mL076/638MTjJr2UjlUS65/nwgaaF
 UxCAd/R3DWhmy86q853+hwWHSiM4I/VXZAGcLqPU2vEYFB4IrLzme+XWpjXuxFBw5rbZ
 w7426Abh2lLepQKvhEVML3zKd176kdyTAeTXqSxdYazgrywbpji3iOBU8f9eVLbLhkef
 d16XCn0L3n9Uc9rAHa0uJSX5n8LnYS9DeZk42rn5y4x4XhrlD+FXijNa4j5oEY5PKkIj ng== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3ka1d5g4gj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Oct 2022 18:30:46 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29IIPCtm029732;
        Tue, 18 Oct 2022 18:30:46 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3ka1d5g4fg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Oct 2022 18:30:45 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29IILA0p008905;
        Tue, 18 Oct 2022 18:30:43 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03ams.nl.ibm.com with ESMTP id 3k7mg95que-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Oct 2022 18:30:43 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29IIUfr639911992
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Oct 2022 18:30:41 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9D08EA4054;
        Tue, 18 Oct 2022 18:30:41 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0D6E8A405B;
        Tue, 18 Oct 2022 18:30:39 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.43.70.133])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 18 Oct 2022 18:30:38 +0000 (GMT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH] perf: Fix missing raw data on tracepoint events
From:   Athira Rajeev <atrajeev@linux.vnet.ibm.com>
In-Reply-To: <20221012143857.48198-1-james.clark@arm.com>
Date:   Wed, 19 Oct 2022 00:00:35 +0530
Cc:     linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D3C85EE7-3545-44C7-B11D-71C1935036C1@linux.vnet.ibm.com>
References: <20221012143857.48198-1-james.clark@arm.com>
To:     James Clark <james.clark@arm.com>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: T-DTN9SjUD6i_rqVs3VR1kl8jNGzjVr2
X-Proofpoint-GUID: MhbvKZ9YZijq6BK2TXYADEyVY9IuAOqK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-18_07,2022-10-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 clxscore=1011 priorityscore=1501 mlxlogscore=999 impostorscore=0
 adultscore=0 spamscore=0 bulkscore=0 phishscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210180099
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 12-Oct-2022, at 8:08 PM, James Clark <james.clark@arm.com> wrote:
>=20
> Since commit 838d9bb62d13 ("perf: Use sample_flags for raw_data")
> raw data is not being output on tracepoints due to the PERF_SAMPLE_RAW
> field not being set. Fix this by setting it for tracepoint events.
>=20
> This fixes the following test failure:
>=20
>  perf test "sched_switch" -vvv
>=20
>   35: Track with sched_switch
>  --- start ---
>  test child forked, pid 1828
>  ...
>  Using CPUID 0x00000000410fd400
>  sched_switch: cpu: 2 prev_tid -14687 next_tid 0
>  sched_switch: cpu: 2 prev_tid -14687 next_tid 0
>  Missing sched_switch events
>  4613 events recorded
>  test child finished with -1
>  ---- end ----
>  Track with sched_switch: FAILED!
>=20
> Fixes: 838d9bb62d13 ("perf: Use sample_flags for raw_data")
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: James Clark <james.clark@arm.com>

Hi James,=20

Thanks for the fix. I was getting similar issue with =E2=80=9Cperf =
trace=E2=80=9D and it works with this fix.

Tested-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>


> ---
> kernel/events/core.c | 1 +
> 1 file changed, 1 insertion(+)
>=20
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index b981b879bcd8..824c23830272 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -9759,6 +9759,7 @@ void perf_tp_event(u16 event_type, u64 count, =
void *record, int entry_size,
>=20
> 	perf_sample_data_init(&data, 0, 0);
> 	data.raw =3D &raw;
> +	data.sample_flags |=3D PERF_SAMPLE_RAW;
>=20
> 	perf_trace_buf_update(record, event_type);
>=20
> --=20
> 2.28.0
>=20

