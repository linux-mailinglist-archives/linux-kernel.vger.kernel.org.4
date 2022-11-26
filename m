Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27D6F6393B4
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 04:28:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbiKZD1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 22:27:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbiKZD1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 22:27:49 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36EBBF02D;
        Fri, 25 Nov 2022 19:27:49 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AQ3474S019611;
        Sat, 26 Nov 2022 03:27:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2022-7-12;
 bh=IQhSGq4l7vlRW3zGYByTqwuiGQvDPswvyy93zRnx0FM=;
 b=qNCRdtXOpO7HQRceGEao3WTSLCRcBfiaOHRE8AnDicpcHyxkkSF6arFZY9swMRCZ9CVM
 S2sqP6z3NybidmXxVd05mqJRDYT7WyQHOgyxMlh5JyR9QeY4dSe4Wh1Ykrwq0t37aMEe
 YbujKEJyStmQ9e9Pxz7shenRbGpnc2eRILY3zCOjY+ImsD/ZWts4vqqPuUh99e7Nurlk
 BWd1GiXbTSo/apw2PAdk/wrrJaZZAvdYDqK0XRj97D1zl/ZQrSqv36aVjCX96XY9UP5i
 Rq6EbWa5nYvxmUYZSksqxiAoQmyUr/TNovYSH2/04udzTzraM3y8wP5LGZDALkT/pYyU ww== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m397f8251-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 26 Nov 2022 03:27:45 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AQ1XkPp007555;
        Sat, 26 Nov 2022 03:27:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3m3988b80e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 26 Nov 2022 03:27:45 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AQ3RhsU028327;
        Sat, 26 Nov 2022 03:27:44 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3m3988b7y9-5;
        Sat, 26 Nov 2022 03:27:44 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Douglas Gilbert <dgilbert@interlog.com>, error27@gmail.com,
        harshit.m.mogalapalli@gmail.com, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: Re: [PATCH] scsi: scsi_debug: Fix a warning in resp_write_scat()
Date:   Sat, 26 Nov 2022 03:27:36 +0000
Message-Id: <166943312543.1684293.3175127415315924733.b4-ty@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221111100526.1790533-1-harshit.m.mogalapalli@oracle.com>
References: <20221111100526.1790533-1-harshit.m.mogalapalli@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-26_02,2022-11-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211260024
X-Proofpoint-ORIG-GUID: JIkisbPNZAGG3gtTv2M6-fugZiidUExo
X-Proofpoint-GUID: JIkisbPNZAGG3gtTv2M6-fugZiidUExo
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Nov 2022 02:05:25 -0800, Harshit Mogalapalli wrote:

> As 'lbdof_blen' is coming from user, if the size in kzalloc()
> is >= MAX_ORDER then we hit a warning.
> 
> Call trace:
> 
> sg_ioctl
>  sg_ioctl_common
>    scsi_ioctl
>     sg_scsi_ioctl
>      blk_execute_rq
>       blk_mq_sched_insert_request
>        blk_mq_run_hw_queue
>         __blk_mq_delay_run_hw_queue
>          __blk_mq_run_hw_queue
>           blk_mq_sched_dispatch_requests
>            __blk_mq_sched_dispatch_requests
>             blk_mq_dispatch_rq_list
>              scsi_queue_rq
>               scsi_dispatch_cmd
>                scsi_debug_queuecommand
>                 schedule_resp
>                  resp_write_scat
> 
> [...]

Applied to 6.2/scsi-queue, thanks!

[1/1] scsi: scsi_debug: Fix a warning in resp_write_scat()
      https://git.kernel.org/mkp/scsi/c/216e179724c1

-- 
Martin K. Petersen	Oracle Linux Engineering
