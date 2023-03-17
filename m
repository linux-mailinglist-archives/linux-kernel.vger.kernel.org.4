Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D22B6BDFF4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 05:05:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbjCQEFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 00:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbjCQEFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 00:05:37 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77FBD5B422;
        Thu, 16 Mar 2023 21:05:28 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32GKYgGG001890;
        Fri, 17 Mar 2023 04:05:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2022-7-12;
 bh=yXZcUnMhEq8LEicVeP8vaA50kn5wUHqJeTQcB7899sk=;
 b=wnd7NUP+cTkU99gEAFQVaVrFaRrcf40M/LJv1o5MLobOFBmRrrBMOQkkPq58XPY6sx1w
 RqN/PvlrsGuK+nrzr+84uw+4Sj37QldGSmcqSPE5m+xeMPVLccGabOdMKdMzY2XQyeHI
 7q2N91oZGVkf30y7TU/E1edYG2KjcoFCq6djoHvRdaSaau57ApeYjJDOdiGHlyQA7ycE
 wnKt8b/exqNdE+lV2p3UTvA9DTk9GUg7O5tovr1jOVwYHPltn7gHUpCy3jNVukOP2ZAg
 Im1Hx47pOsEoQsoS7/uZUt9RCgXVcrvNxZoSjI4crkhS1XsZ3rzHsiGGBH50yNQF2or/ 2Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pbs2ajyap-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Mar 2023 04:05:08 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32H107wF036959;
        Fri, 17 Mar 2023 04:05:07 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pbq9jfkpv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Mar 2023 04:05:07 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32H454xv027487;
        Fri, 17 Mar 2023 04:05:06 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3pbq9jfkkv-3;
        Fri, 17 Mar 2023 04:05:06 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     jejb@linux.ibm.com, bvanassche@acm.org, hare@suse.de,
        axboe@kernel.dk, sconnor@purestorage.com,
        michael.christie@oracle.com, brian@purestorage.com,
        yukuai3@huawei.com, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH -next] scsi: scsi_dh_alua: fix memleak for 'qdata' in alua_activate()
Date:   Fri, 17 Mar 2023 00:04:54 -0400
Message-Id: <167902587505.2716429.5798737270736243802.b4-ty@oracle.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230315062154.668812-1-yukuai1@huaweicloud.com>
References: <20230315062154.668812-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-17_01,2023-03-16_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303170023
X-Proofpoint-GUID: TeQqOO_HGlE5X1G0S0k5zQqu_hM_J770
X-Proofpoint-ORIG-GUID: TeQqOO_HGlE5X1G0S0k5zQqu_hM_J770
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Mar 2023 14:21:54 +0800, Yu Kuai wrote:

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
> [...]

Applied to 6.3/scsi-fixes, thanks!

[1/1] scsi: scsi_dh_alua: fix memleak for 'qdata' in alua_activate()
      https://git.kernel.org/mkp/scsi/c/a13faca032ac

-- 
Martin K. Petersen	Oracle Linux Engineering
