Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15B0E6A6F52
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 16:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbjCAPXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 10:23:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbjCAPWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 10:22:51 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D69457FB;
        Wed,  1 Mar 2023 07:22:49 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id CAE8D60006;
        Wed,  1 Mar 2023 15:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1677684168;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=veHqp22wWolx6RiZnbbvLOutWer672c27ajS/GJmogc=;
        b=QVakPxE5LSVc9MxAkGBRSgmdbC2BCKTsWJTp+wDGqvTdkral5N3TNtKgiCFRSWhXG5WMjo
        y5voAUtX7dUaNEoz4+v3cznCrhhQUHj8r+Ed+5ErLy9xmAp1vlWxuXEhg04OX5ugK0GPyL
        93jz84NT+MnJKYx0T9USiBDJoi7S4iw6u7cmM6iPY92N3I/kvUAGX1Y26ffb3X/Qgvl4mk
        BL1KrYcQhG+YUtNzK0hnsspmRuDzPDGIoxqb3wLc4zluZpbfKsjgRE5xRJjgfI/8p+w8hj
        ulvz8jQkBfFn67nqFORPXj3LqTsHOh7WddcKfqG3YTc1At9Sa30cswQW36Anpw==
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
Subject: [PATCH 6/8] nvmem: core: Request layout modules loading
Date:   Wed,  1 Mar 2023 16:22:37 +0100
Message-Id: <20230301152239.531194-7-miquel.raynal@bootlin.com>
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
---
 drivers/nvmem/core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index a66c37a03a36..8e07b9df3221 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -17,6 +17,7 @@
 #include <linux/nvmem-provider.h>
 #include <linux/gpio/consumer.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/slab.h>
 
 struct nvmem_device {
@@ -768,6 +769,13 @@ static struct nvmem_layout *nvmem_layout_get(struct nvmem_device *nvmem)
 	if (!layout_np)
 		return NULL;
 
+	/*
+	 * In case the nvmem device was built-in while the layout was built as a
+	 * module, we shall manually request the layout driver loading otherwise
+	 * we'll never have any match.
+	 */
+	of_device_node_request_module(layout_np);
+
 	spin_lock(&nvmem_layout_lock);
 
 	list_for_each_entry(l, &nvmem_layouts, node) {
-- 
2.34.1

