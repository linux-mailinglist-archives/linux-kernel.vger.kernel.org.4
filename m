Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 047A56319A6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 07:08:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbiKUGIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 01:08:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiKUGIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 01:08:49 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4017F26558;
        Sun, 20 Nov 2022 22:08:49 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AL5cies010378;
        Mon, 21 Nov 2022 06:08:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ulsqLyWqyRYuCvKnm4ocqOn+XybCvjEB/c2PZ+aWPJs=;
 b=lTp9/U80IFN4vyriIm7yRJb386SRXKWy5Cpxi9Vt7GOWlI96gZfDWh1BHJF+mwGPdzf5
 rvWE8jFghmaMQhrgsmZN/18GXtGVVWOK4ETFlghFP/i5YJujrRHKfgqvmQd6Pi2bhmrK
 9dzPTYJ3AZETxNGBoyMrQPNX2JtCvFHvumjMg7uZKQB8eYjd4BKsy2Smh0NBL1E5yZLI
 ecyhL7wV/RwcEfkP0AuypiWdQQirYMglo+gOqXDhRxAWnXh6EYees16vN8xGmJRWVg+Q
 wCMtcNtzEVP2JOYGsrJ5OsMCMNi/xqxWvLuG8sEGR8rV/0DYXPO9jbJrRxZpiFgFBXlF 7g== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kxrf5kjgb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Nov 2022 06:08:34 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2AL68YO9021869
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Nov 2022 06:08:34 GMT
Received: from [10.216.54.201] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Sun, 20 Nov
 2022 22:08:29 -0800
Message-ID: <8ca27fcb-b146-3ea7-a042-55f99e0ae3fb@quicinc.com>
Date:   Mon, 21 Nov 2022 11:38:16 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: PM-runtime: supplier looses track of consumer during probe
To:     Adrian Hunter <adrian.hunter@intel.com>,
        <linux-pm@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        <bjorn.andersson@kernel.org>,
        Nitin Rawat <quic_nitirawa@quicinc.com>,
        <quic_mkshah@quicinc.com>, <quic_lsrao@quicinc.com>,
        <bvanassche@acm.org>, Peter Wang <peter.wang@mediatek.com>
References: <36aed941-a73e-d937-2721-4f0decd61ce0@quicinc.com>
 <8c0a715a-d626-aa70-15f1-79f1e23fbc67@quicinc.com>
 <a5e2aab6-7f0e-7f3b-f34b-6d222450c97d@intel.com>
Content-Language: en-US
From:   Tushar Nimkar <quic_tnimkar@quicinc.com>
In-Reply-To: <a5e2aab6-7f0e-7f3b-f34b-6d222450c97d@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: T3JxXBcevIV0oMVho7xUP78WLJPM3D61
X-Proofpoint-ORIG-GUID: T3JxXBcevIV0oMVho7xUP78WLJPM3D61
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-21_03,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211210048
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

On 11/18/2022 8:25 PM, Adrian Hunter wrote:
> On 4/11/22 11:19, Tushar Nimkar wrote:
>> Hi linux-pm/linux-scsi,

>>> Process -1
>>> ufshcd_async_scan context (process 1)
>>> scsi_autopm_put_device() //0:0:0:0
> 
> I am having trouble following your description.  What function is calling
> scsi_autopm_put_device() here?
> 
Below is flow which calls scsi_autopm_put_device()
Process -1
ufshcd_async_scan()
	scsi_probe_and_add_lun()
		scsi_add_lun()
			slave_configure()
				scsi_sysfs_add_sdev()
					scsi_autopm_get_device()
						device_add()     <- invoked [Process 2] sd_probe()
							scsi_autopm_put_device()

>>> pm_runtime_put_sync()
>>> __pm_runtime_idle()
>>> rpm_idle() -- RPM_GET_PUT(4)
>>>       __rpm_callback
>>>           scsi_runtime_idle()
>>>               pm_runtime_mark_last_busy()
>>>               pm_runtime_autosuspend()  --[A]
>>>                   rpm_suspend() -- RPM_AUTO(8)
>>>                       pm_runtime_autosuspend_expiration() use_autosuspend    is false return 0   --- [B]
>>>                           __update_runtime_status to RPM_SUSPENDING
>>>                       __rpm_callback()
>>>                           __rpm_put_suppliers(dev, false)
>>>                       __update_runtime_status to RPM_SUSPENDED
>>>                   rpm_suspend_suppliers()
>>>                       rpm_idle() for supplier -- RPM_ASYNC(1) return (-EAGAIN) [ Other consumer active for supplier]
>>>                   rpm_suspend() – END with return=0
>>>           scsi_runtime_idle() END return (-EBUSY) always.
> 
> Not following here either.  Which device is EBUSY and why?

scsi_runtime_idle() return -EBUSY always [3]
Storage/scsi team can better explain -EBUSY implementation.

[3] 
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/scsi/scsi_pm.c?h=next-20221118#n210


>>>
>>> [1]: https://lore.kernel.org/lkml/4748074.GXAFRqVoOG@kreacher/T/
>>> [2]: https://lkml.org/lkml/2022/10/12/259
>>>
>>> Thanks,
>>> Tushar Nimkar
> 
Thanks,
Tushar Nimkar
