Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67AB364FD13
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Dec 2022 00:43:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbiLQXnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Dec 2022 18:43:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiLQXnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Dec 2022 18:43:50 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA60101FB;
        Sat, 17 Dec 2022 15:43:48 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id 3so3025782iou.12;
        Sat, 17 Dec 2022 15:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zRUbMxPV27Hg55rivM3e9ddx3+tYw8UCHWAc55pJZeQ=;
        b=caUMYr3B3nDJbrqsqHE6foAd3zKTIE8dHOmZL1H/ntnPjfYsH2xbj/PLVZ6T969axP
         /gtNEvTqeLJgR2+AdUDNiImN2PR4f7fs6lZ9xVHHW8IMD9ocvOUGesdYJOccA63idLKT
         j1fTTBxBwRjUFzyl0P4dFwdNM+fOG+4vcrcxbhfRdxF5abpd2g+TdTcjZsoJ1yzBdMB/
         1YJtUMK2Rql2QItdnkwUhB4Hrse0gzOwXm5km9p+9VbU1f25vMsAkbrtOM8uzCkm4RlN
         axA/lrL82saGVu7raKL/RWk2Bxc724EBevJE/re2zohJ3V3BQ6l2OEfu2dSAJf4bnZxv
         6UIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zRUbMxPV27Hg55rivM3e9ddx3+tYw8UCHWAc55pJZeQ=;
        b=slOz7RyywQB17DGW+845e+5cCm+YX2F1IdwgeFrMwO3Y2M+blUTOXs1Go1FwenJoPh
         TrqI8TlgPqwRYfbYF/QFIs2x22pHM+LmLK7sn+6hlO20tx1hz5DBlPJhygJOjXB1E16Q
         lUtP0nVk/E5rxe9uNJuHbxqpHrUvPSD0w6rLKchKYDkjI2H9M3e/shWsZRRJW5e1hBee
         N3dxJNxChTA3zQ1Qcchm59/+SXo13EwJ3Pg7Gfo2L6WyKa1NvNPWUstJn5TAYYwey6Mh
         Pyznknb6JQCGt0BOCpPJFRrJKRkbzt1WPORD+JjPYV4hi8/NQnqO8sn9njmihw/UpFJr
         ozvw==
X-Gm-Message-State: ANoB5plpZiN8rnwhypiUJHLRn5kRc/Kth/8iwx4JdzBbiA7YWLDyQNcl
        twNZ1kKspm3YSwpk/4kioEQ=
X-Google-Smtp-Source: AA0mqf7xhRixGpITB3SToJo8/XZlbo5wmQ2hydI8q1a6hPyr8tP9xJgdKzBa2aAnSGU4FsYtkIpmBA==
X-Received: by 2002:a5d:93cd:0:b0:6e0:58c:fb32 with SMTP id j13-20020a5d93cd000000b006e0058cfb32mr21890041ioo.2.1671320628164;
        Sat, 17 Dec 2022 15:43:48 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:447:d001:9aea:e023:db8c:bed5:4fd3])
        by smtp.gmail.com with ESMTPSA id z29-20020a056602081d00b006bcd45fe42bsm2205945iow.29.2022.12.17.15.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Dec 2022 15:43:47 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
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
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 1/2] dt-bindings: arm: Add Beacon EmbeddedWorks i.MX8M Plus kit
Date:   Sat, 17 Dec 2022 17:43:38 -0600
Message-Id: <20221217234340.819752-1-aford173@gmail.com>
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
---
V2:  Added Acked-by

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

