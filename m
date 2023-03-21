Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0EE66C2986
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 06:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjCUFBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 01:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbjCUFBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 01:01:05 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B7131E19;
        Mon, 20 Mar 2023 22:00:51 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id r19-20020a05600c459300b003eb3e2a5e7bso8729175wmo.0;
        Mon, 20 Mar 2023 22:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679374848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ENURxkCD4SFoaP6aebwo/q0vo0bcMItJOR8Kmmrb9B8=;
        b=MzDi76ThSJ8I2UkP/1F3yZstqxOBzhMRm8kTOdg93unOq72ahgfP3W5Ulb0xwBZP+j
         EikY+r0Rvr+oAzMBNm1hsM2pVmZkhoe8vrWeiJvB3E56/WBg9o+LTMkYDpu3wrIgEa9O
         BlNq2mLNyFfjSfPX8eMbinPcw15IgQ+1yGUm8ZuFHLgJgeTyJI+2UJwQdx/4Egs7FO6u
         BRqaD1JbmAXUT6Ff4yv8PURggJngN7R9cS1hawx7RZeYnwbmeHCbbnKdEl02QtTPbnAj
         PTZtHB5Yu8IlAhnGRt9bkx56cPi9yMuuRQ/x3N7drBUJ6W3hOBPBTTNOuC+cVJLJbKJ9
         q41g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679374848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ENURxkCD4SFoaP6aebwo/q0vo0bcMItJOR8Kmmrb9B8=;
        b=UZEV3eGwYh9cKYA71l3txjzxDz9XJm5Ui0xKyko84o41Ff70M7/KoHmDDixzZUMq9L
         6Y81Ei0C4VPqh52HQfJvD+Dd3CAKLMkWvJB6FvjSKyvkSJ41Y/u1UJQIwv61gt+isyEC
         fPzVxK5Wj0g1gf+LUR+TNKHH4paiyS6Gbo/L1kC48jnctQ5W790aYiC/7Ktr0knjCiu+
         1OFKTc6MZCrQOEG/paA48B/yIoIPt4UvdC6senF2H/gpmMhimO5wV8V80ZUtREvz/4JZ
         46wIP0W9BX8bkf+ghq/uwYk6krxMKlDCgNeS/1AA27feClRvlqRHPsZDpXSzkc9Zh351
         /XmA==
X-Gm-Message-State: AO0yUKXVRclGd2AMnTOGldZ2XesbTfr8kZUOShjJISHG7WdEAIRNVTsu
        mK60EOG315ZN+JtlAmBqXhRrLnjsJ9s=
X-Google-Smtp-Source: AK7set/nSITNOfKlnwangQvWZxYyjfmmynvUdRicYyvRkVc2yJbushi7SPSbH8E30up/WyxNbmzEwg==
X-Received: by 2002:a7b:c3c8:0:b0:3dc:4fd7:31f7 with SMTP id t8-20020a7bc3c8000000b003dc4fd731f7mr1143547wmj.41.1679374848699;
        Mon, 20 Mar 2023 22:00:48 -0700 (PDT)
Received: from localhost.localdomain (106.red-88-13-29.dynamicip.rima-tde.net. [88.13.29.106])
        by smtp.gmail.com with ESMTPSA id 3-20020a05600c020300b003eddefd8792sm6238432wmi.14.2023.03.20.22.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 22:00:48 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     linux-mips@vger.kernel.org, tsbogend@alpha.franken.de,
        john@phrozen.org, linux-kernel@vger.kernel.org,
        p.zabel@pengutronix.de, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, devicetree@vger.kernel.org,
        arinc.unal@arinc9.com
Subject: [PATCH v2 9/9] MAINTAINERS: add Mediatek MTMIPS Clock maintainer
Date:   Tue, 21 Mar 2023 06:00:34 +0100
Message-Id: <20230321050034.1431379-10-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230321050034.1431379-1-sergio.paracuellos@gmail.com>
References: <20230321050034.1431379-1-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
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

Adding myself as maintainer for Mediatek MTMIPS clock driver.

Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8d5bc223f305..581234dfa735 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13137,6 +13137,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/phy/mediatek,mt7621-pci-phy.yaml
 F:	drivers/phy/ralink/phy-mt7621-pci.c
 
+MEDIATEK MTMIPS CLOCK DRIVER
+M:	Sergio Paracuellos <sergio.paracuellos@gmail.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/clock/mediatek,mtmips-sysc.yaml
+F:	drivers/clk/ralink/clk-mtmips.c
+
 MEDIATEK NAND CONTROLLER DRIVER
 L:	linux-mtd@lists.infradead.org
 S:	Orphan
-- 
2.25.1

