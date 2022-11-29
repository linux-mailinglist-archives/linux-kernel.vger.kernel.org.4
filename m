Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A286863BA65
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 08:13:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbiK2HNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 02:13:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbiK2HND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 02:13:03 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D46742657F;
        Mon, 28 Nov 2022 23:13:02 -0800 (PST)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NLtnf237mz15Mt5;
        Tue, 29 Nov 2022 15:12:22 +0800 (CST)
Received: from localhost.localdomain (10.175.112.70) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 29 Nov 2022 15:13:00 +0800
From:   Wang Yufen <wangyufen@huawei.com>
To:     <gregkh@linuxfoundation.org>, <linus.walleij@linaro.org>,
        <mailhol.vincent@wanadoo.fr>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wangyufen@huawei.com>
Subject: [PATCH v4] USB: FHCI: fix error return code in of_fhci_probe()
Date:   Tue, 29 Nov 2022 15:32:38 +0800
Message-ID: <1669707158-43984-1-git-send-email-wangyufen@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.70]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix to return a negative error code of PTR_ERR(fhci->gpiods[i])
instead of 0.

Fixes: a4efdb8a423b ("USB: FHCI: Switch to GPIO descriptors")
Signed-off-by: Wang Yufen <wangyufen@huawei.com>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/usb/host/fhci-hcd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/fhci-hcd.c b/drivers/usb/host/fhci-hcd.c
index 95a4446..f84f1c8 100644
--- a/drivers/usb/host/fhci-hcd.c
+++ b/drivers/usb/host/fhci-hcd.c
@@ -639,8 +639,8 @@ static int of_fhci_probe(struct platform_device *ofdev)
 					NULL, i, GPIOD_OUT_LOW);
 
 		if (IS_ERR(fhci->gpiods[i])) {
-			dev_err(dev, "incorrect GPIO%d: %ld\n",
-				i, PTR_ERR(fhci->gpiods[i]));
+			ret = PTR_ERR(fhci->gpiods[i]);
+			dev_err(dev, "incorrect GPIO%d: %d\n", i, ret);
 			goto err_gpios;
 		}
 		if (!fhci->gpiods[i]) {
-- 
1.8.3.1

