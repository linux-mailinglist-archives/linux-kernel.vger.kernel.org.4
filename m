Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84B2F63F9CC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 22:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbiLAV2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 16:28:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbiLAV17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 16:27:59 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 364261FF8E
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 13:27:57 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id cg5so2649977qtb.12
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 13:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=timesys-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=li+eohcDsrqZE5thNT9n12zEt/TyQONsMqyuNuEAzg4=;
        b=PjVzQkoENto/e487Z27Cxxpm4kMorb2W7vhofH1USRr3gHeMGX7xgxidNv6FvEoRUv
         K3syUnaPBXdo28aVd+NnOf5D1NiOKyH8lKuIfhKRQLmcZo43RXPp5e/XR2jfPs7Q0/xi
         3rYByZ/zu1DikWacoISBNi07ebXBx/H95oysyXr8MDuC9LY3uRncMC8MmVMUWc1dSfSv
         P4p3im5osoIRnplNXe8WHd8OK4IUSkUMNIlymWtLgPzkJ2SSF4BPiLZ3427ZTZlYAy3O
         KSZYMaePC29JfVkG93xmOjJ87Bb7ZnmqA8QX1i3xkEBuzwWVK1a2Ks9cpl9IPaDo3gXz
         ho0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=li+eohcDsrqZE5thNT9n12zEt/TyQONsMqyuNuEAzg4=;
        b=bidcxclml41YPqlai3pjUjaorWcEGRiHkBq+DXruBupqUEPTZ3zdC+sWpYTHeWKFUm
         OcW+ViFiIu3GWR9i0DAIsg/3T2f5FX4IqDBkX3prMXYV6OczeNmRPXMoPp0KsphARkVC
         qbllf5zd7moPQgMwJCp6gBMUMdwc4WoVDUzUka1NMW5ltqI8cZNARYm/wMRshP6sNQgS
         2YDP1ChIEk5vMUXsiRbI6QFNi6rymnTqNCNOuXyp0SAoSrBS29Blsy+2yIGU/9x4v7hr
         TVaafwiAFrcS+wwAHK52/RJSAP653Xtu2NGWV8dd0wLW9xGOVde/uMvmOCiIu+xjYRsj
         YTLQ==
X-Gm-Message-State: ANoB5pnAQ+KzZxkQYOUxVHRGClLHXm7lh21xNKzuqFk2r/8nWMq4ChRB
        MIDDj0rNtJHUQymrV512wad8lw==
X-Google-Smtp-Source: AA0mqf5uQGlphPSs2yylD15tO00XUorm7g61qOodpzOyei9cn/5JblGPq2nwJQ0mmcgvA21co+GUzg==
X-Received: by 2002:ac8:714a:0:b0:3a6:8aa9:3b85 with SMTP id h10-20020ac8714a000000b003a68aa93b85mr10168073qtp.144.1669930076851;
        Thu, 01 Dec 2022 13:27:56 -0800 (PST)
Received: from nathan-ideapad.. (d-75-76-18-234.oh.cpe.breezeline.net. [75.76.18.234])
        by smtp.gmail.com with ESMTPSA id l15-20020a37f90f000000b006fc447eebe5sm4071321qkj.27.2022.12.01.13.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 13:27:56 -0800 (PST)
From:   Nathan Barrett-Morrison <nathan.morrison@timesys.com>
Cc:     nathan.morrison@timesys.com, greg.malysa@timesys.com,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org (open list:SPI NOR SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 3/3] mtd: spi-nor: Add support for IS25LX256 operating in 1S-8S-8S octal read mode
Date:   Thu,  1 Dec 2022 16:27:50 -0500
Message-Id: <20221201212750.267721-4-nathan.morrison@timesys.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221201212750.267721-1-nathan.morrison@timesys.com>
References: <20221201212750.267721-1-nathan.morrison@timesys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the IS25LX256 chip into the ISSI flash_info parts table

Signed-off-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
---
 drivers/mtd/spi-nor/issi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mtd/spi-nor/issi.c b/drivers/mtd/spi-nor/issi.c
index 89a66a19d754..98cc5e1d9c18 100644
--- a/drivers/mtd/spi-nor/issi.c
+++ b/drivers/mtd/spi-nor/issi.c
@@ -74,6 +74,9 @@ static const struct flash_info issi_nor_parts[] = {
 		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
 		FIXUP_FLAGS(SPI_NOR_4B_OPCODES)
 		.fixups = &is25lp256_fixups },
+	{ "is25lx256", INFO(0x9d5a19, 0, 128 * 1024, 256)
+		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_4B_OPCODES |
+			      SPI_NOR_OCTAL_READ_1_8_8) },
 
 	/* PMC */
 	{ "pm25lv512",   INFO(0,        0, 32 * 1024,    2)
-- 
2.30.2

