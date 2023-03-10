Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 565DB6B3488
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 04:10:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbjCJDKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 22:10:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbjCJDKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 22:10:01 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D75F7865;
        Thu,  9 Mar 2023 19:09:58 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 329LxV0u014050;
        Fri, 10 Mar 2023 03:09:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2022-7-12;
 bh=CQWnYAhmMylUWjWmg0wImYoQBUmvOmoVEkuhsvwzK7w=;
 b=FACNlqUe28XUg0idY+8FMpswdKZmWyZVUYHzSZ2FghBt8DfxueCefjhlKvkLD8q2meU1
 CC7pWdmvTe08+grGSYbbt0poxVtjp7wr5nLDXWqrs18TngXJM3DaFgsdE+dQSeeSGnxt
 X9ZhZT7ZxH0IK0Y8SdfsyOlyFBhgmRPFv7KX8BcQLaQCpNslSwX6uafJUTlGOxQY+X2F
 3Cw7JKRNM0awEypq3aJ1dwBrAtBC/GgJjOYAdbtXZOK3bc0hy8M9SSg0fCuzR/BbZbCf
 +89VPEWdhzt+WGwB4L38x6nLFwvagArSwxb5rxa3eiogWqR74DUxSo0sYtZXezAZCvpp ug== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p418y4d5k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Mar 2023 03:09:48 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32A0GpBB020978;
        Fri, 10 Mar 2023 03:09:47 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3p6fuac8kd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Mar 2023 03:09:47 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32A39kGM002714;
        Fri, 10 Mar 2023 03:09:47 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3p6fuac8k1-2;
        Fri, 10 Mar 2023 03:09:47 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Sathya Prakash <sathya.prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Wenchao Hao <haowenchao2@huawei.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linfeilong@huawei.com
Subject: Re: [PATCH] scsi: mpt3sas: fix NULL pointer access in mpt3sas_transport_port_add()
Date:   Thu,  9 Mar 2023 22:09:39 -0500
Message-Id: <167841768711.2362238.13612858875249629020.b4-ty@oracle.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230225100135.2109330-1-haowenchao2@huawei.com>
References: <20230225100135.2109330-1-haowenchao2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-09_14,2023-03-09_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 suspectscore=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303100022
X-Proofpoint-GUID: s3qOZvPQjbHplWpjKPpFEk9V20IBx_qo
X-Proofpoint-ORIG-GUID: s3qOZvPQjbHplWpjKPpFEk9V20IBx_qo
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Feb 2023 18:01:36 +0800, Wenchao Hao wrote:

> port is allocated by sas_port_alloc_num() and rphy is allocated by
> sas_end_device_alloc() or sas_expander_alloc() which may return NULL,
> so we need to check the rphy to avoid possible NULL pointer access.
> 
> If sas_rphy_add() called with failure rphy is set to NULL, we would
> access the rphy in next lines which would also result NULL pointer
> access.
> 
> [...]

Applied to 6.3/scsi-fixes, thanks!

[1/1] scsi: mpt3sas: fix NULL pointer access in mpt3sas_transport_port_add()
      https://git.kernel.org/mkp/scsi/c/d3c57724f156

-- 
Martin K. Petersen	Oracle Linux Engineering
