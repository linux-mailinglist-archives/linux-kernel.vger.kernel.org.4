Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA5E16B348A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 04:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbjCJDKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 22:10:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbjCJDKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 22:10:05 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 393CDF6B6D;
        Thu,  9 Mar 2023 19:10:04 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 329Lx1Vu003653;
        Fri, 10 Mar 2023 03:09:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2022-7-12;
 bh=jimVw0AlSDhC4fXTl20IJM9Uh4DeLuNxyQBbbJ8Pc1A=;
 b=1Xpu5qQk9UhWNfL44n4a8B5XvTrhx+z8lkgGmDhe/nI+6NFym5mZJ2vaDOTnEq2gkiCs
 wUeEmH/IbZ8HipKQ2cdWo2sXjIJJUtG8avq76n8tY7dc6X7RMJyqO7tlT6WaZlw+R/nC
 XwZFPKs+xsyjusFreMLMdkWf639r8mL3MH0Pegoc006vKM9XhXHN6POzLgEsyYD0w+FH
 Tu337UA8uXcsMH9KvNqcAAM+AwsYe9K+pN6cM6RA0rysnNPzGB7SptdLgdeKKEsYu/pN
 73h5CCBn3LauEtNVCfOWutdonE1qmgoFhDHhXNyBl11Bu9VmeWQBiAVDXgU+xfwaAmrH 7A== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p416wvc1w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Mar 2023 03:09:50 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32A2U9iC020757;
        Fri, 10 Mar 2023 03:09:49 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3p6fuac8kp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Mar 2023 03:09:49 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32A39kGO002714;
        Fri, 10 Mar 2023 03:09:48 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3p6fuac8k1-3;
        Fri, 10 Mar 2023 03:09:48 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     quic_cang@quicinc.com, Asutosh Das <quic_asutoshd@quicinc.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        quic_nguyenb@quicinc.com, quic_xiaosenh@quicinc.com,
        stanley.chu@mediatek.com, adrian.hunter@intel.com,
        bvanassche@acm.org, avri.altman@wdc.com, mani@kernel.org,
        beanhuo@micron.com, linux-scsi@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] scsi: ufs: mcq: Use active_reqs to check busy in clock scaling
Date:   Thu,  9 Mar 2023 22:09:40 -0500
Message-Id: <167841768716.2362238.2634161229367008812.b4-ty@oracle.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <a24e0d646aac70eae0fc5e05fac0c58bb7e6e680.1678317160.git.quic_asutoshd@quicinc.com>
References: <a24e0d646aac70eae0fc5e05fac0c58bb7e6e680.1678317160.git.quic_asutoshd@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-09_14,2023-03-09_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=932 adultscore=0
 phishscore=0 suspectscore=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303100022
X-Proofpoint-GUID: 1lnb3vPIZFL6Opb7s6IYxWkG02U6Am_7
X-Proofpoint-ORIG-GUID: 1lnb3vPIZFL6Opb7s6IYxWkG02U6Am_7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Mar 2023 15:13:23 -0800, Asutosh Das wrote:

> Multi Circular Queue doesn't use outstanding_reqs.
> But the ufs clock scaling functions use outstanding_reqs to
> determine if there're requests pending. When MCQ is enabled
> this check always returns false.
> 
> Hence use active_reqs to check if there're pending requests.
> 
> [...]

Applied to 6.3/scsi-fixes, thanks!

[1/1] scsi: ufs: mcq: Use active_reqs to check busy in clock scaling
      https://git.kernel.org/mkp/scsi/c/c6001025d53a

-- 
Martin K. Petersen	Oracle Linux Engineering
