Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC5B64B67F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 14:42:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235730AbiLMNmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 08:42:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235729AbiLMNmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 08:42:42 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69820319;
        Tue, 13 Dec 2022 05:42:41 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BD9wGqY029177;
        Tue, 13 Dec 2022 13:42:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=XrZbGC6xqJZQMHq1bEwiY8nPFiDOlrB2h9CcFtTYOII=;
 b=HcapBWXGRcRfMx9l8rqhgvf2tEqCizXpYUygFV4ISpKlE/DgkY+L8ygKJDHEXZB4srii
 XdN8yavL8065nysa9M0M20Qg3jmtg9VMbO3+j3aIOerWedyHCGCL8IhC8MHLeEntD3la
 IO0q/2l8li9jC0BQBf+0+FjlTK1HE6S0DS+a7zIbxExnixtwF4kQY8nF/f3UygO7Ef1u
 ++4/4T2vYqoaZoswivzDnFMj6tf2HARx8u5QHLXnSzMpx48tpfRmWHJze5Daqe+4A2Mw
 lFMUit/kufyt4rPN2CvggF3R+yYzdqaHwukBpIGwwhhRV0Gohwfq6PO6jawJOes+J3hN bA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3meq7qgqbg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Dec 2022 13:42:37 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BDDgb41022791
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Dec 2022 13:42:37 GMT
Received: from [10.216.62.137] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 13 Dec
 2022 05:42:31 -0800
Message-ID: <367fdcef-7360-055a-897b-71a66063b4ba@quicinc.com>
Date:   Tue, 13 Dec 2022 19:12:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] spmi: Add check for remove callback in spmi_drv_remove
 API
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>,
        <linus.walleij@linaro.org>, <quic_kamalw@quicinc.com>,
        <quic_jestar@quicinc.com>, <sboyd@kernel.org>,
        <quic_subbaram@quicinc.com>, <quic_collinsd@quicinc.com>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-arm-msm-owner@vger.kernel.org>
References: <1670145780-13111-1-git-send-email-quic_jprakash@quicinc.com>
 <1670145780-13111-2-git-send-email-quic_jprakash@quicinc.com>
 <Y5hqMFw0xl6lmJYL@kroah.com>
From:   Jishnu Prakash <quic_jprakash@quicinc.com>
In-Reply-To: <Y5hqMFw0xl6lmJYL@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: R7W2dDGa3t7pIn16aSIt_MUAB9o0Zs_L
X-Proofpoint-ORIG-GUID: R7W2dDGa3t7pIn16aSIt_MUAB9o0Zs_L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-13_03,2022-12-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 phishscore=0 lowpriorityscore=0 spamscore=0 mlxlogscore=677 suspectscore=0
 adultscore=0 priorityscore=1501 clxscore=1015 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212130122
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg

These are two SPMI drivers without remove callbacks defined:

drivers/mfd/qcom-spmi-pmic.c
drivers/mfd/hi6421-spmi-pmic.c

We made this change after noticing an issue internally with the first 
one above, there was a crash when trying to remove it with rmmod, which 
is fixed by this change. In addition, since the probe of the QCOM SPMI 
PMIC driver uses devm_ functions throughout, we could see that with this 
change, when we remove the device with rmmod, the cleanup does happen 
correctly even though there is no remove function defined in the driver. 
The last function called in the probe of our SPMI PMIC driver is 
devm_of_platform_populate(), to probe all the PMIC peripheral drivers 
under this one, and when this driver module was  removed with rmmod, we 
could see that the individual PMIC drivers under it also got depopulated 
with their remove APIs getting called.

If it is possible for a SPMI driver to be removed correctly by rmmod 
without having a remove API defined, this change should be right, what 
do you think?

Thanks,

Jishnu

On 12/13/2022 5:34 PM, Greg KH wrote:
> On Sun, Dec 04, 2022 at 02:53:00PM +0530, Jishnu Prakash wrote:
>> Add a check for remove callback presence before calling it for a
>> spmi driver, to avoid NULL pointer dereference error if remove callback
>> has not been specified for that SPMI driver.
>>
>> Signed-off-by: Jishnu Prakash <quic_jprakash@quicinc.com>
>> ---
>>   drivers/spmi/spmi.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/spmi/spmi.c b/drivers/spmi/spmi.c
>> index a456ce5..6b34356 100644
>> --- a/drivers/spmi/spmi.c
>> +++ b/drivers/spmi/spmi.c
>> @@ -350,7 +350,8 @@ static void spmi_drv_remove(struct device *dev)
>>   	const struct spmi_driver *sdrv = to_spmi_driver(dev->driver);
>>   
>>   	pm_runtime_get_sync(dev);
>> -	sdrv->remove(to_spmi_device(dev));
>> +	if (sdrv->remove)
>> +		sdrv->remove(to_spmi_device(dev));
>>   	pm_runtime_put_noidle(dev);
>>   
>>   	pm_runtime_disable(dev);
> 
> What in-kernel spmi driver does not have a remove function set that
> requires this change?
> 
> thanks,
> 
> greg k-h
