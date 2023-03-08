Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67B226B0CD5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 16:33:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbjCHPdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 10:33:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232259AbjCHPcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 10:32:51 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ADE7D6EAE;
        Wed,  8 Mar 2023 07:32:25 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id B3B59FF813;
        Wed,  8 Mar 2023 15:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1678289544;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tqDLaqZ1GuVBw64kENerPspXdR7LpiuTsQla1HFP/KA=;
        b=cQ7VnWXm4rso7T5LFef6267qVl+4QhYqUFxU2isjgqiCwTqInek/KLy579lEji53gzli+B
        LrRilpvHwlhDCk3wz8+DKlOP+agaoxKT6CW8A49mBvQ+gFCcRI1b3w9RNVz1huEa9TIHfY
        yVX1CYkCnv3yL/cEPhmYuzI0uQ/wfFKE/eKIYy78/5pAsEQQefspKaHACG8aBN1z2RMtuc
        ypwOGfNgqyqv5ed1rZvjdpDIEFM1+W62NOjoaksmStTAf/fb6uouhXZxBjntlfv2AAKBYj
        SvISjtXfSImrrbkD8BuOaqqGZj6okeHftP9g4md7hRBYeXqcqDqV0YTCRLLBsw==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        <linux-kernel@vger.kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Walle <michael@walle.cc>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v3 11/20] nvmem: core: request layout modules loading
Date:   Wed,  8 Mar 2023 16:31:51 +0100
Message-Id: <20230308153200.682248-12-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230308153200.682248-1-miquel.raynal@bootlin.com>
References: <20230308153200.682248-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a storage device like an eeprom or an mtd device probes, it
registers an nvmem device if the nvmem subsystem has been enabled (bool
symbol). During nvmem registration, if the device is using layouts to
expose dynamic nvmem cells, the core will first try to get a reference
over the layout driver callbacks. In practice there is not relationship
that can be described between the storage driver and the nvmem
layout. So there is no way we can enforce both drivers will be built-in
or both will be modules. If the storage device driver is built-in but
the layout is built as a module, instead of badly failing with an
endless probe deferral loop, lets just make a modprobe call in case the
driver was made available in an initramfs with
of_device_node_request_module(), and offer a fully functional system to
the user.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Tested-by: Michael Walle <michael@walle.cc>
---
 drivers/nvmem/core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 51fd792b8d70..49b4bbaf59e8 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -17,6 +17,7 @@
 #include <linux/nvmem-provider.h>
 #include <linux/gpio/consumer.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/slab.h>
 
 struct nvmem_device {
@@ -761,6 +762,13 @@ static struct nvmem_layout *nvmem_layout_get(struct nvmem_device *nvmem)
 	if (!layout_np)
 		return NULL;
 
+	/*
+	 * In case the nvmem device was built-in while the layout was built as a
+	 * module, we shall manually request the layout driver loading otherwise
+	 * we'll never have any match.
+	 */
+	of_request_module(layout_np);
+
 	spin_lock(&nvmem_layout_lock);
 
 	list_for_each_entry(l, &nvmem_layouts, node) {
-- 
2.34.1

