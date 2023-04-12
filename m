Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74FD26DEB0A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 07:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjDLFZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 01:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjDLFZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 01:25:38 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F4E4EDA
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 22:25:09 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230412052444epoutp03072e1f813771697e7f355388e7fa5238~VGJnGUfvw1226212262epoutp03j
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 05:24:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230412052444epoutp03072e1f813771697e7f355388e7fa5238~VGJnGUfvw1226212262epoutp03j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1681277084;
        bh=v5oUq0SppcnCED62w1178jYoqlFl81B5r/ZCTfebK3s=;
        h=Subject:Reply-To:From:To:Date:References:From;
        b=lepOsG0GWxMn++duGTgxr26jCjHYAbSziTezcjXMMSw2lbWI8/btOCC1X6RGQNPCh
         hqII/M/hejWKhfkXRII3OOYO01VtYrBNX9oRYag250pnAjK+l1C6+i0VOM0btktar+
         8UvvW74xiTCgGyt04Wf7aOipFj85hf7VQIS1EthY=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20230412052444epcas2p2a8c7973e807db9d214cdc074a1a168e3~VGJmqP0Sk2476624766epcas2p2v;
        Wed, 12 Apr 2023 05:24:44 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.89]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4PxB3b3Z9Dz4x9Px; Wed, 12 Apr
        2023 05:24:43 +0000 (GMT)
X-AuditID: b6c32a48-023fa700000025b2-fb-6436409bf158
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        28.E0.09650.B9046346; Wed, 12 Apr 2023 14:24:43 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH 2/2] nvme-pci: fix metadata mapping length
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
Message-ID: <20230412052443epcms2p836b669a12c4e81368bec2cd340656f73@epcms2p8>
Date:   Wed, 12 Apr 2023 14:24:43 +0900
X-CMS-MailID: 20230412052443epcms2p836b669a12c4e81368bec2cd340656f73
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFJsWRmVeSWpSXmKPExsWy7bCmhe5sB7MUg4PzxCz+7znGZjHr9msW
        i5eHNC1Wrj7KZNHbv5XNYtKha4wWl3fNYbOYv+wpu8W61+9ZHDg9Jja/Y/c4f28ji8emVZ1s
        HpuX1HvsvtnA5tG3ZRWjx+dNch7tB7qZAjiism0yUhNTUosUUvOS81My89JtlbyD453jTc0M
        DHUNLS3MlRTyEnNTbZVcfAJ03TJzgK5TUihLzCkFCgUkFhcr6dvZFOWXlqQqZOQXl9gqpRak
        5BSYF+gVJ+YWl+al6+WlllgZGhgYmQIVJmRnbLl2ir3gAk/F01Ur2BsYt3J1MXJySAiYSDzZ
        cYSpi5GLQ0hgB6NEw4Ve9i5GDg5eAUGJvzuEQWqEBawkDj//ywpiCwkoSZxbM4sRpERYwEDi
        Vq85SJhNQE/i55IZbCBjRAQuMkm0db1ghpjPKzGj/SkLhC0tsX35VkYIW0Pix7JeqBpRiZur
        37LD2O+PzYeqEZFovXcWqkZQ4sHP3VBxSYlDh76ygdwgIZAvseFAIES4RuLt8gNQJfoS1zo2
        gq3lFfCVmLd8GdgYFgFVie2bFzNB1LhIHJx6HOwtZgF5ie1v5zCDjGQW0JRYv0sfYrqyxJFb
        LBAVfBIdh/+ywzzVsPE3VvaOeU+YIFrVJBY1GUGEZSS+Hp4PVeIhcfXaQcYJjIqzEKE8C8kJ
        sxBOWMDIvIpRLLWgODc9tdiowAQescn5uZsYwYlUy2MH4+y3H/QOMTJxMB5ilOBgVhLh/eFi
        miLEm5JYWZValB9fVJqTWnyI0RTo+YnMUqLJ+cBUnlcSb2hiaWBiZmZobmRqYK4kzvuxQzlF
        SCA9sSQ1OzW1ILUIpo+Jg1OqgUmpu+jwm4SljnYpuyyOt3o8WbuY9eytad/m5HdlnT9Tmriy
        Suj678yMrTPS40P2yer+nirhtXFVyOerKXc98pqP8l+bne30wJv9+qOFviztK1ccT5i7L9sz
        hPfDuoViRjavJSdwdP2SWKA+uZexJ2/OMXaFIt3K0HdeMzd6Kb17NPMX59dv8+71u2TfvMfd
        ulDwBPus83Fxlytvbte9evNk94MPa2/90pQXPr9735ozQpV7uQJT/PbXlZX1fnshJPXV6spM
        PiHVzWxXhDOX2itJFVpOyDTSmHxlJkuE/IHlouy1wS6Jonz7GzK2/3rAtLNrNceqbcnh15XE
        W6Ov6X5l1hZWYJ/Eqj3t0OcrjruUWIozEg21mIuKEwFzI74WLQQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230412052443epcms2p836b669a12c4e81368bec2cd340656f73
References: <CGME20230412052443epcms2p836b669a12c4e81368bec2cd340656f73@epcms2p8>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Even if the memory allocated for integrity is physically continuous,
struct bio_vec is composed separately for each page size.
In order not to use the blk_rq_map_integrity_sg(), the length of the
DMA mapping should be the total size of integrity payload.

Fixes: 783b94bd9250 ("nvme-pci: do not build a scatterlist to map metadata")
Signed-off-by: Jinyoung Choi <j-young.choi@samsung.com>
---
 drivers/nvme/host/pci.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 593f86323e25..611c677add67 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -827,8 +827,10 @@ static blk_status_t nvme_map_metadata(struct nvme_dev *dev, struct request *req,
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
 
-	iod->meta_dma = dma_map_bvec(dev->dev, rq_integrity_vec(req),
-			rq_dma_dir(req), 0);
+	iod->meta_dma = dma_map_page(dev->dev, rq_integrity_vec(req)->bv_page,
+				     rq_integrity_vec(req)->bv_offset,
+				     rq_integrity_payload_size(req),
+				     rq_dma_dir(req));
 	if (dma_mapping_error(dev->dev, iod->meta_dma))
 		return BLK_STS_IOERR;
 	cmnd->rw.metadata = cpu_to_le64(iod->meta_dma);
@@ -968,7 +970,8 @@ static __always_inline void nvme_pci_unmap_rq(struct request *req)
 	        struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
 
 		dma_unmap_page(dev->dev, iod->meta_dma,
-			       rq_integrity_vec(req)->bv_len, rq_data_dir(req));
+			       rq_integrity_payload_size(req),
+			       rq_data_dir(req));
 	}
 
 	if (blk_rq_nr_phys_segments(req))
-- 
2.34.1
