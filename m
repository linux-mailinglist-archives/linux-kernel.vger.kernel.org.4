Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CEF66207F0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 05:02:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233263AbiKHECX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 23:02:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233135AbiKHECL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 23:02:11 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C62030575;
        Mon,  7 Nov 2022 20:02:10 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A80OKi9018161;
        Tue, 8 Nov 2022 04:02:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2022-7-12;
 bh=3A93ZkFwqz8Fqcwx7O59FtJGrnoIW29W2m1yUqXNFuE=;
 b=gp2tAVs6y6o9L2FfUwEnbz4CyyrPnrYYazxTK0yOQVk9CVMjsLl39rzIelCpP/zvWAWt
 gu8mzgAhRgxCEeYjmw58n0Lo6iCo/E8Oiqf0L/8hZ6dcRq4HqizS2/UcYpgk/7q7DGd7
 0BkrNb70qFjfFFNj+v61zL2z5QBYOoWwszG4rYXswO94ZGDCOJpXq0snorTwNeHwWLl6
 jgej4G8PuFAfhJU1uBAjEZCKL5cINmL7KlOc5uNXW5ISgiS+geizOewNgMLIot3mTIIK
 R1b9nOCo6dNSJhgdbnZ6U+Eh35xN2NbKc+KvQPa5sdB0dYI8uE8u8+wWgPbfkucRKten Cw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kngk6e5jx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Nov 2022 04:02:02 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A817XMK025561;
        Tue, 8 Nov 2022 04:02:01 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kpcqfh3tn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Nov 2022 04:02:01 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2A841vcq022774;
        Tue, 8 Nov 2022 04:02:00 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3kpcqfh3s5-7;
        Tue, 08 Nov 2022 04:02:00 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     John Garry <john.garry@huawei.com>, jejb@linux.ibm.com,
        jinpu.wang@cloud.ionos.com
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, damien.lemoal@opensource.wdc.com,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH] scsi: pm8001: Drop !task check in pm8001_abort_task()
Date:   Mon,  7 Nov 2022 23:01:54 -0500
Message-Id: <166787988588.644518.7669734649788670116.b4-ty@oracle.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <1666781764-123090-1-git-send-email-john.garry@huawei.com>
References: <1666781764-123090-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_11,2022-11-07_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=929 adultscore=0 mlxscore=0
 suspectscore=0 spamscore=0 malwarescore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211080020
X-Proofpoint-ORIG-GUID: eki4mUcTFmnzqvs_O_DY0OTMGddqOrHq
X-Proofpoint-GUID: eki4mUcTFmnzqvs_O_DY0OTMGddqOrHq
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Oct 2022 18:56:04 +0800, John Garry wrote:

> In commit 0b639decf651 ("scsi: pm8001: Modify task abort handling for SATA
> task"), code was introduced to dereference "task" pointer in
> pm8001_abort_task(). However there was a pre-existing later check for
> "!task", which spooked the kernel test robot.
> 
> Function pm8001_abort_task() should never be passed NULL for "task"
> pointer, so remove that check. Also remove the "unlikely" hint, as this is
> not fastpath code.
> 
> [...]

Applied to 6.2/scsi-queue, thanks!

[1/1] scsi: pm8001: Drop !task check in pm8001_abort_task()
      https://git.kernel.org/mkp/scsi/c/4481bdc677c1

-- 
Martin K. Petersen	Oracle Linux Engineering
