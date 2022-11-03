Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0945D617F0A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 15:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbiKCONG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 10:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231388AbiKCOMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 10:12:51 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B00213F47
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 07:12:41 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20221103141240euoutp02e81375e999f7ca8c4a8c55b802930f73~kGI4EyN980722207222euoutp02o
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 14:12:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20221103141240euoutp02e81375e999f7ca8c4a8c55b802930f73~kGI4EyN980722207222euoutp02o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1667484760;
        bh=qCDUQNE7TNiVdNuYLngBq2PYfEAAqmyEHBheVRACkuw=;
        h=From:To:Cc:Subject:Date:References:From;
        b=UJL1bjj9in0aXQ2UCVJ/cMuTTinlq4BAwoKRL7VJoBbNz2CBpJ/ihzte1WX2mM5Vf
         nYVnqGnMmxW1RFiGxOQhQeE/gW7CfiHiuSLeIiSR9f3qnRlP/D+ZrqJXn6WbUJrdD4
         DkpBo6em6IHBixeP6sMib1FsaF1ULoWAt70Oiy1g=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20221103141239eucas1p2639310d953c20b950f8e209a9a0ada60~kGI3duCEp1870018700eucas1p2j;
        Thu,  3 Nov 2022 14:12:39 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id F6.01.07817.75CC3636; Thu,  3
        Nov 2022 14:12:39 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20221103141239eucas1p29dac7ffb7202852c18e48c48c068a90f~kGI26Po1U2133321333eucas1p2h;
        Thu,  3 Nov 2022 14:12:39 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20221103141239eusmtrp2240f41799f400654257dcadac7e7200c~kGI25W1Wl2294622946eusmtrp2K;
        Thu,  3 Nov 2022 14:12:39 +0000 (GMT)
X-AuditID: cbfec7f4-8abff70000011e89-fa-6363cc573943
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 25.57.07473.65CC3636; Thu,  3
        Nov 2022 14:12:38 +0000 (GMT)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20221103141238eusmtip2e021576b43f6c021db3721c93d63eeb4~kGI2Pr3hB1225412254eusmtip2R;
        Thu,  3 Nov 2022 14:12:38 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Stefan Agner <stefan@agner.ch>,
        Johan Hovold <johan@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Subject: [PATCH 1/2] usb: dwc3: exynos: force PHY control from XHCI HCD
