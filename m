Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC67F6B80A5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 19:31:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjCMSbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 14:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbjCMSas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 14:30:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A901499A
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 11:30:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 78B98B811E7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 18:30:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E690CC433D2;
        Mon, 13 Mar 2023 18:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678732199;
        bh=NvUcPCqXclVT0vDCEaH778GVQZ2rqILZ8eRefC/g5TQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MLMA0/W4RIYMRSO1RYJk3EvULfF9X82t6F0IpxQCpIqQu/2t2VdHyACPpsqR/KTg1
         rH9wAim3CUuFFGIspkL/zcHN4Z+Bg/Xul2JQRfXjS/DaL54wFjZ8No+Gchk7x4mQNs
         h3oP3oexGZZzUBUd1yEwNczLF//yo90Wc/2CjaZo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     rafael@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
Subject: [PATCH 21/36] irqchip/mbigen: move to use bus_get_dev_root()
Date:   Mon, 13 Mar 2023 19:29:03 +0100
Message-Id: <20230313182918.1312597-21-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230313182918.1312597-1-gregkh@linuxfoundation.org>
References: <20230313182918.1312597-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1593; i=gregkh@linuxfoundation.org; h=from:subject; bh=NvUcPCqXclVT0vDCEaH778GVQZ2rqILZ8eRefC/g5TQ=; b=owGbwMvMwCRo6H6F97bub03G02pJDCn82ZXX5P+xTk86lSulc/TLbwa3X8tdmtXbS/Nvz1MLN VojlcHfEcvCIMjEICumyPJlG8/R/RWHFL0MbU/DzGFlAhnCwMUpABMxYmNYMG15zvGHYWdeOFS7 iXy4OsPSYt4pLoYFcyQtW4v6TC5ebAl6HaN8KX8d7+o3AA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Direct access to the struct bus_type dev_root pointer is going away soon
so replace that with a call to bus_get_dev_root() instead, which is what
it is there for.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
Note, this is a patch that is a prepatory cleanup as part of a larger
series of patches that is working on resolving some old driver core
design mistakes.  It will build and apply cleanly on top of 6.3-rc2 on
its own, but I'd prefer if I could take it through my driver-core tree
so that the driver core changes can be taken through there for 6.4-rc1.

 drivers/irqchip/irq-mbigen.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-mbigen.c b/drivers/irqchip/irq-mbigen.c
index f3faf5c99770..30ca1bf7fc8b 100644
--- a/drivers/irqchip/irq-mbigen.c
+++ b/drivers/irqchip/irq-mbigen.c
@@ -245,11 +245,14 @@ static int mbigen_of_create_domain(struct platform_device *pdev,
 		if (!of_property_read_bool(np, "interrupt-controller"))
 			continue;
 
-		parent = platform_bus_type.dev_root;
-		child = of_platform_device_create(np, NULL, parent);
-		if (!child) {
-			of_node_put(np);
-			return -ENOMEM;
+		parent = bus_get_dev_root(&platform_bus_type);
+		if (parent) {
+			child = of_platform_device_create(np, NULL, parent);
+			put_device(parent);
+			if (!child) {
+				of_node_put(np);
+				return -ENOMEM;
+			}
 		}
 
 		if (of_property_read_u32(child->dev.of_node, "num-pins",
-- 
2.39.2

