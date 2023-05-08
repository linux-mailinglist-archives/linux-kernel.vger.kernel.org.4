Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC406FAFFB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 14:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234103AbjEHM3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 08:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233921AbjEHM27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 08:28:59 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A22A348B9;
        Mon,  8 May 2023 05:28:32 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 348BIuRE023878;
        Mon, 8 May 2023 12:28:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-03-30;
 bh=xX7OkT3Wy1v+v8Bd6b9U2qjd+1LkoLd1Tej/Y8WV88A=;
 b=Z4pcEAIv5s3a9ykGOASrNUoUz04N2gClgtqPAIht/559WLfVbxkgM8jOGnuqvvxdPN/v
 F+mcRbBSLQp6V3TJhadJYKKT0LSBaG1/rYdVJ7LhiGDR2VX3zmx26TnGQBwzA+RN7r2u
 mVxln5TrtpaO2xk8r2HBmrLVCuNZ/NTQTTbak2CGUOp2fDb2nxOgSQMBSGYjGwplFGNT
 +LrhZrB+FcJ6NiSJ3G6uKcBif9LCrpFFeFVfdsIeR9DZUvV/MIQDeoffFf8a44WwVXbM
 ywbrfBoe4uNUC/NNRof7T2bzWEF4rwXNRPj9ciQERaf+43OnlfMaRWa/hkAMlOZI5HYt 7g== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qddae36v3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 May 2023 12:28:00 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 348C3pF1037151;
        Mon, 8 May 2023 12:27:59 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qddbawf61-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 May 2023 12:27:59 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 348CRxdA005826;
        Mon, 8 May 2023 12:27:59 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3qddbawf5r-1;
        Mon, 08 May 2023 12:27:59 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     ALIM AKHTAR <alim.akhtar@samsung.com>, avri.altman@wdc.com,
        bvanassche@acm.org, jejb@linux.ibm.com, beanhuo@micron.com,
        stanley.chu@mediatek.com, quic_asutoshd@quicinc.com,
        adrian.hunter@intel.com, quic_cang@quicinc.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Keoseong Park <keosung.park@samsung.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH] scsi: ufs: core: Fix IO hang that occurs when BKOPS fails in W-LUN suspend
Date:   Mon,  8 May 2023 08:27:53 -0400
Message-Id: <168354877576.1978546.983925828646920853.b4-ty@oracle.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230425031721epcms2p5d4de65616478c967d466626e20c42a3a@epcms2p5>
References: <CGME20230425031721epcms2p5d4de65616478c967d466626e20c42a3a@epcms2p5> <20230425031721epcms2p5d4de65616478c967d466626e20c42a3a@epcms2p5>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-08_08,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305080085
X-Proofpoint-GUID: FcABskfox0u87KDbkPCXSi53Brq-mqVM
X-Proofpoint-ORIG-GUID: FcABskfox0u87KDbkPCXSi53Brq-mqVM
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Apr 2023 12:17:21 +0900, Keoseong Park wrote:

> Even when urgent BKOPS fails, the consumer will get stuck in runtime
> suspend status. Like commit 1a5665fc8d7a ("scsi: ufs: core: WLUN suspend
> SSU/enter hibern8 fail recovery"), trigger the error handler and return
> -EBUSY to break the suspend.
> 
> 

Applied to 6.4/scsi-fixes, thanks!

[1/1] scsi: ufs: core: Fix IO hang that occurs when BKOPS fails in W-LUN suspend
      https://git.kernel.org/mkp/scsi/c/1a7edd041f2d

-- 
Martin K. Petersen	Oracle Linux Engineering
