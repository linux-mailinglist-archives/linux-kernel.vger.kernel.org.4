Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6443E63F75B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 19:16:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbiLASQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 13:16:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbiLASPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 13:15:53 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D093EBC3
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 10:15:48 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id h10so1880670qvq.7
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 10:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=timesys-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pANXxsT6s2u79mRoyA7VZ+6E4AhguQU1FVPz7KDrpYU=;
        b=olNGjVtiPLiNntuyZnuyzwmHYLt0s6oLYFu/0V27voBfVPFapu9jXckEHeCKR8FL3B
         T2tfD4Ozdrh9kaT2P6X7hneUOM4QlKxfnz3VBQsSqtm04pjqyRWRgnHTpZjROk58R6d5
         BHPB9C6rM3xRNba5hfBIZvA1IfroUnyUyVe7iJzzr4sRC3hz3F3JHUX9gLS++kt3yrH6
         KeU8Ba7vuSJWe8YWokOB9+aLE6s4wRJAzo3CeAej4s4SJH9HLTTSccuYczyriCmH66gj
         F5pP+VgbuVupiWARmQLGS2z3iKJh+LucWtVNr7bPUKGq+Sz+fxiQ+suLaF2MyDSwmmOg
         T/ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pANXxsT6s2u79mRoyA7VZ+6E4AhguQU1FVPz7KDrpYU=;
        b=Mk5K6vTFMMms0zlZknsirwqXIgTAmhluuSgQReETsKGKgxf/JWRU9vD4Pau63rMbBl
         GxMy16uke+cbZRfjferLG69olK1l0bdvO6y+v9CfHHQ7tEmbDaU8a7zYcJjiu/o9x71Z
         iV+BfoWxqCpL/0CnCNW/+3AVajr+YU+j2BgYHMzxRRMZ0Dv9cJGVlfNahL7jAiANn+3/
         KAP365edrda6xVjSlpCit35lCZyiYc6A1GQNCb9zgapr3WHuuITQeG5GAMfAOqoYkphG
         4MH1tJxlNDMQoot3lytFR85sH2coosacENHfzSZJART2KrL0KVGxcnc/QTf6ZOLzNZMh
         JlNQ==
X-Gm-Message-State: ANoB5plCBDjGQ1gm5a3Z34F9dujyj2Tf5Kr7GqLuTtXMDcUiqO+UkPnv
        MHQ/a5a8ISF5ePkomzDb4fBjYOlcksmSU+Cd
X-Google-Smtp-Source: AA0mqf5PrTTB1RgDgjYUeisc+mu8R9Hxa0dB3nk89uv9m8akQnghVEox8A3zsm9NMVFX4/+134jktQ==
X-Received: by 2002:a05:6214:5ec1:b0:4b8:2b54:b798 with SMTP id mn1-20020a0562145ec100b004b82b54b798mr43784980qvb.37.1669918547940;
        Thu, 01 Dec 2022 10:15:47 -0800 (PST)
Received: from nathan-ideapad.. (d-75-76-18-234.oh.cpe.breezeline.net. [75.76.18.234])
        by smtp.gmail.com with ESMTPSA id f12-20020ac8464c000000b003a55fe9f352sm2908912qto.64.2022.12.01.10.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 10:15:47 -0800 (PST)
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
Subject: [PATCH 3/3] mtd: spi-nor: Add support for IS25LX256 operating in 1S-1S-8S mode
Date:   Thu,  1 Dec 2022 13:15:32 -0500
Message-Id: <20221201181532.255449-4-nathan.morrison@timesys.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221201181532.255449-1-nathan.morrison@timesys.com>
References: <20221201181532.255449-1-nathan.morrison@timesys.com>
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
index 89a66a19d754..b4412a9afc4e 100644
--- a/drivers/mtd/spi-nor/issi.c
+++ b/drivers/mtd/spi-nor/issi.c
@@ -74,6 +74,9 @@ static const struct flash_info issi_nor_parts[] = {
 		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
 		FIXUP_FLAGS(SPI_NOR_4B_OPCODES)
 		.fixups = &is25lp256_fixups },
+	{ "is25lx256", INFO(0x9d5a19, 0, 128 * 1024, 256)
+		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_4B_OPCODES |
+			      SPI_NOR_OCTAL_PP | SPI_NOR_OCTAL_READ) },
 
 	/* PMC */
 	{ "pm25lv512",   INFO(0,        0, 32 * 1024,    2)
-- 
2.30.2

