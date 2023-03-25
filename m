Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAEDA6C89DC
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 02:17:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbjCYBRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 21:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjCYBQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 21:16:58 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D09C66C;
        Fri, 24 Mar 2023 18:16:57 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32P154QH002515;
        Sat, 25 Mar 2023 01:16:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2022-7-12;
 bh=pRfUw1TcLkxrZYUseep4cpWIrPgTJqx/blEDFv8gWg4=;
 b=yVqI1zCAiuRUG5ZdLXhptvab6CNCl6CfIcTiJZY0890g4kBGoWRApBa4C+ccBPzavnD7
 ihIPhNQNnGiodI1gXg0tpUUJytk4cKTlbf/RuHesRWTFGvlUNvA1TA8JAzAhmNpVkvMW
 QO1Mmi071cistw+iBtolE+79g/CMtgyr0LrtIlQLN3YOC2nUhM082UPJkSDkdVcn56KQ
 8g/1BSk47AbqeGOVCSztRmTzDWbf54PKyEZ65yPnsHDpGaK6vsGmfsr2sN2A41tEAD7b
 A8uUMr++zahzKbxT/WYYrbNiKMiwCiOKViX4+uLpc1hZcwRYL/pVYCt3T2NYC4VhBe4H nw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3phpyu00dc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 25 Mar 2023 01:16:53 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32OMP3q4027817;
        Sat, 25 Mar 2023 01:16:52 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pgxk4xx6q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 25 Mar 2023 01:16:52 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32P1GpkA018222;
        Sat, 25 Mar 2023 01:16:51 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3pgxk4xx6j-1;
        Sat, 25 Mar 2023 01:16:51 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        MPT-FusionLinux.pdl@broadcom.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: Re: [PATCH v2] scsi: mpt3sas: Don't print sense pool info twice
Date:   Fri, 24 Mar 2023 21:16:44 -0400
Message-Id: <167970695940.326111.1002403744280234640.b4-ty@oracle.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230324193204.567932-1-jsnitsel@redhat.com>
References: <20230321061419.3139051-1-jsnitsel@redhat.com> <20230324193204.567932-1-jsnitsel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 adultscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303250007
X-Proofpoint-GUID: hBRYg6PkQVXnXGyPhSc1IpRSoxPgJ87d
X-Proofpoint-ORIG-GUID: hBRYg6PkQVXnXGyPhSc1IpRSoxPgJ87d
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Mar 2023 12:32:04 -0700, Jerry Snitselaar wrote:

> _base_allocate_sense_dma_pool() already prints out the sense pool
> information, so don't print it a second time after calling it in
> _base_allocate_memory_pools(). In addition the version in
> _base_allocate_memory_pools() was using the wrong size value, sz,
> which was last assigned when doing some nvme calculations instead of
> sense_sz to determine the pool size in kilobytes.
> 
> [...]

Applied to 6.3/scsi-fixes, thanks!

[1/1] scsi: mpt3sas: Don't print sense pool info twice
      https://git.kernel.org/mkp/scsi/c/d684a7a26f7d

-- 
Martin K. Petersen	Oracle Linux Engineering
