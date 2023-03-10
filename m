Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68D5F6B4B3C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 16:36:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234334AbjCJPf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 10:35:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233884AbjCJPfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 10:35:21 -0500
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E07111B38;
        Fri, 10 Mar 2023 07:22:43 -0800 (PST)
Received: by mail-ot1-f44.google.com with SMTP id o4-20020a9d6d04000000b00694127788f4so3103348otp.6;
        Fri, 10 Mar 2023 07:22:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678461762;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IB8iTw6lo+GT2tL0twgsKIavP9xhmvwdcsuEsK0YWR8=;
        b=LHBFIK34ofA803yfkvza6EYuf+VW9ewgpyGeyw6Wxk37rC/+SZULE8MAd1sazBLFH3
         bofFAte3EV0rB4P5om/p92oSWTisQLrr57YlF10AUFoD53jbcKaizsNzLH4sXhnD83LU
         La0sZoPMJdBFg/hV55KkaYcKXFmpk1zBVfCf9ndAG8XNGBMqPbhUldDx5128pXbDrKEh
         AIjb0uPNdbrIEI8xznri2dQucYmR7qsSVRsIcWtuE4NPTugrNAZpw0aFlyyJsS8nDicU
         Xkp2uEgw4Qz3m3e9+mmhMWiL/Oztw8nujciK6/4+2Y7MLbCPAfk1nCDfEtzS9kGtcw3J
         yEYw==
X-Gm-Message-State: AO0yUKWBKoWLvJu4c7QheUht4OtI/qffH3KEGpA8j/fG+b+VdG8EijpG
        Q8qa3yEqS4Q7W7rQ5akqXTft7+dqNw==
X-Google-Smtp-Source: AK7set/jkKv59Toh5FHgl/WazfV3a0smzI5TaosdN1WA9XSptDPl1VvfF1sItgSI8nw35SGmNKjtJQ==
X-Received: by 2002:aca:1207:0:b0:383:fb18:aa7d with SMTP id 7-20020aca1207000000b00383fb18aa7dmr10733343ois.35.1678459699360;
        Fri, 10 Mar 2023 06:48:19 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id i131-20020acaea89000000b00383e0c1f6cdsm966509oih.27.2023.03.10.06.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 06:48:18 -0800 (PST)
Received: (nullmailer pid 1547137 invoked by uid 1000);
        Fri, 10 Mar 2023 14:47:36 -0000
From:   Rob Herring <robh@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] spi: omap2-mcspi: Use of_property_read_bool() for boolean properties
Date:   Fri, 10 Mar 2023 08:47:36 -0600
Message-Id: <20230310144736.1547110-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is preferred to use typed property access functions (i.e.
of_property_read_<type> functions) rather than low-level
of_get_property/of_find_property functions for reading properties.
Convert reading boolean properties to to of_property_read_bool().

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/spi/spi-omap2-mcspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index 6ba9b0d7710b..57ca49e6d9ee 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -1464,7 +1464,7 @@ static int omap2_mcspi_probe(struct platform_device *pdev)
 
 		of_property_read_u32(node, "ti,spi-num-cs", &num_cs);
 		master->num_chipselect = num_cs;
-		if (of_get_property(node, "ti,pindir-d0-out-d1-in", NULL))
+		if (of_property_read_bool(node, "ti,pindir-d0-out-d1-in"))
 			mcspi->pin_dir = MCSPI_PINDIR_D0_OUT_D1_IN;
 	} else {
 		pdata = dev_get_platdata(&pdev->dev);
-- 
2.39.2

