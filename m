Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFE136C874D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 22:07:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232251AbjCXVHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 17:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232081AbjCXVHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 17:07:30 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A18FB206B5;
        Fri, 24 Mar 2023 14:07:24 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32OL4GHL006330;
        Fri, 24 Mar 2023 21:07:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2022-7-12;
 bh=NCjvrc7Wpz+DaegJFn5Jy0vVWEJp5qfRagdUGDd7FO4=;
 b=fUO29j0/kd4uZ9gB1qSdSiF13vgKmOmjcWrF4TlTMdHCYjnraOtvtt5il8a3PV3sQTNk
 9Z+Ma8E+b1gsEewN+lqb/Yag/NeT2KUyullJiozFm31eQwCDqdorrWV5Ev6HJHrCRVP3
 GiMtXds4hCzsSBM1r0S87ea4XR/x18EcP1dKV3XWx2QZOazmTHQecfPLKnd40DbJbyEo
 vBtMT3Yj7l9BQecMalwLmDRR+PK37OuUDT+oPlZz5PJnllXQ7L88dGTeFhwD2fyTqwHL
 XaAIaFpi5euGT+3yWPJDmQ9v75TiXpY/JpRJxc+yPtIQR9cbuOymvpMn4Agycg4LkK4X tA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3phkey806p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Mar 2023 21:07:07 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32OIn276027708;
        Fri, 24 Mar 2023 21:07:06 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pgxk4se31-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Mar 2023 21:07:06 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32OL76f2017159;
        Fri, 24 Mar 2023 21:07:06 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3pgxk4se2p-1;
        Fri, 24 Mar 2023 21:07:06 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Satish Kharat <satishkh@cisco.com>,
        Sesidhar Baddela <sebaddel@cisco.com>,
        Karan Tilak Kumar <kartilak@cisco.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: Re: [PATCH v1 1/1] scsi: fnic: Switch to use %ptTs
Date:   Fri, 24 Mar 2023 17:06:52 -0400
Message-Id: <167969123959.59527.3782523368342950875.b4-ty@oracle.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230314145813.66112-1-andriy.shevchenko@linux.intel.com>
References: <20230314145813.66112-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 spamscore=0 mlxlogscore=644 adultscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303240160
X-Proofpoint-GUID: q-XnmCuVyNHroP0HSjgFeA6ZBTsbiACk
X-Proofpoint-ORIG-GUID: q-XnmCuVyNHroP0HSjgFeA6ZBTsbiACk
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Mar 2023 16:58:13 +0200, Andy Shevchenko wrote:

> Use %ptTs instead of open-coded variant to print contents
> of time64_t type in human readable form.
> 
> 

Applied to 6.4/scsi-queue, thanks!

[1/1] scsi: fnic: Switch to use %ptTs
      https://git.kernel.org/mkp/scsi/c/58b42c949b30

-- 
Martin K. Petersen	Oracle Linux Engineering
