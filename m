Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 563F2705CF6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 04:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbjEQCO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 22:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231699AbjEQCOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 22:14:21 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55E3559C8;
        Tue, 16 May 2023 19:13:49 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34GJx2XU021272;
        Wed, 17 May 2023 02:13:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-03-30;
 bh=CXyQ8Fo4IiXCzUc04LPR4rXIORsuxYswCO1d/5DoClg=;
 b=0sST0apDl/Uts6XKNl09SNQeaZsPG56p9e0xvZ4QhxACGH82sk8+2/UdEpaZaip+Vclc
 /1JkCpQ6EsiNxOko/98LNYCSFmHX2jhP+1F7VlZkZgqd6f8vjaMpLimebZroW2SKyHVm
 Y6YD4ChCgU51uuFw88seLNG9O1B/BVvCDmiBvMVLfsmNU18qtOuMXjwqqDey33UPkGxt
 fp7K1pd3i6GAIWPv57+fLo2xiNeJOnEVj6Xfn6l1WKatmGUQ8BxLuenvkUAEkSD3vx28
 hL/bOafiXOmuvGAxHlV3YyBqL8u8aUo9GpW5ZIKGBniiJFpfEEvAZN76KU+T93CvLPVd BA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj0ye4fyh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 May 2023 02:13:35 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34H28whR039972;
        Wed, 17 May 2023 02:13:34 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qj104k9tx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 May 2023 02:13:34 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34H29qF1039460;
        Wed, 17 May 2023 02:13:33 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3qj104k9sf-1;
        Wed, 17 May 2023 02:13:33 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        Ming Lei <ming.lei@redhat.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Wenchao Hao <haowenchao2@huawei.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linfeilong@huawei.com, louhongxiang@huawei.com
Subject: Re: [PATCH 0/2] Fix kernel panic in scsi_queue_rq()
Date:   Tue, 16 May 2023 22:13:25 -0400
Message-Id: <168428957882.722389.18154929061006608111.b4-ty@oracle.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230515070156.1790181-1-haowenchao2@huawei.com>
References: <20230515070156.1790181-1-haowenchao2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-16_14,2023-05-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 mlxscore=0 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=846
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305170017
X-Proofpoint-ORIG-GUID: gmMatbxBKrwdJBITFgLEo1s6fhE-dPDd
X-Proofpoint-GUID: gmMatbxBKrwdJBITFgLEo1s6fhE-dPDd
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 May 2023 15:01:54 +0800, Wenchao Hao wrote:

> 'cfee29ffb45b ("scsi: core: Do not increase scsi_device's iorequest_cnt
> if dispatch failed")' introduce bug which would cause kernel panic.
> 
> So revert the changes and fix the origin issue by decreasing the
> iorequest_cnt if scsi_dispatch_cmd return failed.
> 
> Wenchao Hao (2):
>   Revert "scsi: core: Do not increase scsi_device's iorequest_cnt if
>     dispatch failed"
>   scsi: core: decrease scsi_device's iorequest_cnt if dispatch failed
> 
> [...]

Applied to 6.4/scsi-fixes, thanks!

[1/2] Revert "scsi: core: Do not increase scsi_device's iorequest_cnt if dispatch failed"
      https://git.kernel.org/mkp/scsi/c/6ca9818d1624
[2/2] scsi: core: decrease scsi_device's iorequest_cnt if dispatch failed
      https://git.kernel.org/mkp/scsi/c/09e797c8641f

-- 
Martin K. Petersen	Oracle Linux Engineering
