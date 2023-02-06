Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 745E568BE88
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 14:44:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbjBFNoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 08:44:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjBFNoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 08:44:17 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C150C171B
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 05:44:07 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id h16so10376082wrz.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 05:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ezl79ZrFtdgcZgpVVd2789IBH+ROi3SQvtmwb7LRshQ=;
        b=kLbQjpp+yiFEof3kgQGIRvdAG5E4s1w7U0CwzYzfOazeD7mDTdFoIkBj1SLzWJFCOM
         aIrgw/bXwdXdy7WHWoFwtB6+YB+Pmlcv916+1K4wv1tn39MKp6uATJF48JXAkw96qz7U
         CuSO5g2O2xkEReMJ7P2lEsd1tJ4JaqcK0lOnvXv8KDhFFHKop7ayer3OIZlFt/yUbE6L
         4ysc+x9lsVPRRz6Fq31CB3QrsWFNFZVbia0VRROd1j31RW5i+cL1s11fL2rve07yhbXR
         FHt4+mFFF1Wo/o/hxww2IxXac7oaa//g8NFdDI6BFPMv7DTNv1pnzHPTQ96e80xT0RKA
         USBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ezl79ZrFtdgcZgpVVd2789IBH+ROi3SQvtmwb7LRshQ=;
        b=CZ2ahREzkOHyox5cgzT1Bvr7fE8BAtRpg92zOIgNUR934sHX6W0gEpoGajDInT7gPM
         W2Dc/dQFwUSMOzaJOsQByuYvCrjqtUw9+cq1iNwiJKblNilTaWcuaqyRPfCKRqMZ0q84
         Dt4lUIF3rzVut3Lb4zw9MPHO/vNn4jqDar4+VSJZYiHMemkY+BShVBbyrNfORJqGAVZh
         aGV+btTgeVe7YnpwIOCYkY8PVbORxxK0L+eDsbJrBv6ockOXPzXxD46QNcwd5gwaKSCA
         8YhLlTF7rDInhmIm5mHMIV3ANqDkrd271xmJcE91n9XbhpAIIORH5GqUjKHy+As2kowf
         zO7w==
X-Gm-Message-State: AO0yUKUFbaRQXuPWBaK/bISc5a4lO3fMg34K0iwxX1ZJ/yglZkcDEh8g
        CCxjm8pDJYQpjXtMqCjGzhdMmw==
X-Google-Smtp-Source: AK7set+d3iadIuWYGv5FMnRCWDbtJkPgZQzhceYHzmr+5LpWHGTFcKvz6y58uJ5ClLQiBmJorLPI1g==
X-Received: by 2002:a5d:4bc9:0:b0:2c3:e300:f5a2 with SMTP id l9-20020a5d4bc9000000b002c3e300f5a2mr6003394wrt.50.1675691046359;
        Mon, 06 Feb 2023 05:44:06 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id o15-20020adfa10f000000b002bddaea7a0bsm9008037wro.57.2023.02.06.05.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 05:44:05 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 03/22] dt-bindings: nvmem: Add compatible for MSM8976
Date:   Mon,  6 Feb 2023 13:43:37 +0000
Message-Id: <20230206134356.839737-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230206134356.839737-1-srinivas.kandagatla@linaro.org>
References: <20230206134356.839737-1-srinivas.kandagatla@linaro.org>
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

From: Marijn Suijten <marijn.suijten@somainline.org>

Document generic QFPROM compatibility on MSM8976.

Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
index cc39514e8c84..48cfec0c9ece 100644
--- a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
+++ b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
@@ -21,6 +21,7 @@ properties:
           - qcom,ipq8064-qfprom
           - qcom,msm8916-qfprom
           - qcom,msm8974-qfprom
+          - qcom,msm8976-qfprom
           - qcom,msm8996-qfprom
           - qcom,msm8998-qfprom
           - qcom,qcs404-qfprom
-- 
2.25.1

