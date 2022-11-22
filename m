Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 390DB6331F3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 02:09:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232224AbiKVBJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 20:09:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232240AbiKVBJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 20:09:15 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0679C54B04
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 17:08:11 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id b8so7811995edf.11
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 17:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=770v95sUrIlvtNLFG2ZFJPK2miGjPEzCsACcRdRH3P0=;
        b=tDoF3baarEZ/xbXDm7tk2HrsTGWpICgpqIAtSi03HywXzuaphjgJW54N71ewodQGgL
         W3DIwAOD1Z+BTxjyIkWFvBX4mFMnFV6j8xFwuUOGN12ePggI/v+RjoA02TWEeTP2sdUB
         b19ybRxEdtNpRoJbrGhyvTC63KxBZu0QuPH42XbY9BQ6XwdYDpUBkbYG9WVACRZguDXI
         uubWjH05gIC4oZ8NkoFPdw7iGNLrlZVwK13hQWmbYnFDT5k7s9ROcyPaUvx/rR96GmO+
         E3EWKEI7TuP6eoRMaarAKrk4dV5iR2Q08YMiomF6wF98eCjp67l9VMJ6TtBixdO9LbvS
         hztA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=770v95sUrIlvtNLFG2ZFJPK2miGjPEzCsACcRdRH3P0=;
        b=mjSzheKDUaY9zBHyfglB2jc3MoK/iX6AZWlKONtbLPk//DwxeNPn0TouSJH4pSerPk
         Zr3+/SwYu6hCA0Cl85ajv4pYxpORx2GdM3mmGIMYkq4jmqDWMSt4fO7aDxWB+M9AbnzG
         sFBV5eHAercZBgBWsqfYQ2GSDwql+/cCSnekLraa6m9FtoauWIQCTlfgqFtIG+Vylq5c
         kVR1hJyKRJHCe8Y6ZOC86As/IvJehtgzCApLavva1KK/D7lg3xuw/1+J+AY1bvPuNrde
         xSBpIO9b5W4xj+q8smCdEMKTlm1a2fBTuI+miQslDBwZY5KiKQD8GKTaO4cxRl5k0K0S
         KZ9A==
X-Gm-Message-State: ANoB5pl0TgLmfkL/2GeO0Iwg54sYWGzu3dxaDXALiFDOmExbbhPyiu06
        Vx/fyvlIOA8nwUCxp0Eezro6gw==
X-Google-Smtp-Source: AA0mqf6r3Zdf5ruet9qXDuVjd6GpPw7JVMSyJT9jBcH+eBdwhPNkdmCtSnW+kRAmDvWyunfZrvyPYQ==
X-Received: by 2002:a05:6402:3886:b0:463:ab08:2bc6 with SMTP id fd6-20020a056402388600b00463ab082bc6mr2102790edb.143.1669079289585;
        Mon, 21 Nov 2022 17:08:09 -0800 (PST)
Received: from c64.fritz.box ([2a01:2a8:8108:8301:7643:bec8:f62b:b074])
        by smtp.gmail.com with ESMTPSA id f13-20020a1709064dcd00b007030c97ae62sm5514683ejw.191.2022.11.21.17.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 17:08:09 -0800 (PST)
From:   =?UTF-8?q?Bernhard=20Rosenkr=C3=A4nzer?= <bero@baylibre.com>
To:     devicetree@vger.kernel.org
Cc:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        krzysztof.kozlowski@linaro.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, khilman@baylibre.com
Subject: [PATCH v2 2/7] pinctrl: stm32: Remove check for pins-are-numbered
Date:   Tue, 22 Nov 2022 02:07:48 +0100
Message-Id: <20221122010753.3126828-3-bero@baylibre.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221122010753.3126828-1-bero@baylibre.com>
References: <20221122010753.3126828-1-bero@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the check for the unnecessary pins-are-numbered
DeviceTree property

Signed-off-by: Bernhard Rosenkränzer <bero@baylibre.com>
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/pinctrl/stm32/pinctrl-stm32.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/pinctrl/stm32/pinctrl-stm32.c b/drivers/pinctrl/stm32/pinctrl-stm32.c
index cc9472b284047..1cddca506ad7e 100644
--- a/drivers/pinctrl/stm32/pinctrl-stm32.c
+++ b/drivers/pinctrl/stm32/pinctrl-stm32.c
@@ -1499,11 +1499,6 @@ int stm32_pctl_probe(struct platform_device *pdev)
 	if (!match_data)
 		return -EINVAL;
 
-	if (!device_property_present(dev, "pins-are-numbered")) {
-		dev_err(dev, "only support pins-are-numbered format\n");
-		return -EINVAL;
-	}
-
 	pctl = devm_kzalloc(dev, sizeof(*pctl), GFP_KERNEL);
 	if (!pctl)
 		return -ENOMEM;
-- 
2.38.1

