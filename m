Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F4025729C61
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 16:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240849AbjFIOIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 10:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240306AbjFIOIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 10:08:30 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3339830DD
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 07:07:59 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b1c910ee19so20071231fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 07:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686319655; x=1688911655;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2/WZ9XTOzPX5a0+7wZ6YBA8xUco86oZHAnUM6PsZjHk=;
        b=Q3qtIbZ7+NeCPE82f8AYHJU6fFUiNAqMOgeeacCve6RxPeHokozbt8ovmqN4kv10UU
         Mfm7BURb2x3iA2f6/drdRAUtaQp1uxw8BKP0jbVgpLMFcIxbxBXctxlpgFxp1rIHgX1I
         ofevWxKgUYxXdJ6zTv4JwS2scqF7IeMZ/eZcun2QAezpkB6jq/H4upWjUJOe3nwz5xOs
         YNUrIGiAC6LkBIu+bhaX4tjjd0sVK2HqgYtckgxBlL9DKEz+eHnUNLCbRn/7fSMKSbPx
         tyxCp9oTlR57riUWxh1g1TGa4dzL3u12pp5HSMT4/4SEgkcu61Qkyt6Ccafy9PIwuR60
         W+yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686319655; x=1688911655;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2/WZ9XTOzPX5a0+7wZ6YBA8xUco86oZHAnUM6PsZjHk=;
        b=T7bDzSRdsubgw5L3dolSEXX0hTt/n61kEK3zfMh9zkphiev0zODjTu/RP8qLPdHCRW
         gkw+U1l9nSPVLk+VQdgEjZKmPCzxk1q2cZSc+usbn9hdC+bqQDug6vGlutxOtj+IBWrx
         XcZ3X5FbsS6yo/6qzQggP4zXdoYmegg/cX4FbkzYISPUH7Pl5VbXodaKZxJwAjrUm/2i
         quxhicZTEvn33wz5l740Y/lSgzRuV2PjexDy7X2UYR9WlhlyGw4y8cWWAmIrYyHcC71a
         6pFysou8XTFaEDuv+M3B0uy3ougakcajpnyRAQEghfVKObMY2MHwo7erdT9BdyAxY2is
         MpyA==
X-Gm-Message-State: AC+VfDz68qkSDELGz3OSxhlrrS0/tbAHfr2pxgvkKb12qfv18NE6H509
        wV206UqbHvR/UxoL5Cq1CQitsA==
X-Google-Smtp-Source: ACHHUZ6JwuYTFNz2MQ0ZGxyMpoO7QgBUmQUVIXSFcMxEUmRYbmUboPNfpQXm7f4t5gP1xDIJES/45Q==
X-Received: by 2002:a2e:9b0c:0:b0:2b1:af36:93d9 with SMTP id u12-20020a2e9b0c000000b002b1af3693d9mr1201261lji.26.1686319654998;
        Fri, 09 Jun 2023 07:07:34 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id f11-20020aa7d84b000000b00514ad0e3167sm1824011eds.71.2023.06.09.07.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 07:07:34 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: interconnect: fsl,imx8m-noc: drop unneeded quotes
Date:   Fri,  9 Jun 2023 16:07:32 +0200
Message-Id: <20230609140732.64828-1-krzysztof.kozlowski@linaro.org>
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
 .../devicetree/bindings/interconnect/fsl,imx8m-noc.yaml         | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/interconnect/fsl,imx8m-noc.yaml b/Documentation/devicetree/bindings/interconnect/fsl,imx8m-noc.yaml
index f7a5e31c506e..fc21fe3e7b37 100644
--- a/Documentation/devicetree/bindings/interconnect/fsl,imx8m-noc.yaml
+++ b/Documentation/devicetree/bindings/interconnect/fsl,imx8m-noc.yaml
@@ -51,7 +51,7 @@ properties:
     type: object
 
   fsl,ddrc:
-    $ref: "/schemas/types.yaml#/definitions/phandle"
+    $ref: /schemas/types.yaml#/definitions/phandle
     description:
       Phandle to DDR Controller.
 
-- 
2.34.1

