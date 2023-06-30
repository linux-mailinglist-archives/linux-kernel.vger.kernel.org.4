Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54986743B83
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 14:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233036AbjF3MGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 08:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233016AbjF3MGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 08:06:04 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 687B13C3C;
        Fri, 30 Jun 2023 05:05:26 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fbc656873eso7648435e9.1;
        Fri, 30 Jun 2023 05:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688126718; x=1690718718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/M+822NMBcWFhtW8psDduBe6caBnlnfKm7WRYzHuukU=;
        b=rLdjIQN7yit+HWPAMW+jhFcyGvyUsmyIP0VGmjcfLwXF299DfXuhRlt0bNU1yZvjxD
         c2nZHhKKd32WLaRmNsZfKS6uk+x7WU6HSe2HYj4bmVXbu9+AiEn/C7HhH67IfM6+lJZ2
         VCQySiUismfPmy4aq4xIspeNTZ8wm+8lQbCW7Gkz0gn1ygDqUau0L70GiWyqJzyb5lXl
         1Ov1CGGt0OinBmPyg6efhLDnkz4Y0YnaRPTi0lIsYhV+0bAOy+5w/D3dTelpWwKQUIO7
         Z/0ySqXY943JLZB77FLpcv7kTXRd3Dw0bW5iuF5F1QkYdM+ULE9UOqg1CgzTMyYXyk2x
         nDbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688126718; x=1690718718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/M+822NMBcWFhtW8psDduBe6caBnlnfKm7WRYzHuukU=;
        b=KIEZYhWu1jqdWEWoxEMIJuCWz8C6NM3/IQlskqBRsOhSRA0V88OvHq/PbkLqLo8pRj
         HxlRcQrGtalaVqM/5je5qLc8euuPbMR2Oxvq48e3ANJSH4zpylrSzXExRjZYrwNFGiwe
         fmcPlZKddm2o+zY+0J3BKQdp+t64xvgVXxSrj/GlfXeJtDS1Qp/e3jawLnZcctaq+GZ/
         19nHaPIo3tgjFxsI5vCclQlr5VRt5co/eZcmEhe1/zTyD3kMpEoKfMZr6Vz5u/YC7f07
         /d2OC8k+HQ9JqGsTPOlt1ro9WpEqZVFsrrg+49UJcGaFffwRgt8voZ+0CoUZtQkOr56K
         uCng==
X-Gm-Message-State: AC+VfDy7D/ECGSoTchV74WebjnZLWYki4wJiyPHaMIcIv1GlWBSsarUT
        Q90qaB+uflzrPDjkA7437R4=
X-Google-Smtp-Source: ACHHUZ7YSKrbGPipvwwchGHahSK0z8Szh2TyxflljlqD9nBbK/YxHxmt/PROw/yeSvHxBK61RFwlMQ==
X-Received: by 2002:a7b:cd8e:0:b0:3fa:8aed:d57f with SMTP id y14-20020a7bcd8e000000b003fa8aedd57fmr2239809wmj.24.1688126718052;
        Fri, 30 Jun 2023 05:05:18 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:dbbb:7082:18ec:f407])
        by smtp.gmail.com with ESMTPSA id k22-20020a05600c0b5600b003fb40f5f553sm11766912wmr.31.2023.06.30.05.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 05:05:17 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [RFC PATCH 2/4] pinctrl: renesas: pinctrl-rzg2l: Add validation of GPIO pin in rzg2l_gpio_request()
Date:   Fri, 30 Jun 2023 13:04:31 +0100
Message-Id: <20230630120433.49529-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230630120433.49529-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20230630120433.49529-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Validate the GPIO pin request in rzg2l_gpio_request() callback using
rzg2l_validate_gpio_pin() function.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index a0c2e585e765..2fc1b880db0c 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -780,12 +780,18 @@ static const struct pinconf_ops rzg2l_pinctrl_confops = {
 static int rzg2l_gpio_request(struct gpio_chip *chip, unsigned int offset)
 {
 	struct rzg2l_pinctrl *pctrl = gpiochip_get_data(chip);
+	const struct pinctrl_pin_desc *pin = &pctrl->desc.pins[offset];
+	u64 *pin_data = pin->drv_data;
 	u32 port = RZG2L_PIN_ID_TO_PORT(offset);
 	u8 bit = RZG2L_PIN_ID_TO_PIN(offset);
 	unsigned long flags;
 	u8 reg8;
 	int ret;
 
+	ret = rzg2l_validate_gpio_pin(pctrl, *pin_data, port, bit);
+	if (ret)
+		return ret;
+
 	ret = pinctrl_gpio_request(chip->base + offset);
 	if (ret)
 		return ret;
-- 
2.34.1

