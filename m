Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7498F6CB93D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 10:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbjC1IVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 04:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbjC1IVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 04:21:46 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92D3E4EE2;
        Tue, 28 Mar 2023 01:21:16 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32S6XIhE013994;
        Tue, 28 Mar 2023 08:21:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=kmm9w/HUF5DL0XlfCw9kOGGhBrw7rQ+kN11GBM7+yFg=;
 b=WWL4l/fcTEW3Z0g5HnqHby09RYAmWtpKNU+gUTkU221k0z9H3LPXAhjJ/Lts1kRbFIfG
 bzBYoq8LsWJLgAxek1w3hJs0RuewWIywwiTmwMGc4bchNT/D0Q+jzye536pMdOtZPRXk
 UIasJtV2ALC3E4VHDiCWDGctVdneR5cs2iLGFqYnX09iQUBmcfR489TYrVCtmdsEbJBt
 XzmPB0E9nIxG7TLtSWUzwp/1Yp93IyZfN2ynIEDf9kgAjOq+EKFBxnzswrftqQAQf/QX
 t3qDDlMjy47i9cBXXW4nMNSFsQQi4WlAQUis/KTFkQ+HuqJbXe4/gWo29B39rCxT/Oly RA== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pkcm2tc1j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Mar 2023 08:21:13 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32S8LCgY019672
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Mar 2023 08:21:12 GMT
Received: from [10.214.66.81] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 28 Mar
 2023 01:21:02 -0700
Message-ID: <4fa90274-9902-dd9a-f566-29c6956d8175@quicinc.com>
Date:   Tue, 28 Mar 2023 13:50:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v4 5/5] firmware: qcom_scm: Add multiple download mode
 support
Content-Language: en-US
To:     Bjorn Andersson <andersson@kernel.org>
CC:     <agross@kernel.org>, <konrad.dybcio@linaro.org>,
        <linus.walleij@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>
References: <1679935281-18445-1-git-send-email-quic_mojha@quicinc.com>
 <1679935281-18445-6-git-send-email-quic_mojha@quicinc.com>
 <20230327182723.bopz73a5as4ft74g@ripper>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20230327182723.bopz73a5as4ft74g@ripper>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: J4SD-L73fgLzGT_b1TL8NzMqMFMMSe4u
X-Proofpoint-GUID: J4SD-L73fgLzGT_b1TL8NzMqMFMMSe4u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-27_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303280069
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/27/2023 11:57 PM, Bjorn Andersson wrote:
> On Mon, Mar 27, 2023 at 10:11:21PM +0530, Mukesh Ojha wrote:
>> Currently, scm driver only supports full dump when download
>> mode is selected. Add support to enable minidump as well both
>> dump(full dump + minidump).
>>
>> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
>> ---
>>   drivers/firmware/qcom_scm.c | 13 +++++++++++--
>>   1 file changed, 11 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
>> index 0c94429..19315d0 100644
>> --- a/drivers/firmware/qcom_scm.c
>> +++ b/drivers/firmware/qcom_scm.c
>> @@ -32,6 +32,8 @@ static u32 download_mode;
>>   
>>   #define QCOM_DOWNLOAD_MODE_MASK 0x30
>>   #define QCOM_DOWNLOAD_FULLDUMP	0x1
>> +#define QCOM_DOWNLOAD_MINIDUMP  0x2
>> +#define QCOM_DOWNLOAD_BOTHDUMP	(QCOM_DOWNLOAD_FULLDUMP | QCOM_DOWNLOAD_MINIDUMP)
>>   #define QCOM_DOWNLOAD_NODUMP	0x0
>>   
>>   struct qcom_scm {
>> @@ -1421,13 +1423,16 @@ static irqreturn_t qcom_scm_irq_handler(int irq, void *data)
>>   	return IRQ_HANDLED;
>>   }
>>   
>> -
>>   static int get_download_mode(char *buffer, const struct kernel_param *kp)
>>   {
>>   	int len = 0;
>>   
>>   	if (download_mode == QCOM_DOWNLOAD_FULLDUMP)
>>   		len = sysfs_emit(buffer, "full\n");
>> +	else if (download_mode == QCOM_DOWNLOAD_MINIDUMP)
>> +		len = sysfs_emit(buffer, "mini\n");
>> +	else if (download_mode == QCOM_DOWNLOAD_BOTHDUMP)
>> +		len = sysfs_emit(buffer, "both\n");
>>   	else if (download_mode == QCOM_DOWNLOAD_NODUMP)
>>   		len = sysfs_emit(buffer, "off\n");
>>   
>> @@ -1440,6 +1445,10 @@ static int set_download_mode(const char *val, const struct kernel_param *kp)
>>   
>>   	if (!strncmp(val, "full", strlen("full"))) {
>>   		download_mode = QCOM_DOWNLOAD_FULLDUMP;
>> +	} else if (!strncmp(val, "mini", strlen("mini"))) {
>> +		download_mode = QCOM_DOWNLOAD_MINIDUMP;
>> +	} else if (!strncmp(val, "both", strlen("both"))) {
> 
> "both" isn't very future proof...
> 
> How about allowing mini,full? You don't need to do string tokenizing
> etc, just strcmp mini,full (and full,mini if you want to be fancy)...
> 

Thanks for the suggestion, this looks good.
I have applied the changes.

-- Mukesh

> Regards,
> Bjorn
> 
>> +		download_mode = QCOM_DOWNLOAD_BOTHDUMP;
>>   	} else if (!strncmp(val, "off", strlen("off"))) {
>>   		download_mode = QCOM_DOWNLOAD_NODUMP;
>>   	} else if (kstrtouint(val, 0, &download_mode) ||
>> @@ -1462,7 +1471,7 @@ static const struct kernel_param_ops download_mode_param_ops = {
>>   
>>   module_param_cb(download_mode, &download_mode_param_ops, NULL, 0644);
>>   MODULE_PARM_DESC(download_mode,
>> -		 "Download mode: off/full or 0/1 for existing users");
>> +		 "download mode: off/full/mini/both(full+mini) or 0/1 for existing users");
>>   
>>   static int qcom_scm_probe(struct platform_device *pdev)
>>   {
>> -- 
>> 2.7.4
>>
