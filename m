Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69A726406B7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 13:23:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233422AbiLBMXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 07:23:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233332AbiLBMXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 07:23:10 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0817BF013;
        Fri,  2 Dec 2022 04:23:09 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B2AresJ010708;
        Fri, 2 Dec 2022 12:23:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=cQZvQoTwciKJEJStvGK0dTVTwyNTXTDVMusv/IDHPdI=;
 b=N9Oz15O0Kz/yCT/evWuqRfYB/ack3SRNrukhp3XUD7zDi1vMcW/XPQRfKDa2v07T2xV3
 vHFXvHVjdN5zWRqvxk/Kn7h7qHeMD4KcUtz8gEPsbsLV1Ris5nqBU7TlHTVwVPm14Zf8
 o2rSq3sNa48P/9Janv8MyY+w/71+IcCY3ZQNjwCy4svaS+L27QRbJ1g9xpVSn1Na7h1y
 wQ1RMaWvV9O/ZZdfATAOkMjQVc3rdL4GSPoGdSlqwdnThZlJNBCIahK6SI7Cm9MsiUNn
 KRR7pa/s+PEV2qyOmBvoZolN02KMJf87uY/w2TIlMRTVQZOx3JmaETIHX25VHo21O58o gA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3m7c22172v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Dec 2022 12:23:00 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2B2CMxOk026345
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 2 Dec 2022 12:22:59 GMT
Received: from [10.216.7.250] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 2 Dec 2022
 04:22:55 -0800
Message-ID: <5f129a61-0311-0b80-2e74-8425650bbd26@quicinc.com>
Date:   Fri, 2 Dec 2022 17:52:41 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: PM-runtime: supplier looses track of consumer during probe
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Adrian Hunter <adrian.hunter@intel.com>
CC:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Nitin Rawat <quic_nitirawa@quicinc.com>,
        <linux-pm@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        <bjorn.andersson@kernel.org>, <quic_mkshah@quicinc.com>,
        <quic_lsrao@quicinc.com>, <bvanassche@acm.org>,
        Peter Wang <peter.wang@mediatek.com>
References: <36aed941-a73e-d937-2721-4f0decd61ce0@quicinc.com>
 <20aae21e-62d2-8fdb-b57a-7b5a180266d8@intel.com>
 <CAJZ5v0gdg=PUz-j0yd_QJRPmjhZ7pCuRrHt30U60H4QyTHCmdA@mail.gmail.com>
 <12104185.O9o76ZdvQC@kreacher>
Content-Language: en-US
From:   Tushar Nimkar <quic_tnimkar@quicinc.com>
In-Reply-To: <12104185.O9o76ZdvQC@kreacher>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 6zxY9HzKvhb9W5GVdFFZEfdDwCzu4vQS
X-Proofpoint-GUID: 6zxY9HzKvhb9W5GVdFFZEfdDwCzu4vQS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-02_05,2022-12-01_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 adultscore=0 phishscore=0 mlxscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212020096
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Adrian and Rafael,
We are trying both patches separately. And will update result once we get.

Thanks,
Tushar Nimkar

