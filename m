Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC7A5F0ACC
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 13:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbiI3LmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 07:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbiI3Ll7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 07:41:59 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3733718347
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 04:34:24 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220930113422euoutp01ddc1484e25ea53320f00e84997a67dfc~ZoC9dXSfU0324803248euoutp01Y
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 11:34:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220930113422euoutp01ddc1484e25ea53320f00e84997a67dfc~ZoC9dXSfU0324803248euoutp01Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1664537662;
        bh=cliruqIaC5S4YYOLJtGX5T6yYZ5tiYo0al1wxFfz3sI=;
        h=From:To:Cc:Subject:Date:References:From;
        b=veBN6M00Bb1gylOcwUUxmNpUXi3U5izdklUcAbJtxiHOp1rfCPo77wM+t1CzW31+P
         TiJUPBP3u1cL7DhzdVW014HAL7/eKFKLfoct0wC5oDWm3y38ceD31ldgBsVz2KYZ3w
         1gqdP3n0IJSOpMgth/h3Vu/wqjby9P7A7XZj091w=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220930113422eucas1p247d506cddbd7df44376f62f0fbaaa9c0~ZoC9MXV5L0540305403eucas1p2l;
        Fri, 30 Sep 2022 11:34:22 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 81.D0.07817.E34D6336; Fri, 30
        Sep 2022 12:34:22 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220930113421eucas1p27f2dcbac6790e7f6232c3ae88e55723c~ZoC82DkLD1051110511eucas1p2Y;
        Fri, 30 Sep 2022 11:34:21 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220930113421eusmtrp2618aee08900b6e1f8cbfcb5d662b38ff~ZoC81Ytpt1404914049eusmtrp2i;
        Fri, 30 Sep 2022 11:34:21 +0000 (GMT)
X-AuditID: cbfec7f4-8abff70000011e89-86-6336d43e101b
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 75.AC.10862.D34D6336; Fri, 30
        Sep 2022 12:34:21 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220930113421eusmtip23e93959cd840d3e36e3234527ff2810a~ZoC8cxqyN2748827488eusmtip2Z;
        Fri, 30 Sep 2022 11:34:21 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH] spi: Ensure that sg_table won't be used after being freed
