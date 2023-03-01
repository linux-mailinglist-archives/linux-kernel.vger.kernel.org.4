Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A424B6A6F55
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 16:23:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbjCAPXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 10:23:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbjCAPW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 10:22:56 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3CE761BA;
        Wed,  1 Mar 2023 07:22:52 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 3F1476000E;
        Wed,  1 Mar 2023 15:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1677684171;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q/yvRwDf0AdtbTrlrjDEi4BXF/Fzx1LyWUDN6tw49lM=;
        b=QaO/w24JvA08uvMecfKs3r8CgraP6VjdyZkEd/5pug68+pTJmHBixd1HJCmMo85/zrv3bn
        56M8cs3BeKlGKeLmp1uYGwwGSEDlr8IoNrVry0MpPTXW0lUNAm7pF0wEUrO/l8mbnDPhG9
        S5lj3Q4dae8TjES7TMFm1P9IPjQIBqwJxo7jWBbL8sI6PAP8LUgd0oJ0fN3gIzLRORP5Ts
        JwITliC2/ZSI0S3UwCttilFc3fzJKMQiaAX3wu/IuvhiJAuAh/2nf3LkY70bgFh7OE9sHA
        wISD71WHqi/EZyx+EMDKv6oKIUlu8lAfukcjNFr7n+/NL+EAbslHgeNSnjjT1Q==
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
Subject: [PATCH 8/8] nvmem: layouts: onie-tlv: Convert layout driver into a module
Date:   Wed,  1 Mar 2023 16:22:39 +0100
Message-Id: <20230301152239.531194-9-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230301152239.531194-1-miquel.raynal@bootlin.com>
References: <20230301152239.531194-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/nvmem/layouts/Kconfig    |  2 +-
 drivers/nvmem/layouts/onie-tlv.c | 15 ++++++++++++++-
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/nvmem/layouts/Kconfig b/drivers/nvmem/layouts/Kconfig
index 3f2d73282242..7ff1ee1c1f05 100644
--- a/drivers/nvmem/layouts/Kconfig
+++ b/drivers/nvmem/layouts/Kconfig
@@ -12,7 +12,7 @@ config NVMEM_LAYOUT_SL28_VPD
 	  If unsure, say N.
 
 config NVMEM_LAYOUT_ONIE_TLV
-	bool "ONIE tlv support"
+	tristate "ONIE tlv support"
 	select CRC32
 	help
 	  Say Y here if you want to support the Open Compute Project ONIE
diff --git a/drivers/nvmem/layouts/onie-tlv.c b/drivers/nvmem/layouts/onie-tlv.c
index 767f39fff717..d45b7301a69d 100644
--- a/drivers/nvmem/layouts/onie-tlv.c
+++ b/drivers/nvmem/layouts/onie-tlv.c
@@ -230,6 +230,7 @@ static const struct of_device_id onie_tlv_of_match_table[] = {
 	{ .compatible = "onie,tlv-layout", },
 	{},
 };
+MODULE_DEVICE_TABLE(of, onie_tlv_of_match_table);
 
 static struct nvmem_layout onie_tlv_layout = {
 	.name = "ONIE tlv layout",
@@ -241,4 +242,16 @@ static int __init onie_tlv_init(void)
 {
 	return nvmem_layout_register(&onie_tlv_layout);
 }
-subsys_initcall(onie_tlv_init);
+
+static void __exit onie_tlv_exit(void)
+{
+	nvmem_layout_unregister(&onie_tlv_layout);
+}
+
+module_init(onie_tlv_init);
+module_exit(onie_tlv_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Miquel Raynal <miquel.raynal@bootlin.com>");
+MODULE_DESCRIPTION("NVMEM layout driver for Onie TLV table parsing");
+MODULE_ALIAS("NVMEM layout driver for Onie TLV table parsing");
-- 
2.34.1

