Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0A636AE7B3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 18:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbjCGRAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 12:00:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbjCGQ6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 11:58:12 -0500
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE6C959E0;
        Tue,  7 Mar 2023 08:54:54 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 49391C0007;
        Tue,  7 Mar 2023 16:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1678208093;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6hNxCYBR5yzRDGBSbfvJ7idoAKl7NjU5wAcCzaXPD2w=;
        b=SXd0K+s7oI2QByaA7bb9vJpRXYpl2uydhFjRxV+TmG/Ic38saSyLyA/G8YCRyzs8L8Scek
        NjRlMTPTf/IeLkL8n6psTRSeR3QNrdWCNXb+pnZZCwY2p2+Yg5BwXvp2Qgpd/l8vD/9sLi
        0w/QBkDSAcR6oXrTrdNiIiCpifkfphn8Slu9GCN02HvqIdRIQuT3YGMadwJ+yUvbZAs33I
        HCdP9bsnuXnxkhcx+N4RaT3Qna0xFb+aa1mckogyeUpMK7XLILmTfkj49OHELeXQP3BbqW
        /u99Ugi5LgvVeXLtI/l0il/lGuBeYuJ3Wr7bSoBTKQkr2uz76FIqTf0WBLtMvA==
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
Subject: [PATCH v2 14/21] nvmem: core: allow to modify a cell before adding it
Date:   Tue,  7 Mar 2023 17:53:52 +0100
Message-Id: <20230307165359.225361-15-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230307165359.225361-1-miquel.raynal@bootlin.com>
References: <20230307165359.225361-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Walle <michael@walle.cc>

Provide a way to modify a cell before it will get added. This is useful
to attach a custom post processing hook via a layout.

Signed-off-by: Michael Walle <michael@walle.cc>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/nvmem/core.c           | 4 ++++
 include/linux/nvmem-provider.h | 5 +++++
 2 files changed, 9 insertions(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 664d48f0dfa7..82e11b9576ad 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -695,6 +695,7 @@ static int nvmem_validate_keepouts(struct nvmem_device *nvmem)
 
 static int nvmem_add_cells_from_of(struct nvmem_device *nvmem)
 {
+	struct nvmem_layout *layout = nvmem->layout;
 	struct device *dev = &nvmem->dev;
 	struct device_node *child;
 	const __be32 *addr;
@@ -724,6 +725,9 @@ static int nvmem_add_cells_from_of(struct nvmem_device *nvmem)
 
 		info.np = of_node_get(child);
 
+		if (layout && layout->fixup_cell_info)
+			layout->fixup_cell_info(nvmem, layout, &info);
+
 		ret = nvmem_add_one_cell(nvmem, &info);
 		kfree(info.name);
 		if (ret) {
diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
index 3bfc23553a9e..be81cc88eabc 100644
--- a/include/linux/nvmem-provider.h
+++ b/include/linux/nvmem-provider.h
@@ -155,6 +155,8 @@ struct nvmem_cell_table {
  * @add_cells:		Will be called if a nvmem device is found which
  *			has this layout. The function will add layout
  *			specific cells with nvmem_add_one_cell().
+ * @fixup_cell_info:	Will be called before a cell is added. Can be
+ *			used to modify the nvmem_cell_info.
  * @owner:		Pointer to struct module.
  * @node:		List node.
  *
@@ -168,6 +170,9 @@ struct nvmem_layout {
 	const struct of_device_id *of_match_table;
 	int (*add_cells)(struct device *dev, struct nvmem_device *nvmem,
 			 struct nvmem_layout *layout);
+	void (*fixup_cell_info)(struct nvmem_device *nvmem,
+				struct nvmem_layout *layout,
+				struct nvmem_cell_info *cell);
 
 	/* private */
 	struct module *owner;
-- 
2.34.1

