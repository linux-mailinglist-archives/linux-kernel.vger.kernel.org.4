Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FBEF63E8A2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 04:48:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbiLADsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 22:48:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbiLADrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 22:47:16 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED9ECA06FE;
        Wed, 30 Nov 2022 19:46:17 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B13PNEo016224;
        Thu, 1 Dec 2022 03:46:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2022-7-12;
 bh=+pKlHWzU5qw6pXLNGammRk03uF7z0IbWQ3e3nGvXPQo=;
 b=LqPWq/Yu8477EJ4gkmqYNzHQCUBjvz4hQACs7GCbJIV8hFhWzewtIdwwn/8yuWNZSq9H
 +4Hmb/9j2c3QAGMMCPUynGjhYAFM8CDgANpEkdGv8UMZYSH2w7n3QLYqlwraGi/imfnq
 Kn8nMRt0qaF2iE6/pqHzuID4+nJImCeZT+bvJbG+Ulv6Rqbaf/2X/mTwmCE5ZG1TKQNK
 XFR8SM2B4dSJtvnFGBS0qZvIav6GU/zMjcgdiCsZrN4JEXqnIL8mwg1bPplNzOAP3zvb
 K4FwAv5NoTyZ0h35qgsZIOmJsrKmIydPyGglWyx1MluDjE25WvogwhAJa5/GGIP/yVNs yA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m4aemjjpc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Dec 2022 03:46:09 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2B12dBBc007549;
        Thu, 1 Dec 2022 03:46:08 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3m398a2d3x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Dec 2022 03:46:08 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2B13jbqM033801;
        Thu, 1 Dec 2022 03:46:07 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3m398a2cjs-31;
        Thu, 01 Dec 2022 03:46:07 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     jejb@linux.ibm.com, Jie Zhan <zhanjie9@hisilicon.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, prime.zeng@hisilicon.com,
        john.g.garry@oracle.com, yangxingui@huawei.com,
        yanaijie@huawei.com, liyihang9@huawei.com,
        johannes.thumshirn@wdc.com, chenxiang66@hisilicon.com,
        damien.lemoal@opensource.wdc.com, linux-scsi@vger.kernel.org,
        linuxarm@huawei.com, duoming@zju.edu.cn
Subject: Re: [PATCH for-next 0/5] scsi: hisi_sas/libsas: Fix SATA devices missing issue during hisi_sas_debug_I_T_nexus_reset()
Date:   Thu,  1 Dec 2022 03:45:32 +0000
Message-Id: <166986602294.2101055.10313720728378984027.b4-ty@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221118083714.4034612-1-zhanjie9@hisilicon.com>
References: <20221118083714.4034612-1-zhanjie9@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-01_02,2022-11-30_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 mlxscore=0 bulkscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212010022
X-Proofpoint-ORIG-GUID: u8G2w2B9H03QSuoaYSQ_-4dc5rQV034t
X-Proofpoint-GUID: u8G2w2B9H03QSuoaYSQ_-4dc5rQV034t
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Nov 2022 16:37:09 +0800, Jie Zhan wrote:

> SATA devices on an expander may be removed and not be found again
> when I_T nexus reset and revalidation are processed simultaneously,
> which is probable to happen in hisi_sas_clear_nexus_ha().
> 
> The issue came up since commit 71453bd9d1bf ("scsi: hisi_sas: Use
> sas_ata_wait_after_reset() in IT nexus reset"), where the ex_phy's
> change count is updated in hisi_sas_debug_I_T_nexus_reset(), stopping
> future revalidation from discovering the SATA devices after link
> reset.
> 
> [...]

Applied to 6.2/scsi-queue, thanks!

[1/5] Revert "scsi: hisi_sas: Drain bcast events in hisi_sas_rescan_topology()"
      https://git.kernel.org/mkp/scsi/c/7e613be7c63d
[2/5] Revert "scsi: hisi_sas: Don't send bcast events from HW during nexus HA reset"
      https://git.kernel.org/mkp/scsi/c/94a3555d1f0f
[3/5] scsi: libsas: Add smp_ata_check_ready_type()
      https://git.kernel.org/mkp/scsi/c/9181ce3cb5d9
[4/5] scsi: hisi_sas: Fix SATA devices missing issue during I_T nexus reset
      https://git.kernel.org/mkp/scsi/c/3c2673a09cf1
[5/5] scsi: libsas: Do not export sas_ata_wait_after_reset()
      https://git.kernel.org/mkp/scsi/c/4d450cf2b00d

-- 
Martin K. Petersen	Oracle Linux Engineering
