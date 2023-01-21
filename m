Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC9167692E
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 21:19:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjAUUT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 15:19:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbjAUUTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 15:19:52 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A60AD2330C;
        Sat, 21 Jan 2023 12:19:35 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id mp20so21758563ejc.7;
        Sat, 21 Jan 2023 12:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3+5bO+lWD89GR1evsBX1z7xFkVso1S4GR3FB8mwTo4k=;
        b=UvacWkQUJbN2AMrJiOhXwm5hxGTxm5q6Npdftn5HBVNPm4BesOmUz1SRBfHjWSz+L6
         9K4ozdXVlSO4Q2PEyOMLpJx64HDKMyz79r1suUS5IvHb8rvLHKVXbiy85to6YLMEZGP6
         SG+CDZdbIDS66NJ0wQy/gzfXXjfCZyG43gDK0Hu325wEgt3EJ2Gij5f1AIpGSiDg77IX
         b7R/JQHn7tcyATYESBCG32WVe/pLko9e4NLXthgFVOYiTg96LiOCXmZcfsawUASlgFwx
         CgJUOLjXRGJVlcI6V6kJZF9td3z5mEw3B5Uj8KfAK3p9W8lxCRGCBVlKaevHp4zoBo+u
         +wGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3+5bO+lWD89GR1evsBX1z7xFkVso1S4GR3FB8mwTo4k=;
        b=4Icaoj4dfxjqdM+ehHz3oA29D/BhBVFwwjbakYS9oCyoAJfC61KcdUjNmj6Nj41H2e
         7SVh7pzk+3isVlLXEmeoC1T/sZADi0ZCq17ctt8neErGo3tPhg1IRbxK5vuS/jmdXDbL
         poKfT/7f2RsGkWizVz8I/uGs9HeRnTBlRienz7y9kKCd7bEnP2oD+GsnnRmHfZgfb7HL
         z8pdscUrNw1x9m7O2zYqYrhsigTuxVI96SQZmPRta1PPI5dvoXODZ74oumRPD0/yz+FX
         x6P5wCFwjpWKipQWXVeDUUDZ0mEDgV/AkVxu7q6frAXbQK0B2p94IZaMEHXqadbSx07h
         r7NA==
X-Gm-Message-State: AFqh2kpS6WIbH2gU5aIquem58Y/e/z60Ff3RkZUSzYFSLYT9QNx04/oo
        K0oPdDCeOO3Y7QGe4U1qFMCeeSJn4zMVtQ==
X-Google-Smtp-Source: AMrXdXuEbRplbXq4PXvSYwkmr8kg+SO70STMTLF33Tn2LBsFAAtbIe9aoX54BzstM/Fw4XTB2utv9w==
X-Received: by 2002:a17:906:9f1c:b0:870:3c70:8c8d with SMTP id fy28-20020a1709069f1c00b008703c708c8dmr16008074ejc.17.1674332373917;
        Sat, 21 Jan 2023 12:19:33 -0800 (PST)
Received: from localhost.localdomain ([194.39.226.133])
        by smtp.gmail.com with ESMTPSA id ku26-20020a170907789a00b0084d46461852sm17462057ejc.126.2023.01.21.12.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 12:19:33 -0800 (PST)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Markuss Broks <markuss.broks@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: arm: samsung: Add compatible for Samsung Galaxy S5 (SM-G900H)
Date:   Sat, 21 Jan 2023 22:19:24 +0200
Message-Id: <20230121201926.46990-2-markuss.broks@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230121201926.46990-1-markuss.broks@gmail.com>
References: <20230121201926.46990-1-markuss.broks@gmail.com>
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

Add the compatible for k3g in the Samsung Exynos5800 boards section.

Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
---
 .../devicetree/bindings/arm/samsung/samsung-boards.yaml          | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.yaml b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.yaml
index faea33e4f731..deb2cf971871 100644
--- a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.yaml
+++ b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.yaml
@@ -171,6 +171,7 @@ properties:
               - hardkernel,odroid-xu3-lite      # Hardkernel Odroid XU3 Lite
               - hardkernel,odroid-xu4           # Hardkernel Odroid XU4
               - hardkernel,odroid-hc1           # Hardkernel Odroid HC1
+              - samsung,k3g                     # Samsung Galaxy S5 (SM-G900H)
           - const: samsung,exynos5800
           - const: samsung,exynos5
 
-- 
2.39.0

