Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0086672FF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 14:16:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbjALNQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 08:16:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbjALNQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 08:16:49 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ACEB3899
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 05:16:46 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id c4-20020a1c3504000000b003d9e2f72093so11721319wma.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 05:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B/XEAQRleT1IlhUju2ODygdLpb0Yjm0cKss4Fd8mbWs=;
        b=8KCdORxa4sltIzkkCwovv3Vi8R44lmL5pLpaqpI4LMA7qNOGvn7wuMCa9E6LhLvkRC
         WdfQCnVMVicU0wisHf5wPD9GL/C6b4YrStpZ+6jAO5xPcmUAGbJmONUd3GOgk8RzElD1
         xIfbeVVp99xH7vCKLhdSrG+s238rVbla9TkgdpA23OGmBKopQ1T/XmNR6EG/0YxD4oP8
         NMERybGD2ura1HTp9xtFk+dG3HX7QTbH1og+u+JXzA1HcW8etbxVRkZxXeCa5dxvpdIx
         r9VdG9oirrrQ4JGUVucujtY9NNRnxO3E6WjhyaVsfVYqn3ZxJVL7zsmqmDur/g+isKXA
         2ctQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B/XEAQRleT1IlhUju2ODygdLpb0Yjm0cKss4Fd8mbWs=;
        b=J5DYy/+RajKQ7CO1fGcD2D4hflvC7OmON3t2suYE62aBogp75FgVgDhnZeB9cTcr6e
         w6I+Se8pFJF3N00wmdcN5lncnzGS/BraZHMdRkREe8owCnAwVhBSu6NsMCh1JWrRHbNp
         PYCQ6IkVxIs/2HweWplP5btnx/egaDDqKY6eWzwrcGcZhpO4XGOEsrQK9vMIojxUO+D8
         At7WEuHGz5/zpA7NreqW4lYQdVo3tRbM2d5UfV4BGk50WSi4G4S2o1ZA2c6oNeDtk0b/
         gJi8dpHjXjPZ2x8Q03hvyXQGx9aCpoBgdoR9ieJZwiKBoXnft/T+qGjpOOrY8LniyPun
         KQAg==
X-Gm-Message-State: AFqh2konlNVO9diWLaEQ8Jtr3bbkM4XQbLE53c1YzIHcEjtLPLKXhiP0
        cmHgOeaFkdUrfZUDSMux4NpxeQ==
X-Google-Smtp-Source: AMrXdXu7weo2fUVafMIgAIp1lRxEQO77KFYppaiJx8aSCN6gxldryrSeh/67F5ZiE2pCb2hCaF2BoQ==
X-Received: by 2002:a05:600c:601d:b0:3d6:4ba9:c111 with SMTP id az29-20020a05600c601d00b003d64ba9c111mr55143004wmb.40.1673529404666;
        Thu, 12 Jan 2023 05:16:44 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:d8:37a9:b9c7:ec8a])
        by smtp.gmail.com with ESMTPSA id o5-20020a05600c510500b003b4ff30e566sm8765204wms.3.2023.01.12.05.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 05:16:44 -0800 (PST)
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
Subject: [PATCH] dt-bindings: mailbox: qcom-ipcc: document the sa8775p platform
Date:   Thu, 12 Jan 2023 14:16:36 +0100
Message-Id: <20230112131636.359402-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
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
Sending it separately for easier pick-up into the right tree.

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

