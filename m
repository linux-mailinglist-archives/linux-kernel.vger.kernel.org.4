Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC711729C37
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 16:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240337AbjFIOHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 10:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239822AbjFIOG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 10:06:57 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F154930FC
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 07:06:55 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-977ed383b8aso309204866b.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 07:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686319614; x=1688911614;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8ez83xrnUgbw0MAP7/4bHfz4IcI1smRL2ein9QCNd6Q=;
        b=MWLzBqFecgIKNf1kgPAbYdebxEuEwkAqBZ/e49ZS5gOtgYOKtpD8LQ66Vnv9LPxiJF
         Mo9RX6D+aYNPiN9nEWemYZ6fCyB7Hqdx00XbM3YtyU6iX6l3saQ6vFZCasD2zN5AKmli
         wHWkF3yxP8aqdzkMYYz+zxRIdZFMgMBPLMI99CLY3WSQOqFCjvgSoqxOo2E9jPdueDAg
         TdG04blH0/lMwU9GRTQpsDIE+hyW/ePw7XJHVgV4b9z3jvWj6PpTE/AN2OPP1MMFGs/H
         qFE96ooOh70XorMN5d40jzSzZRDM+LU0W+0oU8GvzDStCIxJHYaW9lHRgC3vDieyK1lT
         sqkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686319614; x=1688911614;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8ez83xrnUgbw0MAP7/4bHfz4IcI1smRL2ein9QCNd6Q=;
        b=aDkvpC0TxferpU+EhBfIuIvHHBAX/xxshtma97Gn3Hrp0Ys/XbUFX8uZ7vDygzZz5j
         JA9JVMLtNKjAZgHr+UnohOk8EtHO7Mn9uqvHu2XDevmD1EoVVw7v3pm3n2xfCtyovwZD
         GAa3lrMSbMs/zCnegcQm6qvTBX+Fzai+1KwypSFhteKsURUpW48vZ4Xx38nV1lQKVdXm
         gL4BnGeMD1dHUtXwNyhMq/Dc0yeBb57C6g4njmj9iZKWMfK0UyBgBFCDXciAVBS3sa/Q
         i2P31G8SAD20P4eI1C6S/pV5H4EFJ+FdWbIGhQsUGe3XckBlubEda5Xi76IzxlM651f9
         2mTQ==
X-Gm-Message-State: AC+VfDytNDrMqYJwAJsD+jYWul9Arkf47m8/wGsz/aDG4QoGXMKIlNZe
        1hkr7Cz8kfoPlk+Y5yNy95E2cg==
X-Google-Smtp-Source: ACHHUZ6eNQSN6PIFn6NAH6sD5EEzqacvW4Z3scV2BWSPG/097RqqphuqnMSNGCi9/N3LutXcW3LILw==
X-Received: by 2002:a17:907:2d06:b0:973:da59:7c91 with SMTP id gs6-20020a1709072d0600b00973da597c91mr2053621ejc.51.1686319614494;
        Fri, 09 Jun 2023 07:06:54 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id kf10-20020a17090776ca00b00965f6ad266bsm1307695ejc.119.2023.06.09.07.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 07:06:54 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-scsi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: ufs: samsung,exynos: drop unneeded quotes
Date:   Fri,  9 Jun 2023 16:06:51 +0200
Message-Id: <20230609140651.64488-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup bindings dropping unneeded quotes. Once all these are fixed,
checking for this can be enabled in yamllint.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/ufs/samsung,exynos-ufs.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/ufs/samsung,exynos-ufs.yaml b/Documentation/devicetree/bindings/ufs/samsung,exynos-ufs.yaml
index a9988798898d..88cc1e3a0c88 100644
--- a/Documentation/devicetree/bindings/ufs/samsung,exynos-ufs.yaml
+++ b/Documentation/devicetree/bindings/ufs/samsung,exynos-ufs.yaml
@@ -54,7 +54,7 @@ properties:
     const: ufs-phy
 
   samsung,sysreg:
-    $ref: '/schemas/types.yaml#/definitions/phandle-array'
+    $ref: /schemas/types.yaml#/definitions/phandle-array
     description: Should be phandle/offset pair. The phandle to the syscon node
                  which indicates the FSYSx sysreg interface and the offset of
                  the control register for UFS io coherency setting.
-- 
2.34.1

