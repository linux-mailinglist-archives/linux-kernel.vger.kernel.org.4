Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41368619367
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 10:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbiKDJXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 05:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiKDJXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 05:23:10 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E7C275D9;
        Fri,  4 Nov 2022 02:23:09 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A49JntM021774;
        Fri, 4 Nov 2022 09:22:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=XU+pTkO/J5QRdDNXmPAzfbbSQ90JP/22zRHbYnu0jRc=;
 b=SkL/z8m8FGmpZ1FWSc9SMcalmOiZdkz4MdjQBE4MKtxqJGiqUKiIhkTxVhoCE1LrmuBC
 IVDGGrM2w15GzFw562pHkblhnKMBYX9AAXRhWcdC8rQBQc3b3vpW5NN7NvLbd4/qemSa
 GtbMoIOe9jPQzTN9zhOWNgaN7mReInd71dagrzw6OkokPiCSxGEfaQ5Y51ridNTquKgl
 06lP/mJynvRk9sz5IcILqbZkzePWUPA1sLYg87BeB/umOnC90Zv4TAcH7Ki9tnxqWLg7
 nX3okJRriEYhZOOj8dXQDfycjJrMPHew6oLzidnUbm1PT3DmX1elDK6E1B5OapL0ybZW Hw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kmyseg13j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Nov 2022 09:22:48 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2A49Mmlj029511
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 4 Nov 2022 09:22:48 GMT
Received: from [10.216.59.146] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Fri, 4 Nov 2022
 02:22:43 -0700
Message-ID: <8c0a715a-d626-aa70-15f1-79f1e23fbc67@quicinc.com>
Date:   Fri, 4 Nov 2022 14:49:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: PM-runtime: supplier looses track of consumer during probe
From:   Tushar Nimkar <quic_tnimkar@quicinc.com>
To:     <linux-pm@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        <bjorn.andersson@kernel.org>,
        Nitin Rawat <quic_nitirawa@quicinc.com>,
        <quic_mkshah@quicinc.com>, <quic_lsrao@quicinc.com>,
        <bvanassche@acm.org>, <adrian.hunter@intel.com>,
        Peter Wang <peter.wang@mediatek.com>
References: <36aed941-a73e-d937-2721-4f0decd61ce0@quicinc.com>
Content-Language: en-US
In-Reply-To: <36aed941-a73e-d937-2721-4f0decd61ce0@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: EQr5dPOqBfi4y62mddPdvqbe_voJy31h
X-Proofpoint-ORIG-GUID: EQr5dPOqBfi4y62mddPdvqbe_voJy31h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-04_02,2022-11-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 lowpriorityscore=0 clxscore=1011 priorityscore=1501 malwarescore=0
 suspectscore=0 bulkscore=0 impostorscore=0 mlxlogscore=999 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211040060
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi linux-pm/linux-scsi,

Gentle reminder!

Can you please provide your suggestions on below race?

Thanks, Tushar Nimkar

