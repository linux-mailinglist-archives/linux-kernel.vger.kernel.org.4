Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A23A5BA4E1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 05:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbiIPDCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 23:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbiIPDCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 23:02:07 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C73B79D8C0;
        Thu, 15 Sep 2022 20:02:03 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28G1x0HU029407;
        Fri, 16 Sep 2022 03:02:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2022-7-12;
 bh=zkp8lpx7JNRt7yDNEwRQC13Ts/IeE5c8S1xCAJIEXkY=;
 b=PHZRqmjidtlDqAaLwkvVgfZaR/FoLnP2y1+uDq3hu+DKhpQ4B7qqlO869s+uVF8/Ydte
 VokY3qcF4Ww8gvSOW/6L+M18pLaSy1lOzJMprtpIUI2NTK66ICtZVUAE2STyBFEb9iBT
 x4zWJh40kD1UGx9ch6sXE6N2pS2cU6UdGQusyKsxRinA3IT88FD7cy5zK18rZBpDATac
 +jxlveZsnfQbtWJ9NlVxS0wbzxiQqt/2rHoi9TXD6jOHEHL5Ks7Y5x9padpSk/Lxz5LP
 VOi8wpbw06c8pHPARilul5gfhA8DM1vdO8Jt80TIeQUUD3nPmNu54ckz+R4834jMjtVx cw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jm8xc9780-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Sep 2022 03:02:00 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28G0AbJv015949;
        Fri, 16 Sep 2022 03:02:00 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jm8x8pjw8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Sep 2022 03:02:00 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28G31xOY014516;
        Fri, 16 Sep 2022 03:01:59 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3jm8x8pjv1-1;
        Fri, 16 Sep 2022 03:01:59 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     skashyap@marvell.com, Letu Ren <fantasquex@gmail.com>,
        jejb@linux.ibm.com, jhasan@marvell.com
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, Wende Tan <twd2.me@gmail.com>,
        Zheyu Ma <zheyuma97@gmail.com>, linux-scsi@vger.kernel.org,
        GR-QLogic-Storage-Upstream@marvell.com
Subject: Re: [PATCH] scsi: qedf: Fix a UAF bug in __qedf_probe
Date:   Thu, 15 Sep 2022 23:01:55 -0400
Message-Id: <166329729477.12731.17768877694121234425.b4-ty@oracle.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20211112120641.16073-1-fantasquex@gmail.com>
References: <20211112120641.16073-1-fantasquex@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-15_10,2022-09-14_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=781 phishscore=0
 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209160020
X-Proofpoint-ORIG-GUID: Opa0fvBSAu4nqu23SDsyxLJFL0WnWIvM
X-Proofpoint-GUID: Opa0fvBSAu4nqu23SDsyxLJFL0WnWIvM
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Nov 2021 20:06:41 +0800, Letu Ren wrote:

> In __qedf_probe, if `qedf->cdev` is NULL which means
> qed_ops->common->probe() failed, then the program will goto label err1,
> scsi_host_put() will free `lport->host` pointer. Because the memory `qedf`
> points to is allocated by libfc_host_alloc(), it will be freed by
> scsi_host_put(). However, the if statement below label err0 only checks
> whether qedf is NULL but doesn't check whether the memory has been freed.
> So a UAF bug occurred.
> 
> [...]

Applied to 6.0/scsi-fixes, thanks!

[1/1] scsi: qedf: Fix a UAF bug in __qedf_probe
      https://git.kernel.org/mkp/scsi/c/fbfe96869b78

-- 
Martin K. Petersen	Oracle Linux Engineering
