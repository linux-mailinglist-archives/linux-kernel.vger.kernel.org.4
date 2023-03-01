Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC0656A6F51
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 16:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbjCAPXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 10:23:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbjCAPWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 10:22:50 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E649442BD9;
        Wed,  1 Mar 2023 07:22:48 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 9DD6960013;
        Wed,  1 Mar 2023 15:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1677684167;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GuIzUxO4lQXjU9mkGsm3TUZaxNfzhaCKElzogF6isV0=;
        b=fMXMYqkWJ3UjHLEh6WJlxZ/yVh1q0t2kjD0aviSY8eAz9MuvL53UfdXKX4S4xAwjSWfFNn
        sDrjZT/U5TPdJ7Eqc4rmRZiV8pM23fZbc4f2RY5cI59HOAp3BT7Psti1VTHB69Un/OKV+K
        DZE/pfCJLZMu/u7aKcd3Odj9nOZpNB/EPouA4si1lgYNw4M/JAi/MrmLmDHo69R3OA3Wcd
        O6a/tnNE0E7IoAB7wBhUX+uNvWDi12uTYaeKoc2kLL3cNxS4W2VmCO8TAng9J4+XFUEUkF
        VFwRQ0JVRVsFIKrDgcViHCC763rFlu06DgIttgms+3/LrHjGduUhjt/iFTwbQg==
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
Subject: [PATCH 5/8] nvmem: core: Handle the absence of expected layouts
Date:   Wed,  1 Mar 2023 16:22:36 +0100
Message-Id: <20230301152239.531194-6-miquel.raynal@bootlin.com>
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

Make nvmem_layout_get() return -EPROBE_DEFER while the expected layout
is not available. This condition cannot be triggered today as nvmem
layout drivers are initialed as part of an early init call, but soon
these drivers will be converted into modules and be initialized with a
standard priority, so the unavailability of the drivers might become a
reality that must be taken care of.

Let's anticipate this by telling the caller the layout might not yet be
available. A probe deferral is requested in this case.

Please note this does not affect any nvmem device not using layouts,
because an early check against the "nvmem-layout" container presence
will return NULL in this case.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/nvmem/core.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 16044377a41d..a66c37a03a36 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -762,7 +762,7 @@ EXPORT_SYMBOL_GPL(nvmem_layout_unregister);
 static struct nvmem_layout *nvmem_layout_get(struct nvmem_device *nvmem)
 {
 	struct device_node *layout_np, *np = nvmem->dev.of_node;
-	struct nvmem_layout *l, *layout = NULL;
+	struct nvmem_layout *l, *layout = ERR_PTR(-EPROBE_DEFER);
 
 	layout_np = of_get_child_by_name(np, "nvmem-layout");
 	if (!layout_np)
@@ -944,6 +944,13 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 	 * pointer will be NULL and nvmem_layout_put() will be a noop.
 	 */
 	nvmem->layout = config->layout ?: nvmem_layout_get(nvmem);
+	if (IS_ERR(nvmem->layout)) {
+		rval = PTR_ERR(nvmem->layout);
+		nvmem->layout = NULL;
+
+		if (rval == -EPROBE_DEFER)
+			goto err_teardown_compat;
+	}
 
 	if (config->cells) {
 		rval = nvmem_add_cells(nvmem, config->cells, config->ncells);
@@ -976,6 +983,7 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 err_remove_cells:
 	nvmem_device_remove_all_cells(nvmem);
 	nvmem_layout_put(nvmem->layout);
+err_teardown_compat:
 	if (config->compat)
 		nvmem_sysfs_remove_compat(nvmem, config);
 err_put_device:
-- 
2.34.1

