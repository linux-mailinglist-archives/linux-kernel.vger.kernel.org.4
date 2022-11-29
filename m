Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51BEC63C5F7
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 18:00:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236489AbiK2RAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 12:00:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236484AbiK2RAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 12:00:13 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2548C6DFF2;
        Tue, 29 Nov 2022 08:56:30 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ATFCEI4002709;
        Tue, 29 Nov 2022 16:56:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=u9zXB3qqVZ0k/Ms/7UTwwNWaO6cuhnG1yPubtNR+wj0=;
 b=QZLGvXd4PSSC8lmS85vnOI+Dtp2UyIW2PraLvE2ceo8p2aJWT5doqqI7bE7YCgrVRPUn
 eQMosBzs99TFvkNLEHAjCvsA2ebDlgdl78Y0J5/9GQ7P2EWuQQ4iOcK393qf4PhVnI0V
 qWNh1TcSN3knH6p7Svq4uLg3N5IKpD2/7YDYNTCLA169aCd3xwaMB5/JZPtOZamh4E6D
 jiJFiGAjKvyzdqE7QeYtIp5JKNI314nJho/vsdfz+PDJB+2sfnNuJq14jRvnUolvCYo2
 zMcZ9/NDUsumEHbFppR9FtBbm28n1+OGD1NSWeYF8S5+WAeF9Z0iFB9kRLVmFoSCF0lP Tg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3m5bnh1u5k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Nov 2022 16:56:21 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2ATGuKjP030058
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Nov 2022 16:56:20 GMT
Received: from [10.216.8.159] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 29 Nov
 2022 08:56:16 -0800
Message-ID: <2a1047a7-3121-6cbe-d4c5-46bbff0c5cc5@quicinc.com>
Date:   Tue, 29 Nov 2022 22:26:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: PM-runtime: supplier looses track of consumer during probe
To:     Tushar Nimkar <quic_tnimkar@quicinc.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
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
Content-Language: en-US
From:   Nitin Rawat <quic_nitirawa@quicinc.com>
In-Reply-To: <8ca27fcb-b146-3ea7-a042-55f99e0ae3fb@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: PCdJ6YPgUwI8byB6RxkpvBrLF8MLWPan
X-Proofpoint-GUID: PCdJ6YPgUwI8byB6RxkpvBrLF8MLWPan
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-29_11,2022-11-29_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 adultscore=0 lowpriorityscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 bulkscore=0 impostorscore=0 mlxscore=0
 spamscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211290094
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

On 11/21/2022 11:38 AM, Tushar Nimkar wrote:
> Hi Adrian,
> 
> On 11/18/2022 8:25 PM, Adrian Hunter wrote:
>> On 4/11/22 11:19, Tushar Nimkar wrote:
>>> Hi linux-pm/linux-scsi,
> 
>>>> Process -1
>>>> ufshcd_async_scan context (process 1)
>>>> scsi_autopm_put_device() //0:0:0:0
>>
>> I am having trouble following your description.  What function is calling
>> scsi_autopm_put_device() here?
>>
> Below is flow which calls scsi_autopm_put_device()
> Process -1
> ufshcd_async_scan()
>      scsi_probe_and_add_lun()
>          scsi_add_lun()
>              slave_configure()
>                  scsi_sysfs_add_sdev()
>                      scsi_autopm_get_device()
>                          device_add()     <- invoked [Process 2] sd_probe()
>                              scsi_autopm_put_device()
> 
>>>> pm_runtime_put_sync()
>>>> __pm_runtime_idle()
>>>> rpm_idle() -- RPM_GET_PUT(4)
>>>>       __rpm_callback
>>>>           scsi_runtime_idle()
>>>>               pm_runtime_mark_last_busy()
>>>>               pm_runtime_autosuspend()  --[A]
>>>>                   rpm_suspend() -- RPM_AUTO(8)
>>>>                       pm_runtime_autosuspend_expiration() 
>>>> use_autosuspend    is false return 0   --- [B]
>>>>                           __update_runtime_status to RPM_SUSPENDING
>>>>                       __rpm_callback()
>>>>                           __rpm_put_suppliers(dev, false)
>>>>                       __update_runtime_status to RPM_SUSPENDED
>>>>                   rpm_suspend_suppliers()
>>>>                       rpm_idle() for supplier -- RPM_ASYNC(1) return 
>>>> (-EAGAIN) [ Other consumer active for supplier]
>>>>                   rpm_suspend() – END with return=0
>>>>           scsi_runtime_idle() END return (-EBUSY) always.
>>
>> Not following here either.  Which device is EBUSY and why?
> 
> scsi_runtime_idle() return -EBUSY always [3]
> Storage/scsi team can better explain -EBUSY implementation.

EBUSY is returned from below code for consumer dev 0:0:0:0.
scsi_runtime_idle is called from scsi_autopm_put_device which inturn is 
called from ufshcd_async_scan (Process 1 as per above call stack)
static int scsi_runtime_idle(struct device *dev)
{
	:

	if (scsi_is_sdev_device(dev)) {
		pm_runtime_mark_last_busy(dev);
		pm_runtime_autosuspend(dev);
		return -EBUSY; ---> EBUSY returned from here.
	}

	
}

> 
> [3] 
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/scsi/scsi_pm.c?h=next-20221118#n210
> 
> 
>>>>
>>>> [1]: https://lore.kernel.org/lkml/4748074.GXAFRqVoOG@kreacher/T/
>>>> [2]: https://lkml.org/lkml/2022/10/12/259
>>>>
>>>> Thanks,
>>>> Tushar Nimkar
>>
> Thanks,
> Tushar Nimkar

Thanks,
Nitin
