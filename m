Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5C3964F38C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 22:55:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbiLPVzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 16:55:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiLPVz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 16:55:28 -0500
Received: from box.opentheblackbox.net (box.opentheblackbox.net [IPv6:2600:3c02::f03c:92ff:fee2:82bc])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B4DE5F409
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 13:55:24 -0800 (PST)
Received: from authenticated-user (box.opentheblackbox.net [172.105.151.37])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.opentheblackbox.net (Postfix) with ESMTPSA id B92D03EA73;
        Fri, 16 Dec 2022 16:55:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pgazz.com; s=mail;
        t=1671227722; bh=HMHD3iTTm1dNKsVI/i2CxxkFBsiauFMT2knt2LtgRPg=;
        h=From:To:Cc:Subject:Date:From;
        b=bGk7hkHtVc7lgB/+Yh0zkwI4boqOgZPmDv6yqvp+se7GnWXcup3o0rZYaD3d//wX0
         kBhUaBDk+51RXqSEGk30HFG6bS0/EH5B5bpJXzyxuOAKPkb4C++CRmbGBL5LFKA3A8
         p3PU/ix5jxdCi2SXcGwiLP+rr0KK4/xq9NaU6yg8V7TH2Gaj0J05EEA7BqDDGwDJ8S
         e0VkvQ+CmCL0wDcqopqro7JBpUZndGQRwY2yPQX/NH18CwZ6C98xUHykeXupsdaRYo
         YnP3jQLH+OgyIIBuIF8IbimWGfddlB9V7H8YvNTJbcfXkuk7KseNkfNI0VccEJ16kz
         E0KlRRAolIgSQ==
From:   Paul Gazzillo <paul@pgazz.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Zheng Bin <zhengbin13@huawei.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Suman Ghosh <sumang@marvell.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Paul Gazzillo <paul@pgazz.com>
Subject: [PATCH] octeontx2_pf: Select NET_DEVLINK when enabling OCTEONTX2_PF
Date:   Fri, 16 Dec 2022 16:54:48 -0500
Message-Id: <20221216215509.821591-1-paul@pgazz.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_SBL_CSS,RCVD_IN_XBL,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using COMPILE_TEST, the driver controlled by OCTEONTX2_PF does
not select NET_DEVLINK while the related OCTEONTX2_AF driver does.
This means that when OCTEONTX2_PF is enabled from a default
configuration, linker errors will occur due to undefined references to
code controlled by NET_DEVLINK.

1. make.cross ARCH=x86_64 defconfig
2. make.cross ARCH=x86_64 menuconfig
3. Enable COMPILE_TEST
   General setup  --->
     Compile also drivers which will not load
4. Enable OCTEONTX2_PF
   Device Drivers  --->
     Network device support  --->
       Ethernet driver support  --->
         Marvell OcteonTX2 NIC Physical Function driver
5. Exit and save configuration.  NET_DEVLINK will still be disabled.
6. make.cross ARCH=x86_64 several linker errors, for example,
   ld: drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.o:
     in function `otx2_register_dl':
   otx2_devlink.c:(.text+0x142): undefined reference to `devlink_alloc_ns'

This fix adds "select NET_DEVLINK" link to OCTEONTX2_PF's Kconfig
specification to match OCTEONTX2_AF.

Signed-off-by: Paul Gazzillo <paul@pgazz.com>
---
 drivers/net/ethernet/marvell/octeontx2/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/Kconfig b/drivers/net/ethernet/marvell/octeontx2/Kconfig
index 3f982ccf2c85..639893d87055 100644
--- a/drivers/net/ethernet/marvell/octeontx2/Kconfig
+++ b/drivers/net/ethernet/marvell/octeontx2/Kconfig
@@ -31,6 +31,7 @@ config NDC_DIS_DYNAMIC_CACHING
 config OCTEONTX2_PF
 	tristate "Marvell OcteonTX2 NIC Physical Function driver"
 	select OCTEONTX2_MBOX
+	select NET_DEVLINK
 	depends on (64BIT && COMPILE_TEST) || ARM64
 	depends on PCI
 	depends on PTP_1588_CLOCK_OPTIONAL
-- 
2.25.1

