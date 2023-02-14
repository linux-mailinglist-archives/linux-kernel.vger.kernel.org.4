Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF8A7695F28
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 10:28:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbjBNJ2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 04:28:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232372AbjBNJ2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 04:28:02 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A8825285
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 01:27:24 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id r2so14914187wrv.7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 01:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yv8IAedTIIyQacPC2rWyTL/uMmzGJUZpAZ3MenFek+Q=;
        b=zn0CFKMh5UaxmMLb1+nmdeN2PG3bInGGMBh93fZjiyWsgWgTiH0ttWVR0V5kNh11TL
         oQnFc94MqPQVkNX9Wy9+JMARqh2lGyDpVg73a8PZ+2gvGrPeyO5XKurtu+vAtq2oDMwU
         ACCC6dJapGVqWkfBSsf5Obm25kUMN46SxN6RL6VwzeVF9FJ082HxKu4r4I7/LLJDqQ6V
         HzZp+vHkhafOx/1lweMWbP4bqGx3Y9RdlGpFW3cx22aL7B/epjmxyiyGxE3n+QMds+eg
         ZHOsf/qWbVQm7gI8aw8lRZlg055p7qV8eh79ir9IL5GrYu6I70EBbfeJWUjxIYdCgMSC
         Cxtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yv8IAedTIIyQacPC2rWyTL/uMmzGJUZpAZ3MenFek+Q=;
        b=qEd2QGEkSv6Fz0VC4Rs1qjs96SffZTl8c4+EB/eUVQN3xhTqR7BziM6a8ngaVmFYfD
         MThLqAceNlC8Bzywm1NA9dIDUKXJIcqhK0wXz3DNiNR6K4o7zBXEUHG2aqHMUdWnTduK
         WBZjvwMXiBpdo9xBdKzkEZbk2/hU9jmK3tWs5VszIizRHKLS3k5Ev+Tfa2vksvii/NrJ
         dF0Y2hWxDzidguKqgrHm3S3+H0q89fsmwjhPG34dMGC6Cw5gMZeIuBDg6Yr3xTpRzd38
         mVlA2GJe5qgIF6W3Kh2uPBz9D9YlehqwtuN/nq32qEsJ9R3FfOULhJLdBTFzJUNUnhg9
         GVVQ==
X-Gm-Message-State: AO0yUKXvUQHfr+dzdbSoApOcTBXzvbP7eABd8w14TAc/vrnFERd3SqVd
        rsNPTUmfVNRM7Mt72/txCjncyA==
X-Google-Smtp-Source: AK7set/fnnl30PpaLE4exuY8KzSt7RDSlzsiTwNNpEeixwCu22P3EXNtRPUNDPIorQMfdPb1+gGWpw==
X-Received: by 2002:adf:cd08:0:b0:2c5:5a63:ae07 with SMTP id w8-20020adfcd08000000b002c55a63ae07mr1544475wrm.23.1676366839213;
        Tue, 14 Feb 2023 01:27:19 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:6e4b:bef:7edd:1af1])
        by smtp.gmail.com with ESMTPSA id k2-20020a5d6d42000000b002c4061a687bsm12687602wri.31.2023.02.14.01.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 01:27:18 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 1/2] dt-bindings: mailbox: qcom-ipcc: document the sa8775p platform
Date:   Tue, 14 Feb 2023 10:27:12 +0100
Message-Id: <20230214092713.211054-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230214092713.211054-1-brgl@bgdev.pl>
References: <20230214092713.211054-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Add a compatible for the ipcc on sa8775p platforms.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml b/Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml
index f5c73437fef4..de56640cecca 100644
--- a/Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml
+++ b/Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml
@@ -24,6 +24,7 @@ properties:
   compatible:
     items:
       - enum:
+          - qcom,sa8775p-ipcc
           - qcom,sc7280-ipcc
           - qcom,sc8280xp-ipcc
           - qcom,sm6350-ipcc
-- 
2.37.2

