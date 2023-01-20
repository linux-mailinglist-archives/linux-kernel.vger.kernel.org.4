Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B94F67491F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 03:03:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbjATCDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 21:03:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjATCDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 21:03:48 -0500
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C34A5780;
        Thu, 19 Jan 2023 18:03:47 -0800 (PST)
Received: by mail-ot1-f46.google.com with SMTP id j16-20020a056830271000b0067202045ee9so2314186otu.7;
        Thu, 19 Jan 2023 18:03:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VqshQfZ1asO3xiGOBUIxGGNDKczDBZDFIuA5ESjiA2g=;
        b=mwPOJaPmtkqBKcbbqja1McRZDeEAjcLDSl4mx3Fr8sh5lGsN044RITXMvCdpLWUFns
         EQSlwkRRgsDP8jbRzTJ/yr8bFFb6Te2qioPBlfO783wrcQbpNMzUb/6OS7kA6ufB+Ev2
         k4yTaxu1rcudUqM97a7JH1ivTiBP0mkh4bpns9X372MAYQlPWuz2pgcNsZAnUApf0d0s
         qhjhxVbCnaxLmpW//pFsW4I+2bthlh76XO5sr1+MXFXfn6FrEPriUBNQd2Op+gBPotGd
         GHoRXzOO/vSHk55tlzfoznOh3yRM5uforzjI/lR/G8orNBcjAww3gjdC8CZ6QtZxxwF0
         vBlA==
X-Gm-Message-State: AFqh2krZrYXSrT2FfHupm0ImfjZH4lOPAJv7xE310rK7zqxKdXu53lXx
        CXvbJqmfgS/N2BoyzgJmWQ==
X-Google-Smtp-Source: AMrXdXvhY0LzUMN3Ybnbv7eqZlOUHgU6Ot9fTZBJlqcubFH6yjnuwiS2RyxrrDjlSLoynCYcy8hsyA==
X-Received: by 2002:a9d:6ace:0:b0:684:d5bd:56df with SMTP id m14-20020a9d6ace000000b00684d5bd56dfmr7138767otq.34.1674180226535;
        Thu, 19 Jan 2023 18:03:46 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id a2-20020a9d4702000000b006864ccdb053sm4915639otf.26.2023.01.19.18.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 18:03:46 -0800 (PST)
Received: (nullmailer pid 3223267 invoked by uid 1000);
        Fri, 20 Jan 2023 02:03:45 -0000
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: soc: socionext,uniphier-soc-glue: Make child node names fixed names
Date:   Thu, 19 Jan 2023 20:03:39 -0600
Message-Id: <20230120020339.3223112-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The child nodes 'pinctrl', 'usb-hub', and 'clock-controller' in the
socionext,uniphier-soc-glue binding are not patterns, but the full node
name, so move them to 'properties'. As patterns, they were missing start
and end anchors so any prefix or suffix was allowed.

Fixes: 0611adff8b3a ("dt-bindings: soc: socionext: Add UniPhier SoC-glue logic")
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../bindings/soc/socionext/socionext,uniphier-soc-glue.yaml      | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-soc-glue.yaml b/Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-soc-glue.yaml
index 4b6852db4747..7845dcfca986 100644
--- a/Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-soc-glue.yaml
+++ b/Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-soc-glue.yaml
@@ -32,7 +32,6 @@ properties:
   reg:
     maxItems: 1
 
-patternProperties:
   pinctrl:
     $ref: /schemas/pinctrl/socionext,uniphier-pinctrl.yaml#
 
-- 
2.39.0

