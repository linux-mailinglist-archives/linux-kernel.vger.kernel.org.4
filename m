Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 243C3741E74
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 04:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbjF2Cmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 22:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231655AbjF2CmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 22:42:24 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D5791FE8;
        Wed, 28 Jun 2023 19:41:54 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35T1id4S002290;
        Thu, 29 Jun 2023 02:41:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-03-30;
 bh=Tbg5+mKfxrq7tt83Imhc7cghgkrAGv/odQicgErRYco=;
 b=cRMtLc7b277znIkio/uciXbpt8jOypYiXUdww26DWCsIsxAk1NGLFXbnR8whgARnpZGs
 KPWm5MVGpgPPEdEpPUhKaLWr6oVbQP9cwtDpeZhhdSfqoHQYf7xNq7l5NPoPRBQkKHbt
 04h7ufyar1w9RdYbYk/CsFCp8yHHBOQ9137Xoo8POt/lgtW2rG8lwZf4d+PVa9TQFlkI
 ZBCuMZKhcyAVTeAuiGBgvNh7AK0YSZUAhG6T+rlFfo+HdIQT4nwl5bALZWvk92aAqXIH
 1Jhro4vDtGo+Tr1KGxBSZNLXNgOGyVH2aEJ9nG2CnkgroEEPB3Tbz9YJ9FJVsZ38VV4Z WA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rds1ua3f6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Jun 2023 02:41:36 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35T2CuQ2004055;
        Thu, 29 Jun 2023 02:41:34 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpxcvekn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Jun 2023 02:41:34 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35T2fYLD009945;
        Thu, 29 Jun 2023 02:41:34 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3rdpxcveka-1;
        Thu, 29 Jun 2023 02:41:33 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Arnd Bergmann <arnd@kernel.org>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Justin Tee <justin.tee@broadcom.com>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH] scsi: lpfc: fix lpfc_name struct packing
Date:   Wed, 28 Jun 2023 22:41:27 -0400
Message-Id: <168800630153.587979.15904389303880305259.b4-ty@oracle.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230616090705.2623408-1-arnd@kernel.org>
References: <20230616090705.2623408-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_14,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306290022
X-Proofpoint-GUID: w93DFv3IXslOC6X0l4GF1DxXJIw1L124
X-Proofpoint-ORIG-GUID: w93DFv3IXslOC6X0l4GF1DxXJIw1L124
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Jun 2023 11:06:56 +0200, Arnd Bergmann wrote:

> clang points out that the lpfc_name structure has an 8-byte alignement requirement
> on most architectures, but is embedded in a number of other structures that are
> forced to be only 1-byte aligned:
> 
> drivers/scsi/lpfc/lpfc_hw.h:1516:30: error: field pe within 'struct lpfc_fdmi_reg_port_list' is less aligned than 'struct lpfc_fdmi_port_entry' and is usually due to 'struct lpfc_fdmi_reg_port_list' being packed, which can lead to unaligned accesses [-Werror,-Wunaligned-access]
>         struct lpfc_fdmi_port_entry pe;
> drivers/scsi/lpfc/lpfc_hw.h:850:19: error: field portName within 'struct _ADISC' is less aligned than 'struct lpfc_name' and is usually due to 'struct _ADISC' being packed, which can lead to unaligned accesses [-Werror,-Wunaligned-access]
> drivers/scsi/lpfc/lpfc_hw.h:851:19: error: field nodeName within 'struct _ADISC' is less aligned than 'struct lpfc_name' and is usually due to 'struct _ADISC' being packed, which can lead to unaligned accesses [-Werror,-Wunaligned-access]
> drivers/scsi/lpfc/lpfc_hw.h:922:19: error: field portName within 'struct _RNID' is less aligned than 'struct lpfc_name' and is usually due to 'struct _RNID' being packed, which can lead to unaligned accesses [-Werror,-Wunaligned-access]
> drivers/scsi/lpfc/lpfc_hw.h:923:19: error: field nodeName within 'struct _RNID' is less aligned than 'struct lpfc_name' and is usually due to 'struct _RNID' being packed, which can lead to unaligned accesses [-Werror,-Wunaligned-access]
> 
> [...]

Applied to 6.5/scsi-queue, thanks!

[1/1] scsi: lpfc: fix lpfc_name struct packing
      https://git.kernel.org/mkp/scsi/c/00c2cae6b66a

-- 
Martin K. Petersen	Oracle Linux Engineering
