Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7CEB5BA4E3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 05:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbiIPDCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 23:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbiIPDCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 23:02:09 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A6598D21;
        Thu, 15 Sep 2022 20:02:05 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28G1x7XW004152;
        Fri, 16 Sep 2022 03:02:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2022-7-12;
 bh=9kFFqQZdJlfi8fk9MtgdWYfAQjp0OHCJwsm8IiKbfpc=;
 b=qbJTBPk+vLr+fa72JVHK12cvyv7rtomUJdniJx/z3nbvTAaYc+/hX0FXwtU3Avq9cGyF
 U64/kw9J2igY9zEIsHMXICrgch5heU6Qu+y1kPM2W+4xrHWmalXVxgUPLYnim5O+pL++
 a04Q3WX/bEpWNmm4s9QqVUPyIv3QoZJfYteMgAj3/3XjFp9O9oR5CF5nbxf9SfI3KuQ+
 JrvghAjejf2KX5TOpQYK9APvsOQYLZ/51QXvFk4BtOD7J0Pm5RfPxkkx9dJb7JbUdLq1
 wLvIK04G3u4F/Pg6e3SpmDsrISq5A0r0VVkwhwHO3HevX1oZaGouQtl5XoDZxv0XkRoE 8g== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jm8xah2vp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Sep 2022 03:02:02 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28G04bH1015932;
        Fri, 16 Sep 2022 03:02:01 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jm8x8pjwu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Sep 2022 03:02:01 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28G31xOZ014516;
        Fri, 16 Sep 2022 03:02:00 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3jm8x8pjv1-2;
        Fri, 16 Sep 2022 03:02:00 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Himanshu Madhani <himanshu.madhani@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Rafael Mendonca <rafaelmendsr@gmail.com>,
        Nilesh Javali <njavali@marvell.com>,
        Mike Christie <michael.christie@oracle.com>,
        GR-QLogic-Storage-Upstream@marvell.com
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: qla2xxx: Fix memory leak in __qlt_24xx_handle_abts()
Date:   Thu, 15 Sep 2022 23:01:56 -0400
Message-Id: <166329729478.12731.14401759516196987191.b4-ty@oracle.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220914024924.695604-1-rafaelmendsr@gmail.com>
References: <20220914024924.695604-1-rafaelmendsr@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-15_10,2022-09-14_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=711 phishscore=0
 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209160020
X-Proofpoint-GUID: oJG7VFHPGjJCkLcAu_pqbmZTlG92tkW-
X-Proofpoint-ORIG-GUID: oJG7VFHPGjJCkLcAu_pqbmZTlG92tkW-
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Sep 2022 23:49:24 -0300, Rafael Mendonca wrote:

> Commit 8f394da36a36 ("scsi: qla2xxx: Drop TARGET_SCF_LOOKUP_LUN_FROM_TAG")
> made the __qlt_24xx_handle_abts() function return early if
> tcm_qla2xxx_find_cmd_by_tag() doesn't find a command, but it missed to
> clean up the allocated memory for the management command in such a case.
> 
> 

Applied to 6.0/scsi-fixes, thanks!

[1/1] scsi: qla2xxx: Fix memory leak in __qlt_24xx_handle_abts()
      https://git.kernel.org/mkp/scsi/c/601be20fc6a1

-- 
Martin K. Petersen	Oracle Linux Engineering
