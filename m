Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0D7672747B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 03:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbjFHBmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 21:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232320AbjFHBmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 21:42:37 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EBF82113;
        Wed,  7 Jun 2023 18:42:36 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 357LbFmG005557;
        Thu, 8 Jun 2023 01:42:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-03-30;
 bh=zZ5To+aD24C9VXbcPsTs1VfEhFDNKc8or82dflmX6p4=;
 b=UwMdM93IggkPGjcJM4iYGSvwXM3L4+AgvKKW3jPM/8gJJHIYo8aO74fbTYt9dku6OI/h
 eMHf1F3r7uA+eRFRp0loP0hSGEAYGEcHaDKQUY7KxbnzWqMcuLy5K9n8Iamm+SFDY6Qu
 ysMibq5Lv9PXDUFPreexj9C0kGqebLsvjvJcbBHMlaEWvpKf3N2dFY0nucXZjB7o8CC8
 v76QjbEWsB53GCRUls44Y+0VSeKSfn9gC0kbgbxIQfE4zRO62aMdADCR70Lh/9ALMDVB
 xuF+aerCpkIY3uC5jHNaRC76+E8/y28bOAgQt+kA80GXhAq5OMUVo3Pa5BrVGhVE1SSu VQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r2a6sk7jg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Jun 2023 01:42:28 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35801Haj037367;
        Thu, 8 Jun 2023 01:42:27 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r2a6hyt3v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Jun 2023 01:42:27 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3581gQUd031871;
        Thu, 8 Jun 2023 01:42:26 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3r2a6hyt3a-1;
        Thu, 08 Jun 2023 01:42:26 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        Avri Altman <avri.altman@wdc.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Keoseong Park <keosung.park@samsung.com>,
        "Bao D . Nguyen" <quic_nguyenb@quicinc.com>,
        Bean Huo <beanhuo@micron.com>,
        Stanley Chu <stanley.chu@mediatek.com>
Subject: Re: [PATCH v3] scsi: ufs: core: Do not open code SZ_x
Date:   Wed,  7 Jun 2023 21:42:05 -0400
Message-Id: <168618844261.2636448.13104798896337222496.b4-ty@oracle.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230531070009.4593-1-avri.altman@wdc.com>
References: <20230531070009.4593-1-avri.altman@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-07_13,2023-06-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 adultscore=0 mlxlogscore=538 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306080011
X-Proofpoint-GUID: bk-cUTpfz39Ohi3m7NmvSXJBBzv0Cdw7
X-Proofpoint-ORIG-GUID: bk-cUTpfz39Ohi3m7NmvSXJBBzv0Cdw7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 May 2023 10:00:09 +0300, Avri Altman wrote:

> v2 -> v3: few more
> v1 -> v2: Attend UTMRD as well
> 
> A tad cleanup - No functional change.
> 
> 

Applied to 6.5/scsi-queue, thanks!

[1/1] scsi: ufs: core: Do not open code SZ_x
      https://git.kernel.org/mkp/scsi/c/23caa33d36e7

-- 
Martin K. Petersen	Oracle Linux Engineering
