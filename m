Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5479C6A6F4C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 16:23:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbjCAPXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 10:23:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbjCAPWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 10:22:49 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC3C410A4;
        Wed,  1 Mar 2023 07:22:47 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 6BDA560010;
        Wed,  1 Mar 2023 15:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1677684166;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1dh6uGZ61Q7do467wqoDaMh6uB2u9srGrh1AVvKSU6M=;
        b=VtSYrdBhwFAsMBULAFTYUYpOylcY4XED6Sw6J05beW6Q6pl0XGnYueudCn2JsgvgwiD7Bn
        J2vlIaTBeDzoBn73VzLTlszWkGkXD9XmvFTTj4cvyNOEmt769lODpdud+WqANq2iOt5Pkm
        kSZnQozL5PPeKmmUFm52qGZcR0M7cfXxSgwjY65axGIRxyZZziuL7dfjJ0DjJjxyGw/HHB
        OjGHqCGZPaloeHK5zTxGUBN5eZHFQDmZzJaPSadRdxcdTU8V9YppexKBcwNRQKLPRYtf+5
        qyiCIR6wemROamDlR68biNhH2W3OsTU0hvxpbOetLMib/ZKxsGpWkPlBj//OwQ==
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
Subject: [PATCH 4/8] nvmem: core: Fix error path ordering
Date:   Wed,  1 Mar 2023 16:22:35 +0100
Message-Id: <20230301152239.531194-5-miquel.raynal@bootlin.com>
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

The layout is being retrieved before the addition of nvmem cells and
after the creation of the sysfs entries. Soon the layout operation will
have the possibility to fail, hence adding a new goto label in the error
path. Before doing so, we need to fix the operation order in the error
path.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/nvmem/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 56b4b20a95a9..16044377a41d 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -975,9 +975,9 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 
 err_remove_cells:
 	nvmem_device_remove_all_cells(nvmem);
+	nvmem_layout_put(nvmem->layout);
 	if (config->compat)
 		nvmem_sysfs_remove_compat(nvmem, config);
-	nvmem_layout_put(nvmem->layout);
 err_put_device:
 	put_device(&nvmem->dev);
 
-- 
2.34.1

