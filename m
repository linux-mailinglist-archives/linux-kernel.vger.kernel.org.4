Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4530C62EDC5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 07:40:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241249AbiKRGkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 01:40:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241179AbiKRGkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 01:40:15 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E7B89BA27
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 22:39:58 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id i186-20020a1c3bc3000000b003cfe29a5733so6819045wma.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 22:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1EtHwJzeElZKUFj3RehIBV9OlxuribamMcnPQCPFmzU=;
        b=hfFqCpMZEitSiqKOKe7NqFDiYwBODKR6MwRtrakFoJuNz8jgxsGkyF7grPJceXe2rh
         tfGhc6wTkd5heXc8jk9rBDGS0+gra/8tUAza3oHFBcuNIYbgCDpCZUJG6D/eR+Rjcjcf
         xpjJPrN4uv7JK1O/m84c6GrSQ+SfwskbUplwo6q9QuD3lKpRDJqscS8DnQmr3SiPkRSC
         iAsoJlbV7tb6tf1cJnV/mtrFgUNjUrXIa7lMM4vqj3gdsPyXeY35WJ0phsStDzb7V6Vp
         8wpBDYPWLoH/SXVUceGW6twrvtQgRYVjsmYQpxGmerveMRTKfUDdbsQGsHB9CUYpgtNA
         L+eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1EtHwJzeElZKUFj3RehIBV9OlxuribamMcnPQCPFmzU=;
        b=XLnK60iS7lD4299gfgyKwT0mFVytZq2wYKBXl4jKSIw2Qqx86Nnq8uC4k9jyAopJ0G
         JUdz6qLODXnYjlXYofJhzAJSW3uoPi4N8IgTzZF0yOYP57QxzVa5N6NTKJzpEkAWSN+7
         XGvPZ+0uKzwy0vpeA9JHMZAQDeuV61Ta7/zK0DEHq7RjV3uzJA107oA3E2FKw5AgnkY/
         3kmhBGKM4AOxRe7+v+RJ0njD5oDwsj0A+h3QI60dytM9oEhE5NZH+c9AnKOIcNFwCkyq
         217jREEQTInDqrM161lqCdnfaec8fbqcbUkuUfL9LXHiYdmyBnlZ9f2WhrqFs+vCtxTl
         SBrw==
X-Gm-Message-State: ANoB5pl5RgwjCEZ72KEBlH9Y7ZqpqaY/ammdomuU1QjF2XpEFCc4dp2M
        r54P08POUqW0jfoIqR8nVWraGQ==
X-Google-Smtp-Source: AA0mqf6k1QKhniOZ8mISw98jIdHku3AosMNLcXBEiOTiqR43Qd+qn0dD2F/AhNPRvxNt+NJJYhXn5Q==
X-Received: by 2002:a05:600c:31a3:b0:3cf:4757:fc3 with SMTP id s35-20020a05600c31a300b003cf47570fc3mr3903538wmp.172.1668753597029;
        Thu, 17 Nov 2022 22:39:57 -0800 (PST)
Received: from localhost.localdomain ([167.98.215.174])
        by smtp.gmail.com with ESMTPSA id j13-20020adff54d000000b0023655e51c33sm2785902wrp.4.2022.11.17.22.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 22:39:56 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Patrick Delaunay <patrick.delaunay@foss.st.com>,
        Rob Herring <robh@kernel.org>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 04/13] dt-bindings: nvmem: add new stm32mp13 compatible for stm32-romem
Date:   Fri, 18 Nov 2022 06:39:23 +0000
Message-Id: <20221118063932.6418-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221118063932.6418-1-srinivas.kandagatla@linaro.org>
References: <20221118063932.6418-1-srinivas.kandagatla@linaro.org>
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

From: Patrick Delaunay <patrick.delaunay@foss.st.com>

Add a new compatible for stm32mp13 support.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
Reviewed-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 Documentation/devicetree/bindings/nvmem/st,stm32-romem.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/nvmem/st,stm32-romem.yaml b/Documentation/devicetree/bindings/nvmem/st,stm32-romem.yaml
index 448a2678dc62..16f4cad2fa55 100644
--- a/Documentation/devicetree/bindings/nvmem/st,stm32-romem.yaml
+++ b/Documentation/devicetree/bindings/nvmem/st,stm32-romem.yaml
@@ -22,6 +22,7 @@ properties:
   compatible:
     enum:
       - st,stm32f4-otp
+      - st,stm32mp13-bsec
       - st,stm32mp15-bsec
 
   reg:
-- 
2.25.1

