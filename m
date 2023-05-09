Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A65016FBE29
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 06:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233880AbjEIEVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 00:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbjEIEVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 00:21:09 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB86B44B4;
        Mon,  8 May 2023 21:21:03 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3493IgP7026433;
        Tue, 9 May 2023 04:20:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=pCb1PtWoLh2u32tC53xZV7dT9Q6u+VHvvh5VLNOcoEw=;
 b=fiIT2jI1LxQbkKxT/ViyuwvnN2nZPV6NFIUcIU6jgMkAeaqtzTXSu5rGNiRoDAlX2/MY
 H3HlcMGN/jiO5I8x8ipd3mEJPrVJQNmwuMRGZV1G0gHBxIUnW7v8rsWELorhsSnfBMz9
 Ssf6KySYwgasDra3MQ+S0Ul9/SJZw/OHNdlo3FHduoRTNRB5ruRlIAva+zgsT0esEh5b
 urs/mGsQ32TB0jZ3gAIqBTtgVcTVxAXBesJnjSSu5ZmleEX6OmIe44asD8S78iFZeMIt
 dNjNV1KsBwBjYCFBE5eCq7z3KrT8hV2uSJNQWfl3pJc055GebkIL/NRnGJJqJQtlCeh+ 5Q== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qf77h8rgm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 May 2023 04:20:53 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3494KqF1009176
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 9 May 2023 04:20:52 GMT
Received: from [10.50.37.86] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Mon, 8 May 2023
 21:20:47 -0700
Message-ID: <3109fb7a-0050-1b9b-d2aa-e00e26937b72@quicinc.com>
Date:   Tue, 9 May 2023 09:50:33 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH V4 2/3] soc: qcom: boot_stat: Add Driver Support for Boot
 Stats
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
References: <cover.1681742910.git.quic_schowdhu@quicinc.com>
 <C1eDJi-H9uWRAtbInRclmCgPb4EcgaeS3sk5FKO9cw8KscgMCH8dxRSvdPGUMwDFKpte7cBVeaqPhlLog-CRrg==@protonmail.internalid>
 <2ef76ce292c059c144e559123a9a54201ae2d0cf.1681742910.git.quic_schowdhu@quicinc.com>
 <575ee047-c6ce-95c3-8781-8c9a78534bb1@linaro.org>
 <f42637c8-400b-e39f-412d-60328e176585@quicinc.com>
 <35ac64ab-512d-1425-7a1b-6e8d3806c8a8@linaro.org>
Content-Language: en-US
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
In-Reply-To: <35ac64ab-512d-1425-7a1b-6e8d3806c8a8@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 4kYXeBNHYzYa1-7zJLr8FYOQLBm2cn0d
X-Proofpoint-ORIG-GUID: 4kYXeBNHYzYa1-7zJLr8FYOQLBm2cn0d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-09_02,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 suspectscore=0 phishscore=0 mlxlogscore=999
 adultscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305090032
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/4/2023 9:49 PM, Dmitry Baryshkov wrote:
> On 04/05/2023 09:35, Souradeep Chowdhury wrote:
>>
>>
>> On 5/4/2023 4:23 AM, Caleb Connolly wrote:
>>>
>>>
>>> On 17/04/2023 16:08, Souradeep Chowdhury wrote:
>>>> All of Qualcomm's proprietary Android boot-loaders capture boot time
>>>> stats, like the time when the bootloader started execution and at what
>>>> point the bootloader handed over control to the kernel etc. in the IMEM
>>>> region. This information is captured in a specific format by this 
>>>> driver
>>>> by mapping a structure to the IMEM memory region and then accessing the
>>>> members of the structure to show the information within debugfs file.
>>>> This information is useful in verifying if the existing boot KPIs have
>>>> regressed or not. The information is shown in milliseconds, a sample
>>>> log from sm8450(waipio) device is as follows:-
>>>>
>>>> /sys/kernel/debug/146aa6b0.boot_stats # cat abl_time
>>>> 17898 ms
>>>> /sys/kernel/debug/146aa6b0.boot_stats # cat pre_abl_time
>>>> 2879 ms
>>>>
>>>> The Module Power Manager(MPM) sleep counter starts ticking at the PBL
>>>> stage and the timestamp generated by the sleep counter is logged by
>>>> the Qualcomm proprietary bootloader(ABL) at two points-> First when it
>>>> starts execution which is logged here as "pre_abl_time" and the second
>>>> when it is about to load the kernel logged as "abl_time". Documentation
>>>> details are also added in 
>>>> Documentation/ABI/testing/debugfs-driver-bootstat
>>>>
>>>> Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
>>>
>>> Hi,
>>>
>>> [...]
>>>> +
>>>> +static int boot_stats_probe(struct platform_device *pdev)
>>>> +{
>>>> +    struct device *bootstat_dev = &pdev->dev;
>>>> +    struct bs_data *drvdata;
>>>> +
>>>> +    drvdata = devm_kzalloc(bootstat_dev, sizeof(*drvdata), 
>>>> GFP_KERNEL);
>>>> +    platform_set_drvdata(pdev, drvdata);
>>>> +
>>>> +    drvdata->dbg_dir = debugfs_create_dir(dev_name(bootstat_dev), 
>>>> NULL);
>>>
>>> This might be better as just "qcom_boot_stats", rather than including
>>> the address.
>>
>> We usually use the dev_name to represent the one to one correspondence 
> 
> Who is "we"?
> 
>> of the debugfs file with the device. Will create the root dir as
>> "qcom_boot_stats" and push the dev_name dir inside it.
> 
> No, this doesn't sound logical. Please use just the "qcom_boot_stats" as 
> Caleb suggested.

Ack

> 
>>
>>>
>>> [...]
>>>> +
>>>> +static const struct of_device_id boot_stats_dt_match[] = {
>>>> +    { .compatible = "qcom,sm8450-bootstats" },
>>>
>>> This driver doesn't only support sm8450, I've tested this on sdm845 and
>>> it works just fine. Can we use a generic compatible here instead?
>>
>> We can add soc specific compatibles here to extend support for other 
>> socs. This also captures the SoCs for which the driver is supported 
>> which won't be the case if we use a generic compatible.
> 
> No. If there is no difference between SoCs, please don't add 
> soc-specific compatibles. They pollute the kernel and provide no 
> additional benefits. Please use generic compatible and add 
> platform-specific ones only if you have something to override.

Ack
> 
>>
>>
>>>> +    { }
>>>> +};
>>>> +MODULE_DEVICE_TABLE(of, boot_stats_dt_match);
>>>> +
>>>> +static struct platform_driver boot_stat_driver = {
>>>> +    .probe  = boot_stats_probe,
>>>> +    .remove_new = boot_stats_remove,
>>>> +    .driver = {
>>>> +        .name = "qcom-boot-stats",
>>>> +        .of_match_table = boot_stats_dt_match,
>>>> +    },
>>>> +};
>>>> +module_platform_driver(boot_stat_driver);
>>>> +
>>>> +MODULE_DESCRIPTION("Qualcomm Technologies Inc. Boot Stat driver");
>>>> +MODULE_LICENSE("GPL");
>>>> -- 
>>>> 2.7.4
>>>>
>>>
> 
