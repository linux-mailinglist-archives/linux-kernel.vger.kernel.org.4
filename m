Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2881363E872
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 04:45:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiLADpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 22:45:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiLADpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 22:45:49 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE1C9075D;
        Wed, 30 Nov 2022 19:45:49 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B12cw7b018211;
        Thu, 1 Dec 2022 03:45:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2022-7-12;
 bh=s2lKGcIDI4AmL3/WrisDPx/XVUZYFEjrbjDERtfxedM=;
 b=P25S1mwpy16V9MA7WRyiyP8PT5DsP73pv8MLMUvP3PyEkpJ/1UmJbg0l5z1nzMy1NGaR
 VTZJmYgCYfbr/ZnckCuNarizuf4ulQ6JYl+omFqjwZ8A0u3TDoYtRX3yvOmR0JoLBfYt
 wk5khozpbh8oVQpPbHPMtfw7FWP4bhxlz5EPXUrfWqoxh7hJRVEOBKKFdm66dbMXtJ2s
 F7pwrMXqMs3/dWvEkg/qkRibf/h80Ni3AOCzC5NqGG63TuopLXywTj7hS17U4iSmbrX9
 5XHDKdOfDtdxHLXsiqDrsaQoqkm9WlpmBk8BIi3eCJS8vpe05sLZTfnKR/ZLSjwhaq/k pg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m3xhtbnpx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Dec 2022 03:45:40 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2B13EhFO007601;
        Thu, 1 Dec 2022 03:45:40 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3m398a2cky-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Dec 2022 03:45:40 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2B13jbpQ033801;
        Thu, 1 Dec 2022 03:45:39 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3m398a2cjs-3;
        Thu, 01 Dec 2022 03:45:39 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org,
        Chen Zhongjin <chenzhongjin@huawei.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        jejb@linux.ibm.com, christophe.jaillet@wanadoo.fr, hare@suse.de,
        ram.vegesna@broadcom.com, dwagner@suse.de, james.smart@broadcom.com
Subject: Re: [PATCH] scsi: efct: Fix possible memleak in efct_device_init()
Date:   Thu,  1 Dec 2022 03:45:04 +0000
Message-Id: <166986602281.2101055.16297897704954452228.b4-ty@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221111074046.57061-1-chenzhongjin@huawei.com>
References: <20221111074046.57061-1-chenzhongjin@huawei.com>
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
X-Proofpoint-GUID: J-bSg6ItaaEh2IX5ayA29fee92Pd0m5N
X-Proofpoint-ORIG-GUID: J-bSg6ItaaEh2IX5ayA29fee92Pd0m5N
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Nov 2022 15:40:46 +0800, Chen Zhongjin wrote:

> In efct_device_init(), when efct_scsi_reg_fc_transport() fails,
> efct_scsi_tgt_driver_exit() is not called to release memory for
> efct_scsi_tgt_driver_init() and causes memleak:
> 
> unreferenced object 0xffff8881020ce000 (size 2048):
>   comm "modprobe", pid 465, jiffies 4294928222 (age 55.872s)
>   backtrace:
>     [<0000000021a1ef1b>] kmalloc_trace+0x27/0x110
>     [<000000004c3ed51c>] target_register_template+0x4fd/0x7b0 [target_core_mod]
>     [<00000000f3393296>] efct_scsi_tgt_driver_init+0x18/0x50 [efct]
>     [<00000000115de533>] 0xffffffffc0d90011
>     [<00000000d608f646>] do_one_initcall+0xd0/0x4e0
>     [<0000000067828cf1>] do_init_module+0x1cc/0x6a0
>     ...
> 
> [...]

Applied to 6.2/scsi-queue, thanks!

[1/1] scsi: efct: Fix possible memleak in efct_device_init()
      https://git.kernel.org/mkp/scsi/c/bb0cd225dd37

-- 
Martin K. Petersen	Oracle Linux Engineering
