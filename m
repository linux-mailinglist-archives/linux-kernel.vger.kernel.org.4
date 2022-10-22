Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20E136083FB
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 05:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbiJVDwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 23:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbiJVDwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 23:52:43 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC992A17DC;
        Fri, 21 Oct 2022 20:52:42 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29M3Bt7C029569;
        Sat, 22 Oct 2022 03:52:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2022-7-12;
 bh=txILRUl1gGHRsQYIne4v8MiDYagqsUt1reAFjSgIEJU=;
 b=QsheaxyhTMJzb0eDLZdHE0VADjodErzIO+KNlH1SUtVoIgecom+1Yv4K71/rzL3LS0kU
 iFjZbeRHRDhWO0cX1jqaMvejY1mperIyoZ5QaHiczdWXIm1nC/9wp96RbJhKpcRutPuT
 OLyRS7KFz6A1wKwhxyoeGU3WVjmVbCUJ2pjgeaLpKipYTvelLtSw/N8OJ6ax9F1hCJRC
 dB23FnQx1+FRjEOYyQObb4xN05h9AErmnWNt+IUNTWXixBd0IC5BBNn+kNR8UGAM5od8
 x+u7x8htZ49ovhi+6+eCGXVSgfTHEqnfos8/1R8r6F44oov7mekeQKAXjQTvvoXGkfX0 fA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kc8db80pv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 22 Oct 2022 03:52:28 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29M1XXv9015255;
        Sat, 22 Oct 2022 03:52:27 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kc6y8hk7v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 22 Oct 2022 03:52:27 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29M3qOMK004796;
        Sat, 22 Oct 2022 03:52:26 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3kc6y8hk7g-4;
        Sat, 22 Oct 2022 03:52:26 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     jejb@linux.ibm.com, jinpu.wang@cloud.ionos.com,
        John Garry <john.garry@huawei.com>,
        damien.lemoal@opensource.wdc.com
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        linux-scsi@vger.kernel.org, niklas.cassel@wdc.com,
        yangxingui@huawei.com
Subject: Re: [PATCH v6 0/8] libsas and drivers: NCQ error handling
Date:   Fri, 21 Oct 2022 23:52:19 -0400
Message-Id: <166641056340.3488251.247554797121338933.b4-ty@oracle.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <1665998435-199946-1-git-send-email-john.garry@huawei.com>
References: <1665998435-199946-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-21_04,2022-10-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=904 phishscore=0
 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210220021
X-Proofpoint-ORIG-GUID: MR--JWScZRsNyX6_n1Y39ZYQ9bnZPadC
X-Proofpoint-GUID: MR--JWScZRsNyX6_n1Y39ZYQ9bnZPadC
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Oct 2022 17:20:27 +0800, John Garry wrote:

> As reported in [0], the pm8001 driver NCQ error handling more or less
> duplicates what libata does in link error handling, as follows:
> - abort all commands
> - do autopsy with read log ext 10 command
> - reset the target to recover, if necessary
> 
> Indeed for the hisi_sas driver we want to add similar handling for NCQ
> errors.
> 
> [...]

Applied to 6.2/scsi-queue, thanks!

[1/8] scsi: libsas: Add sas_ata_device_link_abort()
      https://git.kernel.org/mkp/scsi/c/44112922674b
[2/8] scsi: hisi_sas: Move slot variable definition in hisi_sas_abort_task()
      https://git.kernel.org/mkp/scsi/c/4b329abc9180
[3/8] scsi: hisi_sas: Add SATA_DISK_ERR bit handling for v3 hw
      https://git.kernel.org/mkp/scsi/c/930d97dabdd5
[4/8] scsi: hisi_sas: Modify v3 HW SATA disk error state completion processing
      https://git.kernel.org/mkp/scsi/c/4ef4f1a61555
[5/8] scsi: pm8001: Modify task abort handling for SATA task
      https://git.kernel.org/mkp/scsi/c/0b639decf651
[6/8] scsi: pm8001: Use sas_ata_device_link_abort() to handle NCQ errors
      https://git.kernel.org/mkp/scsi/c/811be570a9a8
[7/8] scsi: libsas: Make sas_{alloc, alloc_slow, free}_task() private
      https://git.kernel.org/mkp/scsi/c/8e8d43642f2f
[8/8] scsi: libsas: Update SATA dev FIS in sas_ata_task_done()
      https://git.kernel.org/mkp/scsi/c/cc22efbec011

-- 
Martin K. Petersen	Oracle Linux Engineering
