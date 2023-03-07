Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1654B6AD51F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 03:58:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbjCGC6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 21:58:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbjCGC6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 21:58:02 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB7A2128;
        Mon,  6 Mar 2023 18:57:53 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32700IAn029304;
        Tue, 7 Mar 2023 02:57:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2022-7-12;
 bh=7U0kR+2e79TDlFgol8jLjZ5PHGpEjxFPrCjy398oFpQ=;
 b=lkATJR0/76E6tcpMOZ+rsEAQjbaFNJ/rpAJHlrAvdYXV3Dhx6DVZijd6Y+XKcZ7UuVSK
 wMBGKEMw+Ezow3LlOJ/lqmswa+dLVCVogISPeu6EPSrWvbyWsVbPER+x5XtbwtaIo3lj
 crDC4BwJTOwS5UGiMKpIeulaXCXPuJPDVRQlC6aA6mmg/PsXYqzVlQGPaSavtqPsyZ33
 0Qh1A1guIIse0O0Y8cZrGY0MY3ASyJyjv0Eskk2PVYNObvGGJVb5+j5Shzn6FhYI2vFb
 hzmVxKWDJ4mLd7Pa9QD5PYCAVJq8HeeBZ+NTyWElHlnIhD65NO0MIxtMYHOUCs0Vnc7f FQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p416wmgra-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Mar 2023 02:57:45 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32700GNv037244;
        Tue, 7 Mar 2023 02:57:44 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3p4txdvjmk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Mar 2023 02:57:44 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3272vY2U009567;
        Tue, 7 Mar 2023 02:57:43 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3p4txdvjhj-11;
        Tue, 07 Mar 2023 02:57:43 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     chenxiang66@hisilicon.com, void0red <void0red@gmail.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        jejb@linux.ibm.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: hisi_sas: add a check of devm_add_action
Date:   Mon,  6 Mar 2023 21:57:28 -0500
Message-Id: <167815780199.2075334.1059001900446855576.b4-ty@oracle.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230227031030.893324-1-void0red@gmail.com>
References: <20230227031030.893324-1-void0red@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-06_14,2023-03-06_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 spamscore=0 suspectscore=0 mlxlogscore=596 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303070025
X-Proofpoint-GUID: AWOmCdhxfz4geou5ffJ-84xafhvOtAgK
X-Proofpoint-ORIG-GUID: AWOmCdhxfz4geou5ffJ-84xafhvOtAgK
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Feb 2023 11:10:30 +0800, void0red wrote:

> devm_add_action may fails, check it in the caller of
> interrupt_preinit_v3_hw
> 
> 

Applied to 6.3/scsi-fixes, thanks!

[1/1] scsi: hisi_sas: add a check of devm_add_action
      https://git.kernel.org/mkp/scsi/c/06d1a90de602

-- 
Martin K. Petersen	Oracle Linux Engineering
