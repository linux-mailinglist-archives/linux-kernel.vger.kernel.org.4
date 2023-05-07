Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 013B06F9620
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 02:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233015AbjEGAkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 20:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232516AbjEGAia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 20:38:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD37918863;
        Sat,  6 May 2023 17:36:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 602206156F;
        Sun,  7 May 2023 00:36:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA34CC433D2;
        Sun,  7 May 2023 00:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683419792;
        bh=oHOBcHJeaDGIG5ugZ2/erKMhtehFMgYs80Xs7kg5fjA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rnCP4tXasGpE5Xxzj2+tFkK7L84kwuoGok40593q2TpAnofUU1TOOteXCOwkTYy8Q
         KBgIHvI/9pAxlfIygA6JKPH6v3FS3Na/k93SG+Iwb74fWEFqQJbR9hVbfRw7y6zjoI
         IEt3mdinj68j/DPBID5DioA4VX3qLKhvHCZqPeXXgo8SZ2eo4XVn7tFKgmKMem+4nY
         mNmBatbVjw9X6RyUIRSNZ4NPWCfoQJAKHaX5qDQJ1OOZYDUELhim6V5AYSVl0kQIBZ
         t6sBWHHIq5CGwD6naQ5fPnFNFm0oB6jREC749chg8wpTsfXMlW1GJlc5QmZzXYYBhu
         TgYfeTsMjNveQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Rodr=C3=ADguez=20Barbarin=2C=20Jos=C3=A9=20Javier?= 
        <JoseJavier.Rodriguez@duagon.com>,
        Jorge Sanjuan Garcia <jorge.sanjuangarcia@duagon.com>,
        Javier Rodriguez <josejavier.rodriguez@duagon.com>,
        Johannes Thumshirn <jth@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, morbidrsa@gmail.com
Subject: [PATCH AUTOSEL 5.4 9/9] mcb-pci: Reallocate memory region to avoid memory overlapping
Date:   Sat,  6 May 2023 20:36:09 -0400
Message-Id: <20230507003609.4079746-9-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230507003609.4079746-1-sashal@kernel.org>
References: <20230507003609.4079746-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rodríguez Barbarin, José Javier <JoseJavier.Rodriguez@duagon.com>

[ Upstream commit 9be24faadd085c284890c3afcec7a0184642315a ]

mcb-pci requests a fixed-size memory region to parse the chameleon
table, however, if the chameleon table is smaller that the allocated
region, it could overlap with the IP Cores' memory regions.

After parsing the chameleon table, drop/reallocate the memory region
with the actual chameleon table size.

Co-developed-by: Jorge Sanjuan Garcia <jorge.sanjuangarcia@duagon.com>
Signed-off-by: Jorge Sanjuan Garcia <jorge.sanjuangarcia@duagon.com>
Signed-off-by: Javier Rodriguez <josejavier.rodriguez@duagon.com>
Signed-off-by: Johannes Thumshirn <jth@kernel.org>
Link: https://lore.kernel.org/r/20230411083329.4506-3-jth@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mcb/mcb-pci.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/mcb/mcb-pci.c b/drivers/mcb/mcb-pci.c
index 14866aa22f753..22927c80ff469 100644
--- a/drivers/mcb/mcb-pci.c
+++ b/drivers/mcb/mcb-pci.c
@@ -31,7 +31,7 @@ static int mcb_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct resource *res;
 	struct priv *priv;
-	int ret;
+	int ret, table_size;
 	unsigned long flags;
 
 	priv = devm_kzalloc(&pdev->dev, sizeof(struct priv), GFP_KERNEL);
@@ -90,7 +90,30 @@ static int mcb_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (ret < 0)
 		goto out_mcb_bus;
 
-	dev_dbg(&pdev->dev, "Found %d cells\n", ret);
+	table_size = ret;
+
+	if (table_size < CHAM_HEADER_SIZE) {
+		/* Release the previous resources */
+		devm_iounmap(&pdev->dev, priv->base);
+		devm_release_mem_region(&pdev->dev, priv->mapbase, CHAM_HEADER_SIZE);
+
+		/* Then, allocate it again with the actual chameleon table size */
+		res = devm_request_mem_region(&pdev->dev, priv->mapbase,
+						table_size,
+						KBUILD_MODNAME);
+		if (!res) {
+			dev_err(&pdev->dev, "Failed to request PCI memory\n");
+			ret = -EBUSY;
+			goto out_mcb_bus;
+		}
+
+		priv->base = devm_ioremap(&pdev->dev, priv->mapbase, table_size);
+		if (!priv->base) {
+			dev_err(&pdev->dev, "Cannot ioremap\n");
+			ret = -ENOMEM;
+			goto out_mcb_bus;
+		}
+	}
 
 	mcb_bus_add_devices(priv->bus);
 
-- 
2.39.2

