Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B288763E87A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 04:46:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbiLADqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 22:46:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbiLADpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 22:45:52 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B310299503;
        Wed, 30 Nov 2022 19:45:51 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B11PAil017406;
        Thu, 1 Dec 2022 03:45:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2022-7-12;
 bh=/Owoyrm87ay/Ct6A0gJ3obUEJNV/Zg3PBJjNpIcrV8s=;
 b=OEgrG61PGxdujsMnmKa2l/yqJNVl89t1jaX7AjbMykEyTNHsW3AFzrXA78Grg1SpNg2B
 nzcudl3OXKe0xhK5nBvYcZezRreKFxWNj6cLFEjZbFBC6iPId/8Cf8R1tBktAgPr283G
 M/z5pzhW7m7ZCAy5+bU6FTzzMupdJgmxMcgy43eflCsW/rTGnQxKwMDeBlGnjyaBJMa1
 71/XnPc6w5KbN6KOSFNJ630yMdRMLtYpgr1tZqG9O6ELqHRT8npWDoqNhkqPJni0m7gA
 W2YyIt1gj6eC9qrJxK/Xq5AgIKUEWcrJhzBUwZ3q+bcQE+Z9eDo/pByxuH31h2cTWwlf qA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m40y43ep0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Dec 2022 03:45:45 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2B110D3X007662;
        Thu, 1 Dec 2022 03:45:44 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3m398a2cp4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Dec 2022 03:45:44 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2B13jbpY033801;
        Thu, 1 Dec 2022 03:45:44 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3m398a2cjs-7;
        Thu, 01 Dec 2022 03:45:43 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     alim.akhtar@samsung.com, linux-kernel@vger.kernel.org,
        jejb@linux.ibm.com, bvanassche@acm.org, avri.altman@wdc.com,
        Chanwoo Lee <cw9316.lee@samsung.com>,
        linux-scsi@vger.kernel.org, beanhuo@micron.com
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH] scsi: ufs: core: Fix unnecessary operation for early return
Date:   Thu,  1 Dec 2022 03:45:08 +0000
Message-Id: <166986602279.2101055.13361739954725366760.b4-ty@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221111062301.7423-1-cw9316.lee@samsung.com>
References: <CGME20221111062328epcas1p2c2d1f52fed1068579a1dad7fb4e60f52@epcas1p2.samsung.com> <20221111062301.7423-1-cw9316.lee@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-01_02,2022-11-30_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 mlxscore=0 bulkscore=0 spamscore=0 malwarescore=0
 mlxlogscore=991 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212010022
X-Proofpoint-GUID: rBDGApneAbyityliKD0GLyyYBn8mUtEy
X-Proofpoint-ORIG-GUID: rBDGApneAbyityliKD0GLyyYBn8mUtEy
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Nov 2022 15:23:01 +0900, Chanwoo Lee wrote:

> From: ChanWoo Lee <cw9316.lee@samsung.com>
> 
> For early return, bitmap_len operation is not required.
> Modified to reduce unnecessary operations.
> 
> 

Applied to 6.2/scsi-queue, thanks!

[1/1] scsi: ufs: core: Fix unnecessary operation for early return
      https://git.kernel.org/mkp/scsi/c/222d227f375b

-- 
Martin K. Petersen	Oracle Linux Engineering
