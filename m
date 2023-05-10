Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83BA76FD97C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 10:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236709AbjEJIcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 04:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236565AbjEJIcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 04:32:06 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30FBB137
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 01:31:53 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f41d087b3bso43112945e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 01:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683707511; x=1686299511;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dqfFtZjpBwpHnbanMeS8saew2f7WSD17vQFnp7exxSY=;
        b=YiBP3qY+Vw3bmkuu6sb7B2r/0LijokTWIbijSkaRl5FK6d/QQ3LguwG1r57to+SC85
         S6FfW+f1/haW/B3UxXSg05pN3YIwquleGEKbxzNp3wWb7eNIoD/kUN7UFenwh2AWIVx7
         /bCwHAuGf9Tdp5oR5Wnp7EAC/lwm8eiaNttE9WXyUXwYG71sQfioqjrQ1JZiEEX5yVJq
         9Jftj68sDq3Nl6r1G0+30MFCVOIcHRSvwshwOqsKoAoQFB3AURI2ssv0b9CWxDHLCPZT
         dSIXXBL1DfKyFP8sodtoq4Yz2IfN0V1KllCNk3e6CGTcgtGv1wFvFDmMcomzKMGpxac/
         xH9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683707511; x=1686299511;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dqfFtZjpBwpHnbanMeS8saew2f7WSD17vQFnp7exxSY=;
        b=YceBjNPHVDqp7oigiTjZ5hmhAWf7Qsg2ogW+H+f6TmsanXdXiFuZYDo7qKZqFpEGA/
         hv881GF/yVTGVtV9Hnbyq7ZzcZAE3T9P37RCcbd6ySV1LRxJYumH9LYe417KASgkaDqs
         uav2GWm7pI6ldNgtIvELK+/hsI+y8eX1SnV0eKorme+cg1G6cHJz692riUszeFNaPAZG
         HE7glZq81Z93M0Wbijci4R4H6rb7ILrHzZyY+Vg6Jl/aj8IYM+b6oFCYkyor+YOE10bo
         pzdiZfFolFBOwdLrJ0ZYqwPyoVONnJRZUetc9E0LlpI8aaQZcBWhAdMtNK5lSHseMEfK
         lurA==
X-Gm-Message-State: AC+VfDw7P+Zd8EYYZJrz4OCv0pgs4yXQjribTN+XXu+Qc5g0A6OWITUq
        erfw5MI72GCbjAIn1IwFXXPcyg==
X-Google-Smtp-Source: ACHHUZ5X9XB668QK1S3+sIrDwTXV4f/Xoz/Qrn2rPBgxBarvYCkdjz/+bdwZh1FU7yQlpbeZHYRhaA==
X-Received: by 2002:a1c:750a:0:b0:3f4:2bce:eef8 with SMTP id o10-20020a1c750a000000b003f42bceeef8mr3325916wmc.16.1683707511610;
        Wed, 10 May 2023 01:31:51 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id n23-20020a7bc5d7000000b003ee74c25f12sm22108737wmk.35.2023.05.10.01.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 01:31:51 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 10 May 2023 10:31:44 +0200
Subject: [PATCH v2 6/6] qcom: pmic_glink: enable altmode for SM8450
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230503-topic-sm8450-graphics-dp-next-v2-6-8acbbe1e9d14@linaro.org>
References: <20230503-topic-sm8450-graphics-dp-next-v2-0-8acbbe1e9d14@linaro.org>
In-Reply-To: <20230503-topic-sm8450-graphics-dp-next-v2-0-8acbbe1e9d14@linaro.org>
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
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkW1ZwMYPN4N3wWUyC6O4/4CDJRUNuji9/6zTMMbzP
 7PIzOtCJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZFtWcAAKCRB33NvayMhJ0VUoD/
 9gn8fsP4D26Co1nmxz3i6jcdyyns/BSsqXkLsWEEoWCZVVy9XE/ygXwVJw1W+zj94nMEibejqbj2ZY
 1xALIex3FmlHFhn9bDVziwt2Wfbh2ZPQBGkWEFWBzYoGzlYj0PHaQIIu9IX0ksRRsNrVVrq1LpYWIo
 kyHfw2FGkh1YhVCTbKpaaRAwcI389Coj2pCRqynkEl6hazwLCd6cSVYxryhrWqfQBdmWDMmBXWuFvO
 GU8j0mIfjiqgntiHDggCmMTdXfyJQs22WqU+bE0z4LWk2j5e8QByNM/wZTiIQW49SHDBfUUVAU+H+Z
 QvYrCgvn0b9WaDQO+2I5jXJKQ2g8qQzqjgeDZzO2T+W60WeT2SHlp4H2TeFE5GNZYn2Pd2BrmWlxQB
 55GkMnnHPfWJMJfxfidq8P5hAkSm3CBp0Nd9XiYxmsnCLqVxgU67JYFyOfR/q28bOhKoynA4TlzSGa
 UXKbROxp7x7YuYPCEmR1gr2NGgxXgyA+1vY9p4j3kydSa92b204OBGhK33jXOd7bvNg7UDrPADzli7
 kdJCpoNvH5+KR4UGn7K1cRsnNSDnXavuPezW3n+l7MwP5rs0ZTQER6R+a9FAN5io1LIv3MymJLYYsg
 Zcg2CkRR6/Bip7erXRzdOdZyrEsfbaIqNrQoq7C/2F55RflL4aaBInNKQJQA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
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

