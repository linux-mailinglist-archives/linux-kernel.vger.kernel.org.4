Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB6473CB00
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 15:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232748AbjFXNRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 09:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbjFXNRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 09:17:13 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7EC8116;
        Sat, 24 Jun 2023 06:17:09 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f918922954so15873815e9.2;
        Sat, 24 Jun 2023 06:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687612628; x=1690204628;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ou3Llv8LccPhD+lVAZHU8h+Zxb2u2iNeLld4FYbDCL0=;
        b=NLvKfkmODJ7d2w3rY83obV0RROyfN4Jh/Ro2ode6/E4S4XFJcJXyjsKWYOfKOjhW8x
         pXfDVb1124NzEtabZQXUHmqmWtNYgWGaVGNPllZkGE5e9Qn+qkGU7eWioQpl5vaOsZ7N
         Q8ZYtWCThoTgD3Pe59L3yF347vv/gcUlsXuYOAWYxHfKlsOkwXuX5QZOVH0r+zxw9gdO
         KLc8/kwi2EDUxxTByI218Q9nkxa5ZGzY/tG8ghv0iFz1ww4eA+OQVE3/j25Vw9ylv4II
         okcXkALJkP8xoGaPVZv2Jpnkc9vV9qUAu5FGxTUI9tVQnNYRxcFmy2BQCIsiT605HwXJ
         gZ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687612628; x=1690204628;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ou3Llv8LccPhD+lVAZHU8h+Zxb2u2iNeLld4FYbDCL0=;
        b=Dp1wBaVffPe3yHnHP8NQz3IlmsDlaI2LOmUGvyLFcVuS6wsDAQkLDxCSzVgETaTrhP
         P8gkSJvjZZei499FbClnJpifmtuGXcYgOFX4JAfrgtmPU4+OgVewMhVsdJ1cLLgLjOlQ
         udXUEZVYjJdKevz/0axjBmz+22xAaGuYGUkCKXG0MaNXmZkZeQ2HD2J9psNYliSO46Sq
         TV6Ot428Gd6pC4sBPI/vYxBdu/5mZ4c4OeD7DOKh5OaR+T5eGw9VgUztgSOmEhPO2/yu
         YjIgUF5JYolkoHEM2/K1Cz8VcYqaSq/k7UfDm13Rq7SBWYUHOhJcXhKUTOCBRRlDFiRj
         5sNg==
X-Gm-Message-State: AC+VfDzyIFHfxWxhrhguZaf1frvhR1GznL2Gd3cjCwUtuGNPIoNuXvth
        tpZn+YUNPHQb25LmvK+t3uFHoz7vknwSsQn/
X-Google-Smtp-Source: ACHHUZ4vCWn1Kwx1tyQ9XpYEiYzeBd75zN/pheQbZRhsK9gz7NDagLNjcdUqx0JgxusaY+v6Bcuiuw==
X-Received: by 2002:a1c:6a0a:0:b0:3f9:2c0:b58 with SMTP id f10-20020a1c6a0a000000b003f902c00b58mr14937759wmc.4.1687612628018;
        Sat, 24 Jun 2023 06:17:08 -0700 (PDT)
Received: from user-PC.. ([92.51.95.194])
        by smtp.gmail.com with ESMTPSA id l1-20020a1ced01000000b003f9b0830107sm5107428wmh.41.2023.06.24.06.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jun 2023 06:17:07 -0700 (PDT)
From:   Maksim Kiselev <bigunclemax@gmail.com>
To:     linux-spi@vger.kernel.org
Cc:     Maksim Kiselev <bigunclemax@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Mark Brown <broonie@kernel.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/3] spi: sun6i: add dual and quad SPI modes support for R329/D1/R528/T113s
Date:   Sat, 24 Jun 2023 16:16:23 +0300
Message-Id: <20230624131632.2972546-3-bigunclemax@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230624131632.2972546-1-bigunclemax@gmail.com>
References: <20230624131632.2972546-1-bigunclemax@gmail.com>
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

Listed SoCs have SPI controllers that can operate in dual or quad modes.
This patch adds dual/quad mode bits for spi_master on these SoCS.

Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>
---
 drivers/spi/spi-sun6i.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
index cec2747235ab..e9144d76bcdb 100644
--- a/drivers/spi/spi-sun6i.c
+++ b/drivers/spi/spi-sun6i.c
@@ -761,6 +761,7 @@ static const struct sun6i_spi_cfg sun8i_h3_spi_cfg = {
 
 static const struct sun6i_spi_cfg sun50i_r329_spi_cfg = {
 	.fifo_depth	= SUN8I_FIFO_DEPTH,
+	.mode_bits	= SPI_RX_DUAL | SPI_TX_DUAL | SPI_RX_QUAD | SPI_TX_QUAD,
 };
 
 static const struct of_device_id sun6i_spi_match[] = {
-- 
2.39.2

