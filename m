Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9058C63E882
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 04:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiLADqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 22:46:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbiLADpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 22:45:53 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 640E5975C3;
        Wed, 30 Nov 2022 19:45:53 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B133ci4022994;
        Thu, 1 Dec 2022 03:45:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2022-7-12;
 bh=Dao7V3IuXK/uUwxH2RR0W6oduC9JIaRrwYoUs+wXEz8=;
 b=1noYF0ehCIatEx8MI7LzafNpatLzaJr9NY8t21RtBoE64kOwDfXcVvY/j4ZdYbBJ9c9I
 zdpb7Hkv7wDonDQ7NzLiWITxSXTGj1z/q2Ky5rLxptD6LwultTMSu7KOENLisjBUDvmq
 iftz4/po6SaRkBgyw4pCLMGhuHoRhk0tBuhAxMGwKDrXRtbo7XTkQFcJ21S0B/QwW8vT
 IQxs1oWPPT/9YxwW+7Z1BtDdqVWLLCHL4femDd1vpOu1uOJwVWUgG5VEoH7LOZnikamJ
 xKEQvGkgV7ShxrVQ2V0IoucoSmqWBTHLqaVxW4PRv75drWgQpNLqx7Mf3wUp4iwWpQ6H tQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m40y43enu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Dec 2022 03:45:41 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2B13f2ut007584;
        Thu, 1 Dec 2022 03:45:41 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3m398a2cme-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Dec 2022 03:45:41 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2B13jbpS033801;
        Thu, 1 Dec 2022 03:45:40 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3m398a2cjs-4;
        Thu, 01 Dec 2022 03:45:40 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Chen Zhongjin <chenzhongjin@huawei.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        jejb@linux.ibm.com, bprakash@broadcom.com, robert.w.love@intel.com,
        James.Bottomley@suse.de, hare@suse.de, yi.zou@intel.com
Subject: Re: [PATCH] scsi: fcoe: Fix transport not deattached when fcoe_if_init() fails
Date:   Thu,  1 Dec 2022 03:45:05 +0000
Message-Id: <166986602287.2101055.16563015716609057451.b4-ty@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221115092442.133088-1-chenzhongjin@huawei.com>
References: <20221115092442.133088-1-chenzhongjin@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-01_02,2022-11-30_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 mlxscore=0 bulkscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212010022
X-Proofpoint-GUID: cARE2Ej_Z9qBbv-L-e_6MkauMeaEfnTB
X-Proofpoint-ORIG-GUID: cARE2Ej_Z9qBbv-L-e_6MkauMeaEfnTB
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Nov 2022 17:24:42 +0800, Chen Zhongjin wrote:

> fcoe_init() calls fcoe_transport_attach(&fcoe_sw_transport), but when
> fcoe_if_init() fails, &fcoe_sw_transport is not detached and leave freed
> &fcoe_sw_transport on list fcoe_transports, which causes panic when
> reinserting module.
> 
>  BUG: unable to handle page fault for address: fffffbfff82e2213
>  RIP: 0010:fcoe_transport_attach+0xe1/0x230 [libfcoe]
>  Call Trace:
>   <TASK>
>   do_one_initcall+0xd0/0x4e0
>   load_module+0x5eee/0x7210
>   ...
> 
> [...]

Applied to 6.2/scsi-queue, thanks!

[1/1] scsi: fcoe: Fix transport not deattached when fcoe_if_init() fails
      https://git.kernel.org/mkp/scsi/c/4155658cee39

-- 
Martin K. Petersen	Oracle Linux Engineering
