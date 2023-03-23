Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 017476C68B6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 13:45:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbjCWMpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 08:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjCWMpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 08:45:17 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A65F22D5A;
        Thu, 23 Mar 2023 05:45:16 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id r29so20318725wra.13;
        Thu, 23 Mar 2023 05:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679575515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=umlB44Y9/RQzoXmteHKil0EY6NqmhxRrqoCy6EX0T8g=;
        b=TzvzX1Xn+K5UaV3D5wgIpQWr0uYwlfNOc90LuAIMcZYFZp7B3umvE+v7lr9BCy0nCY
         2LeLr4VC/IAEw8f+btKGzFlHIChD3cn9nYnFxa5l7Oq1P0oSvLaLLRNURCgxBaF2rr18
         XUPUih1JRmGPpCaXVkGakzvgyYUDUu0vflKjwZkI83+R040kXlltuc1OJyjEFoMxJ/Z/
         w4TlVcDb8mMkQT2ezaRv304zX+NjCff7UnC3UH/eSjLhUCQFP+EU4fOUC4Hesp6nnQyA
         HQuZ0ai4jSMrvj6f56oT8I9b25o+eoMqZkhKDlPNX/QbKyDeHCmnNcVXV2wTMPYMElbW
         6n6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679575515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=umlB44Y9/RQzoXmteHKil0EY6NqmhxRrqoCy6EX0T8g=;
        b=shtB0HoIpnUGwK1WryzBOAO0SPIF4+N4zwTClg1xvgE6anmSlgzB2AcCvmIAFVMRCo
         O80EZxg5jSOEHo7xRXe8jnJkAXQrRBZYjErPGdpZ5R92CLXQwfLPblrAkbmFfAZ8oSGF
         kOZPwcH/tgIlmvCC0a7E/UZKALaDwGtuMp6Gxp3iG25v8evgmj86+njqs6nqyikNaL0v
         2WMUMuIw7awlqHEf5h1+X2EcmOOclZ3HFM0PdP022iWrkF3z++y05Y9Ys5xW/xZUXyJ7
         mvuQwdoH8Wb9DmpWIOSZtGUNiWqAeT3N5IQG0xb553JdqHiHRrkhQLJ9mu9ThWX4a06m
         8QhQ==
X-Gm-Message-State: AAQBX9czszjfbCUmnhAzuMEea4sFcZJo+kSk4MTa4+jmy8Ja9uPI60ry
        BbOlwD8q7R7esR7lF7VdHoI=
X-Google-Smtp-Source: AKy350ZDqwo8YwYfUss1BF/h6Qz1Yl5+RUi3hjTf9ysdr0R6WyZz+l/CRqg0gdF/P9gfC7ryPqWBWQ==
X-Received: by 2002:a5d:4a4d:0:b0:2cf:e132:bfbb with SMTP id v13-20020a5d4a4d000000b002cfe132bfbbmr2313892wrs.38.1679575514978;
        Thu, 23 Mar 2023 05:45:14 -0700 (PDT)
Received: from atlantis.lan (255.red-79-146-124.dynamicip.rima-tde.net. [79.146.124.255])
        by smtp.gmail.com with ESMTPSA id j9-20020a05600c1c0900b003ee6aa4e6a9sm1942939wms.5.2023.03.23.05.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 05:45:14 -0700 (PDT)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        masonccyang@mxic.com.tw, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH 2/2] mtd: nand: raw: macronix: allow disabling block protection
Date:   Thu, 23 Mar 2023 13:45:10 +0100
Message-Id: <20230323124510.2484808-3-noltari@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230323124510.2484808-1-noltari@gmail.com>
References: <20230323124510.2484808-1-noltari@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some devices hang when block protection is enabled, so let's add a boolean
property to allow disabling it.

Fixes: 03a539c7a118 ("mtd: rawnand: Macronix: Add support for block protection")
Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
 drivers/mtd/nand/raw/nand_macronix.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mtd/nand/raw/nand_macronix.c b/drivers/mtd/nand/raw/nand_macronix.c
index 1472f925f386..b9f0338ebdaf 100644
--- a/drivers/mtd/nand/raw/nand_macronix.c
+++ b/drivers/mtd/nand/raw/nand_macronix.c
@@ -219,9 +219,13 @@ static int mxic_nand_unlock(struct nand_chip *chip, loff_t ofs, uint64_t len)
 
 static void macronix_nand_block_protection_support(struct nand_chip *chip)
 {
+	struct device_node *dn = nand_get_flash_node(chip);
 	u8 feature[ONFI_SUBFEATURE_PARAM_LEN];
 	int ret;
 
+	if (of_property_read_bool(dn, "mxic,disable-block-protection"))
+		return;
+
 	bitmap_set(chip->parameters.get_feature_list,
 		   ONFI_FEATURE_ADDR_MXIC_PROTECTION, 1);
 
-- 
2.30.2

