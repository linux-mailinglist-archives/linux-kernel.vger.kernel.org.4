Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB210729341
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 10:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbjFIIcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 04:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241004AbjFIIbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 04:31:31 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD5EA4210
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 01:31:01 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id 5614622812f47-38c35975545so423531b6e.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 01:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686299457; x=1688891457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wKG2swLU2cxH0fvGtChiGmTQPvwznm6/vNPt46Id5GA=;
        b=cyjo9eyx+bMWokEPapCIqNtrmXeWN2VUQZKHM9v8TisgDQANJ7603ZSrMpYCAta5ws
         mw/rs0y9gEUTZw0dYlNT5hsLYMK8R3vxSumcCFeE54eAPlOcw5HhYUMLZrzUSuH9RvjK
         Vaw4WqzBuH+ku+IoYHhNzDoZMD+ikODetptvo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686299457; x=1688891457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wKG2swLU2cxH0fvGtChiGmTQPvwznm6/vNPt46Id5GA=;
        b=hdFxfNq2IEpYxNlIYJWfww7DWdZm4DbFSxBScyXsGiXf0Z72G4+8X3zFPrQETh8Nfl
         jQTFG0ioeO3hRjbYUOLjl8UTIiT8HxTZHPUPS4rll6Zz8GgtATRcjQSd3fxL4/XVbWTb
         ZaP5jFAjUZ/K1LPz1x+RzaS3ziw/QdB4Rrqvxq4h9LUyK6ESnx5/ZU1T/pedOhvneaGc
         woxxcKK5L39w10VDRhdc70Ak0v/IQh6nBA97bOsxl9s16C+9PshmOF+aRGgkKaMBGFie
         qocf0V10oEIjzBq7WrzPnODjVKsUKKBXIec8WruOBiEmBOj+sQ1zig+unAmGf5GihBgA
         QhmQ==
X-Gm-Message-State: AC+VfDxksbohvuLJcaBHzB4fdJ4BpmH4AoQ3lK4qmXdIY20YfWox/DnC
        WHG0dnRpCPS8HUOu6akkBHAl3Q==
X-Google-Smtp-Source: ACHHUZ7ikIDh/64RRC8hcnVVQEVUF207vgCR8uMYtPbLyaQXl+JT9HwYbPpYEclmygdxv8frpXyIvw==
X-Received: by 2002:a05:6808:1829:b0:398:6008:f465 with SMTP id bh41-20020a056808182900b003986008f465mr1162071oib.4.1686299456598;
        Fri, 09 Jun 2023 01:30:56 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:c2ea:d8e4:1fe8:21f0])
        by smtp.gmail.com with ESMTPSA id 23-20020aa79157000000b0063b806b111csm2184327pfi.169.2023.06.09.01.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 01:30:56 -0700 (PDT)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 9/9] arm64: dts: mediatek: mt6358: Merge ldo_vcn33_* regulators
Date:   Fri,  9 Jun 2023 16:30:06 +0800
Message-ID: <20230609083009.2822259-10-wenst@chromium.org>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
In-Reply-To: <20230609083009.2822259-1-wenst@chromium.org>
References: <20230609083009.2822259-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ldo_vcn33_bt and ldo_vcn33_wifi regulators are actually the same
regulator, having the same voltage setting and output pin. There are
simply two enable bits that are ORed together to enable the regulator.

Having two regulators representing the same output pin is misleading
from a design matching standpoint, and also error-prone in driver
implementations.

Now that the bindings have these two merged, merge them in the device
tree as well. Neither vcn33 regulators are referenced in upstream
device trees. As far as hardware designs go, none of the Chromebooks
using MT8183 w/ MT6358 use this output.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 arch/arm64/boot/dts/mediatek/mt6358.dtsi | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt6358.dtsi b/arch/arm64/boot/dts/mediatek/mt6358.dtsi
index b605313bed99..186898f9384b 100644
--- a/arch/arm64/boot/dts/mediatek/mt6358.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt6358.dtsi
@@ -304,15 +304,8 @@ mt6358_vrf18_reg: ldo_vrf18 {
 				regulator-enable-ramp-delay = <120>;
 			};
 
-			mt6358_vcn33_bt_reg: ldo_vcn33_bt {
-				regulator-name = "vcn33_bt";
-				regulator-min-microvolt = <3300000>;
-				regulator-max-microvolt = <3500000>;
-				regulator-enable-ramp-delay = <270>;
-			};
-
-			mt6358_vcn33_wifi_reg: ldo_vcn33_wifi {
-				regulator-name = "vcn33_wifi";
+			mt6358_vcn33_reg: ldo_vcn33 {
+				regulator-name = "vcn33";
 				regulator-min-microvolt = <3300000>;
 				regulator-max-microvolt = <3500000>;
 				regulator-enable-ramp-delay = <270>;
-- 
2.41.0.162.gfafddb0af9-goog

