Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0772743E0C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 16:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232844AbjF3O6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 10:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232823AbjF3O6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 10:58:30 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD4B81FFA;
        Fri, 30 Jun 2023 07:58:28 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35UDxH1M024499;
        Fri, 30 Jun 2023 14:58:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=FWsoqs5iDUcCdUn2UKhCC9bwPd9A9e7CbTu4kW+ZpB8=;
 b=fnmyUWxzzm79znoy8gnBpmXrs3gJhJSXo1UOKD1tZETinx1Ma/+OQH5xFCsuZeMKa3U2
 lsbATJRcBgbH5IKztfChCgwFtt4FzEehkpFhUBEbM3su+EvQfSW+bwquruzksSQwGth9
 5VD+2JC7Fco1kHux2tLE45WUTMAes2EwQ5o9bhvwFNkDwcTngE1vbkPw+0zhV1vNdL0G
 LEi7nXHToSomg04GA+Z2fTN4VDxtNlHfuCdIO11a7T1IY99SCpm8oydCdOciy2rKIO0V
 bP+NjZQebj1KwBaAX4S8iYDONyrL3MS3oEwQE2uWj5Px9wIljdjiDFi+r6bdUhf5PxJE AA== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rgy1tm5kt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Jun 2023 14:58:06 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35UEw5n2006969
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Jun 2023 14:58:05 GMT
Received: from [10.216.37.216] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Fri, 30 Jun
 2023 07:57:57 -0700
Message-ID: <b13c8010-c7bb-db21-44c5-06e95b341b7c@quicinc.com>
Date:   Fri, 30 Jun 2023 20:27:53 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 19/21] firmware: scm: Modify only the download bits in
 TCSR register
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, <corbet@lwn.net>,
        <agross@kernel.org>, <andersson@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <keescook@chromium.org>, <tony.luck@intel.com>,
        <gpiccoli@igalia.com>, <mathieu.poirier@linaro.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <linus.walleij@linaro.org>, <andy.shevchenko@gmail.com>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>
References: <1687955688-20809-1-git-send-email-quic_mojha@quicinc.com>
 <1687955688-20809-20-git-send-email-quic_mojha@quicinc.com>
 <d5c5671f-b6a8-9e97-f917-784dffed7f90@linaro.org>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <d5c5671f-b6a8-9e97-f917-784dffed7f90@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: LpiivA6ciBvOOGo7KcK_y1r3YaR7Kbj7
X-Proofpoint-GUID: LpiivA6ciBvOOGo7KcK_y1r3YaR7Kbj7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-30_05,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 impostorscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 bulkscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306300126
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/28/2023 8:50 PM, Konrad Dybcio wrote:
> On 28.06.2023 14:34, Mukesh Ojha wrote:
>> CrashDump collection is based on the DLOAD bit of TCSR register.
>> To retain other bits, we read the register and modify only the
>> DLOAD bit as the other bits have their own significance.
>>
>> Co-developed-by: Poovendhan Selvaraj <quic_poovendh@quicinc.com>
>> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
>> ---
>>   drivers/firmware/qcom_scm.c | 12 ++++++++++--
>>   1 file changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
>> index 104d86e49b97..a9ff77d16c42 100644
>> --- a/drivers/firmware/qcom_scm.c
>> +++ b/drivers/firmware/qcom_scm.c
>> @@ -30,6 +30,11 @@ module_param(download_mode, bool, 0);
>>   #define SCM_HAS_IFACE_CLK	BIT(1)
>>   #define SCM_HAS_BUS_CLK		BIT(2)
>>   
>> +#define QCOM_DOWNLOAD_FULLDUMP		 0x1
>> +#define QCOM_DOWNLOAD_NODUMP		 0x0
>> +#define QCOM_DOWNLOAD_MODE_SHIFT	   4
>> +#define QCOM_DOWNLOAD_MODE_MASK		0x30
> GENMASK and then FIELD_PREP below?

Just checked about FIELD_PREP, it works, thanks.

FIELD_PREP(GENMASK(5, 4), QCOM_DOWNLOAD_FULLDUMP)
FIELD_PREP(GENMASK(5, 4), QCOM_DOWNLOAD_NODUMP)

-Mukesh

> 
>> +
>>   struct qcom_scm {
>>   	struct device *dev;
>>   	struct clk *core_clk;
>> @@ -440,6 +445,7 @@ static int __qcom_scm_set_dload_mode(struct device *dev, bool enable)
>>   static void qcom_scm_set_download_mode(bool enable)
>>   {
>>   	bool avail;
>> +	int val;
> What's wrong with initializing it in the same line as ret?
> 
>>   	int ret = 0;
>>   
>>   	avail = __qcom_scm_is_call_available(__scm->dev,
>> @@ -448,8 +454,10 @@ static void qcom_scm_set_download_mode(bool enable)
>>   	if (avail) {
>>   		ret = __qcom_scm_set_dload_mode(__scm->dev, enable);
>>   	} else if (__scm->dload_mode_addr) {
>> -		ret = qcom_scm_io_writel(__scm->dload_mode_addr,
>> -				enable ? QCOM_SCM_BOOT_SET_DLOAD_MODE : 0);
>> +		val = (enable ? QCOM_DOWNLOAD_FULLDUMP : QCOM_DOWNLOAD_NODUMP);
> unnecessary braces
> 
> Konrad
>> +		val <<= QCOM_DOWNLOAD_MODE_SHIFT;
>> +		ret = qcom_scm_io_update_field(__scm->dload_mode_addr,
>> +				QCOM_DOWNLOAD_MODE_MASK, val);
>>   	} else {
>>   		dev_err(__scm->dev,
>>   			"No available mechanism for setting download mode\n");
