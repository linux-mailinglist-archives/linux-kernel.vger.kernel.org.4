Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97DDC6D3BC8
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 04:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbjDCCUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 22:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbjDCCUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 22:20:36 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 703FB975A;
        Sun,  2 Apr 2023 19:20:34 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 332JQ2J8032355;
        Mon, 3 Apr 2023 02:20:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2022-7-12;
 bh=M83xCCAav4aIaX8tNS0qm17EMRh0do46y6l0uv2a1gY=;
 b=V+cO7viFxvow2BC8x5NN93bdCZ7CZr3qKAzfHEc0C3yftol67Em6KkqMXDbJZDYrcAeP
 nTRj0xnRoIllZsDAra5pwD/SGIIY5mbUAsW4FmAeewD6RT6+tPYBIOZ17B/3WLrY0/fg
 LHAFbresY0xU5VqBcjsJQ0EkK+OkcWT/8/k01d9c4pbpVZT5XOLrKlBsvNLMqH7VoU6Y
 hKVzC1YdQJ2e8Qa36YiIJikDNQhHiU4VRZk1mAgmzbeLzEyU3lg1r9XDl3JtqF1UMQCM
 3bSDiOu+kLwt0VaAwiF3gdt8070LOJGUhkbS3Y0PGk2BHQ7yxvLlISDiq3XVFSIppHB1 6g== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ppd5u9yrh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Apr 2023 02:20:20 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 332MSYol017420;
        Mon, 3 Apr 2023 02:20:19 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pptp4n16m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Apr 2023 02:20:19 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3332COOr008162;
        Mon, 3 Apr 2023 02:20:19 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3pptp4n164-2;
        Mon, 03 Apr 2023 02:20:19 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     njavali@marvell.com, GR-QLogic-Storage-Upstream@marvell.com,
        jejb@linux.ibm.com, himanshu.madhani@cavium.com,
        quinn.tran@cavium.com, Li Zetao <lizetao1@huawei.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: qla2xxx: Fix memory leak in qla2x00_probe_one()
Date:   Sun,  2 Apr 2023 22:20:13 -0400
Message-Id: <168048838488.1036111.13697550630186382375.b4-ty@oracle.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230325110004.363898-1-lizetao1@huawei.com>
References: <20230325110004.363898-1-lizetao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-31_07,2023-03-31_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 mlxlogscore=818 bulkscore=0 malwarescore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304030015
X-Proofpoint-ORIG-GUID: MxCRClGOhhW6gbp85Y07uZQyFeQw86A9
X-Proofpoint-GUID: MxCRClGOhhW6gbp85Y07uZQyFeQw86A9
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Mar 2023 11:00:04 +0000, Li Zetao wrote:

> There is a memory leak reported by kmemleak:
> 
>   unreferenced object 0xffffc900003f0000 (size 12288):
>     comm "modprobe", pid 19117, jiffies 4299751452 (age 42490.264s)
>     hex dump (first 32 bytes):
>       00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>       00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     backtrace:
>       [<00000000629261a8>] __vmalloc_node_range+0xe56/0x1110
>       [<0000000001906886>] __vmalloc_node+0xbd/0x150
>       [<000000005bb4dc34>] vmalloc+0x25/0x30
>       [<00000000a2dc1194>] qla2x00_create_host+0x7a0/0xe30 [qla2xxx]
>       [<0000000062b14b47>] qla2x00_probe_one+0x2eb8/0xd160 [qla2xxx]
>       [<00000000641ccc04>] local_pci_probe+0xeb/0x1a0
> 
> [...]

Applied to 6.3/scsi-fixes, thanks!

[1/1] scsi: qla2xxx: Fix memory leak in qla2x00_probe_one()
      https://git.kernel.org/mkp/scsi/c/85ade4010e13

-- 
Martin K. Petersen	Oracle Linux Engineering
