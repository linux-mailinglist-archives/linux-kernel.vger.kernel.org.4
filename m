Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCCCF6FD9CD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 10:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236375AbjEJIoQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 04:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjEJIoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 04:44:15 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B0FAA
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 01:44:11 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230510084409epoutp04e68f893b71e03ca1a4a2e318baf7c4ec~du7tk4MUC2000920009epoutp04b
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 08:44:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230510084409epoutp04e68f893b71e03ca1a4a2e318baf7c4ec~du7tk4MUC2000920009epoutp04b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1683708249;
        bh=tAUq+j8EFp9wNJLVYSWcrdn/ApjcBvFZlh9RLdWUG7I=;
        h=Subject:Reply-To:From:To:Date:References:From;
        b=MWMgaVYlXihfT/rwPOIiiOoLM/ut/4PfVguwspKk73ohVg0BsNladBI+o8whRzE8u
         cE536U/QmGmBg+s8Px+GUFp2rDqs37h/KYGNrLPjEnap53x7v1SQASe7oqTVxUG2hM
         r2VDGK6cqubpzoz/y95LGgLZ5+aVi136ap2xEwac=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20230510084408epcas2p13848402d1760f70a20b32a4ef2aca3e9~du7tBLdKB0623706237epcas2p1z;
        Wed, 10 May 2023 08:44:08 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.90]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4QGT8m0wdvz4x9Q1; Wed, 10 May
        2023 08:44:08 +0000 (GMT)
X-AuditID: b6c32a48-475ff70000005998-5b-645b5957ce54
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        C3.15.22936.7595B546; Wed, 10 May 2023 17:44:08 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH v2 00/14] Change the integrity configuration method in block
Reply-To: j-young.choi@samsung.com
Sender: Jinyoung CHOI <j-young.choi@samsung.com>
From:   Jinyoung CHOI <j-young.choi@samsung.com>
To:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>,
        "kch@nvidia.com" <kch@nvidia.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230510084407epcms2p123f17696d3c30c749897eeaf2c4de684@epcms2p1>
Date:   Wed, 10 May 2023 17:44:07 +0900
X-CMS-MailID: 20230510084407epcms2p123f17696d3c30c749897eeaf2c4de684
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNJsWRmVeSWpSXmKPExsWy7bCmuW5EZHSKwc2bzBar7/azWbw8pGmx
        cvVRJove/q1sFotubGOy+Nt1j8li0qFrjBZPr85isth7S9vi8q45bBbLj/9jslj3+j2Lxe8f
        c9gceD3O39vI4rF5hZbH5bOlHptWdbJ5TFh0gNFj980GNo/e5ndsHh+f3mLx6NuyitHj8yY5
        j/YD3UwB3FHZNhmpiSmpRQqpecn5KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJuam2Si4+Abpu
        mTlA5ysplCXmlAKFAhKLi5X07WyK8ktLUhUy8otLbJVSC1JyCswL9IoTc4tL89L18lJLrAwN
        DIxMgQoTsjMW/HzOUtAoV3Fu0zvGBsaz4l2MnBwSAiYS3Ud2s3YxcnEICexglJi96xBjFyMH
        B6+AoMTfHcIgNcICPhJ/9q1lA7GFBJQkzq2ZBVYiLGAgcavXHCTMJqAn8XPJDDaQMSICvSwS
        d06fZ4GYzysxo/0plC0tsX35VkYIW0Pix7JeZghbVOLm6rfsMPb7Y/OhakQkWu+dhaoRlHjw
        czdUXFLi0KGvbCA3SAjkS2w4EAgRrpF4u/wAVIm+xLWOjWBreQV8JQ7//Q42nkVAVeLo9tlQ
        I10kvk39BmYzC8hLbH87hxlkJLOApsT6XfoQ05Uljtxigajgk+g4/Jcd5qmGjb+xsnfMe8IE
        0aomsajJCCIsI/H18HyoEg+J93dWMk1gVJyFCOVZSE6YhXDCAkbmVYxiqQXFuempxUYFJvCI
        Tc7P3cQITsVaHjsYZ7/9oHeIkYmD8RCjBAezkgivd2hUihBvSmJlVWpRfnxRaU5q8SFGU6Dn
        JzJLiSbnA7NBXkm8oYmlgYmZmaG5kamBuZI478cO5RQhgfTEktTs1NSC1CKYPiYOTqkGpvXz
        Axjzl50UnHCu///1K7UGX7wa9/O8qt40YdH1CWaMcXcOZzyNFFr2xbjambXpBVO+0nrvHr7q
        nW0br1j9nOU09+iZ3zGyEVO7Ur8tcU1+rT/lYBFfWqHUppf/DRyYX2kfTZE+PKO/2iqadaWM
        hK2D8Ry+x4vfJlseyOKWX189L2rOgu8Cb+c3sh2/HvrZZyprOoPjBS09K1uFXxGHTZ/fW+rk
        fya1Z2HDfiPFZvnt/ubxz1o3PRLoyVF1q3e9yqMotezeJ+mnHMZf7a89n3h7h0/gjH8ln+eX
        273P32F65YdsgtLajXeXravxrmDnmCffzXLL8FltT0Gy29P1F+pbQx4rPH2zpSdV5YvpBiWW
        4oxEQy3mouJEAEBWb41OBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230510084407epcms2p123f17696d3c30c749897eeaf2c4de684
