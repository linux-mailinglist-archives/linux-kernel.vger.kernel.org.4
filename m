Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA9C164E4BB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 00:37:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbiLOXhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 18:37:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiLOXhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 18:37:40 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A55433C38;
        Thu, 15 Dec 2022 15:37:38 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id i83so463864ioa.11;
        Thu, 15 Dec 2022 15:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n0S+BNnJ7vpChKd2bKXycrLk2TXgTyRGa3Rtky2JtFo=;
        b=aVSmhgIwuTvtwVtlewKgVXS++UyLWmJ4znxSFIxtsLUOlM6cAim0UFcTuUiYNa6+3N
         LIobIrYPFiiiIX9HQlwme2zjYMcprOwRI1jVjKlpLjukDZPGNpl/e4t0txJngGHnAZDX
         hhBvxNhhguO8HYNSiPcEhUzUhLGXX+a8b7CSNMAGoZTt4ep7xukYqItVdoymiAeF6dyP
         TdK9PK94A0bkeGCQ8pkFZrf6KYQL7UhD2j5zjjVAsfWUkvnSbSjAtP34hvdyG/8g4q++
         riZ26r8bBQZqtBiVgC9xTGdMaWb3jr//78IILCiHH9F5G0PsLBUiUwHpsncEeQnvNOwP
         B6IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n0S+BNnJ7vpChKd2bKXycrLk2TXgTyRGa3Rtky2JtFo=;
        b=cMverpxYv1l6SgnMIl207oGMeLPeywwh4M1bdnTIEa+tregTxuVReudpCbNPzl+wrl
         gq+Irt3nLQA/mHDW4odcfcHe4q72piix7upibqZlom5IlmeyDj2TQe58rVXtOsA0XdUb
         3gONOCPiyHV1A6khYPNZx7vDwuY+pEC0BoEmPQKnJkNMDIWFaL+tQTaqjkcGl/JMgDhg
         NKv9q2d8hnEAreMNMX0/2FJLWIE3+0axkCR7QPk6vOYhIs4jn6vH32RPpyq42ixCMs+X
         2/su1nirvNfgu9z6tQGUO+Itf2pPNPlHIFWeGADbs7HY8eYtnYbT05xAliUwoyWRx3Yu
         siZQ==
X-Gm-Message-State: ANoB5pngOpVx9xX9DJZciPBNfUv49JZCeNQzccHWK8QNoNHnTQ9hSIfY
        e6UlRJz8HJBJqyormxDS70fNHAhb+ZM=
X-Google-Smtp-Source: AA0mqf4sLdhT8b3nqtusSxBPSpoLvXt5jZzMNbq6n9cnnSpOoxfvhOYgqPU29a33BDpYcqlFytze1g==
X-Received: by 2002:a6b:b48b:0:b0:6e0:380b:b900 with SMTP id d133-20020a6bb48b000000b006e0380bb900mr17158172iof.12.1671147457832;
        Thu, 15 Dec 2022 15:37:37 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:447:d001:9aea:a51c:e6d:ec30:864d])
        by smtp.gmail.com with ESMTPSA id o187-20020a6bbec4000000b006cab79c4214sm100747iof.46.2022.12.15.15.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 15:37:35 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: arm: Add Beacon EmbeddedWorks i.MX8M Plus kit
Date:   Thu, 15 Dec 2022 17:37:17 -0600
Message-Id: <20221215233719.404581-1-aford173@gmail.com>
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

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index fbfc4f99c01e..387b038f10c8 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -928,6 +928,7 @@ properties:
       - description: i.MX8MP based Boards
         items:
           - enum:
+              - beacon,imx8mp-beacon-kit  # i.MX8MP Beacon Development Kit
               - dh,imx8mp-dhcom-som       # i.MX8MP DHCOM SoM
               - dh,imx8mp-dhcom-pdk2      # i.MX8MP DHCOM SoM on PDK2 board
               - fsl,imx8mp-evk            # i.MX8MP EVK Board
-- 
2.34.1

