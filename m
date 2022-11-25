Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E10E638455
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 08:15:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbiKYHPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 02:15:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiKYHOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 02:14:54 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE1E2C659
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 23:14:45 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id s5so5454947wru.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 23:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h0J+ugIJ0lSNoX8rurDzNvXKfWJes9/BQo4T8s3+pWU=;
        b=r0hjAf3ZDG7cDT7bMZ0xSyOfhLsEyHqLQo1KeHT9hcpxcwKczhFsNRbZvvz+hMrfkW
         q0IWF06asjf10hXrQUiA5/JOJOSRrtiCbKKbRnztFz6UUuKuho7VRm6swC9P+QogGbI7
         vQy9evy4C5nkUhWrkDOT5dI390Q0d6O+0dy9e+lDzAzdUrbqhcphMxXcTNcvziE9ewz4
         JgJ1Z+ASiGhBPp1AjYtgDINFqbUyFB11sXcyCJHOC5v8qsOAXFvU/pk7H5DGEdfiXzy6
         cjSfjwLqQ8XgfmAKiQJHMZgLvZDCnFLPezwT7LLucMfAYFpKKwUvuEcyI83Y+tIsmxdA
         xwrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h0J+ugIJ0lSNoX8rurDzNvXKfWJes9/BQo4T8s3+pWU=;
        b=3/W8bRoOJDb99SrCmm4nnx1ljUBgT38/gYRHqrjZQV6C4ToOl9Ez7WLogBi60hzaON
         CDPgm9VhJ1htDljuNIqfRMf8x8J8pdr7LrkCb3S/IVsefBPaP+T8ExrSKAy/YnDQK3Gi
         gSb7sclGDrNxiXkpbqXJrG2rciqYEEJuCLgNtDhJVqqgLnm6iqYhjZ5rUdp4HxpzC17d
         iurp7BAp3fVgu5ObGWqMzRNRxOciZwuwWIr1rN8E4/flleuIo2QHmJzLeVMe/LYAWPwt
         gMXH+tMNHBt9IXahwvuNVCIkOrEH9yVVOlvevmderUZqlAi99DKOedQu/tV3kLsO/Qvl
         YB3w==
X-Gm-Message-State: ANoB5pnLP5qUk+jMIYylaRIhAiWK9gGWBaYdoy9tMar8cnQ6N5SroZZs
        pZbkQ+gHjQ/FsDUC7rkoWudbEw==
X-Google-Smtp-Source: AA0mqf4Xr9K2n6Txib0mUy7MXtfu6OwmPXLw/5tY22MQibgQJ356JlhpK1+kFDnSTYWtmnGldZDq5w==
X-Received: by 2002:adf:a54b:0:b0:242:49b:5bb1 with SMTP id j11-20020adfa54b000000b00242049b5bb1mr1378797wrb.337.1669360484227;
        Thu, 24 Nov 2022 23:14:44 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id c2-20020a05600c0a4200b003cfd4cf0761sm9108444wmq.1.2022.11.24.23.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 23:14:43 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 01/10] dt-bindings: misc: qcom,fastrpc: increase allowed iommus entries
Date:   Fri, 25 Nov 2022 07:13:56 +0000
Message-Id: <20221125071405.148786-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221125071405.148786-1-srinivas.kandagatla@linaro.org>
References: <20221125071405.148786-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Abel Vesa <abel.vesa@linaro.org>

The fastrpc components on the SM8550 SoC can require up to 3 IOMMU
entries, this bumps the maxItems to 3 for this purpose.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml b/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
index d7576f8ac94b..1ab9588cdd89 100644
--- a/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
+++ b/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
@@ -79,7 +79,7 @@ patternProperties:
 
       iommus:
         minItems: 1
-        maxItems: 2
+        maxItems: 3
 
       qcom,nsessions:
         $ref: /schemas/types.yaml#/definitions/uint32
-- 
2.25.1

