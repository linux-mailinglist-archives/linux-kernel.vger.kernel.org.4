Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3126BB6CB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 15:58:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232444AbjCOO6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 10:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233212AbjCOO5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 10:57:41 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D15466E82;
        Wed, 15 Mar 2023 07:57:16 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32FDaVL0030730;
        Wed, 15 Mar 2023 14:55:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to : sender :
 content-transfer-encoding : mime-version; s=pp1;
 bh=uoz5zI1JEmZrgbYJhxEqPsCfCisyx6nw3mZeEmzgV+k=;
 b=tSVFLgOAREHIBWvXB1UXeVJnlITq9SElOnsHZCYFLN+Uhp+02x7fzEnkTVcUNn5cg+/y
 w2k7vS3Ah5fdwAJOEAtVQKoOjpuBjAxIMo5op6FsRE5N7aHjN+zNilZpE15YjwQfDTA1
 2zfI9OGsuoFM/RrYrT2gD0VmwS3l0ZeLSiVZ3GkNJoy52YxWXbYVSugnFLaNUX+IooRv
 lqf6dt+JT2i0FYAEycD+3vdpC2y5oZOTTN7MIHaHWhNgRyEZMoNovpy9CPO3S4noqnuL
 qrOlVNA0i5WpKuUvq+GIJpyD3c7MAXYcuS6rAAoEGvfoomTD54RjpPsaH9lj+fJiLjx7 HQ== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pbdb7npu8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Mar 2023 14:55:49 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32EN6XMn003172;
        Wed, 15 Mar 2023 14:55:47 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma01fra.de.ibm.com (PPS) with ESMTPS id 3pb29t0rkf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Mar 2023 14:55:47 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32FEthMp9044526
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Mar 2023 14:55:43 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A552C20043;
        Wed, 15 Mar 2023 14:55:43 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8C5EE20040;
        Wed, 15 Mar 2023 14:55:43 +0000 (GMT)
Received: from t480-pf1aa2c2 (unknown [9.179.0.219])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Wed, 15 Mar 2023 14:55:43 +0000 (GMT)
Received: from bblock by t480-pf1aa2c2 with local (Exim 4.96)
        (envelope-from <bblock@linux.ibm.com>)
        id 1pcSXW-006wBf-35;
        Wed, 15 Mar 2023 15:55:42 +0100
Date:   Wed, 15 Mar 2023 14:55:42 +0000
From:   Benjamin Block <bblock@linux.ibm.com>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com, bvanassche@acm.org,
        hare@suse.de, axboe@kernel.dk, sconnor@purestorage.com,
        michael.christie@oracle.com, brian@purestorage.com,
        yukuai3@huawei.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: Re: [PATCH -next] scsi: scsi_dh_alua: fix memleak for 'qdata' in
 alua_activate()
Message-ID: <20230315145542.GI620522@t480-pf1aa2c2.fritz.box>
References: <20230315062154.668812-1-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20230315062154.668812-1-yukuai1@huaweicloud.com>
Sender: Benjamin Block <bblock@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 2YON9TtXUgsw-k-5S5ieW7MeP-yr8F2u
X-Proofpoint-ORIG-GUID: 2YON9TtXUgsw-k-5S5ieW7MeP-yr8F2u
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-15_08,2023-03-15_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 bulkscore=0 priorityscore=1501 mlxscore=0 adultscore=0
 malwarescore=0 impostorscore=0 clxscore=1011 spamscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2302240000 definitions=main-2303150118
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2023 at 02:21:54PM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> If alua_rtpg_queue() failed from alua_activate(), then 'qdata' is not
> freed, which will cause following memleak:
> 
> unreferenced object 0xffff88810b2c6980 (size 32):
>   comm "kworker/u16:2", pid 635322, jiffies 4355801099 (age 1216426.076s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     40 39 24 c1 ff ff ff ff 00 f8 ea 0a 81 88 ff ff  @9$.............
>   backtrace:
>     [<0000000098f3a26d>] alua_activate+0xb0/0x320
>     [<000000003b529641>] scsi_dh_activate+0xb2/0x140
>     [<000000007b296db3>] activate_path_work+0xc6/0xe0 [dm_multipath]
>     [<000000007adc9ace>] process_one_work+0x3c5/0x730
>     [<00000000c457a985>] worker_thread+0x93/0x650
>     [<00000000cb80e628>] kthread+0x1ba/0x210
>     [<00000000a1e61077>] ret_from_fork+0x22/0x30
> 
> Fix the problem by freeing 'qdata' in error path.
> 
> Fixes: 625fe857e4fa ("scsi: scsi_dh_alua: Check scsi_device_get() return value")
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  drivers/scsi/device_handler/scsi_dh_alua.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 

Looks good to me.


Reviewed-by: Benjamin Block <bblock@linux.ibm.com>

-- 
Best Regards, Benjamin Block        /        Linux on IBM Z Kernel Development
IBM Deutschland Research & Development GmbH    /   https://www.ibm.com/privacy
Vors. Aufs.-R.: Gregor Pillen         /         Geschäftsführung: David Faller
Sitz der Ges.: Böblingen     /    Registergericht: AmtsG Stuttgart, HRB 243294
