Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5451963CFF8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 08:56:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234275AbiK3H4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 02:56:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232674AbiK3H4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 02:56:14 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB4660EBF
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 23:56:13 -0800 (PST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4NMWjm1vltz5BNRf;
        Wed, 30 Nov 2022 15:56:12 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.40.50])
        by mse-fl1.zte.com.cn with SMTP id 2AU7u4wB019582;
        Wed, 30 Nov 2022 15:56:04 +0800 (+08)
        (envelope-from zhang.songyi@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Wed, 30 Nov 2022 15:56:06 +0800 (CST)
Date:   Wed, 30 Nov 2022 15:56:06 +0800 (CST)
X-Zmail-TransId: 2af963870c9635e6ca36
X-Mailer: Zmail v1.0
Message-ID: <202211301556064978448@zte.com.cn>
Mime-Version: 1.0
From:   <zhang.songyi@zte.com.cn>
To:     <arnd@arndb.de>
Cc:     <zhang.songyi@zte.com.cn>, <robert.jarzmik@free.fr>,
        <lkundrak@v3.sk>, <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIHB4YTogUmVtb3ZlIGRldl9lcnIoKSBhZnRlciBwbGF0Zm9ybV9nZXRfaXJxKCk=?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 2AU7u4wB019582
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.138.novalocal with ID 63870C9C.000 by FangMail milter!
X-FangMail-Envelope: 1669794972/4NMWjm1vltz5BNRf/63870C9C.000/10.5.228.132/[10.5.228.132]/mse-fl1.zte.com.cn/<zhang.songyi@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63870C9C.000/4NMWjm1vltz5BNRf
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zhang songyi <zhang.songyi@zte.com.cn>

There is no need to call the dev_err() function directly to print a
custom message when handling an error from either the platform_get_irq()
or platform_get_irq_byname() functions as both are going to display an
appropriate error message in case of a failure.

/drivers/soc/pxa/ssp.c:150:2-9: line 150 is redundant because
platform_get_irq() already prints an error

Signed-off-by: zhang songyi <zhang.songyi@zte.com.cn>
---
 drivers/soc/pxa/ssp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/soc/pxa/ssp.c b/drivers/soc/pxa/ssp.c
index 93449fb3519e..7085901b4e4b 100644
--- a/drivers/soc/pxa/ssp.c
+++ b/drivers/soc/pxa/ssp.c
@@ -147,7 +147,6 @@ static int pxa_ssp_probe(struct platform_device *pdev)

        ssp->irq = platform_get_irq(pdev, 0);
        if (ssp->irq < 0) {
-               dev_err(dev, "no IRQ resource defined\n");
                return -ENODEV;
        }

--
2.15.2
