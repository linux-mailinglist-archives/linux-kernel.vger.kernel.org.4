Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5CDC718F9F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 02:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbjFAAnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 20:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjFAAnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 20:43:40 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BDC411F;
        Wed, 31 May 2023 17:43:40 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34VJtG3p032564;
        Thu, 1 Jun 2023 00:43:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-03-30;
 bh=8mIubt/iqIEj3yF916En/5c6+5bvMQgTYOSnnjWevvQ=;
 b=xoDtlEmsRq+Oj7dQNXHb/6QdtRgYfo6zfJqrLysusF1PvzzaGmRwjCJ+9QDcMlJjDYQT
 iiv/ZdAHAqRckb5mxPXCX8Mu+8X/dowPK91rhr6QcVJO4OoyPacmcE4PM5znTmSCsCgo
 wW/Pl9YasLcrhJtZ32Yi6ScWKgctu021FwYpI/QJsVxRWoikwt5T70G2HBMc83UZKcVX
 RwLlO9w0PlUbhtXcn54mO8p3nNOmw5Csl9TZTF7uNzwrQhHUw7qexZEfTfiFxSzNjdr+
 +OO5o3CEPWK0kIwwLcPrE+f78q9c8Xa8m8EBUd4JQurYNXfw337o3tWv63nZF7QH6VaU dA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhb97d73-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Jun 2023 00:43:34 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34VMje4a004350;
        Thu, 1 Jun 2023 00:43:33 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qv4ye2eam-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Jun 2023 00:43:33 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3510hV9J008516;
        Thu, 1 Jun 2023 00:43:32 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3qv4ye2e6s-2;
        Thu, 01 Jun 2023 00:43:32 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <james.smart@broadcom.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 0/2][next] scsi: lpfc: Replace one-element array with flexible-array member
Date:   Wed, 31 May 2023 20:43:11 -0400
Message-Id: <168558000061.2461197.16055588044567181053.b4-ty@oracle.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1684358315.git.gustavoars@kernel.org>
References: <cover.1684358315.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_18,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=682
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306010004
X-Proofpoint-GUID: 2A7n-JZDucLtJLPG9sjrQ4gP-FMROkEG
X-Proofpoint-ORIG-GUID: 2A7n-JZDucLtJLPG9sjrQ4gP-FMROkEG
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 May 2023 15:22:24 -0600, Gustavo A. R. Silva wrote:

> This small series aims to replace a one-element array with a
> flexible-array member in a couple of structures.
> 
> This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
> routines on memcpy() and help us make progress towards globally
> enabling -fstrict-flex-arrays=3 [1].
> 
> [...]

Applied to 6.5/scsi-queue, thanks!

[1/2] scsi: lpfc: Replace one-element array with flexible-array member
      https://git.kernel.org/mkp/scsi/c/e90644b0ce2d

-- 
Martin K. Petersen	Oracle Linux Engineering
