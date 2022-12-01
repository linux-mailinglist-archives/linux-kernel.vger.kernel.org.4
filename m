Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB5A63E88C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 04:46:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbiLADqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 22:46:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbiLADqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 22:46:04 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A131F975C3;
        Wed, 30 Nov 2022 19:46:00 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B13PoG9017334;
        Thu, 1 Dec 2022 03:45:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2022-7-12;
 bh=C+xGksO44bQgn6Hq64Z60iA2mS7ooFkN0tMK+kazl1o=;
 b=clRXiANOuQ1iH5GyMpyMXmNPOC+fAEUTgAKjJZPUAzECkEvdyeSwJUETM+4R0mjYXGq8
 dZyjRp8LBumHjVPnT0sAm6O/sHKTPFun1cYVf7zVYVuBmLjousCG301wHm9U9abH9pc5
 cin3Fcf5uxtueTfUUz4wUHki0eCw2GpJMREOZMLlEJloB0I4PDmSidAMsGYeyxS7dd/Q
 BQMKbDJIauwPhyvB++l5CxcIVVxZsfa3sx/sLdA4m8NC7vU31pLVzRYSyZ2fyaDVK4Ui
 BWRG16oM1IVINCgPS/6yy//xhWf5PSBr8nxPdsMsnTapuXXLCSq1KWnhNqPfVGkf7aEO Yg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m4aemjjnx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Dec 2022 03:45:55 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2B11wfW4007655;
        Thu, 1 Dec 2022 03:45:55 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3m398a2cuq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Dec 2022 03:45:54 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2B13jbpr033801;
        Thu, 1 Dec 2022 03:45:54 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3m398a2cjs-17;
        Thu, 01 Dec 2022 03:45:54 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        error27@gmail.com, linux-kernel@vger.kernel.org,
        Douglas Gilbert <dgilbert@interlog.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        harshit.m.mogalapalli@gmail.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: Re: [PATCH] scsi: scsi_debug: Fix a warning in resp_verify()
Date:   Thu,  1 Dec 2022 03:45:18 +0000
Message-Id: <166986602283.2101055.16782427879240929714.b4-ty@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221112070031.2121068-1-harshit.m.mogalapalli@oracle.com>
References: <20221112070031.2121068-1-harshit.m.mogalapalli@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-01_02,2022-11-30_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 mlxscore=0 bulkscore=0 spamscore=0 malwarescore=0
 mlxlogscore=781 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212010022
X-Proofpoint-ORIG-GUID: x2fsloB2ly8BdJ6gwhb-Pab59bbKD3e5
X-Proofpoint-GUID: x2fsloB2ly8BdJ6gwhb-Pab59bbKD3e5
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Nov 2022 23:00:31 -0800, Harshit Mogalapalli wrote:

> As 'vnum' is controlled by user, so if user tries to allocate memory
> larger than(>=) MAX_ORDER, then kcalloc() will fail, it creates a stack
> trace and messes up dmesg with a warning.
> 
> Add __GFP_NOWARN in order to avoid too large allocation warning.
> This is detected by static analysis using smatch.
> 
> [...]

Applied to 6.2/scsi-queue, thanks!

[1/1] scsi: scsi_debug: Fix a warning in resp_verify()
      https://git.kernel.org/mkp/scsi/c/ed0f17b748b2

-- 
Martin K. Petersen	Oracle Linux Engineering
