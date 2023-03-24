Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 430546C8077
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 15:56:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232210AbjCXO4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 10:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231877AbjCXO4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 10:56:12 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9513F2D5F;
        Fri, 24 Mar 2023 07:56:10 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 23C035FD35;
        Fri, 24 Mar 2023 17:56:08 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1679669768;
        bh=jKGFF0Da4+1cXaHKpDC/eneHomsmAiAzeGToPU73Ezw=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=n9hzZenddFoehGW/bLJK8iYJ1+F+cmLzgGNjzI05HGrl0Dbm9UYRrZOoPP09iAy7W
         gKUbM5uO2+5SDZWi16LZdE7mRi2Xxhg+Am1QSs0i3jd7ylClla2wTVMZjGex/WgZPY
         6i4FOs0642yY94YTdoRTfq3LP7K3OmxroX4Auqy3TuNUwVZ7U7yvgzgt6H5PVaE6HJ
         hNf4Ehyy4P+32/cAZbdTXsJ/0vKUC18x3q5i8tRtA6fGnNKJS5dfr+6YcoJLzBeego
         XK2DWZGWgq7HkrcpsCyBvyjfuAeSM0N9gbR4gt6wOBYwxHe8yl9hCLa25DwLpUnnb5
         o2xr2q6GEBeVA==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Fri, 24 Mar 2023 17:56:07 +0300 (MSK)
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     <krzysztof.kozlowski@linaro.org>, <robh@kernel.org>,
        <neil.armstrong@linaro.org>, <khilman@baylibre.com>,
        <jbrunet@baylibre.com>, <martin.blumenstingl@googlemail.com>,
        <jianxin.pan@amlogic.com>
CC:     <kernel@sberdevices.ru>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <rockosov@gmail.com>, Dmitry Rokosov <ddrokosov@sberdevices.ru>
Subject: [PATCH v3] firmware: meson_sm: populate platform devices from sm device tree data
Date:   Fri, 24 Mar 2023 17:55:57 +0300
Message-ID: <20230324145557.27797-1-ddrokosov@sberdevices.ru>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH02.sberdevices.ru (172.16.1.5) To
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
Changes v3 since v2 at [2]:
    - unmap meson sm shmem region if devm_of_platform_populate() failed
    - move pr_info() log about successfully enabled secure-monitor to
      the end of probe() routine

Changes v2 since v1 at [1]:
    - decline the device tree /firmware based solution
    - introduce devm_of_platform_populate() solution in the meson sm driver

Links:
    [1] https://lore.kernel.org/all/20230323185548.13731-1-ddrokosov@sberdevices.ru/
    [2] https://lore.kernel.org/linux-amlogic/20230324140141.6743-1-ddrokosov@sberdevices.ru/
---
 drivers/firmware/meson/meson_sm.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/meson/meson_sm.c b/drivers/firmware/meson/meson_sm.c
index 77aa5c6398aa..1a99dbc274fa 100644
--- a/drivers/firmware/meson/meson_sm.c
+++ b/drivers/firmware/meson/meson_sm.c
@@ -311,11 +311,14 @@ static int __init meson_sm_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, fw);
 
-	pr_info("secure-monitor enabled\n");
+	if (devm_of_platform_populate(dev))
+		goto out_in_base;
 
 	if (sysfs_create_group(&pdev->dev.kobj, &meson_sm_sysfs_attr_group))
 		goto out_in_base;
 
+	pr_info("secure-monitor enabled\n");
+
 	return 0;
 
 out_in_base:
-- 
2.36.0

