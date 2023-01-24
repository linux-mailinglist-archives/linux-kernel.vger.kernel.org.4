Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40D9D679C2A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 15:41:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234218AbjAXOlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 09:41:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234099AbjAXOlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 09:41:17 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CDFC4957E;
        Tue, 24 Jan 2023 06:41:15 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id jl3so14906184plb.8;
        Tue, 24 Jan 2023 06:41:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MrcqHhD2+Ap5Bl+Zx7RGd/oyh/FJKuuqv3NrFr1ehPI=;
        b=Jcw9U+MUVYMBEoxsVTJb6IHvY9DP019FBU3Ii42YSO8iatKG3FGVgrx9HW6fsHXCoA
         xlYrO+9iWI3zmJhRn85o0pRwutY2q5fXBTrgASKQZLG9e72araf0krQpgOOdZ+hXXUa9
         7Z7cCXugkTfhz4IrRjqZd2hY6drtj9iwdR3sQ9a7KM86CWy0mrqltCv3IcFlzIPsaBv1
         LujcLihXqLwqzazjRS0RkdaSBk/qXFHYc0iWxAHcWVkbbIrVgaVILv113smNtYdbiuai
         O4WTX1oIIcUPRzsTcmHWIr1sG2UeAfAPVwVWMySSBE2B1jbTUOylJDRkgKdvQnVRaoZD
         F8XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MrcqHhD2+Ap5Bl+Zx7RGd/oyh/FJKuuqv3NrFr1ehPI=;
        b=wtoloNSRN8sRJYOagtz8sxFriNF3/qiZ00wCrhiZwfalo5rc1twvLZThIHtXPd3XVs
         sGzjfTleulGWQtTA0wevFq7xwlVFYFx/PttERD5siE6IjCriduTSxmVZUO5/LMcMDvJX
         mJS3/yf7lhl/D1p5JWV5wkX/buxdzFPrUY0m9DuCMWQejsfjlJ1tpDHF2aDy9gwEq4X/
         KwfZLswSGem4cHs65sJd6EBSBesDFHS5SXKlBKACme/vzpk2HqNcKjMsxdIeKz7GVH79
         h9YYi/tSJxlOFqs2sFsU5SQlgI45MU4OmZ8vxqUcBYWknP7nh24EQZtqHsu/kvMvc0Ms
         /gvw==
X-Gm-Message-State: AFqh2krYQtu+SctPrKPvdHIQx1+GI7zImVe3w/UpqltsX+si7ZQAGA6M
        6qUj/WgLBxWKz++x2jc5OkwgATWvDZQ=
X-Google-Smtp-Source: AMrXdXsiw1AMsYD9M8CrlBgvq6vr3XCMdd9u9THS17CmyWpWSZmHup2EEr1eoEo0RdZgIfwBG/nQFQ==
X-Received: by 2002:a17:903:244f:b0:194:6286:73ba with SMTP id l15-20020a170903244f00b00194628673bamr38337324pls.13.1674571274974;
        Tue, 24 Jan 2023 06:41:14 -0800 (PST)
Received: from localhost.localdomain ([45.112.3.15])
        by smtp.gmail.com with ESMTPSA id b21-20020a170902d31500b0019602dd914csm1747865plc.180.2023.01.24.06.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 06:41:14 -0800 (PST)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH linux-next v4 1/4] ARM: dts: amlogic: Drop superfluous dr_mode in usb node on odroid C1
Date:   Tue, 24 Jan 2023 14:40:50 +0000
Message-Id: <20230124144054.13556-2-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230124144054.13556-1-linux.amoon@gmail.com>
References: <20230124144054.13556-1-linux.amoon@gmail.com>
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

Drop superfluous dr_mode="host" as it is the default in meson.dtsi

Fixes: 3325f3e4534c ("ARM: dts: amlogic: Used onboard usb hub reset to enable usb hub")
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 arch/arm/boot/dts/meson8b-odroidc1.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/meson8b-odroidc1.dts b/arch/arm/boot/dts/meson8b-odroidc1.dts
index 941682844faf..1097b35b7a49 100644
--- a/arch/arm/boot/dts/meson8b-odroidc1.dts
+++ b/arch/arm/boot/dts/meson8b-odroidc1.dts
@@ -368,7 +368,6 @@ &usb1_phy {
 };
 
 &usb1 {
-	dr_mode = "host";
 	#address-cells = <1>;
 	#size-cells = <0>;
 	status = "okay";
-- 
2.38.1

