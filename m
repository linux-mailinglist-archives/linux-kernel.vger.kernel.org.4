Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B10B264FB82
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 19:09:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbiLQSJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Dec 2022 13:09:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiLQSJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Dec 2022 13:09:02 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8792213F18;
        Sat, 17 Dec 2022 10:09:01 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id y3so2890450ilq.0;
        Sat, 17 Dec 2022 10:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9q7xBuulUAodqsj8h08m05s1Xluf/iGOp96RSZvjmgg=;
        b=GHnA01fmJDz+eulYNEoyIiywnjg8tPPn858ys+0Z3x/IjKkyyCuxLwn3ht0Bmk3I4R
         8jpgDWFxlF+LMfqtmFp1YR45qXwYBCwotASGqvAp3u7OP1BAWLwPDNiNHZ99KRrqiO9s
         YHxYDv0DELIjvPts2B+Fu53FS6Eev8WnnGaE5mFtm/IX/v0ZxkRmuIZredq/kL/srUjb
         sXreqaD0VsFNTCnRi0lCzAs48l9nKqbZeqGnwNdJZPtTOuyPFx5dNidy1fj7DyvEOMRM
         JqYq6pWf800nyvTHEcUwxc6EzhnPPEsr4wX3hPwZzm7jheFfRYCmG74AKOvTSsu7yvka
         ssYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9q7xBuulUAodqsj8h08m05s1Xluf/iGOp96RSZvjmgg=;
        b=neOCfUUuQ9QP2EHt9ryUQ0R9W6nxjjgLoNbAUgB7npm/FY1mpE7DInf/8yIDid66KN
         Xa1mPbRlmg/6UHohd+dhKV34LlkueLr6+8fqyAMu9OHBavz37HfHrQNNFglPYem4tyVm
         gWx6e7Wum/39i9+BI3l3pKn1Npa6LjZj6mALO5ZIiN84DL/TVeterKLKEdmNraIoBY1g
         yghrWU3X8ORqxOewXokDmgXoBDGFyovFwHBg3n3jV2hKcgwP9Wz0eMaNSU8gj/GFF8y/
         mnUsUn7SRarMlEHs0FLGpJuKSEG6W1CYvo15IJqdcor0wsfrRk4Yz4q/FKV7yX6/S0z9
         PydA==
X-Gm-Message-State: AFqh2kqEpHbYHZN79RNoyLm9I8QBj7fv/j3Q0cQ3IT6ALiYCfGPGWUbN
        Qd5deKeCVyEO/nkUIJbrCp0=
X-Google-Smtp-Source: AMrXdXu/+Eu5hatE6KWhNHLfVgPNAwHeGYvS1e/ejgwCinbG5MuAEY8r8GwNHLMOYyqCT223v/UHpQ==
X-Received: by 2002:a05:6e02:20cb:b0:308:f4c6:2576 with SMTP id 11-20020a056e0220cb00b00308f4c62576mr3611602ilq.22.1671300540703;
        Sat, 17 Dec 2022 10:09:00 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:447:d001:9aea:d320:bc96:560d:6b27])
        by smtp.gmail.com with ESMTPSA id u26-20020a02cbda000000b003728cd8bc7csm1763398jaq.38.2022.12.17.10.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Dec 2022 10:09:00 -0800 (PST)
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
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] arm64: dts: imx8mp: Fix missing GPC Interrupt
Date:   Sat, 17 Dec 2022 12:08:48 -0600
Message-Id: <20221217180849.775718-1-aford173@gmail.com>
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

The GPC node references an interrupt parent, but it doesn't
state the interrupt itself.  According to the TRM, this IRQ
is 87. This also eliminate an error detected from dt_binding_check

Fixes: fc0f05124621 ("arm64: dts: imx8mp: add GPC node with GPU power domains")
Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index 7a6e6221f421..7a8ca56e48b6 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -524,6 +524,7 @@ gpc: gpc@303a0000 {
 				compatible = "fsl,imx8mp-gpc";
 				reg = <0x303a0000 0x1000>;
 				interrupt-parent = <&gic>;
+				interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
 				interrupt-controller;
 				#interrupt-cells = <3>;
 
-- 
2.34.1