Date:   Fri, 30 Sep 2022 13:34:08 +0200
Message-Id: <20220930113408.19720-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsWy7djP87p2V8ySDRa947OY+vAJm8XlXXPY
        LBo/3mS3WHvkLrvF+W3+Dqwe19cFeGxa1cnm0bdlFaPH501yASxRXDYpqTmZZalF+nYJXBkz
        13ezFtxmq7iwo6qB8TBrFyMnh4SAicSVRfvAbCGBFYwSs/ZLdzFyAdlfGCVu31nKCOF8ZpT4
        duYMXEfDggvMEInljBKfVp1ng2t5Pu0PM0gVm4ChRNfbLjYQW0TAWuLbjGlgHcwCLYwST/bu
        ZAdJCAt4Sfxf8g/MZhFQldh3YR8LiM0rYCsx+ctuRoh18hKrNxwAa5YQeMQu0bDnBgtEwkVi
        x7bXUDcJS7w6voUdwpaR+L9zPhNEQzujxILf96GcCYwSDc9vQY21lrhz7hfQfRxAN2lKrN+l
        DxF2lJhzdg4zSFhCgE/ixltBkDAzkDlp23SoMK9ER5sQRLWaxKzj6+DWHrxwiRnC9pBYNfMG
        OyRQYyWuvOpnncAoNwth1wJGxlWM4qmlxbnpqcVGeanlesWJucWleel6yfm5mxiBsX763/Ev
        OxiXv/qod4iRiYPxEKMEB7OSCK94gWmyEG9KYmVValF+fFFpTmrxIUZpDhYlcV62GVrJQgLp
        iSWp2ampBalFMFkmDk6pBibzwANKTLZfp/ouu66Vm1CmzO5clf6lMPqV5dHN1mdPfb1wrGvS
        mkm5+6+fl5VdVljrqz6p5pDuZJMVnH2HS47w3WqQyj+Sc2crYwBvlbpB6c1PAfu37HOZciIn
        v3DPCvccxiOqFqd6guZcPtv3XOS0jqGG3uMbf5oMwmQbVj2WOrMm58wVLTH24w+Prg546fLL
        6dF7ryf3IidwOxpY/1H70WXzkffEM8EFKW3Hiz6sKTt/PGWVhZEtz23W64ZKx1WEFv04GcEb
        FesRGdevm9b54r7wiqZ7PK2sR5iLFYpDu/Nktsvy9QiatC6dwlD+ueqQvtGNU722rO8LFxRf
        SHY63niXu2r2vMX9rj+ipZRYijMSDbWYi4oTAZkoHQtkAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOLMWRmVeSWpSXmKPExsVy+t/xe7q2V8ySDea8N7SY+vAJm8XlXXPY
        LBo/3mS3WHvkLrvF+W3+Dqwe19cFeGxa1cnm0bdlFaPH501yASxRejZF+aUlqQoZ+cUltkrR
        hhZGeoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehkz13ezFtxmq7iwo6qB8TBrFyMn
        h4SAiUTDggvMXYxcHEICSxkl9k7cxQiRkJE4Oa0BqkhY4s+1LjaIok+MEo9bNjKBJNgEDCW6
        3oIkODlEBGwl5r9/wQpSxCzQxigx++ZEsISwgJfE/yX/2EFsFgFViX0X9rGA2LxADZO/7Iba
        Ji+xesMB5gmMPAsYGVYxiqSWFuem5xYb6RUn5haX5qXrJefnbmIEhti2Yz+37GBc+eqj3iFG
        Jg7GQ4wSHMxKIrziBabJQrwpiZVVqUX58UWlOanFhxhNgfZNZJYSTc4HBnleSbyhmYGpoYmZ
        pYGppZmxkjivZ0FHopBAemJJanZqakFqEUwfEwenVANTyt367Xc5FK/6hb9wa3Rvf7qwIu7M
        F+smAfYzFhPkV/y/v2Rf2E5zvvBoj/TDfP9Y51SdfVe85YWM/Jz1/w7w8D15pb+k78ksvbRI
        vxp/kUJ5ax/Wy0Ze7CaS1kZ7z2uZ1+wxPPilk4mveqFm9zmf/966787M9DP75MV/9sKyicee
        pHZOm92yXPb/qgs5C9ccu9vp1DohbV2A79X4Fy/PNM5+9LIqqOsBx0rnXs3pSobX2qzndV/i
        VDQv4Cre7uH9f37TEQXBu8E3PcO3HD1wwfTkMY4szZUVrdNDF1qw6t94UC35kO3D219/Oyze
        n1i/VkLRPrA2Qadr1+fkxfcT048VFUp9fLr7/cl5K7uSlViKMxINtZiLihMBmtbaZ7oCAAA=
X-CMS-MailID: 20220930113421eucas1p27f2dcbac6790e7f6232c3ae88e55723c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220930113421eucas1p27f2dcbac6790e7f6232c3ae88e55723c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220930113421eucas1p27f2dcbac6790e7f6232c3ae88e55723c
References: <CGME20220930113421eucas1p27f2dcbac6790e7f6232c3ae88e55723c@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SPI code checks for non-zero sgt->orig_nents to determine if the buffer
has been DMA-mapped. Ensure that sg_table is really zeroed after free to
avoid potential NULL pointer dereference if the given SPI xfer object is
reused again without being DMA-mapped.

Fixes: 0c17ba73c08f ("spi: Fix cache corruption due to DMA/PIO overlap")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/spi/spi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 44e4352d948b..5f9aedd1f0b6 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1102,6 +1102,8 @@ static void spi_unmap_buf_attrs(struct spi_controller *ctlr,
 	if (sgt->orig_nents) {
 		dma_unmap_sgtable(dev, sgt, dir, attrs);
 		sg_free_table(sgt);
+		sgt->orig_nents = 0;
+		sgt->nents = 0;
 	}
 }
 
-- 
2.17.1

