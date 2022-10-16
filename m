Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 248B160019F
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 19:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbiJPRCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 13:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbiJPRBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 13:01:46 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C2C37F8D
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 10:01:41 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id hh9so6508544qtb.13
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 10:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LEP7LBVvpmeVA8/+OWTvoqrCZYU/QBAuWRLz/C2JiGY=;
        b=MipN8K0oLCdXNiVpoAhcT6ykDUGpVlW8Mv6+SpZsJK+geg1Ii0wMA7cjDVZd+9kKIh
         qTGM90grHq96kLJ4MEN6ZqRMAJ2kG6/S+WVv3FFLWAWE9n5MAX3zAKmWHdYVS0iB/Zlu
         ylY6U38/lUGX2UvH0ipES/RwJiMx6ZT+izObo17VUP5LCWnlG4k9jgq2RX/OrAKR3MbC
         TrxVExqg9AVukax/UTOU0Nu4ByE+K4oWEkX9ByolGzdGvynXNLWt3z4U7wkIAW7kezUp
         Y5GJX0d2iN4LoUAfI6ooQHayNMwnMUTMU68bu+rfSheNhfR3pv+f1BJzZi/soZvpGka0
         ZdVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LEP7LBVvpmeVA8/+OWTvoqrCZYU/QBAuWRLz/C2JiGY=;
        b=eSvycTpQ/CQBqUpIfV3RYhbWZdvBPifOP/8ty4PauhmCypO8wnxTL5k4vir2O2R+Nq
         ZkTLfR8NCBQTOakbVyJM48DvMPiL73k8g8+O7QpmrysBAM5H/yV9PfdCMEt/QOx26DfH
         K/xl2HtQRCS1NKTVgDRg6lRDoPvEJRipn1Fixvdyiyaz55EY32m1ZghjzezF3Ccqqaxi
         eXBBW2Qv+i3q5+OKXpblg6Rd8KgKGUsl//7u6CrX2T+WlNYL9DB2oowQsxrMTB2q+yMS
         Cdn+fUAQy2K9nU7UL9ExIfkEz/sEwow8aziJCZSqhNeg4S9L/mcUVFR059OL1XDY4aZk
         JXkw==
X-Gm-Message-State: ACrzQf1FUDnsl53l2ZYiKNTQHtvcKGpyKu85quCMFRtmnHR1cB1s0dJs
        s0YePmqkS7b7YpQVy5uiYbxiKA==
X-Google-Smtp-Source: AMsMyM6yDRKxKB6OB+0V0cHV68MNWrOzjXhfLmLchaq4Bm0igxBXylFz5DkpN/0b2EQG1WiVw+yLpQ==
X-Received: by 2002:a05:622a:54d:b0:39c:dadc:10db with SMTP id m13-20020a05622a054d00b0039cdadc10dbmr5891943qtx.504.1665939700826;
        Sun, 16 Oct 2022 10:01:40 -0700 (PDT)
Received: from krzk-bin.hsd1.pa.comcast.net ([2601:42:0:3450:9b13:d679:7b5b:6921])
        by smtp.gmail.com with ESMTPSA id q6-20020a05620a0d8600b006ce7bb8518bsm7539967qkl.5.2022.10.16.10.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Oct 2022 10:01:39 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Shawn Guo <shawn.guo@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Sivaprakash Murugesan <sivaprak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v5 08/34] dt-bindings: pinctrl: qcom,ipq6018: add qpic_pad function
Date:   Sun, 16 Oct 2022 13:00:09 -0400
Message-Id: <20221016170035.35014-9-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221016170035.35014-1-krzysztof.kozlowski@linaro.org>
References: <20221016170035.35014-1-krzysztof.kozlowski@linaro.org>
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

The IPQ6018 pinctrl driver supports qpic_pad and DTS already uses it:

  'qpic_pad' is not one of ['adsp_ext', 'alsp_int', 'atest_bbrx0', ...

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Bjorn Andersson <andersson@kernel.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/pinctrl/qcom,ipq6018-pinctrl.yaml   | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,ipq6018-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,ipq6018-pinctrl.yaml
index 9c6e2cb0c6a5..0bd1aded132d 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,ipq6018-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,ipq6018-pinctrl.yaml
@@ -92,9 +92,9 @@ patternProperties:
                 qdss_ctitrig_in_b0, qdss_ctitrig_in_b1, qdss_ctitrig_out_a0,
                 qdss_ctitrig_out_a1, qdss_ctitrig_out_b0, qdss_ctitrig_out_b1,
                 qdss_traceclk_a, qdss_traceclk_b, qdss_tracectl_a, qdss_tracectl_b,
-                qdss_tracedata_a, qdss_tracedata_b, reset_n, sd_card, sd_write,
-                sec_mi2s, smb_int, ssbi_wtr0, ssbi_wtr1, uim1, uim2, uim3,
-                uim_batt, wcss_bt, wcss_fm, wcss_wlan, webcam1_rst ]
+                qdss_tracedata_a, qdss_tracedata_b, qpic_pad, reset_n, sd_card,
+                sd_write, sec_mi2s, smb_int, ssbi_wtr0, ssbi_wtr1, uim1, uim2,
+                uim3, uim_batt, wcss_bt, wcss_fm, wcss_wlan, webcam1_rst ]
 
       drive-strength:
         enum: [2, 4, 6, 8, 10, 12, 14, 16]
-- 
2.34.1

