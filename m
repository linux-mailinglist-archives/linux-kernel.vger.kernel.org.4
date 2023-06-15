Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A41A5730D17
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 04:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241100AbjFOCQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 22:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238317AbjFOCQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 22:16:36 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D8E11BE8;
        Wed, 14 Jun 2023 19:16:35 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35EKJ3Jo021119;
        Thu, 15 Jun 2023 02:16:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-03-30;
 bh=AdkWYI7NNESNqwM1JoBBeU02ine8N/+vT2OqCf2mekg=;
 b=yUEt/TYY9EvVM1apDd3VFbtZpNR1LIvzy87NlI/UH+XNsDpdxlP7YeYxHMEOHYSfnCO7
 eD0lVhsQ4PhGn1qkAUlQH5sWEmrUhIpKkrCzpg20E63s9qdmrB8dikyechFEqpjKKqsp
 Ch6jTVmGwsq/RBML79JPOyB8PSXsO5TqUaVTmdw800jPFJoKMGSRNmFX5PFpmqNCsxvZ
 N5mZHFgQjK6pxVtqPkCi13vlwFWpKEaSYleRddUopTxixwvrC53RSGSCi+xcwFaoL1Dm
 +9GCYkcfoPWTA+eRUK/bIBURBOHVuPziislyt18B+I+d5Wma1G6Bw8Vc5GWR2w3ndOBx cQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4fkdrsq6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Jun 2023 02:16:29 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35ENrXI7016344;
        Thu, 15 Jun 2023 02:16:29 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fm6bnxe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Jun 2023 02:16:29 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35F2EE7H027953;
        Thu, 15 Jun 2023 02:16:28 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3r4fm6bnx8-2;
        Thu, 15 Jun 2023 02:16:28 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Nilesh Javali <njavali@marvell.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        GR-QLogic-Storage-Upstream@marvell.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [RESEND][PATCH][next] Replace one-element array with DECLARE_FLEX_ARRAY() helper
Date:   Wed, 14 Jun 2023 22:16:21 -0400
Message-Id: <168679535179.3778526.8210116739672829202.b4-ty@oracle.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <ZH+/rZ1R1cBjIxjS@work>
References: <ZH+/rZ1R1cBjIxjS@work>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-14_14,2023-06-14_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=957 bulkscore=0 mlxscore=0
 spamscore=0 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306150017
X-Proofpoint-ORIG-GUID: -aMQgYbIVKTx5uXcCiyAFp25AY7k3SIV
X-Proofpoint-GUID: -aMQgYbIVKTx5uXcCiyAFp25AY7k3SIV
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 06 Jun 2023 17:22:21 -0600, Gustavo A. R. Silva wrote:

> One-element arrays as fake flex arrays are deprecated and we are moving
> towards adopting C99 flexible-array members, instead. So, replace
> one-element array declaration in struct ct_sns_gpnft_rsp, which is
> ultimately being used inside a union:
> 
> drivers/scsi/qla2xxx/qla_def.h:
> 3240 struct ct_sns_gpnft_pkt {
> 3241         union {
> 3242                 struct ct_sns_req req;
> 3243                 struct ct_sns_gpnft_rsp rsp;
> 3244         } p;
> 3245 };
> 
> [...]

Applied to 6.5/scsi-queue, thanks!

[1/1] Replace one-element array with DECLARE_FLEX_ARRAY() helper
      https://git.kernel.org/mkp/scsi/c/512a365368c7

-- 
Martin K. Petersen	Oracle Linux Engineering
