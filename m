Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6ED63CFEA
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 08:53:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234218AbiK3HxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 02:53:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232267AbiK3HxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 02:53:18 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D87FD3C;
        Tue, 29 Nov 2022 23:53:16 -0800 (PST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4NMWfM4ghVz8RTZK;
        Wed, 30 Nov 2022 15:53:15 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.40.50])
        by mse-fl2.zte.com.cn with SMTP id 2AU7r4l0003483;
        Wed, 30 Nov 2022 15:53:04 +0800 (+08)
        (envelope-from zhang.songyi@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Wed, 30 Nov 2022 15:53:06 +0800 (CST)
Date:   Wed, 30 Nov 2022 15:53:06 +0800 (CST)
X-Zmail-TransId: 2af963870be2fffffffffea666c9
X-Mailer: Zmail v1.0
Message-ID: <202211301553066158367@zte.com.cn>
Mime-Version: 1.0
From:   <zhang.songyi@zte.com.cn>
To:     <davem@davemloft.net>
Cc:     <zhang.songyi@zte.com.cn>, <sparclinux@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIHNwYXJjOiBsZW9uOiBncnBjaTE6IHVzZSBkZXZtX3BsYXRmb3JtX2lvcmVtYXBfcmVzb3VyY2UoKQ==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 2AU7r4l0003483
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.137.novalocal with ID 63870BEB.000 by FangMail milter!
X-FangMail-Envelope: 1669794795/4NMWfM4ghVz8RTZK/63870BEB.000/10.5.228.133/[10.5.228.133]/mse-fl2.zte.com.cn/<zhang.songyi@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63870BEB.000/4NMWfM4ghVz8RTZK
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zhang songyi <zhang.songyi@zte.com.cn>

Use the devm_platform_ioremap_resource() helper instead of
calling platform_get_resource() and devm_ioremap_resource()
separately

Signed-off-by: zhang songyi <zhang.songyi@zte.com.cn>
---
 arch/sparc/kernel/leon_pci_grpci1.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/sparc/kernel/leon_pci_grpci1.c b/arch/sparc/kernel/leon_pci_grpci1.c
index e6935d0ac1ec..bbe9c95541e0 100644
--- a/arch/sparc/kernel/leon_pci_grpci1.c
+++ b/arch/sparc/kernel/leon_pci_grpci1.c
@@ -515,7 +515,6 @@ static int grpci1_of_probe(struct platform_device *ofdev)
        int err, len;
        const int *tmp;
        u32 cfg, size, err_mask;
-       struct resource *res;

        if (grpci1priv) {
                dev_err(&ofdev->dev, "only one GRPCI1 supported\n");
@@ -536,8 +535,7 @@ static int grpci1_of_probe(struct platform_device *ofdev)
        priv->dev = &ofdev->dev;

        /* find device register base address */
-       res = platform_get_resource(ofdev, IORESOURCE_MEM, 0);
-       regs = devm_ioremap_resource(&ofdev->dev, res);
+       regs = devm_platform_ioremap_resource(ofdev, 0);
        if (IS_ERR(regs))
                return PTR_ERR(regs);

--
2.15.2
