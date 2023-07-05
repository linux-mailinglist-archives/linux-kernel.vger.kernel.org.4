Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F670747CD9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 08:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbjGEGN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 02:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjGEGN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 02:13:57 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA0710CF;
        Tue,  4 Jul 2023 23:13:55 -0700 (PDT)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36561ba6011763;
        Wed, 5 Jul 2023 06:13:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=uGaygfh4UDGiV6sWAuowx322s0S6b3ZZ5C+JPVkc6Pg=;
 b=RLAV2ZapsLffSj6pVHlVnhBFAQcB38rMwDXcw/nuMbI74BOrRcbmg0gOOnh/yONR3swg
 2ZPxr78uKnCvlV54AG9ep59rsQfvNRxknz2wo48DwMFcGqd+jq4iQ38dXv9zb/Bkxjfq
 C2rBYy9wIn3phELitajf18MctUMeTbmAEDC/+5Ldiw+/Z81+ANJWvog27mAX7JgArFrr
 89FZUEkbn+WNTk88jlbjUzIJwakiWG/VvN0mar0pskxpUZOl4VA7kLa3LIYGUi98Dmhy
 WEuSwxbMFrUesY+Jj+1DPULlkfEQelgAkUn7aQrRh7z27DPMELnCg8WuWVcmedMuQWpy xw== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rn2p70he5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Jul 2023 06:13:17 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3654a7OF011978;
        Wed, 5 Jul 2023 06:13:15 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma06fra.de.ibm.com (PPS) with ESMTPS id 3rjbddss0k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Jul 2023 06:13:15 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3656DBSv19727098
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 5 Jul 2023 06:13:11 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7C3FD20043;
        Wed,  5 Jul 2023 06:13:11 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9D87320040;
        Wed,  5 Jul 2023 06:13:10 +0000 (GMT)
Received: from li-1de7cd4c-3205-11b2-a85c-d27f97db1fe1.ibm.com (unknown [9.171.32.210])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Wed,  5 Jul 2023 06:13:10 +0000 (GMT)
From:   "Marc Hartmayer" <mhartmay@linux.ibm.com>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com, hch@lst.de,
        chaitanyak@nvidia.com, shinichiro.kawasaki@wdc.com,
        dgilbert@interlog.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, axboe@kernel.dk,
        Benjamin Block <bblock@linux.ibm.com>,
        "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH] scsi/sg: don't grab scsi host module reference
In-Reply-To: <1efb3d4d-a05b-2eb2-a140-a76981b662a4@huaweicloud.com>
References: <20230621160111.1433521-1-yukuai1@huaweicloud.com>
 <87lefv622n.fsf@linux.ibm.com>
 <70432d91-3909-ac3c-9c36-5f7484c1fdf1@huaweicloud.com>
 <1efb3d4d-a05b-2eb2-a140-a76981b662a4@huaweicloud.com>
