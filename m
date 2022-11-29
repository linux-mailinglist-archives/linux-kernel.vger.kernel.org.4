Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6519663B9C1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 07:21:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235662AbiK2GVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 01:21:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235397AbiK2GVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 01:21:53 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E5C22FC02;
        Mon, 28 Nov 2022 22:21:52 -0800 (PST)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NLsbS0mYJzJp0j;
        Tue, 29 Nov 2022 14:18:28 +0800 (CST)
Received: from localhost.localdomain (10.175.112.70) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 29 Nov 2022 14:21:50 +0800
From:   Wang Yufen <wangyufen@huawei.com>
To:     <gregkh@linuxfoundation.org>, <linus.walleij@linaro.org>,
        <mailhol.vincent@wanadoo.fr>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wangyufen@huawei.com>
Subject: [PATCH v2] USB: FHCI: fix error return code in of_fhci_probe()
Date:   Tue, 29 Nov 2022 14:41:55 +0800
Message-ID: <1669704115-40011-1-git-send-email-wangyufen@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.70]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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
---
 drivers/usb/host/fhci-hcd.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/fhci-hcd.c b/drivers/usb/host/fhci-hcd.c
index 95a4446..ca4b311 100644
--- a/drivers/usb/host/fhci-hcd.c
+++ b/drivers/usb/host/fhci-hcd.c
@@ -639,8 +639,9 @@ static int of_fhci_probe(struct platform_device *ofdev)
 					NULL, i, GPIOD_OUT_LOW);
 
 		if (IS_ERR(fhci->gpiods[i])) {
-			dev_err(dev, "incorrect GPIO%d: %ld\n",
-				i, PTR_ERR(fhci->gpiods[i]));
+			ret = PTR_ERR(fhci->gpiods[i])
+			dev_err(dev, "incorrect GPIO%d: %d\n",
+				i, ret);
 			goto err_gpios;
 		}
 		if (!fhci->gpiods[i]) {
-- 
1.8.3.1

