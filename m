Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABC6D67E1DA
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 11:39:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232018AbjA0Kj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 05:39:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232048AbjA0KjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 05:39:25 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A191D90C;
        Fri, 27 Jan 2023 02:39:19 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id f12-20020a7bc8cc000000b003daf6b2f9b9so5097176wml.3;
        Fri, 27 Jan 2023 02:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9cdeNu2rBUonzxoRF7BM3W3tfmDx0o1jZ8hpPYfrDac=;
        b=DAc5fdvudmdCacf9+7vec558W+yzremTGjoG3Ptit4ATrUwdmQPHKnS0Jq969HMQAh
         aZQ+puLj0KKKZ88tsd9PPzXPeqgMTd+OJLHh2t7abbXBj1AzH1xzfhJv4BX5XsShqGoa
         ql4GDehOUm603Qx8w6ZhsbOneUVUm7UEmzlgppiODmDcjSOQAw6I/O4Efo3JIzo4U97w
         iFRxj9iGP098x/YXH7avsdu+xwOER1m2CfyGAlD3oAQOcRMP452aAAdjHmxf2TKbHn8z
         KAXnXVdEZ6vLyI5GASrSclvclBbyd4dNkePSpB7ql85fVt2VM4fkbeNW5NujarJey+qa
         c2mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9cdeNu2rBUonzxoRF7BM3W3tfmDx0o1jZ8hpPYfrDac=;
        b=Jo4uh9fmVJLPE8MXgafM3vC31tBn0dStgZNkw6hO3V10L0i0t3BJb7A6gQHMrtwPo+
         EwFvkthMdeGBjgpGgg1K38PPXDOtEFo3gREm0hlS/sDaypyvrZ7zYDWEoXBQ7Gr4ajwr
         lASHnjsRMzW2v+oNNujctZcxJ9AvnwDnnKEgXSgWF1ucUn9eaFObxDnShIy+DPs/HGqY
         YM4Os/fXq4qgeeXS+ZkJCLr8VLxY6Zj9wn6D+tYxsUSWsSIG8NPr0ewK01gt5cJ4PSaC
         lnAeSlxUEiA1mvOq/EBVZH7Yz/WQaU/KXsAPJ+4uas3RfRoqqezJS/duShwiudQxuh45
         hTvg==
X-Gm-Message-State: AFqh2kpYc0gFXvVOShW11iVgW/TZlTVb5ifhJA1NBGCxCMeZKahQo1NZ
        6W6/V0uHgFT3uplxbUM3gYc=
X-Google-Smtp-Source: AMrXdXvWPeCgMkd5bkB8/625YuYyvbABWLybVbF249vAUw4sIA1kElnWmwvbpBrWh7Il/OVvdZCPhw==
X-Received: by 2002:a05:600c:3d98:b0:3d6:ecc4:6279 with SMTP id bi24-20020a05600c3d9800b003d6ecc46279mr36100281wmb.27.1674815958374;
        Fri, 27 Jan 2023 02:39:18 -0800 (PST)
Received: from toolbox.. ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id j2-20020a5d4482000000b002be063f6820sm4348243wrq.81.2023.01.27.02.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 02:39:17 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH] arm64: dts: meson: radxa-zero: allow usb otg mode
Date:   Fri, 27 Jan 2023 10:39:13 +0000
Message-Id: <20230127103913.3386435-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Setting dr_mode to "host" prevents otg which can be useful on a board
with limited connectivity options. So don't force host mode.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a-radxa-zero.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-radxa-zero.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-radxa-zero.dts
index e3bb6df42ff3..cf0a9be83fc4 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a-radxa-zero.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a-radxa-zero.dts
@@ -401,5 +401,4 @@ &uart_AO {
 
 &usb {
 	status = "okay";
-	dr_mode = "host";
 };
-- 
2.34.1

