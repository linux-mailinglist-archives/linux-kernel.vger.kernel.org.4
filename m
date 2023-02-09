Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B34EB690A2C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 14:31:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbjBINbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 08:31:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbjBINaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 08:30:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 710BE5D1E7;
        Thu,  9 Feb 2023 05:30:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F07F161AC4;
        Thu,  9 Feb 2023 13:30:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4B3DC43239;
        Thu,  9 Feb 2023 13:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675949443;
        bh=HISCOQlywscKKiMV1pBIVu7ICjzhN///DKg1eFvToD4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xu86u8HdonbGLeFJ+mZB1yqGEQXC4M0SBIKvjGHzi4Rg2oGVCNhFcvkN08I7P2CZR
         exdI9GkIvPeNQqxQ2lku9EcNAioStI82ppokOEDdUcSYjL41tvm8+LdNtU6OkBzHVS
         12ed9EjvZ6CJ3S6YI/a3LeKqDD0toHeo2Vur+8pgEI/zEPWH5Ny4PWL6dAvNBvtM2w
         o6GTZayDVlY5RsYmKAsJsRg/203JlLlgyQu2yr1KJViRkLOZgK/p4gYl8ZOZatNvCt
         +XeKr5TsfKobVo8cuDYrsaBfZOa3868riTW+jwKe+gUgzAhxbRic7FfITXVdRqIH3M
         Zh2wZIG2YUomw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pQ71H-0001Ld-Lj; Thu, 09 Feb 2023 14:31:23 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc:     x86@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Subject: [PATCH v5 18/19] irqchip/mvebu-odmi: Use irq_domain_create_hierarchy()
Date:   Thu,  9 Feb 2023 14:23:22 +0100
Message-Id: <20230209132323.4599-19-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230209132323.4599-1-johan+linaro@kernel.org>
References: <20230209132323.4599-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the irq_domain_create_hierarchy() helper to create the hierarchical
domain, which both serves as documentation and avoids poking at
irqdomain internals.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Hsin-Yi Wang <hsinyi@chromium.org>
Tested-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/irqchip/irq-mvebu-odmi.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/irqchip/irq-mvebu-odmi.c b/drivers/irqchip/irq-mvebu-odmi.c
index dc4145abdd6f..108091533e10 100644
--- a/drivers/irqchip/irq-mvebu-odmi.c
+++ b/drivers/irqchip/irq-mvebu-odmi.c
@@ -161,7 +161,7 @@ static struct msi_domain_info odmi_msi_domain_info = {
 static int __init mvebu_odmi_init(struct device_node *node,
 				  struct device_node *parent)
 {
-	struct irq_domain *inner_domain, *plat_domain;
+	struct irq_domain *parent_domain, *inner_domain, *plat_domain;
 	int ret, i;
 
 	if (of_property_read_u32(node, "marvell,odmi-frames", &odmis_count))
@@ -197,16 +197,17 @@ static int __init mvebu_odmi_init(struct device_node *node,
 		}
 	}
 
-	inner_domain = irq_domain_create_linear(of_node_to_fwnode(node),
-						odmis_count * NODMIS_PER_FRAME,
-						&odmi_domain_ops, NULL);
+	parent_domain = irq_find_host(parent);
+
+	inner_domain = irq_domain_create_hierarchy(parent_domain, 0,
+						   odmis_count * NODMIS_PER_FRAME,
+						   of_node_to_fwnode(node),
+						   &odmi_domain_ops, NULL);
 	if (!inner_domain) {
 		ret = -ENOMEM;
 		goto err_unmap;
 	}
 
-	inner_domain->parent = irq_find_host(parent);
-
 	plat_domain = platform_msi_create_irq_domain(of_node_to_fwnode(node),
 						     &odmi_msi_domain_info,
 						     inner_domain);
-- 
2.39.1

