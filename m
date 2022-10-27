Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 961F760EE31
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 04:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234114AbiJ0C7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 22:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234078AbiJ0C64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 22:58:56 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF391413A2;
        Wed, 26 Oct 2022 19:58:55 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29QMGwml028121;
        Thu, 27 Oct 2022 02:58:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2022-7-12;
 bh=GOdvbBCviV+sUKkS/mhYvVLY7+zai9D1QExdE/q30PI=;
 b=jCwYTw9cnusBk82WWT+gpM+JYaxR17dtJwiI5SYniby4oGtfpc4EMH+YJkUVOjU+4k3X
 MKwkfRPrX/pyCsEcsqEWksNFDzRF0TDUz5+a87nJ0Kj++7I0wzFhmGDbJ5PF4h+ii11B
 3nJT1Gdo4vNcgOTbOxI4gKk0qdrfcWokAh9qU9N4+if8FMiBUSFk/T0FQ2O/Pq44cHaL
 /iFoZ8BiPClRRF7mM07EBru5NwBhgwz1BQ1XpXY9DSZ02bgthByv27YxErCkIfVbASjZ
 cWVZ4xAH/btyXIY6wtIy5scyK5fmk53xzEYBSqefTgBpCE9Douay24fW1K6oES8cmpSC +Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kfawrrrub-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Oct 2022 02:58:39 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29QLr9Ua006690;
        Thu, 27 Oct 2022 02:58:38 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kfaggh3ha-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Oct 2022 02:58:38 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29R2wWsf007945;
        Thu, 27 Oct 2022 02:58:38 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3kfaggh3fk-5;
        Thu, 27 Oct 2022 02:58:37 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     jejb@linux.ibm.com, John Garry <john.garry@huawei.com>,
        jinpu.wang@cloud.ionos.com, damien.lemoal@wdc.com
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linuxarm@huawei.com, linux-scsi@vger.kernel.org,
        ipylypiv@google.com, hare@suse.de, changyuanl@google.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/7] scsi: libsas: Use request tag in more drivers
Date:   Wed, 26 Oct 2022 22:58:30 -0400
Message-Id: <166683942540.3791741.16087477264542244957.b4-ty@oracle.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <1666091763-11023-1-git-send-email-john.garry@huawei.com>
References: <1666091763-11023-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-26_10,2022-10-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 suspectscore=0 phishscore=0 adultscore=0 mlxscore=0 mlxlogscore=852
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210270015
X-Proofpoint-ORIG-GUID: 4oEJSaqQyNlo1T6IS3HIxFQxL-cvlntn
X-Proofpoint-GUID: 4oEJSaqQyNlo1T6IS3HIxFQxL-cvlntn
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Oct 2022 19:15:56 +0800, John Garry wrote:

> Currently hisi_sas is the only libsas driver which uses the request tag
> for per-HW IO tag.
> 
> All other libsas drivers manage the tags internally. Tag management in
> pm8001 and mvsas is currently using a simple bitmap, so use the request
> tag when available there. With this change we still need to manage tags
> for libsas "internal" commands, like SMP commands, and any other
> private commands so reserve some tags for this:
> - For pm8001 I went with pre-existing and unused PM8001_RESERVE_SLOT size.
>   The value is 8, which should be enough. It is greater than mvsas, below,
>   but this driver sends a lot of other private commands to HW.
> - For mvsas I went with 4, which still should be enough.
> 
> [...]

Applied to 6.2/scsi-queue, thanks!

[1/7] scsi: libsas: Add sas_task_find_rq()
      https://git.kernel.org/mkp/scsi/c/a9ee3f840646
[2/7] scsi: hisi_sas: Use sas_task_find_rq()
      https://git.kernel.org/mkp/scsi/c/295fd2330a91
[3/7] scsi: hisi_sas: Put reserved tags in lower region of tagset
      https://git.kernel.org/mkp/scsi/c/f7d190a94e35
[4/7] scsi: pm8001: Remove pm8001_tag_init()
      https://git.kernel.org/mkp/scsi/c/1baa70d36403
[5/7] scsi: pm8001: Use sas_task_find_rq() for tagging
      https://git.kernel.org/mkp/scsi/c/6472cfb418a0
[6/7] scsi: mvsas: Delete mvs_tag_init()
      https://git.kernel.org/mkp/scsi/c/ffc9f9bf3f14
[7/7] scsi: mvsas: Use sas_task_find_rq() for tagging
      https://git.kernel.org/mkp/scsi/c/2acf97f199f9

-- 
Martin K. Petersen	Oracle Linux Engineering
