Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6CC67DC9D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 04:23:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233150AbjA0DXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 22:23:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232911AbjA0DXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 22:23:17 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B382C658;
        Thu, 26 Jan 2023 19:23:16 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30R0NhhJ009755;
        Fri, 27 Jan 2023 03:23:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2022-7-12;
 bh=DJgZkt+8o4PSxDxhjOkwPEfcZ23jAKRDq/lWSjHAxa4=;
 b=VBaXQLYGaPQiVRmRhpMS+ezdlMgw5R8BBuNv/+oyg2jmHF1IYwlu+70nZjybPOOX8Xlp
 C16LxmY+RRF0V6MQ0+zzdymNQr4ctYnB1lh7Lp2bkiVx0HR2Q+wMz5bb/oxhQcyVmOTy
 az/7Ts8SUgAXlXKVno80DskiEdATRR7Rhi4cE1QknFnWSvvlxZ/FgqmDTAOVcwNNeb4X
 IiLSukDbSaczDVWdt2cNIDbWjcggI97jIeABtj2iP4bIZIGMNLvuX/MrBsezCOuQSjrA
 OkYUyRYulHrDdPwkS1IuKnXTzJLnvdK8HF3nYMNdVyoiK1TtI1nZEMzTB/wzjzWkMWvE Qg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n87ntbvmj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Jan 2023 03:23:11 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30R2PFHd006763;
        Fri, 27 Jan 2023 03:23:10 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n86g8nxr6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Jan 2023 03:23:10 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30R3N7ek036358;
        Fri, 27 Jan 2023 03:23:10 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3n86g8nxpp-4;
        Fri, 27 Jan 2023 03:23:10 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH] scsi: ips: Replace kmap_atomic() with kmap_local_page()
Date:   Thu, 26 Jan 2023 22:22:57 -0500
Message-Id: <167478863295.3972592.14451644723577572411.b4-ty@oracle.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230103173131.21259-1-fmdefrancesco@gmail.com>
References: <20230103173131.21259-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-26_09,2023-01-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 bulkscore=0 mlxscore=0 mlxlogscore=909 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301270029
X-Proofpoint-ORIG-GUID: NchIvqWr2A9iicrCHtcxXBLEq5K2q6UY
X-Proofpoint-GUID: NchIvqWr2A9iicrCHtcxXBLEq5K2q6UY
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 03 Jan 2023 18:31:31 +0100, Fabio M. De Francesco wrote:

> kmap_atomic() is deprecated in favor of kmap_local_page(). Therefore,
> replace kmap_atomic() with kmap_local_page() in ips_is_passthru(). In
> the meantime remove an unnecessary comment soon before local mapping,
> align code and remove spaces (the function is short, therefore the
> reviewers job won't be over-complicated by these logically unrelated
> clean-ups).
> 
> [...]

Applied to 6.3/scsi-queue, thanks!

[1/1] scsi: ips: Replace kmap_atomic() with kmap_local_page()
      https://git.kernel.org/mkp/scsi/c/7edd053b3327

-- 
Martin K. Petersen	Oracle Linux Engineering
