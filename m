Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EECDE705CE2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 04:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbjEQCM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 22:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231679AbjEQCMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 22:12:53 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB3CA3A9D;
        Tue, 16 May 2023 19:12:52 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34GJxu52020345;
        Wed, 17 May 2023 02:12:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-03-30;
 bh=6a/gMZ8p/Gj4CuzZkBee4eywybrsxsCAKy1aAN2PViE=;
 b=Do+5bZ3KePD/Rc6fT0x91Uhvoerlr4OEdF0q4cO2BuctEJzL7et1AocuVvRcww38JKi0
 0i2e/+RzkmTFf4sssVibn5la0HGVvHGt8WHkfZ9w1opRnoCZURWw6/pTJ1etwFtA1zm0
 xbVoTDOfRWIY7uov0oYdHSf8UDG2gMeaaL0r+BV56x/LGVCSxnTIc292ZemkYUdgkzNJ
 pqzsc3Xty1cNz1GRK2osOVUc9tlTK5Na5YWeBhfTfLHRtrEVCL2WlQn02Y1OMI42lYjz
 lW6wW1wNfuagENcrXLtl/dRrm0PZJdDZjaKhtpcLv4WR+UqpEjrJFY6KoZPbIcEj/56w iw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj1524pc8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 May 2023 02:12:49 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34H2AFCJ025109;
        Wed, 17 May 2023 02:12:48 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qj104tw2j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 May 2023 02:12:48 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34H2CdOM016064;
        Wed, 17 May 2023 02:12:48 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3qj104tw04-7;
        Wed, 17 May 2023 02:12:48 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Jack Wang <jinpu.wang@cloud.ionos.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        Pranav Prasad <pranavpp@google.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Changyuan Lyu <changyuanl@google.com>
Subject: Re: [PATCH] scsi: pm80xx: Add GET_NVMD timeout during probe
Date:   Tue, 16 May 2023 22:12:30 -0400
Message-Id: <168428950404.722180.3101128624960844056.b4-ty@oracle.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230419175502.919999-1-pranavpp@google.com>
References: <20230419175502.919999-1-pranavpp@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-16_14,2023-05-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 mlxlogscore=780 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305170016
X-Proofpoint-GUID: Hmzrf-IAqtDOPx8Qyz8a82ga4DpXFt1s
X-Proofpoint-ORIG-GUID: Hmzrf-IAqtDOPx8Qyz8a82ga4DpXFt1s
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Apr 2023 17:55:02 +0000, Pranav Prasad wrote:

> Added a wait timeout to prevent the kernel from waiting for the
> GET_NVMD response forever during probe. Added a check for the
> controller state before issuing GET_NVMD request.
> 
> 

Applied to 6.5/scsi-queue, thanks!

[1/1] scsi: pm80xx: Add GET_NVMD timeout during probe
      https://git.kernel.org/mkp/scsi/c/14a8f116cdc0

-- 
Martin K. Petersen	Oracle Linux Engineering
