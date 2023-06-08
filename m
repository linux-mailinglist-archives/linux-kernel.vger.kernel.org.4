Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB63D727486
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 03:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233641AbjFHBn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 21:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233382AbjFHBnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 21:43:07 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D0126B2;
        Wed,  7 Jun 2023 18:42:48 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3580OYV6018042;
        Thu, 8 Jun 2023 01:42:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-03-30;
 bh=Ryl2EhqfV2+fNBWIZIJic5OD6Y/49W8Fvd0Q0D2WP/8=;
 b=HqoWOqGlwXUmlYYjixqXQsWW0/faUCGFd1h1Ci1uJRGpYGPHc0+caKgfZcOF39rAeTVU
 onGGehIqpKvJ42JeKh80Z04zwu0/ZuAHPBo+kRmifNUVNYZLMkrZVflwJEQYRxFw45oY
 t5kvoBMJDLV41Nz8hCNwkDXNpXK2di1Jmh0B5Lfzj+3OJ0Ss3vIbH6dgw3Mfj87UgKsF
 fimTadKuy6vYeJhkHFmUZb0G7CndlbMJRmpw7JTroJY5a6v+bVE4g6JyPqpTtGOULI4W
 oeHcIoqEBjH8YDgimsAh94JuBQxcd7WXSYkonvqu0yXZfptD3NuDXYyXbRQWezOKraBo bg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r2a6ub3h1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Jun 2023 01:42:40 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 357NZZQ0036485;
        Thu, 8 Jun 2023 01:42:39 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r2a6hyt8h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Jun 2023 01:42:39 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3581gQUv031871;
        Thu, 8 Jun 2023 01:42:38 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3r2a6hyt3a-10;
        Thu, 08 Jun 2023 01:42:38 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Satish Kharat <satishkh@cisco.com>,
        Sesidhar Baddela <sebaddel@cisco.com>,
        Karan Tilak Kumar <kartilak@cisco.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH] scsi: fnic: Use vzalloc()
Date:   Wed,  7 Jun 2023 21:42:14 -0400
Message-Id: <168618844284.2636448.14775031761513658540.b4-ty@oracle.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <a1179941a6d440140513e681f4f3a1b92c8d83ae.1685210773.git.christophe.jaillet@wanadoo.fr>
References: <a1179941a6d440140513e681f4f3a1b92c8d83ae.1685210773.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-07_13,2023-06-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 adultscore=0 mlxlogscore=771 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306080011
X-Proofpoint-GUID: 0Jfzy6-2beWmRXQE3XGeWxJLxWHDGD-X
X-Proofpoint-ORIG-GUID: 0Jfzy6-2beWmRXQE3XGeWxJLxWHDGD-X
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 May 2023 20:06:37 +0200, Christophe JAILLET wrote:

> Use vzalloc() instead of hand writing it with vmalloc()+memset().
> This is less verbose.
> 
> This also fixes some style issues :)
> 
> 

Applied to 6.5/scsi-queue, thanks!

[1/1] scsi: fnic: Use vzalloc()
      https://git.kernel.org/mkp/scsi/c/14ce2c261d6c

-- 
Martin K. Petersen	Oracle Linux Engineering
