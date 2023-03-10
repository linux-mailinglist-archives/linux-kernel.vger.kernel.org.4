Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3D16B3494
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 04:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjCJDOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 22:14:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbjCJDOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 22:14:36 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74AD6EBDB0;
        Thu,  9 Mar 2023 19:14:35 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 329Lwxkf005714;
        Fri, 10 Mar 2023 03:14:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2022-7-12;
 bh=O+MAM6zrhzPV08MrnYhvV4uvnUwX7FY5qMCfahg2ac8=;
 b=jCIAD/nE3gaFAhcjod91AgNljcWJDFCBDmsh0c5gsZ0hYRIa0ax2i5FcmEajqw5/bX+y
 8qbJ8wjhgvbcEt/NirHPphiKbnnf0IVHFO6TfmA6KwTozxg/yzcuZAJYCxGNN5jSxlSN
 Lo+oC3oDqnnmA/cPekH2bA30rBBf6CzxVjpu+tCi/NWKkhHSoUEu5ZWBOcrXmRGIn3lL
 f+LKiQFSYyfPVtBPO0WvMB4FNgsMpS2djHXzVNN13WBA9m37gCqXJjbfSbW37ZuS8fdA
 8IFIH4bXl/XZdG14TWI6LWjsYOsWyamZNtzn1Oi1JyzO+13CuyuV+xtwhIg5VY2t7JWj 4g== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p416247sj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Mar 2023 03:14:31 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32A2EvUc026517;
        Fri, 10 Mar 2023 03:14:31 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3p6g9w39kc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Mar 2023 03:14:31 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32A3ETDI023573;
        Fri, 10 Mar 2023 03:14:30 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3p6g9w39jg-3;
        Fri, 10 Mar 2023 03:14:30 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Sathya Prakash <sathya.prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] scsi: message: fusion: avoid flush_scheduled_work() usage
Date:   Thu,  9 Mar 2023 22:14:23 -0500
Message-Id: <167841804068.2362455.8672714577251900437.b4-ty@oracle.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <0b9ebcfb-b647-1381-0653-b54528a64a86@I-love.SAKURA.ne.jp>
References: <0b9ebcfb-b647-1381-0653-b54528a64a86@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-09_14,2023-03-09_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=912
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303100023
X-Proofpoint-GUID: Zyx0y_sLCrujRTTbqVtZ-idetxhh_7g7
X-Proofpoint-ORIG-GUID: Zyx0y_sLCrujRTTbqVtZ-idetxhh_7g7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Feb 2023 00:02:46 +0900, Tetsuo Handa wrote:

> Like commit c4f135d643823a86 ("workqueue: Wrap flush_workqueue() using a
> macro") says, flush_scheduled_work() is dangerous and will be forbidden.
> 
> Commit 4d4109d0eb69 ("[SCSI] mpt fusion: Power Management fixes for MPT
> SAS PCI-E controllers") added flush_scheduled_work() call into
> mptscsih_suspend(). As of commit 4d4109d0eb69, there were several
> schedule{,_delayed}_work() calls where flush_scheduled_work() from
> mptscsih_suspend() meant to wait for completion, but which work items
> is this flush_scheduled_work() call for was not explained.
> 
> [...]

Applied to 6.4/scsi-queue, thanks!

[1/1] scsi: message: fusion: avoid flush_scheduled_work() usage
      https://git.kernel.org/mkp/scsi/c/a4c2673caed9

-- 
Martin K. Petersen	Oracle Linux Engineering
