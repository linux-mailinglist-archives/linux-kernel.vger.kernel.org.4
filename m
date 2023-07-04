Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41D6C74776B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 19:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbjGDREn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 13:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGDREk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 13:04:40 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 147D3E70;
        Tue,  4 Jul 2023 10:04:39 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 364Gl5Wm016425;
        Tue, 4 Jul 2023 17:04:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=LAlYaU1Q80ckErnqLXQ6rXuB4lkhkkZZB4Q6wB1nmA0=;
 b=WpbjaNDsExapW14t2Jk75Bf1DRTscbcANCgfxvkVlvOpdZ2pFdPIyZsz+ZWSOphRg8//
 HY2AExnmVBHujhg+on2oOkvlQv2LgBpNjr6w0LPg8i3jLdgb5lsRe7tAUAOkex1p/5Xn
 5besF6rws2SUMBQatDSglsbWdEPofWEcdZv4puqUS96R1UBE4AaJEeSJXcAo8aoatWb3
 NxbBkOie0cuEHw68qoqw/IK9gtnOVLWkDSbi6AnMAVkaxRZg1tXBI752QIDR+o6LYovx
 MlYSrIVvlCU7wTSMCC3w6p63RDZ1zVwF9pvzHqvkXMHp4DHd3VJmBUGFNIp8bkdFVkD1 3A== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rmq8f899e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Jul 2023 17:04:07 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 364Een7I007893;
        Tue, 4 Jul 2023 17:04:04 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma01fra.de.ibm.com (PPS) with ESMTPS id 3rjbs4sjym-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Jul 2023 17:04:04 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 364H41pw43516636
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 4 Jul 2023 17:04:01 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3BD332004B;
        Tue,  4 Jul 2023 17:04:01 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D679920040;
        Tue,  4 Jul 2023 17:04:00 +0000 (GMT)
Received: from li-1de7cd4c-3205-11b2-a85c-d27f97db1fe1.ibm.com (unknown [9.152.224.43])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Tue,  4 Jul 2023 17:04:00 +0000 (GMT)
From:   "Marc Hartmayer" <mhartmay@linux.ibm.com>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com, hch@lst.de,
        chaitanyak@nvidia.com, shinichiro.kawasaki@wdc.com,
        dgilbert@interlog.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, yukuai3@huawei.com, axboe@kernel.dk,
        Benjamin Block <bblock@linux.ibm.com>
Subject: Re: [PATCH] scsi/sg: don't grab scsi host module reference
In-Reply-To: <20230621160111.1433521-1-yukuai1@huaweicloud.com>
References: <20230621160111.1433521-1-yukuai1@huaweicloud.com>
Date:   Tue, 04 Jul 2023 19:04:00 +0200
Message-ID: <87lefv622n.fsf@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: f81Wfivd_zqsQfeZGdA8NFO79_ulW331
X-Proofpoint-ORIG-GUID: f81Wfivd_zqsQfeZGdA8NFO79_ulW331
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-04_11,2023-07-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 bulkscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 mlxlogscore=999 impostorscore=0 clxscore=1011 mlxscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307040147
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2023 at 12:01 AM +0800, Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
> From: Yu Kuai <yukuai3@huawei.com>
>
> In order to prevent request_queue to be freed before cleaning up
> blktrace debugfs entries, commit db59133e9279 ("scsi: sg: fix blktrace
> debugfs entries leakage") use scsi_device_get(), however,
> scsi_device_get() will also grab scsi module reference and scsi module
> can't be removed.
>
> It's reported that blktests can't unload scsi_debug after block/001:
>
> blktests (master) # ./check block
> block/001 (stress device hotplugging) [failed]
>      +++ /root/blktests/results/nodev/block/001.out.bad 2023-06-19
>       Running block/001
>       Stressing sd
>      +modprobe: FATAL: Module scsi_debug is in use.
>
> Fix this problem by grabbing request_queue reference directly, so that
> scsi host module can still be unloaded while request_queue will be
> pinged by sg device.
>
> Reported-by: Chaitanya Kulkarni <chaitanyak@nvidia.com>
> Link: https://lore.kernel.org/all/1760da91-876d-fc9c-ab51-999a6f66ad50@nv=
idia.com/
> Fixes: db59133e9279 ("scsi: sg: fix blktrace debugfs entries leakage")
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  drivers/scsi/sg.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
> index 2433eeef042a..dcb73787c29d 100644
> --- a/drivers/scsi/sg.c
> +++ b/drivers/scsi/sg.c
> @@ -1497,7 +1497,7 @@ sg_add_device(struct device *cl_dev)
>  	int error;
>  	unsigned long iflags;
>=20=20
> -	error =3D scsi_device_get(scsidp);
> +	error =3D blk_get_queue(scsidp->request_queue);
>  	if (error)
>  		return error;
>=20=20
> @@ -1558,7 +1558,7 @@ sg_add_device(struct device *cl_dev)
>  out:
>  	if (cdev)
>  		cdev_del(cdev);
> -	scsi_device_put(scsidp);
> +	blk_put_queue(scsidp->request_queue);
>  	return error;
>  }
>=20=20
> @@ -1575,7 +1575,7 @@ sg_device_destroy(struct kref *kref)
>  	 */
>=20=20
>  	blk_trace_remove(q);
> -	scsi_device_put(sdp->device);
> +	blk_put_queue(q);
>=20=20
>  	write_lock_irqsave(&sg_index_lock, flags);
>  	idr_remove(&sg_index_idr, sdp->index);
> --=20
> 2.39.2

Hi,

This change (bisected) triggers a regression in our KVM on s390x CI. The
symptom is that a =E2=80=9Cscsi_debug device=E2=80=9D does not bind to the =
scsi_generic
driver. On s390x you can reproduce the problem as follows (I have not
tested on x86):

With this patch applied:

$ sudo modprobe scsi_debug
$ # Get the 'scsi_host,channel,target_number,LUN' tuple for the scsi_debug =
device
$ lsscsi |grep scsi_debug |awk '{ print $1 }'
[0:0:0:0]
$ sudo stat /sys/bus/scsi/devices/0:0:0:0/scsi_generic
stat: cannot statx '/sys/bus/scsi/devices/0:0:0:0/scsi_generic': No such fi=
le or directory


Patch reverted:

$ sudo modprobe scsi_debug
$ lsscsi |grep scsi_debug |awk '{ print $1 }'
[0:0:0:0]
$ sudo stat /sys/bus/scsi/devices/0:0:0:0/scsi_generic
  File: /sys/bus/scsi/devices/0:0:0:0/scsi_generic
  Size: 0         	Blocks: 0          IO Block: 4096   directory
Device: 0,20	Inode: 12155       Links: 3
=E2=80=A6

Any ideas?

 Marc
