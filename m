Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21AA26083FF
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 05:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbiJVDx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 23:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbiJVDx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 23:53:29 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F28B42A17C5;
        Fri, 21 Oct 2022 20:53:11 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29M1ubAY029618;
        Sat, 22 Oct 2022 03:52:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2022-7-12;
 bh=zDLk3KCxSw4UnrqVOv86DnnU1UxZF0zhNvPLcpjdBYw=;
 b=aEedYY4HQV4dWshx1UgTRGSUcGXbdW+/rL0qhy+xqvA4BeQdUiIPS9U7sIkq4aoQzVNy
 tF2FQmboDkEwvyDV4bidiiGcSLbN9wsDvdzbObbz74kfv1kbLThrT0VA0YezuN4PIrTq
 ERBiCVg1mhjEJkPwn66QBfiqVTlWayC4Mt76o4mtpMXCr3z9lMKab5bcrx6C21LIcGNA
 e87tZXPJ6OWA4lb1rHfn5epww5n7BGE80U8eXiYL8S6+lPD/IXnFQwPJJMcRRJt4f7oZ
 muEYYkKbRpE5dxRfjEZhhGWn9/JHTwVKmqF80I7jP9Z2Oh+lSt2egUmRGP/7g/WLhoTd tg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kc7a2r2dv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 22 Oct 2022 03:52:30 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29M1Xv7x016347;
        Sat, 22 Oct 2022 03:52:30 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kc6y8hk8g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 22 Oct 2022 03:52:29 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29M3qOMS004796;
        Sat, 22 Oct 2022 03:52:29 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3kc6y8hk7g-8;
        Sat, 22 Oct 2022 03:52:29 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     jejb@linux.ibm.com, Jason Yan <yanaijie@huawei.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        bvanassche@acm.org, jinpu.wang@cloud.ionos.com,
        john.garry@huawei.com, linux-kernel@vger.kernel.org, hch@lst.de,
        damien.lemoal@opensource.wdc.com, linux-scsi@vger.kernel.org,
        hare@suse.com
Subject: Re: [PATCH v6 0/8] scsi: libsas: sas address comparison refactor
Date:   Fri, 21 Oct 2022 23:52:23 -0400
Message-Id: <166641056342.3488251.7015455910614190900.b4-ty@oracle.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220928070130.3657183-1-yanaijie@huawei.com>
References: <20220928070130.3657183-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-21_04,2022-10-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210220021
X-Proofpoint-GUID: B-PPyugGFeAIRl9LU05bRWzLGwIrTIY1
X-Proofpoint-ORIG-GUID: B-PPyugGFeAIRl9LU05bRWzLGwIrTIY1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Sep 2022 15:01:22 +0800, Jason Yan wrote:

> Sas address conversion and comparison is widely used in libsas and
> drivers. However they are all opencoded and to avoid the line spill over
> 80 columns, are mostly split into multi-lines.
> 
> To make the code easier to read, introduce some helpers with clearer
> semantics and replace the opencoded segments with them.
> 
> [...]

Applied to 6.2/scsi-queue, thanks!

[1/8] scsi: libsas: introduce sas address comparison helpers
      https://git.kernel.org/mkp/scsi/c/773792e4e704
[2/8] scsi: libsas: introduce sas_find_attached_phy_id() helper
      https://git.kernel.org/mkp/scsi/c/2d08f329a4f2
[3/8] scsi: pm8001: use sas_find_attached_phy_id() instead of open coded
      https://git.kernel.org/mkp/scsi/c/ec64858657a8
[4/8] scsi: mvsas: use sas_find_attached_phy_id() instead of open coded
      https://git.kernel.org/mkp/scsi/c/178c39d94ac2
[5/8] scsi: hisi_sas: use sas_find_attathed_phy_id() instead of open coded
      https://git.kernel.org/mkp/scsi/c/f0ed7bd5d913
[6/8] scsi: libsas: use sas_phy_match_dev_addr() instead of open coded
      https://git.kernel.org/mkp/scsi/c/ad74d1dadbe9
[7/8] scsi: libsas: use sas_phy_addr_match() instead of open coded
      https://git.kernel.org/mkp/scsi/c/bfa22905f386
[8/8] scsi: libsas: use sas_phy_match_port_addr() instead of open coded
      https://git.kernel.org/mkp/scsi/c/868a8824838f

-- 
Martin K. Petersen	Oracle Linux Engineering
