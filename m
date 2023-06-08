Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C453727473
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 03:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233353AbjFHBmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 21:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbjFHBmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 21:42:33 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D27AB2113;
        Wed,  7 Jun 2023 18:42:32 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 357NCLT0026215;
        Thu, 8 Jun 2023 01:42:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-03-30;
 bh=EaVPC6x/CjdaWyEeOEOuS+vruEFnbu0g+p5OQTHDlAc=;
 b=n09NMeAVAu9ZqpupGvyEybhZ4fhl6P345pMWrZq8yyTFNmq0beKsg+YoBJgthpQpaOKW
 WsF1L/Zr+WZH12rL7yFtycB6pyDUSonkWRLlHFh0rnPh+jHBzFV+AFUIBu/OwZoPSbUr
 lNxVCxaxisXQ8VL62oPJItmPgLn8bTF9pg/5R7fA/8xLvKmxJHMV8VwffoU1sGvAB5ey
 z59laTjsk8qqNg/S+w9TMEe2otrpejNHEJo3ezep4WEygsMN+aWQJiWSX8vD2AoqCh4L
 8Kz71uMx1p6rMXkNSONb4EDqsTjm7i73KiKKKh+5gjhCxZ3MEgPWuKZFcD/5X57GbRm7 mw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r2a6rb4x3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Jun 2023 01:42:31 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 357NZZPv036485;
        Thu, 8 Jun 2023 01:42:30 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r2a6hyt55-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Jun 2023 01:42:30 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3581gQUh031871;
        Thu, 8 Jun 2023 01:42:29 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3r2a6hyt3a-3;
        Thu, 08 Jun 2023 01:42:29 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Sathya Prakash <sathya.prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-hardening@vger.kernel.org, MPT-FusionLinux.pdl@broadcom.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: message: fusion: Replace all non-returning strlcpy with strscpy
Date:   Wed,  7 Jun 2023 21:42:07 -0400
Message-Id: <168618844271.2636448.14637793237576075873.b4-ty@oracle.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230530160248.411637-1-azeemshaikh38@gmail.com>
References: <20230530160248.411637-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-07_13,2023-06-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306080011
X-Proofpoint-ORIG-GUID: U6tzPt_RIckA6xVpDreCFl0U2-M52yRE
X-Proofpoint-GUID: U6tzPt_RIckA6xVpDreCFl0U2-M52yRE
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 May 2023 16:02:48 +0000, Azeem Shaikh wrote:

> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> No return values were used, so direct replacement is safe.
> 
> [...]

Applied to 6.5/scsi-queue, thanks!

[1/1] scsi: message: fusion: Replace all non-returning strlcpy with strscpy
      https://git.kernel.org/mkp/scsi/c/dbe37c71d124

-- 
Martin K. Petersen	Oracle Linux Engineering