Date:   Thu,  3 Nov 2022 15:12:32 +0100
Message-Id: <20221103141233.20179-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSe0hTcRTud+/uw+Gt2yr9ZbLBMiOr9SDiQg+KpC5BFkUI0WvOm5VuyuZM
        e5hmpq6ssCC1RZZlNp3WtNXUrGw06bFpRj6wopfOrdI1I6ycua7Vf9/5HueDwyFRkQ4LIfeo
        kjm1Sp4gxYUC86Mhx9zopwrF/O5+CXPRaseYok8jOJNVWo0zRzpOYMxd9y2CaavT40yhoxFh
        Lpdlo4zR+opgsu9aCaamKodgDCX3iRWBbOn31yhrKX5FsCZDHs52v2zA2XsXKgn2ZK0BsLX3
        vID1msQbyC3CpbFcwp4UTj1v+U7hbqfDTSQNzE4teJiFZgB7mA4EkJBeBPNtPYgOCEkRXQ5g
        38BTnB8GAfxoPor5XSLaC2DLl+V/Ex57u4A3XQOwsv459i/R2dhI+F04vQDqPutwP55MH4SW
        1po/a1H6BQL1BacQvzCJXgN1Dt8fk4CeAa/k3x7lSZKil0F3PeDbJLDixn3Un4V0AwlvVlUg
        vBAJ66zlGI8nQZetluBxKByxXET4QA6AJT/fjA2nAczo7RpbuwR223/g/jaUngWr6+bx9EpY
        3VqG+mlIj4cdnyf6aXQUFpjPjdEUzD0m4t3hsNhW9a/2QctzlMcs1J/pRfnLbYN2Tx56GoiL
        /3eVAGAAwZxWo4zjNAtV3D6ZRq7UaFVxMkWi0gRG3+WJzzZ4B1xzeWRNACFBE4AkKp1MfTUr
        FCIqVp62n1Mn7lBrEzhNE5hGCqTBFF4YoRDRcfJkLp7jkjj1XxUhA0IykPhTduWBjdG+vF1D
        pVwRsK3VhdZ3huc+k56ITOx/PDOtuK0t+2yU89iR7UotOU4cEH1FmK3rnWLe63Lp178r72v+
        MTQ3RvSroNtt7PLZZatfCJW2fCTj5rqatO8WTfvVzKDFK2rmfHOmUBLs0hSxsRLbOrPc4V6l
        /zC9VT6xPevosDWxJHV8w4Dv17jA5EwrFZazciTqPeW5nm76yZZOOB831SQL8nZWGAtDUmIP
        Nb01SEQLYzo9mFOcGtyeOZzwpNV1PEwriTbPP5ne9THZUvvSvkm2edvedas6zr+9bAjx9jvT
        N26O+pJEvRnqDy7bmXubPdysQjvCP5iNPeJhqUCzW74gAlVr5L8Bbd/VDZ0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrILMWRmVeSWpSXmKPExsVy+t/xe7phZ5KTDR52WlnMP3KO1WLmm/9s
        Fs2L17NZNN3oYbXY+3oru8XlXXPYLGac38dksWhZK7PF2iN32S1a9x5ht9i8rp3dYtWCA+wO
        PB6Lv99j9tg56y67x6ZVnWwed67tYfPYP3cNu0ffllWMHlv2f2b0+LxJLoAjSs+mKL+0JFUh
        I7+4xFYp2tDCSM/Q0kLPyMRSz9DYPNbKyFRJ384mJTUnsyy1SN8uQS/jxfnX7AUftCsmHW5m
        bmA8p9LFyMkhIWAi8fHcdZYuRi4OIYGljBK3OiYwQSRkJE5Oa2CFsIUl/lzrYoMo+sQo0df5
        HqyITcBQoustREJEoIFRYsfkv0wgDrPADSaJCXP72ECqhAXcJbrO/wOzWQRUJZb0bgcq4uDg
        FbCVeL2bEWKDvMTqDQeYJzDyLGBkWMUoklpanJueW2yoV5yYW1yal66XnJ+7iREY1tuO/dy8
        g3Heq496hxiZOBgPMUpwMCuJ8H7alpwsxJuSWFmVWpQfX1Sak1p8iNEUaN1EZinR5HxgZOWV
        xBuaGZgamphZGphamhkrifN6FnQkCgmkJ5akZqemFqQWwfQxcXBKNTBpzP0bGDf5x+EFxjNv
        rrp0tvLBLuubCQ2zj694Khe/rufP89AEi1Uyc+Zn1J7wz3pk7Pjn+XYmFs0dXO8X7WGT6U0L
        r+ide4NBX7Hthq5bq2neUf1N4bMnqUw6+sFQjykxbM2mXVPlZFr1V50XTu9n2fBG0LEufIP2
        Ajb2P/87hZZczImb7D69f++Bj52GqxNWRjJ9bdgR5mj3olbYTrW67Gj+lD88u8N5lvgubeTa
        2vHietav3A7eU1b5FwLvbD9p+zpCt2gZu69cQgsHX2HaH/UVkX1sv+c0sd5Ibl22IMJ817L9
        KqLucz+f5mbP8nK8fGhLRqkhb1aF6OyolM1zuTg/9Vvdf3NOVjF6hYkSS3FGoqEWc1FxIgDx
        qYkf9AIAAA==
X-CMS-MailID: 20221103141239eucas1p29dac7ffb7202852c18e48c48c068a90f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20221103141239eucas1p29dac7ffb7202852c18e48c48c068a90f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20221103141239eucas1p29dac7ffb7202852c18e48c48c068a90f
References: <CGME20221103141239eucas1p29dac7ffb7202852c18e48c48c068a90f@eucas1p2.samsung.com>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Force controlling of the generic USB PHYs also from XHCI HCD to let XHCI
driver call calibrate() method during the HCD reset. DWC3 also controls
USB PHYs, but it is not able to call the calibrate() method at the right
moment.

Fixes: 6000b8d900cd ("usb: dwc3: disable USB core PHY management")
Reported-by: Stefan Agner <stefan@agner.ch>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
This fixes the issue reported here:
https://lore.kernel.org/all/808bdba846bb60456adf10a3016911ee@agner.ch/

Alternative for this change is a complete revert of the 6000b8d900cd
("usb: dwc3: disable USB core PHY management") commit.

Best regards
Marek Szyprowski, PhD
Samsung R&D Institute Poland 
---
 drivers/usb/dwc3/core.c        |  2 ++
 drivers/usb/dwc3/core.h        |  1 +
 drivers/usb/dwc3/dwc3-exynos.c | 65 +++++++++++++++++++++++-----------
 drivers/usb/dwc3/host.c        |  3 +-
 4 files changed, 49 insertions(+), 22 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index c0e7c76dc5c8..87d4472fc031 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1548,6 +1548,8 @@ static void dwc3_get_properties(struct dwc3 *dwc)
 				"snps,parkmode-disable-ss-quirk");
 	dwc->gfladj_refclk_lpm_sel = device_property_read_bool(dev,
 				"snps,gfladj-refclk-lpm-sel-quirk");
