Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDCF266D99F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 10:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236558AbjAQJPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 04:15:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236464AbjAQJPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 04:15:17 -0500
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A84AB32516
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 01:07:01 -0800 (PST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4Nx30q2PFbz501St;
        Tue, 17 Jan 2023 17:06:35 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
        by mse-fl1.zte.com.cn with SMTP id 30H96Rre076903;
        Tue, 17 Jan 2023 17:06:27 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Tue, 17 Jan 2023 17:06:30 +0800 (CST)
Date:   Tue, 17 Jan 2023 17:06:30 +0800 (CST)
X-Zmail-TransId: 2af963c66516fffffffffd6dec0a
X-Mailer: Zmail v1.0
Message-ID: <202301171706300144532@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <arnd@arndb.de>
Cc:     <mpe@ellerman.id.au>, <npiggin@gmail.com>,
        <christophe.leroy@csgroup.eu>, <linuxppc-dev@lists.ozlabs.org>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIHBvd2VycGMvY2VsbC9heG9uX21zaTogVXNlIGRtYV96YWxsb2NfY29oZXJlbnQoKQ==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 30H96Rre076903
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63C6651B.003/4Nx30q2PFbz501St
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SPF_PERMERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ye xingchen <ye.xingchen@zte.com.cn>

Instead of using dma_alloc_coherent() and memset() directly use
dma_zalloc_coherent().

Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 arch/powerpc/platforms/cell/axon_msi.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/cell/axon_msi.c b/arch/powerpc/platforms/cell/axon_msi.c
index 0c11aad896c7..8a4c522c8e67 100644
--- a/arch/powerpc/platforms/cell/axon_msi.c
+++ b/arch/powerpc/platforms/cell/axon_msi.c
@@ -358,8 +358,8 @@ static int axon_msi_probe(struct platform_device *device)
 		goto out_free_msic;
 	}

-	msic->fifo_virt = dma_alloc_coherent(&device->dev, MSIC_FIFO_SIZE_BYTES,
-					     &msic->fifo_phys, GFP_KERNEL);
+	msic->fifo_virt = dma_zalloc_coherent(&device->dev, MSIC_FIFO_SIZE_BYTES,
+					      &msic->fifo_phys, GFP_KERNEL);
 	if (!msic->fifo_virt) {
 		printk(KERN_ERR "axon_msi: couldn't allocate fifo for %pOF\n",
 		       dn);
@@ -372,7 +372,6 @@ static int axon_msi_probe(struct platform_device *device)
 		       dn);
 		goto out_free_fifo;
 	}
-	memset(msic->fifo_virt, 0xff, MSIC_FIFO_SIZE_BYTES);

 	/* We rely on being able to stash a virq in a u16, so limit irqs to < 65536 */
 	msic->irq_domain = irq_domain_add_nomap(dn, 65536, &msic_host_ops, msic);
-- 
2.25.1
