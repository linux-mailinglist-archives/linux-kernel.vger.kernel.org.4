Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4928A6F5541
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 11:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbjECJuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 05:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbjECJtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 05:49:21 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8184D4EE3
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 02:49:17 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230503094914epoutp0209fdac08647da92393ce868e239ab36f~bmTix7KWw0248602486epoutp02H
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 09:49:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230503094914epoutp0209fdac08647da92393ce868e239ab36f~bmTix7KWw0248602486epoutp02H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1683107354;
        bh=y34C25Juy+kpYmPl3eAQRnfua1qUExV+Pj6UnTKVf6U=;
        h=Subject:Reply-To:From:To:Date:References:From;
        b=p50avasmz+ou4RCNlEWD29CjwXOTzFoMslEiujIjA2roruoDv3LoVCEabxFNkydtV
         JjviLDBwbhrYi6e97QqH5aE6aCJkuWuYneUdoMzwfwuqfQGIZfkK6JF7o6sMpyRtme
         YzkbOCCLfHq+qGlV/WPEP6JPEpvhgiG3XUvu+eRk=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20230503094913epcas2p3d0e602b2ac018dd7b6d06868adaa52d2~bmTiFzuu02311423114epcas2p3I;
        Wed,  3 May 2023 09:49:13 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.102]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4QBBx51krZz4x9Pv; Wed,  3 May
        2023 09:49:13 +0000 (GMT)
X-AuditID: b6c32a46-b23fd7000001438d-cc-64522e19e3d8
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        26.DA.17293.91E22546; Wed,  3 May 2023 18:49:13 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH 00/15] Change the integrity configuration method in block
Reply-To: j-young.choi@samsung.com
Sender: Jinyoung CHOI <j-young.choi@samsung.com>
From:   Jinyoung CHOI <j-young.choi@samsung.com>
To:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "kch@nvidia.com" <kch@nvidia.com>,
        "johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230503094912epcms2p4bef206eab1c41a92eba2583a69c74323@epcms2p4>
Date:   Wed, 03 May 2023 18:49:12 +0900
X-CMS-MailID: 20230503094912epcms2p4bef206eab1c41a92eba2583a69c74323
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBJsWRmVeSWpSXmKPExsWy7bCmma6kXlCKwbzLbBar7/azWbw8pGmx
        cvVRJove/q1sFotubGOy+Nt1j8li0qFrjBZPr85isth7S9vi8q45bBbzlz1lt+i+voPNYvnx
        f0wW616/Z7H4/WMOmwO/x/l7G1k8Nq/Q8rh8ttRj06pONo8Jiw4wemxeUu+x+2YDm0dv8zs2
        j49Pb7F49G1ZxejxeZOcR/uBbqYAnqhsm4zUxJTUIoXUvOT8lMy8dFsl7+B453hTMwNDXUNL
        C3MlhbzE3FRbJRefAF23zBygZ5QUyhJzSoFCAYnFxUr6djZF+aUlqQoZ+cUltkqpBSk5BeYF
        esWJucWleel6eaklVoYGBkamQIUJ2Rn/Nu1hLFgmWzFzyk2WBsZO8S5GTg4JAROJT2eesXUx
        cnEICexglDj0ayKQw8HBKyAo8XeHMEiNsICnxLklN5hAbCEBJYlza2YxgpQICxhI3Oo1Bwmz
        CehJ/FwyA2yMiEA/q0T3g5usEPN5JWa0P2WBsKUlti/fyghha0j8WNbLDGGLStxc/ZYdxn5/
        bD5UjYhE672zUDWCEg9+7oaKS0ocOvQV7EwJgXyJDQcCIcI1Em+XH4Aq0Ze41rGRBeITX4kV
        u9RAwiwCqhJdq1dBXeMisXjDHrCvmAXkJba/ncMMUs4soCmxfpc+xHBliSO3WCAq+CQ6Dv9l
        h/mpYeNvrOwd854wQbSqSSxqMoIIy0h8PTwfqsRDYvLuFywTGBVnIQJ5FpITZiGcsICReRWj
        WGpBcW56arFRgRE8XpPzczcxgpO0ltsOxilvP+gdYmTiYDzEKMHBrCTC+6HQL0WINyWxsiq1
        KD++qDQntfgQoynQ8xOZpUST84F5Iq8k3tDE0sDEzMzQ3MjUwFxJnFfa9mSykEB6Yklqdmpq
        QWoRTB8TB6dUA1PhW7Xrmul/V0Q/CrpSelmp7iqr3uE8rse/LJsqY9pEhDw0Fczu+hZVcK9P
        urv08s+KlK8b+FgiLJXk5pXemvn2nozrjlzOJzFL9+RX3c6zbH+RZPDrsdIF1/NCVTzHX50Q
        VXn88+I26b3LhUyKPsw8uX2tVrt47IWlx3jcNu9qDl20cb9R2z7ty513Cnq69pyfx7oj/vrC
        8+FPLbKDH7bGPf4WY7ZX4/Dh/9Yn1vCHHH+/f13IpWlL+ZkWTGdZcXRJR5OdgJNTsPDyjRUq
        LvMq471+le6ryFpbqdzcyRryWvWV3hlH1VYVT/ZX/e9+9+i0Fh9d737l2RkFt48fFv559u0o
        r33sugQRvY9//yoosRRnJBpqMRcVJwIA53sSilsEAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230503094912epcms2p4bef206eab1c41a92eba2583a69c74323
References: <CGME20230503094912epcms2p4bef206eab1c41a92eba2583a69c74323@epcms2p4>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
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


Jinyoung Choi (15):
  block: bio: rename page_is_mergeable to bio_page_is_mergeable and make
    non-static
  block: blk-integiry: add helper functions for bio_integrity_add_page
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

 block/bio-integrity.c         | 106 +++++++++++++++++++++------
 block/bio.c                   |   8 +--
 block/blk-integrity.c         | 132 +++++++++-------------------------
 block/blk-merge.c             |  66 +++++++++++++++--
 block/blk.h                   |   7 ++
 drivers/nvme/host/rdma.c      |   2 +-
 drivers/scsi/scsi_lib.c       |  67 ++++++++---------
 include/linux/bio.h           |   7 ++
 include/linux/blk-integrity.h |  10 ++-
 include/linux/blk-mq.h        |   5 ++
 include/linux/bvec.h          |   6 ++
 11 files changed, 251 insertions(+), 165 deletions(-)

-- 
2.34.1
