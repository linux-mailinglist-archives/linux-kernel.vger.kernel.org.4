Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED4796EA844
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 12:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbjDUKXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 06:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbjDUKW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 06:22:58 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0413CCC36;
        Fri, 21 Apr 2023 03:22:15 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33L9ZrF9013684;
        Fri, 21 Apr 2023 10:21:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=szugQcQNiONg5ojeMtB7mQRn6Qj8MR8hO1IA92sp2RA=;
 b=Dv8R+tKMpgd5lf5V7JrfuayJrf64iRPM7keN+l3pkv0ncr/OaucaeW9UxSSzN/BaACWh
 1ogNPzFwQf7/ia9cclrVGg/sK1epoVmiS9JfFVBwLf0QEQ1tJwQGJqyMrdzVttLL2Ku3
 fpfuFFd3bLorPVv2+UBdAuxJ55QaQMiUyivNe3eOP7DEtMb3Pms3CBj1PepQAPntS9rf
 jwuSbcdrMSgGY1B+fsu9TS4BhFkZ86pKSG/0tU9cRFTjvDq6zGyywuG59hUozMRGa0TG
 n/dtR+P+1+dC2oSyPgbDTSkcpaKWHmywxwKJw9d7YfBzawi9g6JvkjMDT0eSCR5QSHNK Pg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q3dcmhauh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Apr 2023 10:21:27 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33LALQg0025570
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Apr 2023 10:21:26 GMT
Received: from [10.50.53.23] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Fri, 21 Apr
 2023 03:21:21 -0700
Message-ID: <c69d0a95-f216-5e68-28ac-1a5cf28b3f32@quicinc.com>
Date:   Fri, 21 Apr 2023 15:50:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH V5 2/3] soc: qcom: boot_stat: Add Driver Support for Boot
 Stats
To:     Bryan O'Donoghue <pure.logic@nexus-software.ie>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
References: <cover.1681799201.git.quic_schowdhu@quicinc.com>
 <142bfd034c12c245cda9f1dee20a05188b63494d.1681799201.git.quic_schowdhu@quicinc.com>
 <b66290c6-5c1b-70a4-84e3-d65b139d1460@nexus-software.ie>
