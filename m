Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EEAA72748C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 03:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233669AbjFHBne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 21:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233588AbjFHBnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 21:43:10 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C1D26B6;
        Wed,  7 Jun 2023 18:42:51 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 357Mv5lT018047;
        Thu, 8 Jun 2023 01:42:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-03-30;
 bh=33rxBu2AsW9cSAtuRJf+4k22ke47dvYvX9R/bXb9I1M=;
 b=fAU/HGcs4I/A7nnEFAz0GAqSWsiG4Vlt2ZDKsBXSyZ2AZ2AXDNGwyFYZoeybVEkfj898
 6jaq1KUFZcQICGOOgeSmhREHz39/rItqRp4zqCbyOuYIyGsNsYzLG+enZsof6ikD66Na
 efzYhxkp0bu69hmrQr9IXDNUt3HZIXtxaoMciaph1CiOTZayBNUUSKJK+Y9rP3uKN9zZ
 x1u/X9tan/aeB2AJ17FGloceo68bfnCpSEN3NDfUCyI3/3lukvHR8iVddlnkH0npGyl4
 4q5Fw2OEU5xzH6NXzCDziuAQ5rw88WKKOrQOULp2PWHYOkz6rgapJi3BBqyz+DQDG1D0 pg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r2a6ub3ht-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Jun 2023 01:42:46 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 357Nb1Nk037103;
        Thu, 8 Jun 2023 01:42:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r2a6hytah-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Jun 2023 01:42:45 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3581gQV7031871;
        Thu, 8 Jun 2023 01:42:44 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3r2a6hyt3a-15;
        Thu, 08 Jun 2023 01:42:44 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Jack Wang <jinpu.wang@cloud.ionos.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        Pranav Prasad <pranavpp@google.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Changyuan Lyu <changyuanl@google.com>
Subject: Re: [PATCH v2] scsi: pm80xx: Add fatal error checks
Date:   Wed,  7 Jun 2023 21:42:19 -0400
Message-Id: <168618844282.2636448.11367758567095525180.b4-ty@oracle.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230526235155.433243-1-pranavpp@google.com>
References: <20230526235155.433243-1-pranavpp@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-07_13,2023-06-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 adultscore=0 mlxlogscore=717 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306080011
X-Proofpoint-GUID: 3IC56_xfNWz7yP6AfuCb3ePws-4kFMDs
X-Proofpoint-ORIG-GUID: 3IC56_xfNWz7yP6AfuCb3ePws-4kFMDs
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 May 2023 23:51:55 +0000, Pranav Prasad wrote:

> This patch adds a fatal error check for the pm8001_phy_control()
> and pm8001_lu_reset() functions.
> 
> Changes compared to v1:
> - Changed the patch series to a single patch.
> - Added empty "/*" line to the comments as requested
>   by Damien Le Moal.
> - Aligned function arguments in pm8001_dbg() as
>   requested by Damien Le Moal.
> 
> [...]

Applied to 6.5/scsi-queue, thanks!

[1/1] scsi: pm80xx: Add fatal error checks
      https://git.kernel.org/mkp/scsi/c/4851c39aae3a

-- 
Martin K. Petersen	Oracle Linux Engineering
