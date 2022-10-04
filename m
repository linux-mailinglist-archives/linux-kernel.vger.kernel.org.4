Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF0725F4ABC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 23:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbiJDVOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 17:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbiJDVOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 17:14:16 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01CFB6C76D;
        Tue,  4 Oct 2022 14:14:15 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id i83-20020a1c3b56000000b003bd44dc526fso18695wma.3;
        Tue, 04 Oct 2022 14:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=XkXIwov4m/9qgzTg66a2/P6fWI2LfTY8JgQsDcsVYWE=;
        b=ZrP1PLy53pP/rc8G4TvGBmXpTqmFZ/SY6Htzo8NibSOmVtY5adRrD3vJwME8Sp7BnS
         F4Z5apezARFi0/vJJ5HHOJte9xist+cmEFPDr142wi9FepLdkpOAhkfEfM5p7q1rIL9d
         YUvhs6I7tQ6tVqy9xKEv/QjdLMn/ipVXXfAdhGfa//n0Lgd46YRpu3fouTmDDIIvE20e
         amWGkIgnZIF28BO7z7AzI+AdVxiql25wkoxJytUn1+x4tVX5EkVWZuqUj1lDxkwRIjlB
         ow/Q82t9+K55SO0V1yeidCMeaIT832YiHAH6jnULNSGlFhDBmDfM+7NLxROOKXaBt0aD
         j2UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=XkXIwov4m/9qgzTg66a2/P6fWI2LfTY8JgQsDcsVYWE=;
        b=eGEQ3Nt63xUKKpP6LA6vIAakSJfoJUXXEeQls3q+xnCZruOiH76kP8Hpx0CTkKnhq5
         ZmNFGCwir8VoaSln6Z6EjT3aaFse6LymJGesJ1SGUQYqdTNSPsydnWQQfVo/3tjx+dnf
         LohyTLhYYDvo5SgVJPfo8kgPBb2syrugKvpj67DmZrUBFTNZxF/r+AQCoG9MbOa6OikF
         sxGjqXWmV2URAeoQZDxsdldtanlr/vlgUr+xOfrZPQY4uYfe2nnOPchY03CU0r94Yveq
         6w/2RlwFgIQ8Tzy3XZdo2JPvriNP59s2mO7K7grssxxgUFnfzcl/wjjgXQcIX6yDzm8U
         Mt+Q==
X-Gm-Message-State: ACrzQf1wDHnl5ScCWfKo5LWoWElul5OXFj45pxobRe7MUbQ5EGhgc+52
        wfDqqD/JIjDPgVpAK9igiQo=
X-Google-Smtp-Source: AMsMyM59l9ZC8Yl3Ao249Cc2WZqR71AVFD0jEz1pnEuVgMeRYp98p2nDFBIkgSgSwOvRdu9IOf0ppA==
X-Received: by 2002:a05:600c:6003:b0:3b5:aef:d8d7 with SMTP id az3-20020a05600c600300b003b50aefd8d7mr1141722wmb.50.1664918053464;
        Tue, 04 Oct 2022 14:14:13 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id j2-20020adfd202000000b002285f73f11dsm16887940wrh.81.2022.10.04.14.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 14:14:13 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        u.kleine-koenig@pengutronix.de, Mark Brown <broonie@kernel.org>,
        linux-mtd@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: dataflash: Remove duplicated id table
Date:   Tue,  4 Oct 2022 22:14:12 +0100
Message-Id: <20221004211412.182940-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A previous change added a new id table but failed to remove
the original assignment to .id_table. Remove the original
to clean up a clang scan build warning:

warning: initializer overrides prior initialization of this
subobject [-Winitializer-overrides]

Fixes: ac4f83482afb ("mtd: dataflash: Add SPI ID table")
Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/mtd/devices/mtd_dataflash.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mtd/devices/mtd_dataflash.c b/drivers/mtd/devices/mtd_dataflash.c
index 25bad4318305..c6d25331e00c 100644
--- a/drivers/mtd/devices/mtd_dataflash.c
+++ b/drivers/mtd/devices/mtd_dataflash.c
@@ -939,7 +939,6 @@ static struct spi_driver dataflash_driver = {
 		.name		= "mtd_dataflash",
 		.of_match_table = of_match_ptr(dataflash_dt_ids),
 	},
-	.id_table = dataflash_dev_ids,
 
 	.probe		= dataflash_probe,
 	.remove		= dataflash_remove,
-- 
2.37.2

