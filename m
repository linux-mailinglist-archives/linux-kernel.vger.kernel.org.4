Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5A9B6E7189
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 05:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232057AbjDSDWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 23:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232019AbjDSDVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 23:21:42 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99695901C;
        Tue, 18 Apr 2023 20:20:53 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33IM3dAK006913;
        Wed, 19 Apr 2023 03:20:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-03-30;
 bh=8xIN/BO/NVYgyZOjXSs5ZwdhmdJSG3UevPiURnOtt5k=;
 b=nkp+RiYX42oqShadTetzRH/HKUHOMhEVzzby0XfmgWgORhyszSFLMgowtVnn5qwu6JmY
 Yf57l61ru1XFkl5/qBXDthL8ZwX2OGm7hYXmtSUpHL9D6ZFy72qHIVr1DtTOnAS7QzxG
 N39ZuSEVZf15hUtyAWVVXBk1GRD76GNh4s7vd5KZNc+cQYmrhVRDsxoO2LI4kUqADkPj
 QY3EEiZs+oaTivOJzqV7V2wrMMsiYUwicf6yEXbvB2m2vxFc7Q4RFQFV3VuyfgSz+9LE
 trM8t4sAzadukKErr2Iw2uNDExHQqPonybbO0Xti+UyZUZSh8Ip6jiYMKMij5io3MVRm vA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q0768x882-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Apr 2023 03:20:23 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33J2RXh5037160;
        Wed, 19 Apr 2023 03:20:22 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pyjcccvu7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Apr 2023 03:20:22 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33J3KLp7012748;
        Wed, 19 Apr 2023 03:20:22 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3pyjcccvts-1;
        Wed, 19 Apr 2023 03:20:21 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Xiang Chen <chenxiang66@hisilicon.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Yihang Li <liyihang9@huawei.com>,
        Arnd Bergmann <arnd@kernel.org>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Arnd Bergmann <arnd@arndb.de>,
        John Garry <john.garry@huawei.com>,
        Xingui Yang <yangxingui@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: hisi_sas: work around build failure in suspend function
Date:   Tue, 18 Apr 2023 23:20:10 -0400
Message-Id: <168187437335.702980.6139661216307211988.b4-ty@oracle.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230405083611.3376739-1-arnd@kernel.org>
References: <20230405083611.3376739-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-18_17,2023-04-18_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=750 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304190029
X-Proofpoint-ORIG-GUID: 9nvouzzDWVfbCmmXaxdhChN9giGPqCBq
X-Proofpoint-GUID: 9nvouzzDWVfbCmmXaxdhChN9giGPqCBq
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 05 Apr 2023 10:36:04 +0200, Arnd Bergmann wrote:

> The suspend/resume functions in this driver seem to have multiple
> problems, the latest one just got introduced by a bugfix:
> 
> drivers/scsi/hisi_sas/hisi_sas_v3_hw.c: In function '_suspend_v3_hw':
> drivers/scsi/hisi_sas/hisi_sas_v3_hw.c:5142:39: error: 'struct dev_pm_info' has no member named 'usage_count'
>  5142 |         if (atomic_read(&device->power.usage_count)) {
> drivers/scsi/hisi_sas/hisi_sas_v3_hw.c: In function '_suspend_v3_hw':
> drivers/scsi/hisi_sas/hisi_sas_v3_hw.c:5142:39: error: 'struct dev_pm_info' has no member named 'usage_count'
>  5142 |         if (atomic_read(&device->power.usage_count)) {
> 
> [...]

Applied to 6.4/scsi-queue, thanks!

[1/1] scsi: hisi_sas: work around build failure in suspend function
      https://git.kernel.org/mkp/scsi/c/e01e2290f094

-- 
Martin K. Petersen	Oracle Linux Engineering
