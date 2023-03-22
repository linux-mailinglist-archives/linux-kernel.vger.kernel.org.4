Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10D556C4C7E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 14:54:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbjCVNyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 09:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjCVNyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 09:54:35 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 307CDF750;
        Wed, 22 Mar 2023 06:54:34 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32M43GeX026267;
        Wed, 22 Mar 2023 13:54:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=C73UFqKD3C9y3/ngb6vv60XWQujvXtOIq9+3QOqJgT8=;
 b=XN/e57skMiI68vmiHYFDegNg3/D5Rbt0DcVn67XFZ4p3IcWbUiy9xEHREv1+Vy97KYiw
 BUZpOHqi1EbDUcwTBbKVqTqFFtyROjGJiJpxI5nNthmPH5TiEx9jey2G/wp0jA/gWoQK
 EXJ5MKH5tATL+HHgfUb6gt/8PDzC2J2DejOijTPyUBGC/JnJmj5gj/uYypJyowoZ1Frp
 t8TYYlTmMytehuj6aLu5vKpgwGadrpLOcvuYGAO4KOVvZhx9iSYV3mD3StnqaTlNRi4F
 Clfmq/RFLryli3Bti92ALLlR7xwF5XWFxEnQpzfUBc01du1P+KyXaWeL7jj7dnBDKULr ag== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pfhnx29pf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Mar 2023 13:54:24 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32MDsM5R014858
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Mar 2023 13:54:22 GMT
Received: from [10.50.8.113] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 22 Mar
 2023 06:54:19 -0700
Message-ID: <321005fc-1bfd-c04d-b2b5-d85d213ac00a@quicinc.com>
Date:   Wed, 22 Mar 2023 19:24:16 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH V1 3/4] soc: qcom: boot_stat: Add Driver Support for Boot
 Stats
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
References: <cover.1679403696.git.quic_schowdhu@quicinc.com>
 <3f385562845ae26d519940ca8098fde89282991b.1679403696.git.quic_schowdhu@quicinc.com>
 <611ea918-64a6-f306-b5ec-db55e41abda2@linaro.org>
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
In-Reply-To: <611ea918-64a6-f306-b5ec-db55e41abda2@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: OJGSI2LAiJIyEgtTNOvMPmfBB7q6S3Tt
X-Proofpoint-ORIG-GUID: OJGSI2LAiJIyEgtTNOvMPmfBB7q6S3Tt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_11,2023-03-22_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 adultscore=0 mlxlogscore=999
 lowpriorityscore=0 impostorscore=0 clxscore=1015 phishscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303220101
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/21/2023 11:07 PM, Krzysztof Kozlowski wrote:
> On 21/03/2023 14:51, Souradeep Chowdhury wrote:
>> All of Qualcomm's proprietary Android boot-loaders capture boot time
>> stats, like the time when the bootloader started execution and at what
>> point the bootloader handed over control to the kernel etc. in the IMEM
>> region. This information is captured in a specific format by this driver
>> by mapping a structure to the IMEM memory region and then accessing the
>> members of the structure to print the information. This information is
>> useful in verifying if the existing boot KPIs have regre
> 
> 
>> +/**
>> + *  struct boot_stats - timestamp information related to boot stats
>> + *  @bootloader_start:	Time for the starting point of the abl bootloader
>> + *  @bootloader_end:	Time when the kernel starts loading from abl bootloader
>> + */
>> +struct boot_stats {
>> +	u32 bootloader_start;
>> +	u32 bootloader_end;
>> +} __packed;
>> +
>> +static struct boot_stats __iomem *boot_stats;
>> +static void __iomem *mpm_counter_base;
>> +static u32 mpm_counter_freq;
> 
> No file-scope variables. Does not scale, not easy for review and
> maintenance. Avoid such code.

Ack
> 
>> +
>> +static int mpm_parse_dt(void)
>> +{
>> +	struct device_node *np_imem, *np_mpm2;
>> +
>> +	np_imem = of_find_compatible_node(NULL, NULL,
>> +					  "qcom,imem-boot_stats");
>> +	if (!np_imem) {
>> +		pr_err("can't find qcom,imem node\n");
> 
> So you are printing errors everywhere, on every soc and with compile
> test on every platform there is in the world... sorry, it does not work
> like that.

Ack
> 
>> +		return -ENODEV;
>> +	}
>> +	boot_stats = of_iomap(np_imem, 0);
>> +	if (!boot_stats) {
>> +		pr_err("boot_stats: Can't map imem\n");
>> +		goto err1;
>> +	}
> 
> 
>> +
>> +static void __exit boot_stats_exit(void)
>> +{
>> +}
>> +module_exit(boot_stats_exit)
> 
> 
> I don't think this is some special code which deserves init calls. Make
> it module_platform_driver().

Since this just reads some values from the Imem region and prints it to 
the user and doesn't have a specific device associated with it, a 
generic module code is written for it and not a module_platform_driver().

> 
> 
> Best regards,
> Krzysztof
> 
