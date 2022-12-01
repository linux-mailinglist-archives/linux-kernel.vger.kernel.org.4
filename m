Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 576FE63F32D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 15:55:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbiLAOy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 09:54:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiLAOy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 09:54:57 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4224BB7E5;
        Thu,  1 Dec 2022 06:54:55 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B1ClA0Z020865;
        Thu, 1 Dec 2022 14:54:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=AHZfeKWHAigykHXpKG+U8KPxZRTpKcXcySDW/Tm6oVE=;
 b=XEObTR86tM5OKA5pYb3W3XUgT35IpeEJ2kIPLC4bh68BRVbaw66AAlnV9JvJsxnCJIjK
 SIKvy+zJd5Um0bExQTDe5OsonJ3eEQcOKpb+0rYYoQPtqBQKFTBMRBVlc1zRoKaz8Lkz
 T1IkqRqED2W+fUGB4nA3XEsoFLrvDKlPwLRcMFBa4ooolLI7PEhr1pm8DnzlZoX0whrK
 FIEU5KCqbet9MK1iFkhVRcPitswHIBZnBZt5iM14wNJUlzQiU3peIzsENgAQrNlvfS0D
 PkAwGu5DjBc22IihAzB+CFg0x6L2WIIRIooVqc6FsjU1+4JgfNsFcG6TXr3nox0Y0tI1 GA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3m6k2c29t7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Dec 2022 14:54:31 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2B1EsSnx024355
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 1 Dec 2022 14:54:28 GMT
Received: from [10.216.42.191] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 1 Dec 2022
 06:54:23 -0800
Message-ID: <50578b41-8894-24fe-a768-25c55fa38a78@quicinc.com>
Date:   Thu, 1 Dec 2022 20:24:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: PM-runtime: supplier looses track of consumer during probe
Content-Language: en-US
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Tushar Nimkar <quic_tnimkar@quicinc.com>,
        <linux-pm@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        <bjorn.andersson@kernel.org>, <quic_mkshah@quicinc.com>,
        <quic_lsrao@quicinc.com>, <bvanassche@acm.org>,
        Peter Wang <peter.wang@mediatek.com>
References: <36aed941-a73e-d937-2721-4f0decd61ce0@quicinc.com>
 <8c0a715a-d626-aa70-15f1-79f1e23fbc67@quicinc.com>
 <a5e2aab6-7f0e-7f3b-f34b-6d222450c97d@intel.com>
 <8ca27fcb-b146-3ea7-a042-55f99e0ae3fb@quicinc.com>
 <2a1047a7-3121-6cbe-d4c5-46bbff0c5cc5@quicinc.com>
 <20aae21e-62d2-8fdb-b57a-7b5a180266d8@intel.com>
From:   Nitin Rawat <quic_nitirawa@quicinc.com>
In-Reply-To: <20aae21e-62d2-8fdb-b57a-7b5a180266d8@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 2U8UlMOvKdvPcZqq1DNliUaSbNr2AG7r
X-Proofpoint-GUID: 2U8UlMOvKdvPcZqq1DNliUaSbNr2AG7r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-01_11,2022-12-01_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 adultscore=0 mlxlogscore=999 impostorscore=0 spamscore=0 clxscore=1015
 bulkscore=0 phishscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212010108
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,
Thanks for the patch.
I Agree, using local variable to store the runtime status before 
dev->power.lock is released and using this variable later in the code 
can meet the intention of code and can help to solve this race.

We will get it tested and update you.


Regards,
Nitin

