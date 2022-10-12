Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8675FC3C6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 12:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbiJLKbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 06:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiJLKbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 06:31:18 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A5E4C614;
        Wed, 12 Oct 2022 03:31:17 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29C7xx0o022938;
        Wed, 12 Oct 2022 10:31:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=y/qOu3L46EGsj1jWCQr10KXP7kKggIRosU0MGGPdRks=;
 b=eOqUJOUPDM6yD+THge9/qDzivRsD4ks6mOauIptJWK2iBdIa5vHtECBiFVa76i+3OrH8
 JeGLmLaHiMPhF38KUq6AVRBb9u5AIR3i46ncinhBuDrVLUYVnm+mhjnX+WewsrkjDSN9
 +rWw37dIaEpSb0EvdS1yHd2E8J4H1VIpgt4GAmypREYlUA9UMuiVCXGy3seWVtpAHCBH
 zDMsxFD/eSYC5l6wv/FCgL37go7gt7xGTjulM5gV4qptHty2caM4YWKkACDBWHtMT6rA
 Afvt7WmC+XQrBU+f+m4oJ8UEZ4ePUVMTkpfiupxRQNR6mTDkiCdN6/BkAh8AKpdHoAWG tA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k5j7b1huq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Oct 2022 10:31:08 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29CAV7at011711
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Oct 2022 10:31:07 GMT
Received: from [10.242.7.244] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 12 Oct
 2022 03:31:05 -0700
Message-ID: <d7111bd2-d431-e5e1-1a36-6d0d4d4ec19b@quicinc.com>
Date:   Wed, 12 Oct 2022 16:01:01 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v1] PM-runtime: Check supplier_preactivated before release
 supplier
To:     Peter Wang <peter.wang@mediatek.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
CC:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20220613120755.14306-1-peter.wang@mediatek.com>
 <b55d5691-0b2d-56bb-26ff-dcac56770611@mediatek.com>
 <CAJZ5v0gTpv2gt_Gm9rUd+8Jmp4=ij2=J20o7qO0sC-hm=w3=_A@mail.gmail.com>
 <12028598.O9o76ZdvQC@kreacher>
 <90b5f619-2dd6-817b-fe2d-f895be0b5b98@mediatek.com>
 <CAJZ5v0h8xNCV+1YwRA5wob6Vnvz8JFikv3pYMR_mUrXxzfc=tQ@mail.gmail.com>
 <f6ebfd39-a27a-8b1c-6a61-f9a63236961d@mediatek.com>
 <CAJZ5v0gChpusk6JuTG+Zhd_qGR1N+s97Avn4ybdp7Ggpv_uRaQ@mail.gmail.com>
 <7c3ec17e-296f-ab15-6055-fd59a7d8f036@mediatek.com>
 <5c9a3908-a2c6-76d7-db6d-d762503d640a@mediatek.com>
 <CAJZ5v0gSY7sJ2zsUsBeNFpT8XnL5yHd0inxh1+pXa9s1b9M50A@mail.gmail.com>
 <80a67ef6-ea29-5b96-9596-6fbbb34c4961@mediatek.com>
Content-Language: en-US
From:   Nitin Rawat <quic_nitirawa@quicinc.com>
In-Reply-To: <80a67ef6-ea29-5b96-9596-6fbbb34c4961@mediatek.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ZKQmqTEPNJtWwAHQdWkZr0J-6sezSfGJ
X-Proofpoint-ORIG-GUID: ZKQmqTEPNJtWwAHQdWkZr0J-6sezSfGJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-12_04,2022-10-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 spamscore=0 suspectscore=0 clxscore=1011 impostorscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210120068
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter/Rafael,
We are also observed similiar issue on our platform. Looks like there is 
a race condition(explained below) which cause consumer to resume w/o 
bumping up the supplier's PM-runtime usage counter.

Process 1 (ufshcd_async_scan context)
ufshcd_async_scan()
     scsi_probe_and_add_lun
         scsi_add_lun
             slave_configure    -> enable rpm
                 scsi_sysfs_add_sdev
                     scsi_autopm_get_device
                         device_add     <- invoked sd_probe in process 2
                             scsi_autopm_put_device

Process 2 (sd_probe context)
driver_probe_device
__device_attach_async_helper
     __device_attach_driver
         driver_probe_device
             __driver_probe_device
                 sd_probe
                     scsi_autopm_get_device