+	dwc->xhci_force_phy_control_quirk = device_property_read_bool(dev,
+				"snps,xhci_force_phy_control");
 
 	dwc->tx_de_emphasis_quirk = device_property_read_bool(dev,
 				"snps,tx_de_emphasis_quirk");
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 8f9959ba9fd4..4d53edaf5999 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -1318,6 +1318,7 @@ struct dwc3 {
 	unsigned		resume_hs_terminations:1;
 	unsigned		parkmode_disable_ss_quirk:1;
 	unsigned		gfladj_refclk_lpm_sel:1;
+	unsigned		xhci_force_phy_control_quirk:1;
 
 	unsigned		tx_de_emphasis_quirk:1;
 	unsigned		tx_de_emphasis:2;
diff --git a/drivers/usb/dwc3/dwc3-exynos.c b/drivers/usb/dwc3/dwc3-exynos.c
index 0ecf20eeceee..fbeefc9eb9c5 100644
--- a/drivers/usb/dwc3/dwc3-exynos.c
+++ b/drivers/usb/dwc3/dwc3-exynos.c
@@ -13,6 +13,7 @@
 #include <linux/slab.h>
 #include <linux/platform_device.h>
 #include <linux/clk.h>
+#include <linux/dma-mapping.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/regulator/consumer.h>
@@ -35,22 +36,20 @@ struct dwc3_exynos {
 
 	struct regulator	*vdd33;
 	struct regulator	*vdd10;
+	struct platform_device	*dwc3;
 };
 
-static int dwc3_exynos_remove_child(struct device *dev, void *unused)
-{
-	struct platform_device *pdev = to_platform_device(dev);
-
-	platform_device_unregister(pdev);
-
-	return 0;
-}
+static const struct property_entry dwc3_exynos_properties[] = {
+	PROPERTY_ENTRY_BOOL("snps,xhci_force_phy_control"),
+	{}
+};
 
 static int dwc3_exynos_probe(struct platform_device *pdev)
 {
 	struct dwc3_exynos	*exynos;
 	struct device		*dev = &pdev->dev;
-	struct device_node	*node = dev->of_node;
+	struct device_node	*node = dev->of_node, *child;
+	struct platform_device	*dwc3;
 	const struct dwc3_exynos_driverdata *driver_data;
 	int			i, ret;
 
@@ -109,21 +108,44 @@ static int dwc3_exynos_probe(struct platform_device *pdev)
 		goto vdd10_err;
 	}
 
-	if (node) {
-		ret = of_platform_populate(node, NULL, NULL, dev);
-		if (ret) {
-			dev_err(dev, "failed to add dwc3 core\n");
-			goto populate_err;
-		}
-	} else {
-		dev_err(dev, "no device node, failed to add dwc3 core\n");
-		ret = -ENODEV;
-		goto populate_err;
+	child = of_get_next_child(node, NULL);
+	if (!child) {
+		dev_err(dev, "Failed to find DWC3 core device node\n");
+		goto dwc3_child_err;
+	}
+
+	dwc3 = of_device_alloc(child, NULL, dev);
+	if (!dwc3) {
+		dev_err(dev, "Failed to allocate DWC3 core device\n");
+		goto dwc3_alloc_err;
+	}
+
+	dwc3->dev.coherent_dma_mask = DMA_BIT_MASK(32);
+	dwc3->dev.dma_mask = &dwc3->dev.coherent_dma_mask;
+	dwc3->dev.bus = &platform_bus_type;
+
+	ret = device_create_managed_software_node(&dwc3->dev,
+						  dwc3_exynos_properties, NULL);
+	if (ret < 0) {
+		dev_err(dev, "Failed to add properties to DWC3 device\n");
+		goto dwc3_props_err;
+	}
+
+	ret = of_device_add(dwc3);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to register DWC3 core device\n");
+		goto dwc3_props_err;
 	}
+	exynos->dwc3 = dwc3;
+	of_node_put(child);
 
 	return 0;
 
-populate_err:
+dwc3_props_err:
+	platform_device_put(dwc3);
+dwc3_alloc_err:
+	of_node_put(child);
+dwc3_child_err:
 	regulator_disable(exynos->vdd10);
 vdd10_err:
 	regulator_disable(exynos->vdd33);
@@ -142,7 +164,8 @@ static int dwc3_exynos_remove(struct platform_device *pdev)
 	struct dwc3_exynos	*exynos = platform_get_drvdata(pdev);
 	int i;
 
-	device_for_each_child(&pdev->dev, NULL, dwc3_exynos_remove_child);
+	device_remove_software_node(&exynos->dwc3->dev);
+	of_device_unregister(exynos->dwc3);
 
 	for (i = exynos->num_clks - 1; i >= 0; i--)
 		clk_disable_unprepare(exynos->clks[i]);
diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c
index a7154fe8206d..84f25f392dbd 100644
--- a/drivers/usb/dwc3/host.c
+++ b/drivers/usb/dwc3/host.c
@@ -97,7 +97,8 @@ int dwc3_host_init(struct dwc3 *dwc)
 		goto err;
 	}
 
-	ret = platform_device_add_data(xhci, &dwc3_xhci_plat_priv,
+	if (!dwc->xhci_force_phy_control_quirk)
+		ret = platform_device_add_data(xhci, &dwc3_xhci_plat_priv,
 					sizeof(dwc3_xhci_plat_priv));
 	if (ret)
 		goto err;
-- 
2.17.1

