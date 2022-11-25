Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B282C63888E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 12:20:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbiKYLTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 06:19:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbiKYLTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 06:19:48 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A61E28E17;
        Fri, 25 Nov 2022 03:19:45 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id cl5so6270649wrb.9;
        Fri, 25 Nov 2022 03:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H4DbuMCnCKfZ/X33NVzzgb/ifknYJFeQAyg/fDbKILM=;
        b=MJTopbFMxXVgGa3ngdb1kcHRAh4vMZ7fbyu1UeoKxPOAleRmO4pX76dgm81YUUB17L
         F8E/IUYa937tek8muSzdgfgLC+gchdb/UUJ1fizl22ErU4DeH9Qomk838IG7xCMgCTXn
         noBYTatzIC89Wa0fx7WmDnBuvOVY2w01/ynG1veOgO2OsK/JRwkBhq57e4umTHkyEXQ+
         QHdpiG60Cl11EtDF5+aqQPkZavx1VKTJqzKjWsOmnVKUoPlOtrmmE6M/yMtl06qb3mpL
         I3UJeAxD5tVLP7ktD1CevI9ga+4W640YEFsV3HXPg3XPbez2c1fp7B6jH6+USJQp9S0+
         ZW5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H4DbuMCnCKfZ/X33NVzzgb/ifknYJFeQAyg/fDbKILM=;
        b=PzI7Zj/y/kx+7JzIJVZLYcZM6ccXHSFIH5VCXdKPAoLGocMTmS+go1/eKIckmd34lB
         9EcCVFgFc5JH7L2kIXhO9IvXO82737aVI2UP67uFbtcEbosTTMf/U76lUSXRx2z+bIrd
         4MvZjkFI6ufcyBJ59IfD64XDXCezo2YvDiuyEC0JfFv1rk8lhCMyJRPe6aGmEeWd7jiJ
         6isDhpJQN4A3BxmhK6Ur+jvyT6BIrX6iTndIsa3xhW1y7zcHbB291p405cIBv9LnZEU3
         BQ+WnZt49iN7aMdKh/bHl8DXHZBc4P6C0YpdnkYZgR91MHBfd3zgTGxihdbea27/Vays
         ASAw==
X-Gm-Message-State: ANoB5pltrTk9H1M/BYSwYPZLvWccsYJSfrnmdr2Tvg1zD+T2W70o+TmS
        VfbG7DyayyYOGAlZaivpQEw=
X-Google-Smtp-Source: AA0mqf7R0O/iMKw+/pY3QRSPGLMqpoZMk6Y+6iqjJv+P2qnYsq8Eff8A9TxL5wfpOu5YfjJ8gs1hYw==
X-Received: by 2002:a5d:6dcf:0:b0:236:78b7:87c9 with SMTP id d15-20020a5d6dcf000000b0023678b787c9mr22664039wrz.556.1669375184088;
        Fri, 25 Nov 2022 03:19:44 -0800 (PST)
Received: from cizrna.home (cst-prg-44-69.cust.vodafone.cz. [46.135.44.69])
        by smtp.gmail.com with ESMTPSA id v11-20020a5d4b0b000000b002368f6b56desm4207406wrq.18.2022.11.25.03.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 03:19:43 -0800 (PST)
Sender: Tomeu Vizoso <tomeu.vizoso@gmail.com>
From:   Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Amlogic Meson
        SoC support),
        linux-amlogic@lists.infradead.org (open list:ARM/Amlogic Meson SoC
        support), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 4/6] arm64: dts: meson-g12-common: Add reference to NNA reset to pwrc
Date:   Fri, 25 Nov 2022 12:19:17 +0100
Message-Id: <20221125111921.37261-5-tomeu.vizoso@collabora.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221125111921.37261-1-tomeu.vizoso@collabora.com>
References: <20221125111921.37261-1-tomeu.vizoso@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on the power sequence in the downstream driver.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
index 45947c1031c4..fa96fddf4633 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
@@ -1625,10 +1625,11 @@ pwrc: power-controller {
 							 <&reset RESET_VDAC>,
 							 <&reset RESET_VDI6>,
 							 <&reset RESET_VENCL>,
-							 <&reset RESET_VID_LOCK>;
+							 <&reset RESET_VID_LOCK>,
+							 <&reset RESET_NNA>;
 						reset-names = "viu", "venc", "vcbus", "bt656",
 							      "rdma", "venci", "vencp", "vdac",
-							      "vdi6", "vencl", "vid_lock";
+							      "vdi6", "vencl", "vid_lock", "nna";
 						clocks = <&clkc CLKID_VPU>,
 							 <&clkc CLKID_VAPB>;
 						clock-names = "vpu", "vapb";
-- 
2.38.1

