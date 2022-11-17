Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 018D362E433
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 19:30:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240555AbiKQS3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 13:29:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240558AbiKQS3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 13:29:43 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB4DE7D526;
        Thu, 17 Nov 2022 10:29:41 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AHIG5xF007355;
        Thu, 17 Nov 2022 18:29:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2022-7-12;
 bh=JPMPTfz7K9f6mDuxr+LFJWJnWVhDsa757l2ZlNixbZk=;
 b=lSHjI8snXgXqE6QwKKm3N8wFuhCY/8V7JEB/BQWDgyixwnjfedcjVT60BXuGiDMPxQ12
 BfQCLyG47pAmoR2LcWtZqE2bSyuA9zWsrl08u6qeX0a0tfVsosbzSSOPazendsztvS/y
 P69fsgh5Sxs9DjXiUQ/pvG3g3j6YjxVDaVRulkF9Eqp20Rml+fPVRtJKKmLLx4ZOnyb+
 GSakyDXA4e2HRxDkaFtE2jEYdEYZNYUXpZ8pcZuLOeGrKwzBHI6PtSOnM4p6vjupbre2
 O6WCHKNb1qe8oXxIOK8JkKtBb7HeR1LSDB5Eb7uxvOdd4pZCEF/b7IO5myS1SAi0KBah 1g== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kv3nsa6nc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Nov 2022 18:29:41 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AHHGvNH010928;
        Thu, 17 Nov 2022 18:29:38 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ku3kab0j6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Nov 2022 18:29:38 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AHITap7022894;
        Thu, 17 Nov 2022 18:29:38 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3ku3kab0gb-4;
        Thu, 17 Nov 2022 18:29:38 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        target-devel@vger.kernel.org, linux-scsi@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/30] scsi: target: Use kstrtobool() instead of strtobool()
Date:   Thu, 17 Nov 2022 13:29:26 -0500
Message-Id: <166870943121.1584889.4599233741385053270.b4-ty@oracle.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <fcddc0a53b4fc6e3c2e93592d3f61c5c63121855.1667336095.git.christophe.jaillet@wanadoo.fr>
References: <cover.1667336095.git.christophe.jaillet@wanadoo.fr> <fcddc0a53b4fc6e3c2e93592d3f61c5c63121855.1667336095.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-17_06,2022-11-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 mlxlogscore=793 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211170133
X-Proofpoint-GUID: Nx_0uRD_ksQGd6oLrSoCM54btoW8tEoC
X-Proofpoint-ORIG-GUID: Nx_0uRD_ksQGd6oLrSoCM54btoW8tEoC
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Nov 2022 22:13:52 +0100, Christophe JAILLET wrote:

> strtobool() is the same as kstrtobool().
> However, the latter is more used within the kernel.
> 
> In order to remove strtobool() and slightly simplify kstrtox.h, switch to
> the other function name.
> 
> While at it, include the corresponding header file (<linux/kstrtox.h>)
> 
> [...]

Applied to 6.2/scsi-queue, thanks!

[04/30] scsi: target: Use kstrtobool() instead of strtobool()
        https://git.kernel.org/mkp/scsi/c/e56ca6bcd213

-- 
Martin K. Petersen	Oracle Linux Engineering
