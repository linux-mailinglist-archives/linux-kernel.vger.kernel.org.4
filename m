Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF6E68BA1D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 11:29:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbjBFK2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 05:28:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbjBFK2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 05:28:30 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A0661969C
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 02:28:26 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id m16-20020a05600c3b1000b003dc4050c94aso8349907wms.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 02:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dUNPIWp5WTSOCDKia5k+jXCL26J1A9hep40mE5FWQns=;
        b=AXDA1USmva4sumEPKRwMr1USITH+OPrUm4S+vjWfJx9a08hCTxDJ1lbS8W/tjNnSE4
         O564hE9Z2HP4DyRTU5LDPQArg6awoOWYo6KaIrpi/YIIuSIHjKB+xo2v93icpOoCdeSO
         aufPRwy7LZCXn2JQxYHuSlnZlRTi/4MMq9N0pB2IfCO/iRzcbPX2oNsK0R+cs7Z3A5Jw
         i/vIqeJbAUrRs+dvhS6PgOqXbhyqCNEVpjG9JwoSn/h/U32U29xKrgET28efxrtuXSvy
         i8WJVPSp467gk/FBVkCJ9yRpCJf53lCfifPybedQquagc5JfkxUQDVIOOoUNKELrB+aN
         xPgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dUNPIWp5WTSOCDKia5k+jXCL26J1A9hep40mE5FWQns=;
        b=D5UKilTI6hwf/AOcesd2/b6dsm4pw7eKzPftYJzumZ/7uLONgvWf0FL4vmC3Oz32ik
         lcMzoRsi5wM9jxbrJnHII/un8PrihTY146Lbe1v9YA+ptnPAp+obd2OqJc+6fRY/PP2z
         4DEDwUXV3/44nGsNmSSNJL6voLeHnUc8IjqwhLoVoCVOZ2vC5pxqLkuAdMzQvC3edMma
         xowBUFQ6O5U0cdxWQL82NJtDyXj/Nb1IJo589Tewqs+NjqvPj21Z8YB87oUFnKmX93Xl
         Vm2yQFXRgOqjK61GjcEgBrpUOFXmfZhCav7fZ3e7istDniWIqridRfkXj2X5oyoXEvNV
         lEBA==
X-Gm-Message-State: AO0yUKXN0F4WCYnkbDQsvdiv5BKIOwxKo2WBqe8nKN0mlp0O1qKG9QjJ
        9YAj5adwHZotLSNaNBeSOL9Zyw==
X-Google-Smtp-Source: AK7set+d+PC+FwXM1v22iDfA3Bwp6x8ofye9kNAZjMjBbW74A0UIRvCbnyO11+6U8svz5CJPhA4cyQ==
X-Received: by 2002:a05:600c:3caa:b0:3da:270b:ba6b with SMTP id bg42-20020a05600c3caa00b003da270bba6bmr20017963wmb.41.1675679305824;
        Mon, 06 Feb 2023 02:28:25 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id g10-20020a05600c310a00b003de77597f16sm11002446wmo.21.2023.02.06.02.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 02:28:25 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Rob Herring <robh@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RESEND PATCH 10/37] of: property: make #.*-cells optional for simple props
Date:   Mon,  6 Feb 2023 10:27:32 +0000
Message-Id: <20230206102759.669838-11-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230206102759.669838-1-srinivas.kandagatla@linaro.org>
References: <20230206102759.669838-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Walle <michael@walle.cc>

Sometimes, future bindings for phandles will get additional arguments.
Thus the target node of the phandle will need a new #.*-cells property.
To be backwards compatible, this needs to be optional.

Prepare the DEFINE_SIMPLE_PROPS() to handle the cells name as optional.

Signed-off-by: Michael Walle <michael@walle.cc>
Tested-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/of/property.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index 134cfc980b70..3043ca7735db 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1256,8 +1256,8 @@ static struct device_node *parse_suffix_prop_cells(struct device_node *np,
 	if (strcmp_suffix(prop_name, suffix))
 		return NULL;
 
-	if (of_parse_phandle_with_args(np, prop_name, cells_name, index,
-				       &sup_args))
+	if (__of_parse_phandle_with_args(np, prop_name, cells_name, 0, index,
+					 &sup_args))
 		return NULL;
 
 	return sup_args.np;
-- 
2.25.1