Race condition for dev->power.runtime_status for consumer dev 0:0:0:0 
can happen as below in rpm framework

ufshcd_async_scan context (process 1)
scsi_autopm_put_device() //0:0:0:0
	pm_runtime_put_sync()
	__pm_runtime_idle()
	rpm_idle()
	__rpm_callback()
		scsi_runtime_idle()
			pm_runtime_mark_last_busy()
			pm_runtime_autosuspend()
				__pm_runtime_suspend(RPM_AUTO)
				rpm_suspend(RPM_AUTO)
					status = RPM_SUSPENDING
					scsi_runtime_suspend()
						__rpm_callback()
					status = RPM_SUSPENDED------>1
					rpm_suspend_suppliers()
			return -EBUSY

		(use_links)&&(dev->power.runtime_status == RPM_RESUMING && 
retval)------->3
		__rpm_put_suppliers()





sd_probe context (Process 2)
scsi_autopm_get_device() //0:0:0:0
     __pm_runtime_resume(RPM_GET_PUT)
     rpm_resume
      	status = RPM_RESUMING----->2



After power.runtime_status of consumer 0:0:0:0 was changed to 
RPM_SUSPENDED and before scsi_runtime_idle retval was -16(EBUSY) to 
__rpm_callback, power.runtime_status of consumer 0:0:0:0 was changed to 
RPM_RESUMING and hence condition 3 became true and __rpm_put_suppliers 
was called and hence consumer resumed with decremented usage_count due 
to this race condition.

Please let me know your thoughts on this.

Regards,
Nitin

On 8/2/2022 7:03 PM, Peter Wang wrote:
> 
> On 8/2/22 7:01 PM, Rafael J. Wysocki wrote:
>> On Tue, Aug 2, 2022 at 5:19 AM Peter Wang <peter.wang@mediatek.com> 
>> wrote:
>>>
>>>> Hi Rafael,
>>>>
>>>> Yes, it is very clear!
>>>> I miss this important key point that usage_count is always >
>>>> rpm_active 1.
>>>> I think this patch could work.
>>>>
>>>> Thanks.
>>>> Peter
>>>>
>>>>
>>>>
>>>>
>>> Hi Rafael,
>>>
>>> After test with commit ("887371066039011144b4a94af97d9328df6869a2 PM:
>>> runtime: Fix supplier device management during consumer probe") past 
>>> weeks,
>>> The supplier still suspend when consumer is active "after"
>>> pm_runtime_put_suppliers.
>>> Do you have any idea about that?
>> Well, this means that the consumer probe doesn't bump up the
>> supplier's PM-runtime usage counter as appropriate.
>>
>> You need to tell me more about what happens during the consumer probe.
>> Which driver is this?
> 
> Hi Rafael,
> 
> I have the same idea with you. But I still don't know how it could happen.
> 
> It is upstream ufs driver in scsi system. Here is call flow
> do_scan_async (process 1)
>      do_scsi_scan_host
>          scsi_scan_host_selected
>              scsi_scan_channel
>                  __scsi_scan_target
>                      scsi_probe_and_add_lun
>                          scsi_alloc_sdev
>                              slave_alloc     -> setup link
>                          scsi_add_lun
>                              slave_configure    -> enable rpm
>                              scsi_sysfs_add_sdev
>                                  scsi_autopm_get_device    <- get 
> runtime pm
>                                  device_add                <- invoke 
> sd_probe in process 2
>                                  scsi_autopm_put_device    <- put 
> runtime pm, point 1
> 
> driver_probe_device (process 2)
>      __driver_probe_device
>          pm_runtime_get_suppliers
>              really_probe
>                  sd_probe
>                      scsi_autopm_get_device                <- get 
> runtime pm, point 2
>                      pm_runtime_set_autosuspend_delay    <- set rpm 
> delay to 2s
>                      scsi_autopm_put_device                <- put 
> runtime pm
>          pm_runtime_put_suppliers                        <- 
> (link->rpm_active = 1)
> 
> After process 1 call scsi_autopm_put_device(point 1) let consumer enter 
> suspend,
> process 2 call scsi_autopm_get_device(point 2) may have chance resume 
> consumer but not
> bump up the supplier's PM-runtime usage counter as appropriate.
> 
> Thanks.
> Peter
> 
> 
> 
> 
> 
> 
> 
