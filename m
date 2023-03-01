Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81F6F6A6F54
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 16:23:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbjCAPXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 10:23:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbjCAPWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 10:22:55 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D4810DE;
        Wed,  1 Mar 2023 07:22:51 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id EE1226000F;
        Wed,  1 Mar 2023 15:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1677684170;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X48eOuQR9g5TMfWe2rTj2NLQ7Kg+37T7XdPWVVAdg/k=;
        b=YvX0uQbYrMLltUcObHa7M12j5xm3cWqbzZKlrX3RdCRhiXDscazjQPndiZTGwwtj2HcxgN
        b6n+ufqWUB2cDnewB0mCllYIBgQ+6/Q4/h3HFl0SLwtDT9Cf164VTEucnEP4dd7exyrS0P
        fdbA67QELtFZc0Gyorwu42Y1sc0UKehjAV3ET7mpmZSzyEYcQl+zH6biyPPJvnCRTxgZqx
        RVmXriiXlUYJHp8ejHFh631aSjV2DJ/MycrkvC+/3mSMbfqp0UBPKuL7z2ProgjOLUBNEM
        FMDVe4+404vvh5SE2TKmSzZqs0+oQeiQ9lrmcEpENBDmYfQoihfReuelBdKIKg==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        <linux-kernel@vger.kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Walle <michael@walle.cc>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        rafal@milecki.pl, Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 7/8] nvmem: layouts: sl28vpd: Convert layout driver into a module
Date:   Wed,  1 Mar 2023 16:22:38 +0100
Message-Id: <20230301152239.531194-8-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230301152239.531194-1-miquel.raynal@bootlin.com>
References: <20230301152239.531194-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The nvmem core has already been converted to accept layout drivers
compiled as modules. So in order to make this change effective we need
to convert this driver so it can also be compiled as a module. We then
need to expose the match table, provide MODULE_* macros, use
module_init/exit() instead of the early subsys_initcall() and of course
update the Kconfig symbol type to tristate.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/nvmem/layouts/Kconfig   |  2 +-
 drivers/nvmem/layouts/sl28vpd.c | 14 +++++++++++++-
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/nvmem/layouts/Kconfig b/drivers/nvmem/layouts/Kconfig
index 9ad50474cb77..3f2d73282242 100644
--- a/drivers/nvmem/layouts/Kconfig
+++ b/drivers/nvmem/layouts/Kconfig
@@ -3,7 +3,7 @@
 menu "Layout Types"
 
 config NVMEM_LAYOUT_SL28_VPD
-	bool "Kontron sl28 VPD layout support"
+	tristate "Kontron sl28 VPD layout support"
 	select CRC8
 	help
 	  Say Y here if you want to support the VPD layout of the Kontron
diff --git a/drivers/nvmem/layouts/sl28vpd.c b/drivers/nvmem/layouts/sl28vpd.c
index a36800f201a3..9370e41bad73 100644
--- a/drivers/nvmem/layouts/sl28vpd.c
+++ b/drivers/nvmem/layouts/sl28vpd.c
@@ -139,6 +139,7 @@ static const struct of_device_id sl28vpd_of_match_table[] = {
 	{ .compatible = "kontron,sl28-vpd" },
 	{},
 };
+MODULE_DEVICE_TABLE(of, sl28vpd_of_match_table);
 
 struct nvmem_layout sl28vpd_layout = {
 	.name = "sl28-vpd",
@@ -150,4 +151,15 @@ static int __init sl28vpd_init(void)
 {
 	return nvmem_layout_register(&sl28vpd_layout);
 }
-subsys_initcall(sl28vpd_init);
+
+static void __exit sl28vpd_exit(void)
+{
+	nvmem_layout_unregister(&sl28vpd_layout);
+}
+
+module_init(sl28vpd_init);
+module_exit(sl28vpd_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Michael Walle <michael@walle.cc>");
+MODULE_DESCRIPTION("NVMEM layout driver for the VPD of Kontron sl28 boards");
-- 
2.34.1

