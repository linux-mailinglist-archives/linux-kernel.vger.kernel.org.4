Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DEB667E2EC
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 12:17:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbjA0LRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 06:17:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbjA0LRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 06:17:47 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2283544A8
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:17:46 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id z5so4660287wrt.6
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ezl79ZrFtdgcZgpVVd2789IBH+ROi3SQvtmwb7LRshQ=;
        b=CcLf8nj7ZXKd6+ZzgKHdp0A+lexoCrWstBA08D4Nn11mM3bEpAmV81r9w6Z1KlMiDb
         4m/qlwjMp1mYSeQBX2DdMCs4ZL7EvKA/vHt3BRfb6ntxWic8FeyBPQCQ9n4IexUSx5Ph
         WxIDPsSuSmNfBh56EE7WQtavrStP35uiM+3oiOotvRxoTgHw2u7tQ06b/Kq/EFlIxIMa
         rdu5JIRFmzILcMWGwu2uEMQaflI3klb7HWrqpNbl4Nh44my03L4n3VPR0a2Y4uRCECpc
         wGFkY+W9Zu7LbCnwOy47g3jGrfhBgY69Pmxo4BfsmKEEyXXl0TBEg+l3OdcYreKgce1G
         mJfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ezl79ZrFtdgcZgpVVd2789IBH+ROi3SQvtmwb7LRshQ=;
        b=plGnSaNWPc97P8WtaU74olRutBQFh2PMCkoU13SoJTnS0eabXzUtyO6iOsmh1DjnIE
         8asLque9rpNWNAG/JRvkn03KwqtpRIrruL1unuPxaSNXYRePo3ilbp4XYAuA62L+ZNVx
         LITyVXHpufdVu1DMxoLWL4FxXwngQ4yuXvn1OsnHb+03IM9VV34pCQm5vvBZiwxFKw1F
         qyHFS5PlQYFEl+hbfVg2lPPXkRUKjVKJMcdCw2gW7bt36fM3j3IXx+dgDtAGe0hvPdDH
         zOdg7tEHEh6xGqJAq+avFlB3MD2DaqDZqm4jHSks3KoNAyNtv5sTLfZWBddBwEbAWRxd
         2vjQ==
X-Gm-Message-State: AFqh2kqhWwtePdaoepeYTHi6Wn+H54G5n5K7/Eg1OC/hvSHfM4KChon1
        +AEoYwVxe/4Ct09zHDPileWTow==
X-Google-Smtp-Source: AMrXdXsrwxbJnBdD7zH2ht/h+NXSLwRe79cY1M7MdIB7wzy73083zszBZg7P3MIIDBqS5aG25Dox2A==
X-Received: by 2002:a05:6000:98d:b0:2bd:f172:94fe with SMTP id by13-20020a056000098d00b002bdf17294femr37267473wrb.17.1674818264713;
        Fri, 27 Jan 2023 03:17:44 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id c13-20020adffb0d000000b002bfd190fd60sm1843314wrr.108.2023.01.27.03.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 03:17:44 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 03/37] dt-bindings: nvmem: Add compatible for MSM8976
Date:   Fri, 27 Jan 2023 11:15:31 +0000
Message-Id: <20230127111605.25958-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230127111605.25958-1-srinivas.kandagatla@linaro.org>
References: <20230127111605.25958-1-srinivas.kandagatla@linaro.org>
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

