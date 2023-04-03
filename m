Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA3476D3BBB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 04:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbjDCCPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 22:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbjDCCPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 22:15:44 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B322CC665;
        Sun,  2 Apr 2023 19:15:34 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 332MMvJC014672;
        Mon, 3 Apr 2023 02:15:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2022-7-12;
 bh=p8Au+cM2Kj3ggilSBC8ilM6tDjtw3KbIL7gXud3F7ks=;
 b=0P1VZhCfOH0bd7qhfnuguMLUHcIV2NnJ4lnsVuazwqHPTzhKEgSmBsPl66xKQjLd6zez
 luHBW3+wbH58TooFgdoaqsguSxPmhvZdjKTMqLZJ5Hnoc64fymLxvjfJnZSYqPSY0I8d
 0a9L9Q284fp9IUfRtOS1bQVlTIfHbBf5tcy4Cl/sGAGH5a5cfo6rPU5UiO0QiR+SVNiE
 fDntDAHPkK7do1ojd1zrh8HYSCrscfY9Tq428vJKNEGAgRtWO+4doJJssL7S1i0yqnhk
 AnlCaHegzfyf0ryRqpAgBnbNORFrcQMWlXVLTNfTPbORh/Z5snz0SCHR1SZPn1mpXd0p yQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ppcncsyg5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Apr 2023 02:15:23 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 332MPFP8014227;
        Mon, 3 Apr 2023 02:15:22 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ppt3ddbq4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Apr 2023 02:15:22 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3332FHwn010318;
        Mon, 3 Apr 2023 02:15:22 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3ppt3ddbn7-5;
        Mon, 03 Apr 2023 02:15:22 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Kashyap Desai <kashyap.desai@broadcom.com>,
        Danila Chernetsov <listdansp@mail.ru>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH] megaraid: fix mega_cmd_done CMDID_INT_CMDS
Date:   Sun,  2 Apr 2023 22:15:06 -0400
Message-Id: <168031383550.650124.3607695758145488001.b4-ty@oracle.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230317175109.18585-1-listdansp@mail.ru>
References: <20230317175109.18585-1-listdansp@mail.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-31_07,2023-03-31_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=589 mlxscore=0 adultscore=0
 suspectscore=0 spamscore=0 malwarescore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304030015
X-Proofpoint-GUID: nSfa-wpXjBmTB-zhJbY39ib101M6EPIi
X-Proofpoint-ORIG-GUID: nSfa-wpXjBmTB-zhJbY39ib101M6EPIi
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Mar 2023 17:51:09 +0000, Danila Chernetsov wrote:

> When cmdid == CMDID_INT_CMDS, the 'cmds' pointer is NULL but is dereferenced below.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> 

Applied to 6.4/scsi-queue, thanks!

[1/1] megaraid: fix mega_cmd_done CMDID_INT_CMDS
      https://git.kernel.org/mkp/scsi/c/75cb113cd43f

-- 
Martin K. Petersen	Oracle Linux Engineering
