Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0686DEAE3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 07:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjDLFQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 01:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjDLFQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 01:16:56 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED3441BD9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 22:16:51 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230412051644epoutp01c443b6bb49bdc413d575fa6d3d594563~VGCnvevu80418504185epoutp01U
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 05:16:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230412051644epoutp01c443b6bb49bdc413d575fa6d3d594563~VGCnvevu80418504185epoutp01U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1681276604;
        bh=b0Tl3wa1A0rsyeO1OYkPsDbplQjwdowp8kNaOSgtlvc=;
        h=Subject:Reply-To:From:To:Date:References:From;
        b=LrQXJKbze31urzXZTdZsyJjyC/4bcY1UC1t8RCjUmdSD9ZaBusXC1ZD1v2E7RkOgd
         izEvcq/GFyMC8iIYjfHbtzVg7dklKbVtAxv0Ogb9q6UXsZi3W980yv/Z/qp7Lv/7jU
         NfB55l+As47uAvdQ+FRI0I/e1yxGyxKU/PiqBih0=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20230412051643epcas2p48563904c3edf7f1cee2ea3f40804209f~VGCm8veog1406114061epcas2p4V;
        Wed, 12 Apr 2023 05:16:43 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.100]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4Px9tM0kt0z4x9Py; Wed, 12 Apr
        2023 05:16:43 +0000 (GMT)
X-AuditID: b6c32a45-e13fa700000026e9-c6-64363eba8ae4
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        AD.76.09961.ABE36346; Wed, 12 Apr 2023 14:16:42 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH 0/2] Fix NVMe metadata mapping size for integrity
Reply-To: j-young.choi@samsung.com
Sender: Jinyoung CHOI <j-young.choi@samsung.com>
From:   Jinyoung CHOI <j-young.choi@samsung.com>
To:     "kbusch@kernel.org" <kbusch@kernel.org>,
        "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "chaitanya.kulkarni@wdc.com" <chaitanya.kulkarni@wdc.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230412051642epcms2p648d91f72aba5647bbccd6d4d6333224e@epcms2p6>
Date:   Wed, 12 Apr 2023 14:16:42 +0900
X-CMS-MailID: 20230412051642epcms2p648d91f72aba5647bbccd6d4d6333224e
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGJsWRmVeSWpSXmKPExsWy7bCmhe5uO7MUg14fi/97jrFZzLr9msXi
        5SFNi5WrjzJZ9PZvZbOYdOgao8XlXXPYLOYve8puse71exYHTo+Jze/YPc7f28jisWlVJ5vH
        5iX1HrtvNrB59G1ZxejxeZOcR/uBbqYAjqhsm4zUxJTUIoXUvOT8lMy8dFsl7+B453hTMwND
        XUNLC3MlhbzE3FRbJRefAF23zByg45QUyhJzSoFCAYnFxUr6djZF+aUlqQoZ+cUltkqpBSk5
        BeYFesWJucWleel6eaklVoYGBkamQIUJ2RkvlnUzFzwVqNjbv4KxgXEjbxcjJ4eEgIlE98UZ
        bF2MXBxCAjsYJW4enM/UxcjBwSsgKPF3hzBIjbCAo8SMNZ/ZQWwhASWJc2tmMYKUCAsYSNzq
        NQcJswnoSfxcAjFGROAik0Rb1wtmiPm8EjPan7JA2NIS25dvZYSwNSR+LOuFqhGVuLn6LTuM
        /f7YfKgaEYnWe2ehagQlHvzcDRWXlDh06CsbyA0SAvkSGw4EQoRrJN4uPwBVoi9xrWMjC8Qn
        vhLH7+eCmCwCqhKLp0VDNLpIbH/sClLMLCAvsf3tHGaQMLOApsT6XfoQFcoSR26xQFTwSXQc
        /ssO81HDxt9Y2TvmPWGCaFWTWNRkBBGWkfh6eD5UiYfE9hf3mScwKs5CBPEsJCfMQjhhASPz
        Kkax1ILi3PTUYqMCQ3isJufnbmIEJ1At1x2Mk99+0DvEyMTBeIhRgoNZSYT3h4tpihBvSmJl
        VWpRfnxRaU5q8SFGU6DXJzJLiSbnA1N4Xkm8oYmlgYmZmaG5kamBuZI4r7TtyWQhgfTEktTs
        1NSC1CKYPiYOTqkGppQns4qE30S8f7XKcl1jefmuLZvFfqZWGrLNePOrhP9bpciOsgu2dZLX
        f0z2zQu6kPAmLvNXpJBa3j1G3dWbZ7wMWpL15pFO2NWpm/YaLxZJPqOR/K1248125dzu5nkv
        XkZP9nqZ+KVOlsl222KZiY8fF+rb2FWVvpp8bcmRaVe6GkNmXfwW+7zdaXWobcCiIu9P72/O
        +1nFdORzGsPZvHT+qbaFomnPKneE1qybM/nake8nzf4oXLZvOZ4mf7jQqdtI9928isNcUa/W
        aC73td3qXR1fOcV6wTer3nnrFNWzdt2539EcHWJxMZL/tYtW6detTivSBawl+uad3LSeYc70
        bXOt7T3cZ/hm7Tov8FSJpTgj0VCLuag4EQAhNEtSKQQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230412051642epcms2p648d91f72aba5647bbccd6d4d6333224e
References: <CGME20230412051642epcms2p648d91f72aba5647bbccd6d4d6333224e@epcms2p6>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

To solve this problem, DMA mapping for metadata was modified to use the 
total segment size of the integrity payload.


Tested like this:

- Format (support pi type 1)
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

Jinyoung Choi (2):
  blk-integrity: add rq_integrity_payload_size helper
  nvme-pci: fix metadata mapping length

 drivers/nvme/host/pci.c       | 9 ++++++---
 include/linux/blk-integrity.h | 7 +++++++
 2 files changed, 13 insertions(+), 3 deletions(-)

-- 
2.34.1
