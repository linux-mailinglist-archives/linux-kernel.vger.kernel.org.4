Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9754730D18
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 04:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241225AbjFOCQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 22:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238287AbjFOCQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 22:16:36 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88905213B;
        Wed, 14 Jun 2023 19:16:35 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35EK28It011675;
        Thu, 15 Jun 2023 02:16:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-03-30;
 bh=/HyjONeMU7stI1vytKXrTvwS3Ej/N+4v/h0ga9y7/NA=;
 b=wXnSFENMDmQciouprzR8mBM+zbRBHGsOlPaTukPZge++6yahnv+5i4GWmfNB0Hl7MosZ
 RuP6aRuucJ1jQkqQJ4XK6g1swkPomGomhyF0bvymAh2cL6zzsDtojAIhi/bGuovaaBiJ
 KYOkmPV6fsGlS29cipvtF37vN3enLG8wBw4yIQP62O2WT/mhBaQl7mARuVED/CuKKoRg
 oJIINpkWrgGZKa+iXJPoym9GgmwXpT1ftA53I2tNjblBF3sRspYiySdid70gvWQ9XMj0
 Ec/+3RUXB1kYo/EE/yTQ44pFjm21YBTEmfEbc0nWXmgkGcvcEYkTEXuUR/Cb9R4EAArp Dg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4gsu0tsb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Jun 2023 02:16:29 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35F1wg6p016286;
        Thu, 15 Jun 2023 02:16:28 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fm6bnxb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Jun 2023 02:16:28 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35F2EE7F027953;
        Thu, 15 Jun 2023 02:16:28 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3r4fm6bnx8-1;
        Thu, 15 Jun 2023 02:16:28 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2][next] scsi: lpfc: Avoid -Wstringop-overflow warning
Date:   Wed, 14 Jun 2023 22:16:20 -0400
Message-Id: <168679535176.3778526.10107132390411297417.b4-ty@oracle.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <ZHkseX6TiFahvxJA@work>
References: <ZHkseX6TiFahvxJA@work>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-14_14,2023-06-14_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=654 bulkscore=0 mlxscore=0
 spamscore=0 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306150017
X-Proofpoint-GUID: p2Xwwe-FqLRVd-rqZUacazIlVRbLln9N
X-Proofpoint-ORIG-GUID: p2Xwwe-FqLRVd-rqZUacazIlVRbLln9N
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 01 Jun 2023 17:40:41 -0600, Gustavo A. R. Silva wrote:

> Prevent any potential integer wrapping issue, and avoid a
> -Wstringop-overflow warning by using the check_mul_overflow() helper.
> 
> drivers/scsi/lpfc/lpfc.h:
> 837:#define LPFC_RAS_MIN_BUFF_POST_SIZE (256 * 1024)
> 
> drivers/scsi/lpfc/lpfc_debugfs.c:
> 2266 size = LPFC_RAS_MIN_BUFF_POST_SIZE * phba->cfg_ras_fwlog_buffsize;
> 
> [...]

Applied to 6.5/scsi-queue, thanks!

[1/1] scsi: lpfc: Avoid -Wstringop-overflow warning
      https://git.kernel.org/mkp/scsi/c/a48e2c328c65

-- 
Martin K. Petersen	Oracle Linux Engineering
