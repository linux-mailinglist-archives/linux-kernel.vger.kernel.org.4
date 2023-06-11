Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2742972B232
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 16:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234059AbjFKOFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 10:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233813AbjFKOEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 10:04:33 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C6D210A
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 07:04:03 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f6d3f83d0cso35575395e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 07:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686492243; x=1689084243;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YmDf3BI3bzNg9o4CowlmAn4byNY9OfAOi9w8j9LZ3tY=;
        b=yJ0P5HIpU1cS0Jc6bx2anPndDOaM7iqvfCCgiOgW8h08wSjjieD3VFiiD/vDG8vwrO
         7CfW5ZC4IKybneIU0sUQ7VJdrYlswG3OMZVjGtgWfGTxmqcM5r43lxbo2na3Oj7ro7Bo
         Tq/Az/ziIcirF8W9TvUKFc5Srp4Tr85NPuFwaAJDSWZmqH31wEW21dp3iJU3LdC39Fbf
         C+2YDi1TKVWLt9CAlxpSFemBPnSRoyACsnnU4YdRL3BF1Si79rWuSLlBP0tpOdsIRMws
         e7cFP+gqEwy3G6JYja2U9VZLa55wav/N39jhHf+WhUrHHp2sV/L3IBr9ENfKYUMdWiJv
         iIvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686492243; x=1689084243;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YmDf3BI3bzNg9o4CowlmAn4byNY9OfAOi9w8j9LZ3tY=;
        b=ZR2CSYuAjpSqD9i0KvCFhHGQ0DgbyTkpAdgbna2O3mMpSe+vvmVi+d1eBgaxL0rv6t
         nNQGBxi5hOeawWWlMRfBkmmFzboTHviSOQwthvMufAq6VF3rNLwxdUL5VNSLY/LebAmC
         O/GU79Tx86Hc9h2Z+GQ/PG1rLgXSD6E/ohepR/i4a0SvWr3E7poIR0FMUz+lAO5DNLm8
         Q5kujnjc/nWiV1vqzSQS1bb3vP7Mb+Y7wqkCGW4oCG3dXXttGnSHgcr70RPKujJZiJAn
         6gEpkQ8PnVjVzIlOFguvVk92T3xRBpTlo08Y513TeUpAjOXCQaN65CQlKpZyAnrMFZKG
         NcHg==
X-Gm-Message-State: AC+VfDxqZsMGpddvguluREY0iOuPc2pmDP861l7ZiKTvI+jkTv91IiWV
        j4jBIRWRQEb6CnwANV5Ux8pW9A==
X-Google-Smtp-Source: ACHHUZ4VStewkAaUGO99SYGL0Y8KUmqRmffnaQEp2TDhXt18TUA9U/YIGEjNtUmUQwodfYnf/htRHw==
X-Received: by 2002:a7b:c853:0:b0:3f7:e58b:5898 with SMTP id c19-20020a7bc853000000b003f7e58b5898mr5582269wml.33.1686492242784;
        Sun, 11 Jun 2023 07:04:02 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id h17-20020a05600c28d100b003f080b2f9f4sm8567222wmd.27.2023.06.11.07.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jun 2023 07:04:01 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 14/26] dt-bindings: nvmem: mxs-ocotp: drop unneeded address/size-cells
Date:   Sun, 11 Jun 2023 15:03:18 +0100
Message-Id: <20230611140330.154222-15-srinivas.kandagatla@linaro.org>
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

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Referenced nvmem.yaml schema already defines address/size-cells, so
remove redundant entries and use unevaluatedProperties: false.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 Documentation/devicetree/bindings/nvmem/mxs-ocotp.yaml | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/nvmem/mxs-ocotp.yaml b/Documentation/devicetree/bindings/nvmem/mxs-ocotp.yaml
index 8938eec22b52..a9b822aeaa7e 100644
--- a/Documentation/devicetree/bindings/nvmem/mxs-ocotp.yaml
+++ b/Documentation/devicetree/bindings/nvmem/mxs-ocotp.yaml
@@ -18,12 +18,6 @@ properties:
       - fsl,imx23-ocotp
       - fsl,imx28-ocotp
 
-  "#address-cells":
-    const: 1
-
-  "#size-cells":
-    const: 1
-
   reg:
     maxItems: 1
 
@@ -35,7 +29,7 @@ required:
   - reg
   - clocks
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
-- 
2.25.1

