Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6939A6C7FC8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 15:21:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbjCXOVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 10:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbjCXOVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 10:21:46 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ADD11F93D;
        Fri, 24 Mar 2023 07:21:43 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 8F8975FD2F;
        Fri, 24 Mar 2023 17:01:51 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1679666511;
        bh=IlFUWYEeDUhp/CciNDBSLCyclwAtjmsXI28Xo3rwRSw=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=sHf1Y8yk9o4VXC8BZNagl2tiGnwtFelKqjJUtNAxFegqckcy7GjyeJVzHPfAe3OKK
         dfguX36kq9gogm/CyzjmalabqgtiqOj+DLRUh3trhID3+221x2tdk4OqYHSMP4UDyK
         HXrpUHlnWIF8Ni3FI1B19Z7c1JiVRHCVAc36LVr1+q5Hq3ejDBOcPODnEBtfEt0+Kw
         9YElqH9KUvCL/tAIwRDrvPEmg8M9NVbCuOpZq+XRcTkz2bxoEYdKZZy3UeD+nmKSVH
         G5MQ/sAjmKbKeSVHhefXHBP+SA9JjtKbCGqkqqKzZlSxpBUbFivQXNGrzjDm/ikNuK
         TY67koCIxlmMQ==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Fri, 24 Mar 2023 17:01:50 +0300 (MSK)
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     <krzysztof.kozlowski@linaro.org>, <robh@kernel.org>,
        <neil.armstrong@linaro.org>, <khilman@baylibre.com>,
        <jbrunet@baylibre.com>, <martin.blumenstingl@googlemail.com>,
        <jianxin.pan@amlogic.com>
CC:     <kernel@sberdevices.ru>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <rockosov@gmail.com>, Dmitry Rokosov <ddrokosov@sberdevices.ru>
Subject: [PATCH v2] firmware: meson_sm: populate platform devices from sm device tree data
Date:   Fri, 24 Mar 2023 17:01:41 +0300
Message-ID: <20230324140141.6743-1-ddrokosov@sberdevices.ru>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH01.sberdevices.ru (172.16.1.4) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/03/24 06:52:00 #21002836
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some meson boards, secure monitor device has children, for example,
power secure controller. By default, secure monitor isn't the bus in terms
of device tree subsystem, so the of_platform initialization code doesn't
populate its device tree data. As a result, secure monitor's children
aren't probed at all.

Run the 'of_platform_populate()' routine manually to resolve such issues.

Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
---
 drivers/firmware/meson/meson_sm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/meson/meson_sm.c b/drivers/firmware/meson/meson_sm.c
index 77aa5c6398aa..b79d0e316cb1 100644
--- a/drivers/firmware/meson/meson_sm.c
+++ b/drivers/firmware/meson/meson_sm.c
@@ -316,7 +316,7 @@ static int __init meson_sm_probe(struct platform_device *pdev)
 	if (sysfs_create_group(&pdev->dev.kobj, &meson_sm_sysfs_attr_group))
 		goto out_in_base;
 
-	return 0;
+	return devm_of_platform_populate(dev);
 
 out_in_base:
 	iounmap(fw->sm_shmem_in_base);
-- 
2.36.0