References: <CGME20230510084407epcms2p123f17696d3c30c749897eeaf2c4de684@epcms2p1>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the case of NVMe, it has an integrity payload consisting of one segment.
So, rather than configuring SG_LIST, it was changed by direct DMA mapping.

The page-merge is not performed for the struct bio_vec when creating 
a integrity payload in block.
As a result, when creating an integrity paylaod beyond one page, each 
struct bio_vec is generated, and its bv_len does not exceed the PAGESIZE.

To solve it, bio_integrity_add_page() should just add to the existing 
bvec, similar to bio_add_page() and friends. 
As the bip configuration changed, the code related to sg_list was
also modified.

(ref: https://lore.kernel.org/linux-nvme/yq18rewbmay.fsf@ca-mkp.ca.oracle.com/T/#t)


Tested like this:

- Format (support pi)
$ sudo nvme format /dev/nvme2n1 --force -n 1 -i 1 -p 0 -m 0 -l 1 -r

- Run FIO
[global]
ioengine=libaio
group_reporting

[job]
bs=512k
iodepth=256
rw=write
numjobs=8
direct=1
runtime=10s
filename=/dev/nvme2n1

- Result
...
[   93.496218] nvme2n1: I/O Cmd(0x1) @ LBA 62464, 1024 blocks, I/O Error (sct 0x2 / sc 0x82) MORE
[   93.496227] protection error, dev nvme2n1, sector 62464 op 0x1:(WRITE) flags 0x18800 phys_seg 3 prio class 2
[   93.538788] nvme2n1: I/O Cmd(0x1) @ LBA 6144, 1024 blocks, I/O Error (sct 0x2 / sc 0x82) MORE
[   93.538798] protection error, dev nvme2n1, sector 6144 op 0x1:(WRITE) flags 0x18800 phys_seg 3 prio class 2
[   93.566231] nvme2n1: I/O Cmd(0x1) @ LBA 124928, 1024 blocks, I/O Error (sct 0x0 / sc 0x4)
[   93.566241] I/O error, dev nvme2n1, sector 124928 op 0x1:(WRITE) flags 0x18800 phys_seg 3 prio class 2
[   93.694147] nvme2n1: I/O Cmd(0x1) @ LBA 64512, 1024 blocks, I/O Error (sct 0x2 / sc 0x82) MORE
[   93.694155] protection error, dev nvme2n1, sector 64512 op 0x1:(WRITE) flags 0x18800 phys_seg 3 prio class 2
[   93.694299] nvme2n1: I/O Cmd(0x1) @ LBA 5120, 1024 blocks, I/O Error (sct 0x2 / sc 0x82) MORE
[   93.694305] protection error, dev nvme2n1, sector 5120 op 0x1:(WRITE) flags 0x18800 phys_seg 3 prio class 2
...


Changes to v1:
- Add tag to fix patches 
- Unification of the page merge process of data and integrity
- Solve the build failure when CONFIG_BLK_DEV_INTEGRITY is disabled


Jinyoung Choi (14):
  block: bio: separation to reuse a part of the function
  block: bio-integrity: modify bio_integrity_add_page()
  block: bio-integiry: cleanup bio_integrity_prep
  block: fix not to apply bip information in blk_rq_bio_prep()
  block: blk-merge: fix to add the number of integrity segments to the
    request twice
  block: blk-merge: fix merging two requests in ll_merge_requests_fn
  block: add helper function to get the number of integrity segments
  scsi: add scsi_alloc_integrity_sgtables() for integrity process
  scsi: change to use blk_rq_nr_integrity_segments() instead of
    blk_rq_count_integrity_sg()
  block: blk-integrity: change how to find the number of integrity of
    bio
  nvme: rdma: change how to find the number of integrity of request
  block: add helper function for iteration of bip's bvec
  block: blk-integrity: change sg-table configuration method for
    integrity
  block: blk-integrity: remove blk_rq_count_integrity_sg()

 block/bio-integrity.c         |  73 +++++++++++++------
 block/bio.c                   |  87 ++++++++++++++--------
 block/blk-integrity.c         | 132 +++++++++-------------------------
 block/blk-merge.c             |  68 ++++++++++++++++--
 block/blk.h                   |  20 ++++++
 drivers/nvme/host/rdma.c      |   2 +-
 drivers/scsi/scsi_lib.c       |  67 ++++++++---------
 include/linux/bio.h           |   4 ++
 include/linux/blk-integrity.h |  10 ++-
 include/linux/blk-mq.h        |   5 ++
 include/linux/bvec.h          |   6 ++
 11 files changed, 284 insertions(+), 190 deletions(-)

-- 
2.34.1
