Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48094696A85
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 17:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232876AbjBNQ7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 11:59:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232778AbjBNQ7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 11:59:08 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8044F28D3D;
        Tue, 14 Feb 2023 08:58:39 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31EGYFsY020177;
        Tue, 14 Feb 2023 16:57:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2022-7-12;
 bh=ihtAbqPCqrQZ8CiNugWy5gScZpQJPvgkqSJkSqZqKVs=;
 b=gfy1p7JyLYBuMPGFOhv+AI6JrD1Z7on/z1r3hiQpWBt6GCkW+jX5dEmJaL9m8JNzyv+f
 O8WQcMswOViWiLdMhZw4fnt1ci79HtgXF2m6ZzzBqfxIaLYJ1PF4PKQIB3N0G76/43+g
 sglDqeQQbgCgIsH9BRCO5sCItDwFC3irsJqK/m2qgn4pDhtUJDI2qKVXXg3A4ufwkP7j
 RjLGiEt3luAAk93lfeXOdPR+mtLY1ARmfUpWwaWZe5BTkslafA/5VigRy5Na8cHpL4E+
 SAi4N6OFjH+g9OP8jRJAb0Qp9993MmKFaZ6ZMNN+InXpshHkgkHOC7cqE+DfB8tPX9dY bw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3np3jtwwx1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Feb 2023 16:57:44 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31EGtkSM009613;
        Tue, 14 Feb 2023 16:57:43 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3np1f5uuhe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Feb 2023 16:57:43 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31EGuHol039739;
        Tue, 14 Feb 2023 16:57:42 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3np1f5uuff-6;
        Tue, 14 Feb 2023 16:57:42 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     yanaijie@huawei.com, Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        jejb@linux.ibm.com, john.garry@huawei.com, damien.lemoal@wdc.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: aic94xx: Add missing check for dma_map_single
Date:   Tue, 14 Feb 2023 11:57:32 -0500
Message-Id: <167639371130.486235.8805082530660354635.b4-ty@oracle.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230128110832.6792-1-jiasheng@iscas.ac.cn>
References: <20230128110832.6792-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-14_11,2023-02-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxscore=0 spamscore=0 mlxlogscore=708 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302140144
X-Proofpoint-ORIG-GUID: CCeuU4EKOLLoM8FjRl_1xSvZJnw-I6QW
X-Proofpoint-GUID: CCeuU4EKOLLoM8FjRl_1xSvZJnw-I6QW
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Jan 2023 19:08:32 +0800, Jiasheng Jiang wrote:

> Add check for dma_map_single and return error if it fails in order
> to avoid invalid dma address.
> 
> 

Applied to 6.3/scsi-queue, thanks!

[1/1] scsi: aic94xx: Add missing check for dma_map_single
      https://git.kernel.org/mkp/scsi/c/32fe45274edb

-- 
Martin K. Petersen	Oracle Linux Engineering
