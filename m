Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6201D6BB793
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 16:24:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232052AbjCOPYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 11:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjCOPYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 11:24:00 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94304EC59;
        Wed, 15 Mar 2023 08:23:59 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32FALA8r022173;
        Wed, 15 Mar 2023 15:23:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=OdnxiIa2RzAWKpmCWbias4+mruI+Y1nnKYY8NQ/Z9o0=;
 b=MVnkC5v3/s7B3JUuPgAQOnIn8QwlKsx8VvwZqyS0OvtnIN+LRLX6l6NicX407qHKx9WB
 3TWIDPxcpcrEiFWeOGIjAlJMQXXvIyNsNKFQU1XwU8q1ZtKpXDEL9HdKF1VN2o8IeNpK
 jIgYsCMXid7zJUN+fWRlbCyvdeKMp406t9BIfIsfCApD1CYNvWddOvxJaKLdKh/JW9Vw
 vNMRvqpnmyCkpJnQJVro4SrG0BbhNts8Ja3SfFjKLGAWVZcrZ6CSbrtHiZuoEXAeqMwm
 uuM2Vcm1CWbwkbNiNUHM2+8pEsWuRiEXU3osp+QsGBPtr6WGAko4zILo6ibzp7STvqsN WA== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pb2c8a1c8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Mar 2023 15:23:41 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32FFNfVV012640
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Mar 2023 15:23:41 GMT
Received: from [10.216.36.238] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 15 Mar
 2023 08:23:36 -0700
Message-ID: <f999f9bc-fb87-7716-3f55-9bd68475a667@quicinc.com>
Date:   Wed, 15 Mar 2023 20:53:31 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [RFC PATCH 3/6] soc: qcom: Add Qualcomm minidump kernel driver
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <keescook@chromium.org>, <tony.luck@intel.com>,
        <gpiccoli@igalia.com>, <catalin.marinas@arm.com>, <will@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <1676978713-7394-1-git-send-email-quic_mojha@quicinc.com>
 <1676978713-7394-4-git-send-email-quic_mojha@quicinc.com>
 <00b37174-f19e-ce59-b520-304891f6e2ef@linaro.org>
 <88bd0152-8b53-5ae2-bb16-5060419ca580@linaro.org>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <88bd0152-8b53-5ae2-bb16-5060419ca580@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: CZJpnAapbasNkr7WYu4tv1YLC7bq2jyM
X-Proofpoint-ORIG-GUID: CZJpnAapbasNkr7WYu4tv1YLC7bq2jyM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-15_08,2023-03-15_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 clxscore=1011 malwarescore=0 lowpriorityscore=0
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2302240000 definitions=main-2303150129
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the review and comment.

On 3/9/2023 2:20 AM, Konrad Dybcio wrote:
> 
> 
> On 8.03.2023 21:22, Srinivas Kandagatla wrote:
>>
>>
>> On 21/02/2023 11:25, Mukesh Ojha wrote:
>>> Minidump is a best effort mechanism to collect useful and predefined
>>> data for first level of debugging on end user devices running on
>>> Qualcomm SoCs. It is built on the premise that System on Chip (SoC)
>>> or subsystem part of SoC crashes, due to a range of hardware and
>>> software bugs. Hence, the ability to collect accurate data is only
>>> a best-effort. The data collected could be invalid or corrupted,
>>> data collection itself could fail, and so on.
>>>
>>> Qualcomm devices in engineering mode provides a mechanism for
>>> generating full system ramdumps for post mortem debugging. But in some
>>> cases it's however not feasible to capture the entire content of RAM.
>>> The minidump mechanism provides the means for selecting region should
>>> be included in the ramdump. The solution supports extracting the
>>> ramdump/minidump produced either over USB or stored to an attached
>>> storage device.
>>>
>>> The core of minidump feature is part of Qualcomm's boot firmware code.
>>> It initializes shared memory(SMEM), which is a part of DDR and
>>> allocates a small section of it to minidump table i.e also called
>>> global table of content (G-ToC). Each subsystem (APSS, ADSP, ...) has
>>> their own table of segments to be included in the minidump, all
>>> references from a descriptor in SMEM (G-ToC). Each segment/region has
>>> some details like name, physical address and it's size etc. and it
>>> could be anywhere scattered in the DDR.
>>>
>>> Minidump kernel driver adds the capability to add linux region to be
>>> dumped as part of ram dump collection. It provides appropriate symbol
>>> to check its enablement and register client regions.
>>>
>>> To simplify post mortem debugging, it creates and maintain an ELF
>>> header as first region that gets updated with upon registration
>>> of a new region.
>>>
>>> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
>>> ---
> [...]
> 
>>> +int qcom_minidump_ready(void)
>>> +{
>>> +    void *ptr;
>>> +    struct device_node *np;
>>> +    static bool is_smem_available = true;
>>> +
>>> +    if (!is_smem_available || !(np = of_find_compatible_node(NULL, NULL, "qcom,smem"))) {
>>
>> just check for dt node here does not mean that smem device is available, you should probably check if the device is avaliable aswell using of_device_is_available()
>>
>>
>> We should proabably return -EPROBEDEFER incase the node is present and device is not present.
> qcom_smem_get() seems to handle -EPROBE_DEFER internally, so this check
> may be entirely redundant.

The main idea behind checking qcom,smem availability is to not stop 
client(core kernel) probe if the smem dt node is not present at all
and qcom_smem_get() will always return  -EPROBE_DEFER for such cases.

For e.g: Again i am taking ramoops example which seems relevant for
this case, ramoops driver should still probe and not defer forever
if the smem node is not available at all for non-qcom device tree.

-Mukesh
> 
> Konrad
