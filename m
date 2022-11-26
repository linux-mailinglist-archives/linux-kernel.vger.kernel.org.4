Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B10C46393B7
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 04:28:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbiKZD2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 22:28:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbiKZD2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 22:28:25 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B42E820340;
        Fri, 25 Nov 2022 19:28:06 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AQ2s0xX026859;
        Sat, 26 Nov 2022 03:27:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2022-7-12;
 bh=8iMcYve8nytUkCqxaMbsMz1z7XitqINQPlhPG05E2ek=;
 b=1Cad7Xhm0icmINE9vbLHE2S8rqTKtZjsPmn/Y3YUCrGyu+7j+5sb0ny7I/WuPK8uhFm+
 qPGTAeZJheFkl4Ln5emO/5oBTgHIj+g30C8oFzm29RejZ+80ZPadS1jIP/NMtv3GkVyK
 J3m0cCIxyDR64mJlxwJ7hmrHd5L2SYoGQ4uqdKuRHHs+PBeXYwt/S45BL5qG6MnNIJ4H
 Q7nB1xdVYAkkzIyFKR+O0if5xpGrGd6eGOHISS6jcZx3Ut50iPOkrAN5Re8oMvmGa4i3
 qG/Xul3rbMmHxWTcl1bMdfSy87AJ91rrRv36zCzPxuHzFYiQdPGKkuuT0J84wMr+G9ez Gw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m3adt00jv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 26 Nov 2022 03:27:47 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AQ1XcPp007448;
        Sat, 26 Nov 2022 03:27:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3m3988b819-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 26 Nov 2022 03:27:46 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AQ3Rhsd028327;
        Sat, 26 Nov 2022 03:27:46 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3m3988b7y9-9;
        Sat, 26 Nov 2022 03:27:46 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     jejb@linux.ibm.com, Xiu Jianfeng <xiujianfeng@huawei.com>,
        dick.kennedy@broadcom.com, james.smart@broadcom.com
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH -next] scsi: lpfc: Use memset_startat() helper
Date:   Sat, 26 Nov 2022 03:27:40 +0000
Message-Id: <166943312544.1684293.12387050473657747589.b4-ty@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221111074310.132125-1-xiujianfeng@huawei.com>
References: <20221111074310.132125-1-xiujianfeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-26_02,2022-11-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 phishscore=0
 mlxlogscore=747 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211260024
X-Proofpoint-ORIG-GUID: QtPIKfrzz37AWfeJesureWauLn-7P-LV
X-Proofpoint-GUID: QtPIKfrzz37AWfeJesureWauLn-7P-LV
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Nov 2022 15:43:10 +0800, Xiu Jianfeng wrote:

> User memset_startat() helper to simplify the code, no functional
> changes in this patch.
> 
> 

Applied to 6.2/scsi-queue, thanks!

[1/1] scsi: lpfc: Use memset_startat() helper
      https://git.kernel.org/mkp/scsi/c/b29e91385ce2

-- 
Martin K. Petersen	Oracle Linux Engineering
