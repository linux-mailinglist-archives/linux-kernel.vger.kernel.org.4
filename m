Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAA726F58B8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 15:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbjECNLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 09:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbjECNKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 09:10:50 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E205FCF
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 06:10:45 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f1cfed93e2so51530885e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 06:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683119444; x=1685711444;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dqfFtZjpBwpHnbanMeS8saew2f7WSD17vQFnp7exxSY=;
        b=X5e6nqdeOr1LhOT2w/el4JzYGIvop1TUIUA4iuy12YgJensJNeBpHZUaRoKhT6XH8a
         u3bnyRS1QOhwA4nS0cG/hdhqxUuMTEpSO/BqO2iTGX5bx0ZQWhAho2CVy2vEBmOl5fXG
         lAffKN3jTYXLMBX1ln7NJi/54k2kdpgCTG5wH2ODSON0X+zAZa0gzWrR5MywWELPA+aB
         CWkunyqovCogsBaWQTkFN4opqP3s8GZ0FTVghh45le+FlSOSl3jTTiUOO5yNoUrzc9Wx
         fWt1dJFqXC6JaQ8Kw/+bgQfzzfI+MZh0dk1/t04bbutsAe666GuocpNGEjhzkyJW/Ufb
         vmWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683119444; x=1685711444;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dqfFtZjpBwpHnbanMeS8saew2f7WSD17vQFnp7exxSY=;
        b=SMYr7r1t1ZBq5+dDuR5YkAkJYzSkiAqJAY9AHRzGfBiS5T3xXY69y5PdYpI7czF9I9
         ZhqOwauQRv7btuQdz99mWbT/63o4H07GFgQ4E9dmOkeXDnGzQBTBkSCox37bo29D9aMd
         0zti1iW4YGmiASse2CduSGE+beAC9NojFnnZU5RuJtxAfqHtQFGOZWo7vdyq9yN0iXJy
         FbG8uYqyBpYVtbyK58mqjiEgUZzkeyDHEtGvnXJiui+ZX9zELDTF0JQzfSuSuF7P1ZgP
         LiUQGd7CdOcm2r45UluCFYt4TcEBM69lyLf+/H2kM8z6S04sB2gyio+czWGCkxi/8jgz
         lk7A==
X-Gm-Message-State: AC+VfDwRgYU3ZKvbx1iNjL5/bn5xO6TKfnXOv843yVwmqYkXFmF6xA+3
        vAPVU3AaCwBOsUmR7bwTPoGddQ==
X-Google-Smtp-Source: ACHHUZ7MqVtgOQb7P5ctA+ifWc9qBzWFe18a8FP1dLDAbK8Jws0XBRT1oGq5jHOfhrx+tCkcCQQSEQ==
X-Received: by 2002:a7b:cb85:0:b0:3f1:7136:dd45 with SMTP id m5-20020a7bcb85000000b003f17136dd45mr14793376wmi.30.1683119444023;
        Wed, 03 May 2023 06:10:44 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id c10-20020adffb0a000000b00306344eaebfsm5413479wrr.28.2023.05.03.06.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 06:10:43 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 03 May 2023 15:10:38 +0200
Subject: [PATCH 6/6] qcom: pmic_glink: enable altmode for SM8450
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230503-topic-sm8450-graphics-dp-next-v1-6-d1ee9397f2a6@linaro.org>
References: <20230503-topic-sm8450-graphics-dp-next-v1-0-d1ee9397f2a6@linaro.org>
In-Reply-To: <20230503-topic-sm8450-graphics-dp-next-v1-0-d1ee9397f2a6@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1399;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=qkASJFOC8Sum3nf8ciK4XNKG+cxf4hgwBJ+cUAn3rO4=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkUl1NKRunTI8gTuu1bmZf0rFwrWODpoC9Ruv+xEWx
 dqZglNOJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZFJdTQAKCRB33NvayMhJ0f1yEA
 DAHeZRXxPUb4hZtFMNqS8d/kOp/k4sNXsY/IAWHPTsRBj14r04Gq7SWME1lm2Q82PRKdnyGOZSHkYw
 CPhKE82yL7J6D5xPEy1mxlFFMCd8e2J2XOBXIYO7hl7IXx3qLlkQSLaDfY1YlYSUoVFzVSWX8PY1O4
 hLu7+a4PkFE/b6jGzu5RMuze6qGz5RguPb1XCQvb3Q8MiixJeAy+Es5vp7+RFsIbVj1ukmjx7BszKr
 mlsC6LKI5+Uz0KXr2QLmdp78YyJF6UsXqSVbIz6w4mqRNaEsokKPtufIx2zcvl6JBd/xZLQvnIT4fk
 G7dTJ7OyBQ/80sABtv3HxWjzxFFidNwBbbPPSUoydVNOSlAR+1fygt0HVSOIgqAdWlQbWPhuY5u1NU
 Fs7cbB1vlhrFg5uRckf8PsN0qZWnSnvW+UKfQtGpY0R6H+dOXbfAGkDKWvdt1A12+Tti2v/vQyZM7h
 lGc0TYKlVgHoYj2cq3n2Ya+8n12OINqsdAN5/kmtUTcGDSGUawiOkY8EwZn6Sl+nu7Wn3r7zeyoob9
 aUy7jcI/oqRzJTcvmvD0d7t969uAf800JjPx79ZHbQ0POfZYUlftJ4c8fH+YyOtFQ3t4dUlKk3FsiR
 SRTWTpmFONG0+TEaC+nJm1QNvBdXhHLV0O2f8/DgVJKfoJivz7hoDRwN/gAQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create a separate bitmask for sm8550 and enable altmode aux driver
for sm8450 platform to enable pmic-glink altmode events.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/soc/qcom/pmic_glink.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/qcom/pmic_glink.c b/drivers/soc/qcom/pmic_glink.c
index 8bf95df0a56a..c87056769ebd 100644
--- a/drivers/soc/qcom/pmic_glink.c
+++ b/drivers/soc/qcom/pmic_glink.c
@@ -338,13 +338,17 @@ static int pmic_glink_remove(struct platform_device *pdev)
 	return 0;
 }
 
-/* Do not handle altmode for now on those platforms */
 static const unsigned long pmic_glink_sm8450_client_mask = BIT(PMIC_GLINK_CLIENT_BATT) |
+							   BIT(PMIC_GLINK_CLIENT_ALTMODE) |
+							   BIT(PMIC_GLINK_CLIENT_UCSI);
+
+/* Do not handle altmode for now on those platforms */
+static const unsigned long pmic_glink_sm8550_client_mask = BIT(PMIC_GLINK_CLIENT_BATT) |
 							   BIT(PMIC_GLINK_CLIENT_UCSI);
 
 static const struct of_device_id pmic_glink_of_match[] = {
 	{ .compatible = "qcom,sm8450-pmic-glink", .data = &pmic_glink_sm8450_client_mask },
-	{ .compatible = "qcom,sm8550-pmic-glink", .data = &pmic_glink_sm8450_client_mask },
+	{ .compatible = "qcom,sm8550-pmic-glink", .data = &pmic_glink_sm8550_client_mask },
 	{ .compatible = "qcom,pmic-glink" },
 	{}
 };

-- 
2.34.1

