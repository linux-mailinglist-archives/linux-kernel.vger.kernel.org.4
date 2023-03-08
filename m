Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84CF86B0CD4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 16:33:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232191AbjCHPdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 10:33:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbjCHPcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 10:32:47 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB963D5A7B;
        Wed,  8 Mar 2023 07:32:23 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 35ADAFF810;
        Wed,  8 Mar 2023 15:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1678289542;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7KeyBQUfcV1ky8pfB8UN0PcucnmwJo4XrlM30Q7JJvc=;
        b=AYiNuyBEWJM4eBys71tEUiEquTzUtgAJQyflZ4sppwXCsTUgHJ47x7esDynimmFQPBQTmk
        0E7rYTs3WT06c8yQ8FYOLtiAa2cHqw0dSwYpwqzZ2adSjhrLmfl6Fh3K0KbhnAF16woWUR
        7bsPuYHEk2JhrW4ImAu40iEmyvRmghwx/kI1rQM98XSwk/UNCo99MFP3jcyYzqAekIs3+q
        tEJ9sGW4mi7GwOk8x3MuwwIo9AZ3bhjAHInYfNloKADALFqZbKZXg944oDs9ulMGjY5E7k
        lTLll4LcLs5KXkHcvbuR1QccFZjWBlDDBNVhdazC1nGv45SAg3MSsNM65jTH7w==
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
Subject: [PATCH v3 10/20] nvmem: core: handle the absence of expected layouts
Date:   Wed,  8 Mar 2023 16:31:50 +0100
Message-Id: <20230308153200.682248-11-miquel.raynal@bootlin.com>
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
Tested-by: Michael Walle <michael@walle.cc>
---
 drivers/nvmem/core.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index b9be1faeb7be..51fd792b8d70 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -755,7 +755,7 @@ EXPORT_SYMBOL_GPL(nvmem_layout_unregister);
 static struct nvmem_layout *nvmem_layout_get(struct nvmem_device *nvmem)
 {
 	struct device_node *layout_np, *np = nvmem->dev.of_node;
-	struct nvmem_layout *l, *layout = NULL;
+	struct nvmem_layout *l, *layout = ERR_PTR(-EPROBE_DEFER);
 
 	layout_np = of_get_child_by_name(np, "nvmem-layout");
 	if (!layout_np)
@@ -938,6 +938,13 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
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
@@ -970,6 +977,7 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 err_remove_cells:
 	nvmem_device_remove_all_cells(nvmem);
 	nvmem_layout_put(nvmem->layout);
+err_teardown_compat:
 	if (config->compat)
 		nvmem_sysfs_remove_compat(nvmem, config);
 err_put_device:
-- 
2.34.1