Content-Language: en-US
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
In-Reply-To: <b66290c6-5c1b-70a4-84e3-d65b139d1460@nexus-software.ie>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: rDJ1mvdcT3iYcl6eutS4Nnfl2Xb7Wtke
X-Proofpoint-GUID: rDJ1mvdcT3iYcl6eutS4Nnfl2Xb7Wtke
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-21_03,2023-04-20_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 phishscore=0 spamscore=0 impostorscore=0
 mlxlogscore=999 malwarescore=0 suspectscore=0 clxscore=1011 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304210088
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/21/2023 3:32 PM, Bryan O'Donoghue wrote:
> On 18/04/2023 07:46, Souradeep Chowdhury wrote:
>> All of Qualcomm's proprietary Android boot-loaders capture boot time
>> stats, like the time when the bootloader started execution and at what
>> point the bootloader handed over control to the kernel etc. in the IMEM
>> region. This information is captured in a specific format by this driver
>> by mapping a structure to the IMEM memory region and then accessing the
>> members of the structure to show the information within debugfs file.
>> This information is useful in verifying if the existing boot KPIs have
>> regressed or not. The information is shown in milliseconds, a sample
>> log from sm8450(waipio) device is as follows:-
>>
>> /sys/kernel/debug/146aa6b0.boot_stats # cat abl_time
>> 17898 ms
>> /sys/kernel/debug/146aa6b0.boot_stats # cat pre_abl_time
>> 2879 ms
>>
>> The Module Power Manager(MPM) sleep counter starts ticking at the PBL
>> stage and the timestamp generated by the sleep counter is logged by
>> the Qualcomm proprietary bootloader(ABL) at two points-> First when it
>> starts execution which is logged here as "pre_abl_time" and the second
>> when it is about to load the kernel logged as "abl_time". Documentation
>> details are also added in 
>> Documentation/ABI/testing/debugfs-driver-bootstat
>>
>> Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
>> ---
>>   Documentation/ABI/testing/debugfs-driver-bootstat |  17 ++++
>>   drivers/soc/qcom/Kconfig                          |   9 ++
>>   drivers/soc/qcom/Makefile                         |   1 +
>>   drivers/soc/qcom/boot_stats.c                     | 101 
>> ++++++++++++++++++++++
>>   4 files changed, 128 insertions(+)
>>   create mode 100644 Documentation/ABI/testing/debugfs-driver-bootstat
>>   create mode 100644 drivers/soc/qcom/boot_stats.c
>>
>> diff --git a/Documentation/ABI/testing/debugfs-driver-bootstat 
>> b/Documentation/ABI/testing/debugfs-driver-bootstat
>> new file mode 100644
>> index 0000000..2543029
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/debugfs-driver-bootstat
>> @@ -0,0 +1,17 @@
>> +What:        /sys/kernel/debug/...stats/pre_abl_time
>> +Date:           April 2023
>> +Contact:        Souradeep Chowdhury <quic_schowdhu@quicinc.com>
>> +Description:
>> +        This file is used to read the KPI value pre abl time.
>> +        It shows the time in milliseconds from the starting
>> +        point of PBL to the point when the control shifted
>> +        to ABL(Qualcomm proprietary bootloader).
>> +
>> +What:           /sys/kernel/debug/...stats/abl_time
>> +Date:           April 2023
>> +Contact:        Souradeep Chowdhury <quic_schowdhu@quicinc.com>
>> +Description:
>> +        This file is used to read the KPI value abl time.
>> +        It show the duration in milliseconds from the
>> +        time control switched to ABL to the point when
>> +        the linux kernel started getting loaded.
>> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
>> index a8f2830..0d2cbd3 100644
>> --- a/drivers/soc/qcom/Kconfig
>> +++ b/drivers/soc/qcom/Kconfig
>> @@ -16,6 +16,15 @@ config QCOM_AOSS_QMP
>>         subsystems as well as controlling the debug clocks exposed by 
>> the Always On
>>         Subsystem (AOSS) using Qualcomm Messaging Protocol (QMP).
>> +config QCOM_BOOTSTAT
>> +    tristate "Qualcomm Technologies, Boot Stat driver"
>> +    depends on ARCH_QCOM || COMPILE_TEST
>> +    help
>> +      This option enables driver support for boot stats. Boot stat 
>> driver logs
>> +      the kernel bootloader information by accessing the imem region. 
>> These
>> +      information are exposed in the form of debugfs files. This is 
>> used to
>> +      determine if there is any regression in boot timings.
>> +
>>   config QCOM_COMMAND_DB
>>       tristate "Qualcomm Command DB"
>>       depends on ARCH_QCOM || COMPILE_TEST
>> diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
>> index 6e88da8..bdaa41a 100644
>> --- a/drivers/soc/qcom/Makefile
>> +++ b/drivers/soc/qcom/Makefile
>> @@ -1,6 +1,7 @@
>>   # SPDX-License-Identifier: GPL-2.0
>>   CFLAGS_rpmh-rsc.o := -I$(src)
>>   obj-$(CONFIG_QCOM_AOSS_QMP) +=    qcom_aoss.o
>> +obj-$(CONFIG_QCOM_BOOTSTAT) += boot_stats.o
>>   obj-$(CONFIG_QCOM_GENI_SE) +=    qcom-geni-se.o
>>   obj-$(CONFIG_QCOM_COMMAND_DB) += cmd-db.o
>>   obj-$(CONFIG_QCOM_CPR)        += cpr.o
>> diff --git a/drivers/soc/qcom/boot_stats.c 
>> b/drivers/soc/qcom/boot_stats.c
>> new file mode 100644
>> index 0000000..7ae002b
>> --- /dev/null
>> +++ b/drivers/soc/qcom/boot_stats.c
>> @@ -0,0 +1,101 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) 2013-2019, 2021 The Linux Foundation. All rights 
>> reserved.
>> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights 
>> reserved.
>> + */
>> +
>> +#include <linux/debugfs.h>
>> +#include <linux/err.h>
>> +#include <linux/io.h>
>> +#include <linux/init.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/of_address.h>
>> +#include <linux/platform_device.h>
>> +
>> +#define TO_MS(timestamp) ((timestamp * 1000) / 32768)
> 
> Is this related to the sleep_clk, if not, what is the refrence clock ?
> 
> Is this value constant across different SoCs i.e. will this run and 
> produce meaningful results on an msm8916 ?

This is the sleep counter of MPM(Module Power Manager), yes, it will 
produce meaningful results on almost all QCOM SoCs including msm8916.

> 
> ---
> bod
