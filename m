Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9EA73E507
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 18:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbjFZQ3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 12:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbjFZQ3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 12:29:22 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E917230E7;
        Mon, 26 Jun 2023 09:28:16 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35QE0vr8016114;
        Mon, 26 Jun 2023 16:28:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=71P9kkKjmHcIHJCwCMhSnLjhjtNBY9RZBfPWrRB0XN4=;
 b=Y8dJzzBePblKSosfDQgoFn3EwEbRFkTSz407E53naa+MdPq08X07l9cXCBqq51tG2T32
 TLNuPN5R6CNnaCeJqNknQoIoUYQc5KaC2PQaLxutqaffEF9+bQ6X9mfcrlFq7m2MMGOm
 D3WW17mwt3zIHQ7Ag6Rxb5WI8AFS0ET/tTGPxV6BnG6ik6DJZgifNyWONmce+6FhhAno
 xCzmD7OXZXaEzQ8HqN8TC2J9VMoSIkTY3a6kKvmUQejLA9pMViFgcFk/AfxKb2sHspw+
 Pcoq0X5EumDsBrgdkRW+RfZUCOF8jyQ0Q5houHZwhHclQNZXbclr6MMhdAeV1QHWkbFK gw== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rdqgdcmma-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Jun 2023 16:28:11 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35QGSAxI026462
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Jun 2023 16:28:10 GMT
Received: from [10.216.59.223] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Mon, 26 Jun
 2023 09:28:07 -0700
Message-ID: <6d9f251e-2c1a-ed50-638e-a052404ffc64@quicinc.com>
Date:   Mon, 26 Jun 2023 21:57:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v6 4/5] firmware: qcom_scm: Refactor code to support
 multiple download mode
To:     <andy.shevchenko@gmail.com>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <linus.walleij@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>
References: <1680076012-10785-1-git-send-email-quic_mojha@quicinc.com>
 <1680076012-10785-5-git-send-email-quic_mojha@quicinc.com>
 <ZHEt2mrYpSMKBuIX@surfacebook>
Content-Language: en-US
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <ZHEt2mrYpSMKBuIX@surfacebook>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: YQjCSbztMZOiJDGeGxZzkvEGMsJNfE3-
X-Proofpoint-GUID: YQjCSbztMZOiJDGeGxZzkvEGMsJNfE3-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-26_09,2023-06-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1011
 suspectscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 adultscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306260121
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/27/2023 3:38 AM, andy.shevchenko@gmail.com wrote:
> Wed, Mar 29, 2023 at 01:16:51PM +0530, Mukesh Ojha kirjoitti:
>> Currently on Qualcomm SoC, download_mode is enabled if
>> CONFIG_QCOM_SCM_DOWNLOAD_MODE_DEFAULT is selected.
>>
>> Refactor the code such that it supports multiple download
>> modes and drop CONFIG_QCOM_SCM_DOWNLOAD_MODE_DEFAULT config
>> instead, give interface to set the download mode from
>> module parameter.
> 
> ...
> 
>>   #include <linux/clk.h>
>>   #include <linux/reset-controller.h>
>>   #include <linux/arm-smccc.h>
> 
>> +#include <linux/kstrtox.h>
> 
> Can this be located after clk.h which makes (some) order in this block?

Sure.

> 
> ...
> 
>>   #define QCOM_DOWNLOAD_MODE_MASK 0x30
>>   #define QCOM_DOWNLOAD_FULLDUMP	0x1
>> +#define QCOM_DOWNLOAD_NODUMP	0x0
> 
> Okay, so you start backward ordering.
> But see comments to the next patch.

Will fix this by doing it in ascending order..


> 
> ...
> 
>>   		ret = qcom_scm_io_update_field(__scm->dload_mode_addr,
>> -				QCOM_DOWNLOAD_MODE_MASK,
>> -				enable ? QCOM_DOWNLOAD_FULLDUMP : 0);
>> +				QCOM_DOWNLOAD_MODE_MASK, download_mode);
> 
> Can ping-pong style be avoided? I.e. do the right thing in the previous patch,
> so you won't change lines that were introduced just before.

If you notice, I have just converted download mode data type from bool
to int in this patch and hence the changing the line here. Last patch 
was about just using the exported API, so i hope you would be fine here.

> 
> ...
> 
>>   }
>>   
>> +
> 
> Stray change.
> 
>> +static int get_download_mode(char *buffer, const struct kernel_param *kp)
>> +{
>> +	int len = 0;
>> +
>> +	if (download_mode == QCOM_DOWNLOAD_FULLDUMP)
>> +		len = sysfs_emit(buffer, "full\n");
>> +	else if (download_mode == QCOM_DOWNLOAD_NODUMP)
>> +		len = sysfs_emit(buffer, "off\n");
>> +
>> +	return len;
> 
> You can return directly.

Ok.

>  > Also, what about download_mode that doesn't fit to the above two?

return sysfs_emit(buffer, "unknown\n"); ?

> 
>> +}
> 
> ...
> 
>> +static int set_download_mode(const char *val, const struct kernel_param *kp)
>> +{
>> +	u32 old = download_mode;
>> +
>> +	if (sysfs_streq(val, "full")) {
>> +		download_mode = QCOM_DOWNLOAD_FULLDUMP;
>> +	} else if (sysfs_streq(val, "off")) {
>> +		download_mode = QCOM_DOWNLOAD_NODUMP;
> 
> NIH sysfs_match_string().

NIH ?

My apology, if i did not get this..
Do you want me to use sysfs_match_string()
and how would that help compare to what is present now ?

> 
>> +	} else if (kstrtouint(val, 0, &download_mode) ||
>> +		   !(download_mode == 0 || download_mode == 1)) {
>> +		download_mode = old;
>> +		pr_err("qcom_scm: unknown download mode: %s\n", val);
> 
>> +		return -EINVAL;
> 
> Do not shadow the error code from kstrtouint() it can be different to this one.

Will fix this.

> 
>> +	}
>> +
>> +	if (__scm)
>> +		qcom_scm_set_download_mode(download_mode);
>> +
>> +	return 0;
>> +}
> 
> ...
> 
> Have you updated corresponding documentation about this parameter?
> Or there is none?

There is none as of yet outside this file; should that be good what i 
have added in 5/5..

> 

-Mukesh
