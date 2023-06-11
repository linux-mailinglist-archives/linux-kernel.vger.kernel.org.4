Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0649F72B23A
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 16:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234199AbjFKOF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 10:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234023AbjFKOFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 10:05:08 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEC063AA8
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 07:04:25 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3f7fcdc7f7fso22272635e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 07:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686492251; x=1689084251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WgOFOi5BGVeQDQUBD/lrzUW5vkBt/0h6EfOVfqYbWGI=;
        b=WryJxTzwEqNoCeXdnYgCkqdVJ1KsO6e/hWkVw24Av+xrjo4AV//X01bRUFOLUpTzWP
         2rEK3LTa2Atmc5MkVNiCJ8UL7kUyB9NQlfccL4bt9ikDja0hT6CZs/mc9EN17xQ7esPH
         UgFLhkPX8ez88yUC9A/RhpJ40fIp8fQfX6JGKu95wyA+1W5B1CuiyHTid+lV3ExZWarl
         RrkRWBt0j9lqt1oxF1RMMa5ziibqSfUQ0mrkRL0Yr1A15hFvie5009QBSUWQLEnkQx7H
         u6+TsQsSXNeqO7BM2Jw52Fhh0ebkgoX9zVLo5BLoeXUmH+0+W/1LSBNQcQU9xDQD3bNA
         nTPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686492251; x=1689084251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WgOFOi5BGVeQDQUBD/lrzUW5vkBt/0h6EfOVfqYbWGI=;
        b=A+tIR8WqQwMajNZ+YQWm5jkaGvREXyqJxmk0nILsd2JmsPX6SGj+1gxyeEbEdC9mt1
         kd3Ws4ZoN8poPal3KJ0XxfJvcD6lSUNs/qjytu5h/MF1ES8qO+Imp4fToGpYGk9zFof1
         s+Kf/6aghU1QRaUKOjPT0TrSBeR5hYNmxthXXwWkIWZnrIYaBMHH7OE6hLcVePRcpUio
         BLhd/Ydscsp17q2fHqLHYnXapHHNYv+gHPJWiLc92DYtEOF8Rt2bUuAhHkFMVKINQ0Ou
         UTETe5YNLZsF1YidzHNUT2PgiFYRfAkbgTTxxAcawmYm381jANQhAR7I5+cbqEtTqDTL
         YIYQ==
X-Gm-Message-State: AC+VfDzReeWGne6dgXPwPtAbmJLF90PVUi3yRXsvcbPVub3rsaBxqiy5
        95L+Mv1y6f158r8kr6zwJJFW+A==
X-Google-Smtp-Source: ACHHUZ731k2/Mcz6OQ6UfLJAgv9691CvkPX2MRzdlmDuz4hQlgi/Wg4pQGS+ACVDkBPRAZYTP90zAA==
X-Received: by 2002:a7b:c4d9:0:b0:3f7:e818:3a6c with SMTP id g25-20020a7bc4d9000000b003f7e8183a6cmr5798540wmk.5.1686492250964;
        Sun, 11 Jun 2023 07:04:10 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id h17-20020a05600c28d100b003f080b2f9f4sm8567222wmd.27.2023.06.11.07.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jun 2023 07:04:10 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 20/26] dt-bindings: nvmem: imx-ocotp: support i.MX93
Date:   Sun, 11 Jun 2023 15:03:24 +0100
Message-Id: <20230611140330.154222-21-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230611140330.154222-1-srinivas.kandagatla@linaro.org>
References: <20230611140330.154222-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add i.MX93 OCOTP support

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml b/Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml
index 9876243ff1e8..7112d13c9bff 100644
--- a/Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml
+++ b/Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/nvmem/imx-ocotp.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Freescale i.MX6 On-Chip OTP Controller (OCOTP)
+title: Freescale i.MX On-Chip OTP Controller (OCOTP)
 
 maintainers:
   - Anson Huang <Anson.Huang@nxp.com>
@@ -12,7 +12,7 @@ maintainers:
 description: |
   This binding represents the on-chip eFuse OTP controller found on
   i.MX6Q/D, i.MX6DL/S, i.MX6SL, i.MX6SX, i.MX6UL, i.MX6ULL/ULZ, i.MX6SLL,
-  i.MX7D/S, i.MX7ULP, i.MX8MQ, i.MX8MM, i.MX8MN and i.MX8MP SoCs.
+  i.MX7D/S, i.MX7ULP, i.MX8MQ, i.MX8MM, i.MX8MN i.MX8MP and i.MX93 SoCs.
 
 allOf:
   - $ref: nvmem.yaml#
@@ -32,6 +32,7 @@ properties:
               - fsl,imx7ulp-ocotp
               - fsl,imx8mq-ocotp
               - fsl,imx8mm-ocotp
+              - fsl,imx93-ocotp
           - const: syscon
       - items:
           - enum:
-- 
2.25.1

