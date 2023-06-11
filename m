Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 755FA72B22B
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 16:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233846AbjFKOEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 10:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233665AbjFKODx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 10:03:53 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE14E77
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 07:03:52 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f61530506aso35627565e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 07:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686492231; x=1689084231;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+lcjde5IsYaI8jj19D6Xo9EczqR6OYehR7xIWc5U1Bk=;
        b=uvqPbqmx/HeKPfkw9h/K9sUuEyM2dpw2CbfEFkknf1H3/iM9055lBIPlqgmoCbza87
         YBsuAypm60GqSq2TC3G0YPYXUW/muNKhEjiMa1tkoCgDqdcIulISV/luusuOJVnWt4na
         SDv8pknkXWbCFnSJ6pPEuKxSgRJUewWipdFQHRyjryy+OCk7PeB1dg2eTrps7zNXYrT7
         whVxLt+9mvnKhZ/GjQ48M1kniBE2goJCJb6tT2T0pYhY1fhyFH5HvJ7vU8CIWk3ZujYw
         T1gO5KNwY5279/3RPaAlL0hheSaUeJSXrJjTZ8wuZtGNlflRbBWeDp8J5A+3H18x/LCy
         CM4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686492231; x=1689084231;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+lcjde5IsYaI8jj19D6Xo9EczqR6OYehR7xIWc5U1Bk=;
        b=j6ynLC+ExpnZZHxZv17anM0yQqNabo//twEcXRnw9DTH+LSpSgCt3Z/dbw8ZQSq31Z
         z+nEn7sigRwvXwDR1QiXSVK6Yquf2WkOeZBfVyDYXyeQkWwfnWmRFjrjIFLD0xa2+5gb
         DUwLKR7xv0uHJuIecdaPy5lNYsxYj5VY1HYFnRviy1LCJU/0WXYO9GDdlEGZ0ZHi3SWg
         z6q6gENRzqxVImWJ+KZ1TwaL1+pQzDPHD6EBNeWhIFTk9Qd1NvxZmSyBWW0SsY9f2PaH
         H75KbVOjFZgQlqUu2PnryeKa4pYWD8OG4J8LwWCAgQcdzYt8tulqk1KR45gyivWKOEsV
         VodA==
X-Gm-Message-State: AC+VfDzqetsD02sZZG6VVQMUtLcqmUZ7ovNgjt3bSKHzbGQv5PNZOqYR
        Ui1gCqm2XRrPlPfBj8nJB5ItwA==
X-Google-Smtp-Source: ACHHUZ5ePp5/z8Prz3/wfzTcHCRxI52Hcm/ckuP6dRBH/t0e03NoJSAbiY3pE+uL3SbETG0VJBNlCw==
X-Received: by 2002:a05:600c:3793:b0:3f7:8fd5:567 with SMTP id o19-20020a05600c379300b003f78fd50567mr5536767wmr.2.1686492231163;
        Sun, 11 Jun 2023 07:03:51 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id h17-20020a05600c28d100b003f080b2f9f4sm8567222wmd.27.2023.06.11.07.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jun 2023 07:03:50 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, "Ivan T. Ivanov" <iivanov@suse.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 06/26] dt-bindings: nvmem: rmem: Add raspberrypi,bootloader-public-key
Date:   Sun, 11 Jun 2023 15:03:10 +0100
Message-Id: <20230611140330.154222-7-srinivas.kandagatla@linaro.org>
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

From: "Ivan T. Ivanov" <iivanov@suse.de>

On RPi4 the bootloader[1] will copy the binary public key blob
(if present) into memory location specified by this node, for
use by the OS.

[1] https://www.raspberrypi.com/documentation/computers/configuration.html#nvmem-nodes

Signed-off-by: Ivan T. Ivanov <iivanov@suse.de>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 Documentation/devicetree/bindings/nvmem/rmem.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/nvmem/rmem.yaml b/Documentation/devicetree/bindings/nvmem/rmem.yaml
index 38a39c9b8c1c..1ec0d09bcafa 100644
--- a/Documentation/devicetree/bindings/nvmem/rmem.yaml
+++ b/Documentation/devicetree/bindings/nvmem/rmem.yaml
@@ -17,6 +17,7 @@ properties:
     items:
       - enum:
           - raspberrypi,bootloader-config
+          - raspberrypi,bootloader-public-key
       - const: nvmem-rmem
 
   reg:
-- 
2.25.1