On 10/14/2022 4:20 PM, Tushar Nimkar wrote:
> Hi linux-pm/linux-scsi,
> 
> We have included fix [1] but continuing to observe supplier loosing 
> track of consumer.
> 
> Below is trace snippet with additional logging added.
> Here consumer is 0:0:0:0 and supplier is 0:0:0:49488. In Last three 
> lines consumer resume is completed but supplier is put down.
> 
>     kworker/u16:0-7     0.880014: rpm_idle:             0:0:0:0 flags-4 
> cnt-0  dep-0  auto-1 p-0 irq-0 child-0
>     kworker/u16:0-7     0.880017: bprint: 
> pm_runtime_mark_last_busy.46700: :#205 dev_name:0:0:0:0 
> ktime_get_mono_fast_ns():852365364
>     kworker/u16:0-7     0.880019: rpm_suspend:          0:0:0:0 flags-8 
> cnt-0  dep-0  auto-1 p-0 irq-0 child-0
>     kworker/u16:0-7     0.880022: bprint: pm_runtime_put_noidle.44083: 
> pm_runtime_put_noidle: #112 dev_name:0:0:0:49488 dev usage_count:5 
> decremented usage count
>     kworker/u16:0-7     0.880023: bprint: pm_runtime_put_noidle.44083: 
> pm_runtime_put_noidle: #112 dev_name:0:0:0:49488 dev usage_count:4 
> decremented usage count
>     kworker/u16:2-142   0.880024: rpm_resume:           0:0:0:0 flags-4 
> cnt-1  dep-0  auto-1 p-0 irq-0 child-0
>     kworker/u16:0-7     0.880025: bprint: __rpm_put_suppliers: 
> __rpm_put_suppliers: #348 consumer:0:0:0:0 supplier:0:0:0:49488 
> usage_count:4
>     kworker/u16:0-7     0.880061: rpm_idle:             0:0:0:49488 
> flags-1 cnt-4  dep-0  auto-1 p-0 irq-0 child-0
>     kworker/u16:0-7     0.880062: rpm_return_int: 
> rpm_idle+0x16c:0:0:0:49488 ret=-11
>     kworker/u16:2-142   0.880062: bprint: __pm_runtime_resume: 
> __pm_runtime_resume: #1147 dev_name:0:0:0:49488 dev usage_count:5 
> incremented usage count
>     kworker/u16:2-142   0.880063: rpm_resume:           0:0:0:49488 
> flags-4 cnt-5  dep-0  auto-1 p-0 irq-0 child-0
>     kworker/u16:2-142   0.880063: rpm_return_int: 
> rpm_resume+0x690:0:0:0:49488 ret=1
>     kworker/u16:0-7     0.880063: rpm_return_int: 
> rpm_suspend+0x68:0:0:0:0 ret=0
>     kworker/u16:2-142   0.880063: bprint: rpm_get_suppliers: 
> rpm_get_suppliers: #300 consumer:0:0:0:0 supplier:0:0:0:49488 usage_count:5
>     kworker/u16:0-7     0.880065: bprint: pm_runtime_put_noidle.44083: 
> pm_runtime_put_noidle: #112 dev_name:0:0:0:49488 dev usage_count:4 
> decremented usage count
>     kworker/u16:2-142   0.880065: bprint: 
> pm_runtime_mark_last_busy.44088: :#205 dev_name:0:0:0:0 
> ktime_get_mono_fast_ns():852413749
>     kworker/u16:2-142   0.880065: rpm_idle:             0:0:0:0 flags-1 
> cnt-1  dep-0  auto-1 p-0 irq-0 child-0
>     kworker/u16:2-142   0.880065: rpm_return_int: rpm_idle+0x16c:0:0:0:0 
> ret=-11
>     kworker/u16:0-7     0.880066: bprint: __rpm_put_suppliers: 
> __rpm_put_suppliers: #348 consumer:0:0:0:0 supplier:0:0:0:49488 
> usage_count:4
>     kworker/u16:0-7     0.880067: rpm_return_int: rpm_idle+0x16c:0:0:0:0 
> ret=-16
>     kworker/u16:2-142   0.880067: rpm_return_int: 
> rpm_resume+0x690:0:0:0:0 ret=0
> 
> Upon looking into this further the race looks to be in below two 
> processes running in parallel and process-1 is putting down supplier at 
> [C] because process-2 is setting runtime_status as resuming at [D].
> 
> Also as per runtime PM documentation
> In order to use autosuspend, subsystems or drivers must call
> pm_runtime_use_autosuspend(), and thereafter they should use the various 
> `*_autosuspend()` helper functions...
> 
> It was also observed that *_autosuspend() API at point [A] was invoked 
> without first invoking pm_runtime_use_autosuspend() which return 
> expiration as zero at point [B] and proceeds ahead for immediate runtime 
> suspend of device which seems lead to this race condition.
> 
> Process -1
> ufshcd_async_scan context (process 1)
> scsi_autopm_put_device() //0:0:0:0
> pm_runtime_put_sync()
> __pm_runtime_idle()
> rpm_idle() -- RPM_GET_PUT(4)
>      __rpm_callback
>          scsi_runtime_idle()
>              pm_runtime_mark_last_busy()
>              pm_runtime_autosuspend()  --[A]
>                  rpm_suspend() -- RPM_AUTO(8)
>                      pm_runtime_autosuspend_expiration() 
> use_autosuspend    is false return 0   --- [B]
>                          __update_runtime_status to RPM_SUSPENDING
>                      __rpm_callback()
>                          __rpm_put_suppliers(dev, false)
>                      __update_runtime_status to RPM_SUSPENDED
>                  rpm_suspend_suppliers()
>                      rpm_idle() for supplier -- RPM_ASYNC(1) return 
> (-EAGAIN) [ Other consumer active for supplier]
>                  rpm_suspend() – END with return=0
>          scsi_runtime_idle() END return (-EBUSY) always.
>       /* Do that if resume fails too.*/
>      (dev->power.runtime_status == RPM_RESUMING && retval)))  return -EBUSY
>          __rpm_put_suppliers(dev, false)  -- [C]
> rpm_idle() END return -EBUSY
> 
> Process -2
> sd_probe context (Process 2)
> scsi_autopm_get_device() //0:0:0:0
> __pm_runtime_resume(RPM_GET_PUT)
> rpm_resume() -- RPM_GET_PUT(4)
>      __update_runtime_status to RPM_RESUMING --[D]
>      __rpm_callback()
>          rpm_get_suppliers()
>              __pm_runtime_resume() - RPM_GET_PUT(4) – supplier
>                  rpm_resume() for supplier.
>      __update_runtime_status to RPM_ACTIVE
>      pm_runtime_mark_last_busy ()
> rpm_resume() END return 0
> 
> Can you please provide your suggestions on addressing above race condition?
> 
> This is also reported at [2].
> 
> [1]: https://lore.kernel.org/lkml/4748074.GXAFRqVoOG@kreacher/T/
> [2]: https://lkml.org/lkml/2022/10/12/259
> 
> Thanks,
> Tushar Nimkar