On 12/2/2022 1:14 AM, Rafael J. Wysocki wrote:
> On Thursday, December 1, 2022 8:28:25 PM CET Rafael J. Wysocki wrote:
>> On Thu, Dec 1, 2022 at 2:10 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>>
>>> On 29/11/22 18:56, Nitin Rawat wrote:
>>>> Hi Adrian,
>>>>
>>>> On 11/21/2022 11:38 AM, Tushar Nimkar wrote:
>>>>> Hi Adrian,
>>>>>
>>>>> On 11/18/2022 8:25 PM, Adrian Hunter wrote:
>>>>>> On 4/11/22 11:19, Tushar Nimkar wrote:
>>>>>>> Hi linux-pm/linux-scsi,
>>>>>
>>>>>>>> Process -1
>>>>>>>> ufshcd_async_scan context (process 1)
>>>>>>>> scsi_autopm_put_device() //0:0:0:0
>>>>>>
>>>>>> I am having trouble following your description.  What function is calling
>>>>>> scsi_autopm_put_device() here?
>>>>>>
>>>>> Below is flow which calls scsi_autopm_put_device()
>>>>> Process -1
>>>>> ufshcd_async_scan()
>>>>>       scsi_probe_and_add_lun()
>>>>>           scsi_add_lun()
>>>>>               slave_configure()
>>>>>                   scsi_sysfs_add_sdev()
>>>>>                       scsi_autopm_get_device()
>>>>>                           device_add()     <- invoked [Process 2] sd_probe()
>>>>>                               scsi_autopm_put_device()
>>>>>
>>>>>>>> pm_runtime_put_sync()
>>>>>>>> __pm_runtime_idle()
>>>>>>>> rpm_idle() -- RPM_GET_PUT(4)
>>>>>>>>        __rpm_callback
>>>>>>>>            scsi_runtime_idle()
>>>>>>>>                pm_runtime_mark_last_busy()
>>>>>>>>                pm_runtime_autosuspend()  --[A]
>>>>>>>>                    rpm_suspend() -- RPM_AUTO(8)
>>>>>>>>                        pm_runtime_autosuspend_expiration() use_autosuspend    is false return 0   --- [B]
>>>>>>>>                            __update_runtime_status to RPM_SUSPENDING
>>>>>>>>                        __rpm_callback()
>>>>>>>>                            __rpm_put_suppliers(dev, false)
>>>>>>>>                        __update_runtime_status to RPM_SUSPENDED
>>>>>>>>                    rpm_suspend_suppliers()
>>>>>>>>                        rpm_idle() for supplier -- RPM_ASYNC(1) return (-EAGAIN) [ Other consumer active for supplier]
>>>>>>>>                    rpm_suspend() – END with return=0
>>>>>>>>            scsi_runtime_idle() END return (-EBUSY) always.
>>>>>>
>>>>>> Not following here either.  Which device is EBUSY and why?
>>>>>
>>>>> scsi_runtime_idle() return -EBUSY always [3]
>>>>> Storage/scsi team can better explain -EBUSY implementation.
>>>>
>>>> EBUSY is returned from below code for consumer dev 0:0:0:0.
>>>> scsi_runtime_idle is called from scsi_autopm_put_device which inturn is called from ufshcd_async_scan (Process 1 as per above call stack)
>>>> static int scsi_runtime_idle(struct device *dev)
>>>> {
>>>>      :
>>>>
>>>>      if (scsi_is_sdev_device(dev)) {
>>>>          pm_runtime_mark_last_busy(dev);
>>>>          pm_runtime_autosuspend(dev);
>>>>          return -EBUSY; ---> EBUSY returned from here.
>>>>      }
>>>>
>>>>
>>>> }
>>>>
>>>>>
>>>>> [3] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/scsi/scsi_pm.c?h=next-20221118#n210
>>>>>
>>>>>
>>>>>>>>
>>>>>>>> [1]: https://lore.kernel.org/lkml/4748074.GXAFRqVoOG@kreacher/T/
>>>>>>>> [2]: https://lkml.org/lkml/2022/10/12/259
>>>
>>> It looks to me like __rpm_callback() makes assumptions about
>>> dev->power.runtime_status that are not necessarily true because
>>> dev->power.lock is dropped.
>>
>> Well, this happens because rpm_idle() calls __rpm_callback() and
>> allows it to run concurrently with rpm_suspend() and rpm_resume(), so
>> one of them may change runtime_status to RPM_SUSPENDING or
>> RPM_RESUMING while __rpm_callback() is running.
>>
>> It is somewhat questionable whether or not this should be allowed to
>> happen, but since it is generally allowed to suspend the device from
>> its .runtime_idle callback, there is not too much that can be done
>> about it.
> 
> But this means that the patch below should help too.
> 
> I actually think that we can do both, because rpm_idle() doesn't have to do
> the whole device links dance and the fact that it still calls __rpm_callback()
> is a clear oversight.
> 
> ---
>   drivers/base/power/runtime.c |   12 +++++++++++-
>   1 file changed, 11 insertions(+), 1 deletion(-)
> 
> Index: linux-pm/drivers/base/power/runtime.c
> ===================================================================
> --- linux-pm.orig/drivers/base/power/runtime.c
> +++ linux-pm/drivers/base/power/runtime.c
> @@ -484,7 +484,17 @@ static int rpm_idle(struct device *dev,
>   
>   	dev->power.idle_notification = true;
>   
> -	retval = __rpm_callback(callback, dev);
> +	if (dev->power.irq_safe)
> +		spin_unlock(&dev->power.lock);
> +	else
> +		spin_unlock_irq(&dev->power.lock);
> +
> +	retval = callback(dev);
> +
> +	if (dev->power.irq_safe)
> +		spin_lock(&dev->power.lock);
> +	else
> +		spin_lock_irq(&dev->power.lock);
>   
>   	dev->power.idle_notification = false;
>   	wake_up_all(&dev->power.wait_queue);
> 
> 
> 
