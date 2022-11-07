Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8E8A61FB5A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 18:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231974AbiKGR2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 12:28:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232566AbiKGR2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 12:28:40 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C3D201BA;
        Mon,  7 Nov 2022 09:28:39 -0800 (PST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A7GM3Jw009625;
        Mon, 7 Nov 2022 17:28:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : content-type : content-transfer-encoding :
 mime-version; s=pp1; bh=IgGlGZGYc3SRutp12/MeehDn+EWQ3ENWU3VqTURQTVA=;
 b=HQ+l3usUreiR4M/+tqAL1NHSu7o0zC1lOMUxZ1lhL+k1C6J3oLTdxF5nPrszjCVFzRuA
 SVl4wL9Jd3QSwNlJZ6u8d9TkWWxT2q9mioE9UAnJtQsLweS/S8NvK79bayASHZZXqAcI
 vr2T+GuExpL//xreBPu9WUKZacBvjsx3A5fC9+L6VSvaDL4+oIYFUCrzK8ut9W0sGKkX
 U7BfZv3/Dtuywq1ltyh8GEJHYOqOewTJvwTE5D9cK02Kyy+JPnOn6q4lCMfZtD12L/ox
 02R0D0KRgpbfclpNZbASP1I4H6gUXCYPAEgjYZWjgBuTBt/8LUf8Yh65jAYhwbNg4hpj QA== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3kp1w8kmv9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Nov 2022 17:28:21 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A7HL9Jk011693;
        Mon, 7 Nov 2022 17:28:19 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3kngqdawv3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Nov 2022 17:28:19 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2A7HSH2j2884322
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 7 Nov 2022 17:28:17 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1AD2C11C050;
        Mon,  7 Nov 2022 17:28:17 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B24C411C04A;
        Mon,  7 Nov 2022 17:28:16 +0000 (GMT)
Received: from dilbert4 (unknown [9.171.88.237])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  7 Nov 2022 17:28:16 +0000 (GMT)
Message-ID: <fad4d2d5e24eabe1a4fcab75c5d080a6229dc88b.camel@linux.ibm.com>
Subject: nvme-pci: NULL pointer dereference in nvme_dev_disable() on
 linux-next
From:   Gerd Bayer <gbayer@linux.ibm.com>
To:     Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Cc:     Niklas Schnelle <schnelle@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        linux-nvme@lists.infradead.org
Date:   Mon, 07 Nov 2022 18:28:16 +0100
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -bi40E-Fsn90wTCZ25FrdaqF68kpOJw1
X-Proofpoint-ORIG-GUID: -bi40E-Fsn90wTCZ25FrdaqF68kpOJw1
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_08,2022-11-07_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=944 adultscore=0
 mlxscore=0 clxscore=1011 lowpriorityscore=0 bulkscore=0 impostorscore=0
 phishscore=0 priorityscore=1501 spamscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211070137
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

our internal s390 CI pointed us to a potential racy "use after free" or similar 
issue in drivers/nvme/host/pci.c by ending one of the tests in the following 
kernel panic:

[ 1836.550881] nvme nvme0: pci function 0004:00:00.0
[ 1836.563814] nvme nvme0: Shutdown timeout set to 15 seconds
[ 1836.569587] nvme nvme0: 63/0/0 default/read/poll queues
[ 1836.577114]  nvme0n1: p1 p2
[ 1861.856726] nvme nvme0: pci function 0004:00:00.0
[ 1861.869539] nvme nvme0: failed to mark controller CONNECTING
[ 1861.869542] nvme nvme0: Removing after probe failure status: -16
[ 1861.869552] Unable to handle kernel pointer dereference in virtual kernel address space
[ 1861.869554] Failing address: 0000000000000000 TEID: 0000000000000483
[ 1861.869555] Fault in home space mode while using kernel ASCE.
[ 1861.869558] AS:0000000135c4c007 R3:00000003fffe0007 S:00000003fffe6000 P:000000000000013d 
[ 1861.869587] Oops: 0004 ilc:3 [#1] SMP 
[ 1861.869591] Modules linked in: nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4
nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set nf_tables
nfnetlink mlx5_ib ib_uverbs uvdevice s390_trng ib_core vfio_ccw mdev vfio_iommu_type1 eadm_sch
 vfio sch_fq_codel configfs dm_service_time mlx5_core ghash_s390 prng chacha_s390 libchacha aes_s390 des_s390 libdes
sha3_512_s390 sha3_256_s390 sha512_s390 sha256_s390 sha1_s390 nvme sha_common nvme_core zfcp scsi_transport_fc
dm_multipath scsi_dh_rdac scsi_dh_emc scsi_dh_alua dm_mirror dm_region_hash dm_log pkey zcry
pt rng_core autofs4
[ 1861.869627] CPU: 4 PID: 2929 Comm: kworker/u800:0 Not tainted 6.1.0-rc3-next-20221104 #4
[ 1861.869630] Hardware name: IBM 3931 A01 701 (LPAR)
[ 1861.869631] Workqueue: nvme-reset-wq nvme_reset_work [nvme]
[ 1861.869637] Krnl PSW : 0704c00180000000 0000000134f026d0 (mutex_lock+0x10/0x28)
[ 1861.869643]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:0 PM:0 RI:0 EA:3
[ 1861.869646] Krnl GPRS: 0000000001000000 0000000000000000 0000000000000078 00000000a5f8c200
[ 1861.869648]            000003800309601c 0000000000000004 0000000000000000 0000000088e64220
[ 1861.869650]            0000000000000078 0000000000000000 0000000000000098 0000000088e64000
[ 1861.869651]            00000000a5f8c200 0000000088e641e0 00000001349bdac2 0000038003ea7c20
[ 1861.869658] Krnl Code: 0000000134f026c0: c0040008cfb8        brcl    0,000000013501c630
[ 1861.869658]            0000000134f026c6: a7190000            lghi    %r1,0
[ 1861.869658]           #0000000134f026ca: e33003400004        lg      %r3,832
[ 1861.869658]           >0000000134f026d0: eb1320000030        csg     %r1,%r3,0(%r2)
[ 1861.869658]            0000000134f026d6: ec160006007c        cgij    %r1,0,6,0000000134f026e2
[ 1861.869658]            0000000134f026dc: 07fe                bcr     15,%r14
[ 1861.869658]            0000000134f026de: 47000700            bc      0,1792
[ 1861.869658]            0000000134f026e2: c0f4ffffffe7        brcl    15,0000000134f026b0
[ 1861.869715] Call Trace:
[ 1861.869716]  [<0000000134f026d0>] mutex_lock+0x10/0x28 
[ 1861.869719]  [<000003ff7fc381d6>] nvme_dev_disable+0x1b6/0x2b0 [nvme] 
[ 1861.869722]  [<000003ff7fc3929e>] nvme_reset_work+0x49e/0x6a0 [nvme] 
[ 1861.869724]  [<0000000134309158>] process_one_work+0x200/0x458 
[ 1861.869730]  [<00000001343098e6>] worker_thread+0x66/0x480 
[ 1861.869732]  [<0000000134312888>] kthread+0x108/0x110 
[ 1861.869735]  [<0000000134297354>] __ret_from_fork+0x3c/0x58 
[ 1861.869738]  [<0000000134f074ea>] ret_from_fork+0xa/0x40 
[ 1861.869740] Last Breaking-Event-Address:
[ 1861.869741]  [<00000001349bdabc>] blk_mq_quiesce_tagset+0x2c/0xc0
[ 1861.869747] Kernel panic - not syncing: Fatal exception: panic_on_oops

On a stock kernel from
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tag/?h=next-20221104
we have been able to reproduce this at will with
this small script 

#!/usr/bin/env bash

echo $1 > /sys/bus/pci/drivers/nvme/unbind
echo $1 > /sys/bus/pci/drivers/nvme/bind
echo 1 > /sys/bus/pci/devices/$1/remove

when filling in the NVMe drives' PCI identifier.

We believe this to be a race-condition somewhere, since this sequence does not produce the panic
when executed interactively.

Could this be linked to the recent (refactoring) work by Christoph Hellwig?
E.g. https://lore.kernel.org/all/20221101150050.3510-3-hch@lst.de/

Thank you,
Gerd Bayer

