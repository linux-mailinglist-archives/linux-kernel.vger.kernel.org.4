Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24ABE6A001A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 01:33:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232804AbjBWAdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 19:33:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjBWAdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 19:33:19 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE9383C5;
        Wed, 22 Feb 2023 16:33:18 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31N0Of9U001037;
        Thu, 23 Feb 2023 00:33:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2022-7-12;
 bh=QFCsR5onlgCwc3c942GZhCrGtr2gtf/luBe3NddelDs=;
 b=nqPLnmEICg9DHLdeVHufPNzax6szYovKR0IrosQL/yA9Z6cE3oitOhL2mI0mJ8g0ZOtO
 zjxCFUdpabqq4c9W4bkjIIRkJEQvU2dcvUXfGrBBLhAjf6Po8F6OwKnJa9aATZOH2Q86
 hF5V9P+1GGM9rol//07HFNIlXecHBSpBz2Z9DJ9Y7azawj386/7a5B8ka6wSG7xnaIu1
 SWmsM+E5OLO1DeOQ5WMLsow+Vgq6YY1lOjjbZP2NyBJeVOJwI5I/xRP9hljv7m13xldO
 lkni9gu6UudXpzcbE831qPRlO91AAvKqn+8mrmzRTi5jbbOYiJGNTudhHhOKCyu5U1+w Vg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ntpja99bg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Feb 2023 00:33:15 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31MNcV1T006773;
        Thu, 23 Feb 2023 00:33:14 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ntn4dvreu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Feb 2023 00:33:13 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31N0XDXV013669;
        Thu, 23 Feb 2023 00:33:13 GMT
Received: from ca-qasparc-x86-2.us.oracle.com (ca-qasparc-x86-2.us.oracle.com [10.147.24.103])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3ntn4dvreh-1;
        Thu, 23 Feb 2023 00:33:13 +0000
From:   Anthony Yznaga <anthony.yznaga@oracle.com>
To:     daniel.m.jordan@oracle.com, steffen.klassert@secunet.com
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] padata: use alignment when calculating the number of worker threads
Date:   Wed, 22 Feb 2023 16:33:12 -0800
Message-Id: <1677112392-17332-1-git-send-email-anthony.yznaga@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-22_12,2023-02-22_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302230002
X-Proofpoint-ORIG-GUID: TLVlqTZedShvIlPqMn2a0gER4aEQT1es
X-Proofpoint-GUID: TLVlqTZedShvIlPqMn2a0gER4aEQT1es
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For multithreaded jobs the computed chunk size is rounded up by the
caller-specified alignment. However, the number of worker threads to
use is computed using the minimum chunk size without taking alignment
into account. A sufficiently large alignment value can result in too
many worker threads being allocated for the job.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 kernel/padata.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/padata.c b/kernel/padata.c
index e007b8a4b738..4abc536ecdb1 100644
--- a/kernel/padata.c
+++ b/kernel/padata.c
@@ -491,7 +491,7 @@ void __init padata_do_multithreaded(struct padata_mt_job *job)
 		return;
 
 	/* Ensure at least one thread when size < min_chunk. */
-	nworks = max(job->size / job->min_chunk, 1ul);
+	nworks = max(job->size / max(job->min_chunk, job->align), 1ul);
 	nworks = min(nworks, job->max_threads);
 
 	if (nworks == 1) {
-- 
1.8.3.1