Date:   Wed, 05 Jul 2023 08:13:08 +0200
Message-ID: <87bkgqkhsb.fsf@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: f3ZACEFGKvm59Dg0QmrRKs0yYLdkQK4S
X-Proofpoint-ORIG-GUID: f3ZACEFGKvm59Dg0QmrRKs0yYLdkQK4S
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-04_16,2023-07-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 adultscore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=999 priorityscore=1501
 clxscore=1015 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307050054
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 05, 2023 at 10:28 AM +0800, Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
> Hi,
>
> =E5=9C=A8 2023/07/05 9:43, Yu Kuai =E5=86=99=E9=81=93:
>> Hi,
>>=20
>> =E5=9C=A8 2023/07/05 1:04, Marc Hartmayer =E5=86=99=E9=81=93:
>>> On Thu, Jun 22, 2023 at 12:01 AM +0800, Yu Kuai=20
>>> <yukuai1@huaweicloud.com> wrote:
>>>> From: Yu Kuai <yukuai3@huawei.com>
>>>>
>>>> In order to prevent request_queue to be freed before cleaning up
>>>> blktrace debugfs entries, commit db59133e9279 ("scsi: sg: fix blktrace
>>>> debugfs entries leakage") use scsi_device_get(), however,
>>>> scsi_device_get() will also grab scsi module reference and scsi module
>>>> can't be removed.
>>>>
>>>> It's reported that blktests can't unload scsi_debug after block/001:
>>>>
>>>> blktests (master) # ./check block
>>>> block/001 (stress device hotplugging) [failed]
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +++ /root/blktests/results/nodev/block/=
001.out.bad 2023-06-19
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Running block/001
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Stressing sd
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +modprobe: FATAL: Module scsi_debug is =
in use.
>>>>
>>>> Fix this problem by grabbing request_queue reference directly, so that
>>>> scsi host module can still be unloaded while request_queue will be
>>>> pinged by sg device.
>>>>
>>>> Reported-by: Chaitanya Kulkarni <chaitanyak@nvidia.com>
>>>> Link:=20
>>>> https://lore.kernel.org/all/1760da91-876d-fc9c-ab51-999a6f66ad50@nvidi=
a.com/=20
>>>>
>>>> Fixes: db59133e9279 ("scsi: sg: fix blktrace debugfs entries leakage")
>>>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>>>> ---
>>>> =C2=A0 drivers/scsi/sg.c | 6 +++---
>>>> =C2=A0 1 file changed, 3 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
>>>> index 2433eeef042a..dcb73787c29d 100644
>>>> --- a/drivers/scsi/sg.c
>>>> +++ b/drivers/scsi/sg.c
>>>> @@ -1497,7 +1497,7 @@ sg_add_device(struct device *cl_dev)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int error;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long iflags;
>>>> -=C2=A0=C2=A0=C2=A0 error =3D scsi_device_get(scsidp);
>>>> +=C2=A0=C2=A0=C2=A0 error =3D blk_get_queue(scsidp->request_queue);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (error)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return error;
>>>> @@ -1558,7 +1558,7 @@ sg_add_device(struct device *cl_dev)
>>>> =C2=A0 out:
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (cdev)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cdev_del(cdev);
>>>> -=C2=A0=C2=A0=C2=A0 scsi_device_put(scsidp);
>>>> +=C2=A0=C2=A0=C2=A0 blk_put_queue(scsidp->request_queue);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return error;
>>>> =C2=A0 }
>>>> @@ -1575,7 +1575,7 @@ sg_device_destroy(struct kref *kref)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 blk_trace_remove(q);
>>>> -=C2=A0=C2=A0=C2=A0 scsi_device_put(sdp->device);
>>>> +=C2=A0=C2=A0=C2=A0 blk_put_queue(q);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 write_lock_irqsave(&sg_index_lock, flag=
s);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 idr_remove(&sg_index_idr, sdp->index);
>>>> --=20
>>>> 2.39.2
>>>
>>> Hi,
>>>
>>> This change (bisected) triggers a regression in our KVM on s390x CI. The
>>> symptom is that a =E2=80=9Cscsi_debug device=E2=80=9D does not bind to =
the scsi_generic
>>> driver. On s390x you can reproduce the problem as follows (I have not
>>> tested on x86):
>>>
>>> With this patch applied:
>>>
>>> $ sudo modprobe scsi_debug
>>> $ # Get the 'scsi_host,channel,target_number,LUN' tuple for the=20
>>> scsi_debug device
>>> $ lsscsi |grep scsi_debug |awk '{ print $1 }'
>>> [0:0:0:0]
>>> $ sudo stat /sys/bus/scsi/devices/0:0:0:0/scsi_generic
>>> stat: cannot statx '/sys/bus/scsi/devices/0:0:0:0/scsi_generic': No=20
>>> such file or directory
>>>
>>>
>>> Patch reverted:
>>>
>>=20
>> I didn't figure out the root cause, howver, have you tried to reviert
>> this patch as well?
>>=20
>> db59133e9279 ("scsi: sg: fix blktrace debugfs entries leakage"
>
> Never mind this, root cause is that the checking of return value of
> blk_get_queue() is wrong.
>
> This shoud be fixed by following patch:
>
> diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
> index 89fa046c7158..0d8afffd1683 100644
> --- a/drivers/scsi/sg.c
> +++ b/drivers/scsi/sg.c
> @@ -1497,9 +1497,10 @@ sg_add_device(struct device *cl_dev)
>          int error;
>          unsigned long iflags;
>
> -       error =3D blk_get_queue(scsidp->request_queue);
> -       if (error)
> -               return error;
> +       if (!blk_get_queue(scsidp->request_queue)) {
> +               pr_warn("%s: get scsi_device queue failed\n", __func__);
> +               return -ENODEV;
> +       }

Hi Kuai,

I just tried your fix and it works - thanks.

Tested-by: Marc Hartmayer <mhartmay@linux.ibm.com>

 Marc

[=E2=80=A6snip]
