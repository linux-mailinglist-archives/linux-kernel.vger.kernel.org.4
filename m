Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D141F62E448
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 19:30:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240424AbiKQSah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 13:30:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240512AbiKQS3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 13:29:54 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E2AC7C473;
        Thu, 17 Nov 2022 10:29:53 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AHIJdil014161;
        Thu, 17 Nov 2022 18:29:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2022-7-12;
 bh=Z/1blqG8hTYudNmjuhE9+x6Y+JLD9Zyc1+hRGCd7tgY=;
 b=APgxxVB3GPD+61wspYyXTUz6t/qa6fKY8gRctk10OxCbaCPz8zeO+SHjceW8/LL4ky0s
 ndnKKudt7SUGyx75Y3jA2X3r6jm0RygD91d8jhy9spnKt4ZUrP/2uilByd8tvPtJfB9Y
 oJB1c9aHEKYdnennpwcMyDB+6SNaV9MxbUFWeYzwoyXC2vlR1AmYpecmbJ5BPt/BSUwc
 KwwHPLUG/LADzHqXOElAzzyGE4K9LhlKdyTLmO/NTDGWPYiDx3UYTNw9AaulPNKFWuTf
 8w3pN/UymtNdYAQrNfRJleWtmOL6SAzwMLBDG9D0MlDKMbyqNX+fw/Ef3EL6dBK5dMY6 NQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kv3jst0t7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Nov 2022 18:29:44 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AHHFDHa011101;
        Thu, 17 Nov 2022 18:29:42 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ku3kab0n7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Nov 2022 18:29:42 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AHITapJ022894;
        Thu, 17 Nov 2022 18:29:42 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3ku3kab0gb-10;
        Thu, 17 Nov 2022 18:29:42 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     adrian.hunter@intel.com, bvanassche@acm.org,
        Keoseong Park <keosung.park@samsung.com>,
        linux-kernel@vger.kernel.org, beanhuo@micron.com,
        linux-scsi@vger.kernel.org, avri.altman@wdc.com,
        ALIM AKHTAR <alim.akhtar@samsung.com>, jejb@linux.ibm.com,
        Jinyoung CHOI <j-young.choi@samsung.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH] scsi: ufs: core: Refactor ufshcd_hba_enable()
Date:   Thu, 17 Nov 2022 13:29:32 -0500
Message-Id: <166870943110.1584889.8247263374871093855.b4-ty@oracle.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221028073553epcms2p6dc4f8bdbebdc8f96f43fc4197b3edd0c@epcms2p6>
References: <CGME20221028073553epcms2p6dc4f8bdbebdc8f96f43fc4197b3edd0c@epcms2p6> <20221028073553epcms2p6dc4f8bdbebdc8f96f43fc4197b3edd0c@epcms2p6>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-17_06,2022-11-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 mlxlogscore=937 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211170133
X-Proofpoint-ORIG-GUID: 2lVA_vnR13Y9svjgapEsmqZcunTME2G9
X-Proofpoint-GUID: 2lVA_vnR13Y9svjgapEsmqZcunTME2G9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Oct 2022 16:35:53 +0900, Keoseong Park wrote:

> Use "if error return" style in ufshcd_hba_enable().
> No functional change.
> 
> 

Applied to 6.2/scsi-queue, thanks!

[1/1] scsi: ufs: core: Refactor ufshcd_hba_enable()
      https://git.kernel.org/mkp/scsi/c/bc77fb9ce40c

-- 
Martin K. Petersen	Oracle Linux Engineering
