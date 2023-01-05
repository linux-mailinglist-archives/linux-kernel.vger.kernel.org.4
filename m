Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98C2465ED22
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 14:34:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbjAENe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 08:34:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjAENe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 08:34:26 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF96E0E8;
        Thu,  5 Jan 2023 05:34:23 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 305DMIPp009470;
        Thu, 5 Jan 2023 13:33:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : to : cc : from : subject : content-type :
 content-transfer-encoding; s=qcppdkim1;
 bh=bqhjKXWKyHijmV8LaHTMo0tL+cv5DyiB3FVwxZGHLYg=;
 b=lgIMqUQ0KE+I+s0vNGlER1Tgl2vp3rNgclOK36qugyH7YFBIIbCRQeAqiNMQpZnaO92j
 fIRv/fid9cU3DUMjycBxDC6TLJrbmDbEWz4JUHfSse8BFdvCo79MjtVAhQTlQdePWPEM
 jCZvXADITkM5a7yfx4VFHoa5wQy7qLAB/i1xVcSjnJcik9jO9wQ8lz4r8pciMa98o1a/
 kjg4geyvtB3KTQWtRKUN/aCZ+PjPRT9cxFgVvn8tdaCltcsSWl5oo8h6M6EwGdopuCZt
 FFZVMNwVtCl/eXqGRWrHUFckmni8yDF0Xu9op1+4oYjIZzhQX0OL3eNEToQHmtP30Mom 0Q== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mwwfs86gq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Jan 2023 13:33:55 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 305DXsXo017809
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 5 Jan 2023 13:33:54 GMT
Received: from [10.216.49.11] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 5 Jan 2023
 05:33:52 -0800
Message-ID: <ca4679a0-7f29-65f4-54b9-c575248192f1@quicinc.com>
Date:   Thu, 5 Jan 2023 19:03:48 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Content-Language: en-US
To:     <mark.rutland@arm.com>, <maz@kernel.org>,
        <daniel.lezcano@linaro.org>, <tglx@linutronix.de>,
        <linux-arm-kernel@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>
From:   Yogesh Lal <quic_ylal@quicinc.com>
Subject: ERRATUM_858921 is broken on 5.15 kernel
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 7gqCZw4S5KBnqGMkmDzqjI6F0tvDSx-s
X-Proofpoint-ORIG-GUID: 7gqCZw4S5KBnqGMkmDzqjI6F0tvDSx-s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-05_04,2023-01-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 phishscore=0 impostorscore=0 clxscore=1011 priorityscore=1501
 mlxlogscore=999 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301050107
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We are observing issue on A73 core where ERRATUM_858921 is broken.

On 5.15 kernel arch_timer_enable_workaround is set by reading 
arm64_858921_read_cntpct_el0 and arm64_858921_read_cntvct_el0 during 
timer register using following path.

arch_timer_enable_workaround->atomic_set(&timer_unstable_counter_workaround_in_use, 
1);

[code snap]
564 static
565 void arch_timer_enable_workaround(const struct 
arch_timer_erratum_workaround *wa,
566                               bool local)
567 {
568     int i;
569
570     if (local) {
571 __this_cpu_write(timer_unstable_counter_workaround, wa);
572     } else {
573             for_each_possible_cpu(i)
574                     per_cpu(timer_unstable_counter_workaround, i) = wa;
575     }
576
577     if (wa->read_cntvct_el0 || wa->read_cntpct_el0)
578 atomic_set(&timer_unstable_counter_workaround_in_use, 1);


and based on above workaround enablement , appropriate function to get 
counter is used.

1008 static void __init arch_counter_register(unsigned type)
1009 {
1010     u64 start_count;
1011
1012     /* Register the CP15 based counter if we have one */
1013     if (type & ARCH_TIMER_TYPE_CP15) {
1014         u64 (*rd)(void);
1015
1016         if ((IS_ENABLED(CONFIG_ARM64) && !is_hyp_mode_available()) ||
1017             arch_timer_uses_ppi == ARCH_TIMER_VIRT_PPI) {
1018             if (arch_timer_counter_has_wa())
1019                 rd = arch_counter_get_cntvct_stable;
1020             else
1021                 rd = arch_counter_get_cntvct;
1022         } else {
1023             if (arch_timer_counter_has_wa())
1024                 rd = arch_counter_get_cntpct_stable;
1025             else
1026                 rd = arch_counter_get_cntpct;
1027         }
[snap]
1043     /* 56 bits minimum, so we assume worst case rollover */
1044     sched_clock_register(arch_timer_read_counter, 56, arch_timer_rate);


As our boot cores are not impacted by errata sched_clock_register() will 
register !arch_timer_counter_has_wa() callback.

Now when errata impacted core boots up and sched_clock_register already 
register will !arch_timer_counter_has_wa() path.
As sched_clock_register is not per_cpu bases so arch_timer_read_counter 
will always point to !arch_timer_counter_has_wa() function calls.


Looks like this bug is side effect of following patch:

commit 0ea415390cd345b7d09e8c9ebd4b68adfe873043
Author: Marc Zyngier <marc.zyngier@arm.com>
Date:   Mon Apr 8 16:49:07 2019 +0100

     clocksource/arm_arch_timer: Use arch_timer_read_counter to access 
stable counters

     Instead of always going via arch_counter_get_cntvct_stable to 
access the
     counter workaround, let's have arch_timer_read_counter point to the
     right method.

     For that, we need to track whether any CPU in the system has a
     workaround for the counter. This is done by having an atomic variable
     tracking this.

     Acked-by: Mark Rutland <mark.rutland@arm.com>
     Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
     Signed-off-by: Will Deacon <will.deacon@arm.com>


Thanks

Yogesh Lal


