Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 280DF741E70
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 04:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbjF2Cls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 22:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbjF2Cli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 22:41:38 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9BBD213D;
        Wed, 28 Jun 2023 19:41:37 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35T2CkGF026676;
        Thu, 29 Jun 2023 02:41:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-03-30;
 bh=JB/KSFrQXifkmK6IF3dpoykWg/WvV9FEJFqYDbKOZkU=;
 b=FUCpnFemrDABB+5QMfEiLAX5zd/Lfo2nPc/jpxm2a+JlB5AkH0JpCL8rbqDc1yHgOTPn
 NsoHsXpuzjqXl9J18UJCPfR6BYdpOP5BzPwSSJzkfTyxBUYvYFhLFo/aLqizZrE3MQpo
 gtqtUXrkdkoBgn3p813RRijvOpTKLqZT4ynuliajrP11frDdMEY4AmS5L9H34htTlrkg
 3+AIG1joPnds8VTR7pz5UyHIOGNMpHQ8BxRg5IxyLrUzqfKjl7nv5+AcHgMg7gZeP4FA
 Zk0FtfddUL110NSwXqqadFtcOF8CKj31d5LPlccZ28wMCyEJzw8zx5wwYUOcOTUK5zbJ vg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdpwdj1up-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Jun 2023 02:41:35 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35T2G0Iq003985;
        Thu, 29 Jun 2023 02:41:34 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpxcvekv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Jun 2023 02:41:34 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35T2fYLF009945;
        Thu, 29 Jun 2023 02:41:34 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3rdpxcveka-2;
        Thu, 29 Jun 2023 02:41:34 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Bodo Stroesser <bostroesser@gmail.com>,
        Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-hardening@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] scsi: Replace strlcpy with strscpy
Date:   Wed, 28 Jun 2023 22:41:28 -0400
Message-Id: <168800630154.587979.4105915044944808138.b4-ty@oracle.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230621030033.3800351-1-azeemshaikh38@gmail.com>
References: <20230621030033.3800351-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_14,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=509 bulkscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306290022
X-Proofpoint-GUID: QB6GD5hfw-mQu2eAFi0Hde6ggT7H7AaU
X-Proofpoint-ORIG-GUID: QB6GD5hfw-mQu2eAFi0Hde6ggT7H7AaU
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jun 2023 03:00:31 +0000, Azeem Shaikh wrote:

> This patch series replaces strlcpy in the scsi subsystem wherever trivial
> replacement is possible, i.e return value from strlcpy is unused. The patches
> themselves are independent of each other and are included as a series for
> ease of review.
> 
> Azeem Shaikh (2):
>   scsi: Replace strlcpy with strscpy
>   scsi: target: tcmu: Replace strlcpy with strscpy
> 
> [...]

Applied to 6.5/scsi-queue, thanks!

[1/2] scsi: Replace strlcpy with strscpy
      https://git.kernel.org/mkp/scsi/c/d1e8a9fbb392
[2/2] scsi: target: tcmu: Replace strlcpy with strscpy
      https://git.kernel.org/mkp/scsi/c/4b2e28758daf

-- 
Martin K. Petersen	Oracle Linux Engineering
