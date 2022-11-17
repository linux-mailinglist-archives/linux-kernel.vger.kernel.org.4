Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB9462D967
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 12:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239654AbiKQL3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 06:29:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234237AbiKQL3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 06:29:20 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 574BD42999
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 03:29:19 -0800 (PST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4NCd3d72VGz8RTZG;
        Thu, 17 Nov 2022 19:29:17 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.40.50])
        by mse-fl2.zte.com.cn with SMTP id 2AHBT8eI075903;
        Thu, 17 Nov 2022 19:29:08 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Thu, 17 Nov 2022 19:29:11 +0800 (CST)
Date:   Thu, 17 Nov 2022 19:29:11 +0800 (CST)
X-Zmail-TransId: 2af963761b0732122386
X-Mailer: Zmail v1.0
Message-ID: <202211171929111293904@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <jassisinghbrar@gmail.com>
Cc:     <heiko@sntech.de>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIG1haWxib3g6IHJvY2tjaGlwOiBVc2UgZGV2aWNlX2dldF9tYXRjaF9kYXRhKCkgdG8gc2ltcGxpZnkKCiB0aGUgY29kZQ==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 2AHBT8eI075903
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.137.novalocal with ID 63761B0D.000 by FangMail milter!
X-FangMail-Envelope: 1668684558/4NCd3d72VGz8RTZG/63761B0D.000/10.5.228.133/[10.5.228.133]/mse-fl2.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63761B0D.000/4NCd3d72VGz8RTZG
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ye xingchen <ye.xingchen@zte.com.cn>

Directly get the match data with device_get_match_data().

Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/mailbox/rockchip-mailbox.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mailbox/rockchip-mailbox.c b/drivers/mailbox/rockchip-mailbox.c
index 979acc810f30..e02d3c9e3693 100644
--- a/drivers/mailbox/rockchip-mailbox.c
+++ b/drivers/mailbox/rockchip-mailbox.c
@@ -164,7 +164,6 @@ MODULE_DEVICE_TABLE(of, rockchp_mbox_of_match);
 static int rockchip_mbox_probe(struct platform_device *pdev)
 {
 	struct rockchip_mbox *mb;
-	const struct of_device_id *match;
 	const struct rockchip_mbox_data *drv_data;
 	struct resource *res;
 	int ret, irq, i;
@@ -172,8 +171,7 @@ static int rockchip_mbox_probe(struct platform_device *pdev)
 	if (!pdev->dev.of_node)
 		return -ENODEV;

-	match = of_match_node(rockchip_mbox_of_match, pdev->dev.of_node);
-	drv_data = (const struct rockchip_mbox_data *)match->data;
+	drv_data = (const struct rockchip_mbox_data *) device_get_match_data(&pdev->dev);

 	mb = devm_kzalloc(&pdev->dev, sizeof(*mb), GFP_KERNEL);
 	if (!mb)
-- 
2.25.1
