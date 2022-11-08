Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFF166216D5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 15:33:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234395AbiKHOc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 09:32:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234531AbiKHOcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 09:32:02 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E91A858BEB;
        Tue,  8 Nov 2022 06:31:25 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A8E2vLW014879;
        Tue, 8 Nov 2022 14:31:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=GxwZyLTiuyTBBaDDryQGhcwWmRWeEyfXiiSeXaDHm8I=;
 b=TGMVInwaaj20GeRQotxoI/pJ6MJgb47P3sEJmUSfmid35COMJgJb4JBuscJkgt+0yVh8
 d3gzCFGnOnYmdZzhDfWTOoiOM0zGN/sb8puxa3/3GpLBtUajH1eJk5LB7FY6p2BuKSyn
 viss61lIkUHzkLOEo9cSqlbznbl9KwpdLF2ox6jqXXxFDRS9/7+ZNB6JthqnpsD9GpJY
 E6FIN868O44E96h2/jFNtR3E64QDmVaN0PN+Olqu/5GJZqUbreWMTa3LP6NOaTviixpZ
 U2jtXGBpmRWbztQxeTP8U4I1YlPdzCc8jzYZNgxd5XfvJBU2n8apdaFceptJBFoSuZy6 Ag== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kqhmgh5dt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Nov 2022 14:31:04 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2A8EV33p019963
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 8 Nov 2022 14:31:03 GMT
Received: from [10.214.66.81] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 8 Nov 2022
 06:30:59 -0800
Message-ID: <bccb731a-f99d-91ab-6dca-c1182d55ff28@quicinc.com>
Date:   Tue, 8 Nov 2022 20:00:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v5 2/4] sched: Add helper kstat_cpu_softirqs_sum()
Content-Language: en-US
To:     Zhen Lei <thunder.leizhen@huawei.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Neeraj Upadhyay" <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, <rcu@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_mojha@quicinc.com>
CC:     Robert Elliott <elliott@hpe.com>
References: <20221104141118.119-1-thunder.leizhen@huawei.com>
 <20221104141118.119-3-thunder.leizhen@huawei.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20221104141118.119-3-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 6MPCf56f32ux8Y6E6bj4a6Pc_ptre2Qj
X-Proofpoint-ORIG-GUID: 6MPCf56f32ux8Y6E6bj4a6Pc_ptre2Qj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_11,2022-11-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 adultscore=0 suspectscore=0 mlxlogscore=780
 priorityscore=1501 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211080087
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/4/2022 7:41 PM, Zhen Lei wrote:
> Similar to kstat_cpu_irqs_sum(), it counts the sum of all software
> interrupts on a specified CPU.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>   include/linux/kernel_stat.h | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/include/linux/kernel_stat.h b/include/linux/kernel_stat.h
> index 90e2fdc17d79ff8..898076e173a928a 100644
> --- a/include/linux/kernel_stat.h
> +++ b/include/linux/kernel_stat.h
> @@ -67,6 +67,17 @@ static inline unsigned int kstat_softirqs_cpu(unsigned int irq, int cpu)
>          return kstat_cpu(cpu).softirqs[irq];
>   }
>   

One header comment would have been good.

> +static inline unsigned int kstat_cpu_softirqs_sum(int cpu)
> +{
> +	int i;
> +	unsigned int sum = 0;
> +
> +	for (i = 0; i < NR_SOFTIRQS; i++)
> +		sum += kstat_softirqs_cpu(i, cpu);
> +
> +	return sum;
> +}
> +
>   /*
>    * Number of interrupts per specific IRQ source, since bootup
>    */

LGTM.
Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>

-Mukesh
