Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39DED63F842
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 20:31:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbiLATbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 14:31:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbiLATae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 14:30:34 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D86C8D2D
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 11:30:21 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id h16so2208028qtu.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 11:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=timesys-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8qZZ/bmZwEI9aDSPcyDyAicp7ItEQHVjMS3j20zf9fQ=;
        b=aLynhYNyioy+NfHU2wZDQeTHz+lUZ8ovDqQOsYmMrvKUArjXnpnIGeVFpkjV+GMIrF
         z7kQV8oVgUb5/y4/fYUBu9KgERLHJyOPBDzfFVX3GSLCIyT0B9++txvs8jEtstB9R5nI
         714uIkH7csYI/PaSVEqz2yFf2CSRfTG4dhZvA2hlZEmvEe7MHGpvMR1LZ/oZs02tJ4Sw
         zztIViIYrrMentHreQwZgasrF28zBZ/Mx3+yKT1UdX7d6WMvhf2cH7v2R7iuAfJHq8Mp
         U7xTPPsII92xfyyyBw9EyuEjjpiow2qQzq4Pr1LPGb4xB9Fb0I1u4ZC1zKQXi13RTug8
         hdcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8qZZ/bmZwEI9aDSPcyDyAicp7ItEQHVjMS3j20zf9fQ=;
        b=KhpjNdJ+V2qjx3ycILTsAcY2UxxGcLSKB3weEWMUyzKW1so7mNkpALWKPmcG2hhJ0Y
         GcGn6UyFd4r/qqlJ+vfX91c2Yp2Hk/bLY2ejmR2AO1/qaEhNWo+RS9VnSTaM4z5HkwZG
         oAhRWnHzR4HwJUNX64axZe90XdoQUB5mx3O/KaDXLWQ9UXnbWV+lkN8n+rRhYYfOzcJd
         AD9cexLKrUbUYACgDkgiszgZrFg5RCtFPuVaJE/Kr827KKsMOaH7vL9XzwZoZ9XzNXv4
         bcMezol4wLKa/6ORHpaCYV9GAcYUCNJSGif4U2Rgn51+6cN94PNXhhc0foohgH8XQIAi
         m9hg==
X-Gm-Message-State: ANoB5pn9PihPH9GAS0eJuza+41fzQyYRkPYRjMn5Qq3u0HsGHvX5Ev04
        G+bIBciKPuJzjTtya6305Zog1Q==
X-Google-Smtp-Source: AA0mqf5At6RxhQv7SNejD5cYSTYbLIgr8s1qOciJA/0hX80qzNespQZ+0by4P8hyG8anjnTanPYC0g==
X-Received: by 2002:a05:622a:40cb:b0:3a5:7e65:ddeb with SMTP id ch11-20020a05622a40cb00b003a57e65ddebmr44639337qtb.424.1669923020093;
        Thu, 01 Dec 2022 11:30:20 -0800 (PST)
Received: from nathan-ideapad.. (d-75-76-18-234.oh.cpe.breezeline.net. [75.76.18.234])
        by smtp.gmail.com with ESMTPSA id h19-20020ac85153000000b003a6328ee7acsm2977748qtn.87.2022.12.01.11.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 11:30:19 -0800 (PST)
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
Subject: [PATCH v2 3/3] mtd: spi-nor: Add support for IS25LX256 operating in 1S-1S-8S octal read mode
Date:   Thu,  1 Dec 2022 14:30:06 -0500
Message-Id: <20221201193007.261690-4-nathan.morrison@timesys.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221201193007.261690-1-nathan.morrison@timesys.com>
References: <20221201193007.261690-1-nathan.morrison@timesys.com>
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
 drivers/mtd/spi-nor/issi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mtd/spi-nor/issi.c b/drivers/mtd/spi-nor/issi.c
index 89a66a19d754..f00f1e621d84 100644
--- a/drivers/mtd/spi-nor/issi.c
+++ b/drivers/mtd/spi-nor/issi.c
@@ -74,6 +74,8 @@ static const struct flash_info issi_nor_parts[] = {
 		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
 		FIXUP_FLAGS(SPI_NOR_4B_OPCODES)
 		.fixups = &is25lp256_fixups },
+	{ "is25lx256", INFO(0x9d5a19, 0, 128 * 1024, 256)
+		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_4B_OPCODES | SPI_NOR_OCTAL_READ) },
 
 	/* PMC */
 	{ "pm25lv512",   INFO(0,        0, 32 * 1024,    2)
-- 
2.30.2