On 12/1/2022 6:39 PM, Adrian Hunter wrote:
> On 29/11/22 18:56, Nitin Rawat wrote:
>> Hi Adrian,
>>
>> On 11/21/2022 11:38 AM, Tushar Nimkar wrote:
>>> Hi Adrian,
>>>
>>> On 11/18/2022 8:25 PM, Adrian Hunter wrote:
>>>> On 4/11/22 11:19, Tushar Nimkar wrote:
>>>>> Hi linux-pm/linux-scsi,
>>>
>>>>>> Process -1
>>>>>> ufshcd_async_scan context (process 1)
>>>>>> scsi_autopm_put_device() //0:0:0:0
>>>>
>>>> I am having trouble following your description.  What function is calling
>>>> scsi_autopm_put_device() here?
>>>>
>>> Below is flow which calls scsi_autopm_put_device()
>>> Process -1
>>> ufshcd_async_scan()
>>>       scsi_probe_and_add_lun()
>>>           scsi_add_lun()
>>>               slave_configure()
>>>                   scsi_sysfs_add_sdev()
>>>                       scsi_autopm_get_device()
>>>                           device_add()     <- invoked [Process 2] sd_probe()
>>>                               scsi_autopm_put_device()
>>>
>>>>>> pm_runtime_put_sync()
>>>>>> __pm_runtime_idle()
>>>>>> rpm_idle() -- RPM_GET_PUT(4)
>>>>>>        __rpm_callback
>>>>>>            scsi_runtime_idle()
>>>>>>                pm_runtime_mark_last_busy()
>>>>>>                pm_runtime_autosuspend()  --[A]
>>>>>>                    rpm_suspend() -- RPM_AUTO(8)
>>>>>>                        pm_runtime_autosuspend_expiration() use_autosuspend    is false return 0   --- [B]
>>>>>>                            __update_runtime_status to RPM_SUSPENDING
>>>>>>                        __rpm_callback()
>>>>>>                            __rpm_put_suppliers(dev, false)
>>>>>>                        __update_runtime_status to RPM_SUSPENDED
>>>>>>                    rpm_suspend_suppliers()
>>>>>>                        rpm_idle() for supplier -- RPM_ASYNC(1) return (-EAGAIN) [ Other consumer active for supplier]
>>>>>>                    rpm_suspend() – END with return=0
>>>>>>            scsi_runtime_idle() END return (-EBUSY) always.
>>>>
>>>> Not following here either.  Which device is EBUSY and why?
>>>
>>> scsi_runtime_idle() return -EBUSY always [3]
>>> Storage/scsi team can better explain -EBUSY implementation.
>>
>> EBUSY is returned from below code for consumer dev 0:0:0:0.
>> scsi_runtime_idle is called from scsi_autopm_put_device which inturn is called from ufshcd_async_scan (Process 1 as per above call stack)
>> static int scsi_runtime_idle(struct device *dev)
>> {
>>      :
>>
>>      if (scsi_is_sdev_device(dev)) {
>>          pm_runtime_mark_last_busy(dev);
>>          pm_runtime_autosuspend(dev);
>>          return -EBUSY; ---> EBUSY returned from here.
>>      }
>>
>>      
>> }
>>
>>>
>>> [3] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/scsi/scsi_pm.c?h=next-20221118#n210
>>>
>>>
>>>>>>
>>>>>> [1]: https://lore.kernel.org/lkml/4748074.GXAFRqVoOG@kreacher/T/
>>>>>> [2]: https://lkml.org/lkml/2022/10/12/259
> 
> It looks to me like __rpm_callback() makes assumptions about
> dev->power.runtime_status that are not necessarily true because
> dev->power.lock is dropped.  AFAICT the intention of the code
> would be fulfilled by instead using the status as it was before
> the lock was dropped.
> 
> Consequently, perhaps you could try this:
> 
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> index b52049098d4e..3cf9abc3b2c2 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -365,6 +365,7 @@ static int __rpm_callback(int (*cb)(struct device *), struct device *dev)
>   {
>   	int retval = 0, idx;
>   	bool use_links = dev->power.links_count > 0;
> +	enum rpm_status runtime_status = dev->power.runtime_status;
>   
>   	if (dev->power.irq_safe) {
>   		spin_unlock(&dev->power.lock);
> @@ -378,7 +379,7 @@ static int __rpm_callback(int (*cb)(struct device *), struct device *dev)
>   		 * routine returns, so it is safe to read the status outside of
>   		 * the lock.
>   		 */
> -		if (use_links && dev->power.runtime_status == RPM_RESUMING) {
> +		if (use_links && runtime_status == RPM_RESUMING) {
>   			idx = device_links_read_lock();
>   
>   			retval = rpm_get_suppliers(dev);
> @@ -405,8 +406,8 @@ static int __rpm_callback(int (*cb)(struct device *), struct device *dev)
>   		 * Do that if resume fails too.
>   		 */
>   		if (use_links
> -		    && ((dev->power.runtime_status == RPM_SUSPENDING && !retval)
> -		    || (dev->power.runtime_status == RPM_RESUMING && retval))) {
> +		    && ((runtime_status == RPM_SUSPENDING && !retval)
> +		    || (runtime_status == RPM_RESUMING && retval))) {
>   			idx = device_links_read_lock();
>   
>   			__rpm_put_suppliers(dev, false);
> 
> 
