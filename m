Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B09AE6D8B39
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 01:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233739AbjDEXrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 19:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233081AbjDEXrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 19:47:13 -0400
Received: from mo-csw.securemx.jp (mo-csw1514.securemx.jp [210.130.202.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E5E77684;
        Wed,  5 Apr 2023 16:46:48 -0700 (PDT)
Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 335NkIWO004496; Thu, 6 Apr 2023 08:46:19 +0900
X-Iguazu-Qid: 34trPsC3CYtl3ZnLTY
X-Iguazu-QSIG: v=2; s=0; t=1680738378; q=34trPsC3CYtl3ZnLTY; m=ep8IdKMrzZrb5kKMToUvekiVRfV5745ux+7fYG9copo=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
        by relay.securemx.jp (mx-mr1513) id 335NkHZI026619
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 6 Apr 2023 08:46:17 +0900
From:   Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To:     mathias.nyman@intel.com, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [PATCH v2] usb: host: xhci-plat: Use dev_is_pci() helper
Date:   Thu,  6 Apr 2023 08:46:05 +0900
X-TSB-HOP2: ON
Message-Id: <20230405234605.2310155-1-nobuhiro1.iwamatsu@toshiba.co.jp>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.7 required=5.0 tests=RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use common dev_is_pci() helper for checking PCI devices.
And if CONFIG_PCI is not defined, dev_is_pci returns false. Therefore,
CONFIG_PCI is also unnecessary, so remove it.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
---
 v2: Remove CONFIG_PCI

 drivers/usb/host/xhci-plat.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index b9f9625467d61e..76c5a84616eaee 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -362,10 +362,8 @@ static int xhci_generic_plat_probe(struct platform_device *pdev)
 		if (is_of_node(sysdev->fwnode) ||
 			is_acpi_device_node(sysdev->fwnode))
 			break;
-#ifdef CONFIG_PCI
-		else if (sysdev->bus == &pci_bus_type)
+		else if (dev_is_pci(sysdev))
 			break;
-#endif
 	}
 
 	if (!sysdev)
-- 
2.36.1


