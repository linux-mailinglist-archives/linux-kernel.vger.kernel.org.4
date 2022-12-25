Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAB7D655C14
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Dec 2022 02:28:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbiLYB2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Dec 2022 20:28:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiLYB2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Dec 2022 20:28:35 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5DF3B4BB;
        Sat, 24 Dec 2022 17:28:34 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id j28so4222161ila.9;
        Sat, 24 Dec 2022 17:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gRpYtnpGHDyDiD3CgctrwyEpPrHlIsvIW1qOn5G6hEQ=;
        b=PW/nffsaEDuYpJow7BF21cHssKEKP9sc8mu+7YN3Wy/K3jfK0sVNdDxJavjgXYVvwo
         8lUBw0qwPfyQuDO8b2gL2EbsMYpqlRee+SQjBCSePKVUjpge7Z3NGowlmtxKNq/gqY/L
         ODBpQVOxWN34GZjEXCkIaeJPrvVWdClLpvw4qmW8FFGWO5nxJa42L7wNSVPAAeG2ovSB
         LsH/2RoVXDKGnXnxqqDVVO6prRpHUj+IbEscD3nR+tPbcxK4u5Xux/vqT5zzGwezNla3
         /L+r4lJkbAUDa65+ovUMvjZyQQ4T8Lm8jY7lXVaUHHvXLf9QzY8xdOScwHtLB6Uk+sSo
         5feQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gRpYtnpGHDyDiD3CgctrwyEpPrHlIsvIW1qOn5G6hEQ=;
        b=t/ONokd5XnQNlSMc3uqGTrY4ETp17D8VO0Srb2DbM3yD0L01w2unYnUMZNiV2mHNCo
         VALD3jJs3/rjCvNnY/bTaTtdn8XEQbeDxAp4eKiYOfUsXKuNQjU63aS0Tv74uJSPkXnL
         UWiF3VPjAkUOxx5pKqwBCUvBPWRr7QQ6lY3QQk7r768uJg6dYYx3L4mqxG0spmKCs7k1
         QsW5cPo0oAIFRl+DQXAOSYM6GjRzpX2HCIFraNF4MsIHDpKn/+FAQMp3S7SsKNdq4LTh
         LGqRcKsBFdz0X3hvOAGMcSE1JFkFPXG2nbXWbBJ1+V50LFTFnkvgEZLII38aeHW4xoIP
         EpDw==
X-Gm-Message-State: AFqh2kpk2kuSV7b3R4XIVxReXl7AFfg+M2bD9QvfA5xkN2oMqct/jCQ5
        a42LYZMkAJeJSC+yba4oE9INzzJwczA=
X-Google-Smtp-Source: AMrXdXsAiOUoiJpu0NlINaJRTgOYeoCrdklOAQ0mlRbkJ6YBPVE5lrWUUq12Ohx8pEoAqGKbgnsXhA==
X-Received: by 2002:a92:cd0c:0:b0:30b:d25b:e0f5 with SMTP id z12-20020a92cd0c000000b0030bd25be0f5mr9686330iln.27.1671931713810;
        Sat, 24 Dec 2022 17:28:33 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:447:d001:9aea:c6f8:5d92:f3af:e321])
        by smtp.gmail.com with ESMTPSA id y11-20020a92d20b000000b00302a772730esm2179838ily.54.2022.12.24.17.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Dec 2022 17:28:33 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH V4 1/2] dt-bindings: arm: Add Beacon EmbeddedWorks i.MX8M Plus kit
Date:   Sat, 24 Dec 2022 19:28:18 -0600
Message-Id: <20221225012820.206328-1-aford173@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT compatible string for a Beacon EmbeddedWorks development
kit based on the i.MX8M Plus from NXP.

Signed-off-by: Adam Ford <aford173@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 05b5276a0e14..4a92e0b2b890 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -931,6 +931,7 @@ properties:
       - description: i.MX8MP based Boards
         items:
           - enum:
+              - beacon,imx8mp-beacon-kit  # i.MX8MP Beacon Development Kit
               - dh,imx8mp-dhcom-som       # i.MX8MP DHCOM SoM
               - dh,imx8mp-dhcom-pdk2      # i.MX8MP DHCOM SoM on PDK2 board
               - fsl,imx8mp-evk            # i.MX8MP EVK Board
-- 
2.34.1

