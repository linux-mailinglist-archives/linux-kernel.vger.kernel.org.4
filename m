Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E78A570CE45
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 00:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234881AbjEVWrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 18:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234906AbjEVWql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 18:46:41 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB573102;
        Mon, 22 May 2023 15:46:40 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34MKODIG004113;
        Mon, 22 May 2023 22:46:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-03-30;
 bh=NIpJyPWnm+pCo0TIrhUkfZz7LsYStrccZjB+3CKRxCk=;
 b=CbVLtzqVf24fYs86QoiuSpMF4+u6bJWqfr0MnE5hHc0D/KIQe8Fdt5apPUpTa+uYqR3c
 /OdfDGCm91kNtPnnWqOnE3puaIqmFFpQZKOx9YJ7DmbeGm2eV0IJBd7ytBEicPSgb/Lm
 pslxCjZ1m2ac4Dk40IyqGoJdlU0gPq3TMuKG9HUHmaBb7QX7JA9GOH4Nr5ES5ppsVtvR
 bUDS4/xLvsfT/v1r4p34uKvOm+tkE3lV9on/NsydiUrK4xH3Bdveboq68h0Sv/oe46ak
 rWMFPo/xwZj6ubkxt4Z3scHBrDaxVBZBNDYLuzC5WgaJUUA7B7q+ZP7WZLR5FFkCl+E/ AA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qpp423tvb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 May 2023 22:46:34 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34MM0h7A027571;
        Mon, 22 May 2023 22:46:34 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk2ctfdv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 May 2023 22:46:34 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34MMkPxg017332;
        Mon, 22 May 2023 22:46:33 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3qqk2ctfa8-7;
        Mon, 22 May 2023 22:46:33 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Kashyap Desai <kashyap.desai@broadcom.com>,
        Kees Cook <keescook@chromium.org>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] scsi: megaraid_sas: Convert union megasas_sgl to flex-arrays
Date:   Mon, 22 May 2023 18:46:18 -0400
Message-Id: <168479035938.1118074.1867782367788375137.b4-ty@oracle.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230511220957.never.919-kees@kernel.org>
References: <20230511220957.never.919-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-22_16,2023-05-22_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305220192
X-Proofpoint-ORIG-GUID: bzx41BLHbhy8hbFtgPsIBgt5Avyz6mOv
X-Proofpoint-GUID: bzx41BLHbhy8hbFtgPsIBgt5Avyz6mOv
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 May 2023 15:10:00 -0700, Kees Cook wrote:

> In the ongoing effort to replace all fake flexible arrays with true
> flexible arrays, replace the sge32, sge64, and sge_skinny members of
> union megasas_sgl with true flexible arrays. No binary differences are
> seen after this change; sizes were already being manually calculated
> using the member struct sizes directly.
> 
> 
> [...]

Applied to 6.5/scsi-queue, thanks!

[1/1] scsi: megaraid_sas: Convert union megasas_sgl to flex-arrays
      https://git.kernel.org/mkp/scsi/c/aa67380056a4

-- 
Martin K. Petersen	Oracle Linux Engineering
