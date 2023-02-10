Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 639FE69182E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 06:55:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbjBJFzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 00:55:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbjBJFzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 00:55:47 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E666BA94
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 21:55:41 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id o75so2792854pfg.12
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 21:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ufispace-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JBEDRihCzDtrVkBKLnVTDhVFILtVss8RIDHmoPN1r7w=;
        b=Q/IQZilN4zWkZJKqDLqhFfojSgNZKTcRW3gnI/NWshsNU1Ba6sL1V+ruKzrzCHz/iK
         E59JxMxWwMx+j+/2bCx52XS+T+lAjd4uqjAi3WYLZgQdM6ASVkxxQo1AoX3EnHfbLnpZ
         5RDJd/0kMJ0a12Nm3Sp4iiDz16nuxBu86KKHnIuPcxphQ7UvdRSr+NsYNdEShUnt+F+Y
         w4giOVtaBBBriYZxTgMwMMzFhsb6AgiPQ8X6iM1yyGZjzuRnlyMFIqHus6Sdsj30RDAD
         grTwl+3gSQr4uG1PNvTCKZz5d4pzQamyOClQ1m5uTfVsmctYND4/5iTkjAUr5PbU8JQN
         TdjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JBEDRihCzDtrVkBKLnVTDhVFILtVss8RIDHmoPN1r7w=;
        b=xwcbIT1U+Kuuqq4phPBetwvo81PnXsmtZmqQnWVTz+Rc3/A48wluoJFnwcsP94NSuD
         PNWs56tfX0kTtVgyGh6PDkQUkxQ58623xNNYcRo7s8u4zuK4VdwpysiJXAH6w307p7qH
         BPLseTdPmTkMpJpNo+k0okBrT2umSdc9FxW0vaMd5gqQ/6Ow3Bhit1V8F5bmmo1n3D8l
         HpM5Azo7ybI12YoeaUeajPQsfm/NkHp0jp7MwtQUSdPrXRWDXG16OiEVCVad6CetsuWO
         XqpUF8dQ4HyzhW4Y1Rt3on3MVhD1Eog7PwCQyVSUJj+v9EMNUhKK5HrnNVtote/WJw7k
         RcIg==
X-Gm-Message-State: AO0yUKVr+gSE+6xWK2N8np03ahHae54j/8db7YgOe84xPBIgyDnbTKWm
        359l+rxuwJsFWCO5X7auDuczHQ==
X-Google-Smtp-Source: AK7set9ChVdnnmJf43lU79NxYFsgPGiwAyo2EN9Zw+h9JLv+Iq+zjPAufgMAqtBJWXCrjPWCL96WFw==
X-Received: by 2002:a62:8407:0:b0:580:d71e:a2e5 with SMTP id k7-20020a628407000000b00580d71ea2e5mr12071630pfd.22.1676008540641;
        Thu, 09 Feb 2023 21:55:40 -0800 (PST)
Received: from openbmc500G.LAB.ufispace (CH210-63-217-225.static.apol.com.tw. [210.63.217.225])
        by smtp.gmail.com with ESMTPSA id f15-20020aa782cf000000b005a84de344a6sm2500025pfn.14.2023.02.09.21.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 21:55:40 -0800 (PST)
From:   Jordan Chang <jordan.chang@ufispace.com>
To:     linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        joel@jms.id.au, andrew@aj.id.au, robh+dt@kernel.org
Cc:     jay.tc.lin@ufispace.com, eason.ys.huang@ufispace.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 2/3] dt-bindings: arm: aspeed: document Ufispace NCPLite
Date:   Fri, 10 Feb 2023 13:54:50 +0800
Message-Id: <20230210055451.72153-3-jordan.chang@ufispace.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230210055451.72153-1-jordan.chang@ufispace.com>
References: <20230210055451.72153-1-jordan.chang@ufispace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document Ufispace NCPLite board compatible.

Signed-off-by: Jordan Chang <jordan.chang@ufispace.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 272626937ecd..0f180aad3a09 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -85,6 +85,7 @@ properties:
               - jabil,rbp-bmc
               - nuvia,dc-scm-bmc
               - quanta,s6q-bmc
+              - ufispace,ncplite-bmc
           - const: aspeed,ast2600
 
 additionalProperties: true
-- 
2.39.0

