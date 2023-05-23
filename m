Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5A1270D4B7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 09:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235487AbjEWHQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 03:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235428AbjEWHQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 03:16:17 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E300B1B0
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 00:15:58 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-30a992a9c3eso495445f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 00:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684826157; x=1687418157;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dqfFtZjpBwpHnbanMeS8saew2f7WSD17vQFnp7exxSY=;
        b=ELwx8MuM+3lQ8JRNfRhIcN5j/fhD7qpkvAgmUfa15HXJL+N3iftke1aNpTr3LOk3AF
         w6AbAG203Dlubntrv+qxc4Sw6J56ZZrHTTDqaFw7FVL4kKmvq5dUQsXiIdmLXgnC4Oma
         Hl0JZ80utXtGC+wlkrHQC8rkRSYcI3BciBQPpfLVUKBOO7ZYBNbwvfVYFC+JyJp3G+7y
         a0KTjIEAyRRLlw0Zu76PaUL4qNH/KYWPo4MuDYC+q9UqGVvMFW63/swtfuCVCcqVF21P
         gpfDrCWT0Jaxb86D1Xn5LZvmZXCuKXkJx7mvjMef0d4HOoulLNP4OofTFfcH2NFPzNXJ
         upZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684826157; x=1687418157;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dqfFtZjpBwpHnbanMeS8saew2f7WSD17vQFnp7exxSY=;
        b=eaFUnhlcZYflHexc9/nxawWIm618u+GtFtl4eSduTnTjvG0hUYBxleXKF90SO7PIKM
         ECE+5z4npY9GEMmlourYTm8ap467Wg1W1MDocm4AGcYItV4PT3l7h/AoldN6LrkYk6hh
         C4qZy1qIvuH3kqHMK1BzwNmAZaHeL5F4gdEZhnK3P2bjpu4vz4UPvf1MF8C7QunSP8fG
         x4/cAvN4ddOyqFpmmCyuen6edbtfx4vCZZfERJZHgX6ObiQ93XFX3mP28zVG76e81IN6
         B26BOkKoVaXrq2ZVRLq1Vh3Hok7V5FUA5XMxoFJBo8Cb9zVDyvL+Jh9XY5acmZ8g9RWa
         i/aw==
X-Gm-Message-State: AC+VfDzWLQG2vo5GajQUjroHqTijlHeWNRL7cfh9Wy8ZA9DPxh11KKke
        uAGze6Gsw+WAeqDgcZMdv8tZOQ==
X-Google-Smtp-Source: ACHHUZ5zuYspmr1qTK+GSeX740r9P7sdIPRlFZuzTwCaKyhcWCwH1W3y06lAgoOlsBNlb6Ot0IvRVw==
X-Received: by 2002:adf:dc8b:0:b0:303:daff:f1a3 with SMTP id r11-20020adfdc8b000000b00303dafff1a3mr10861571wrj.1.1684826157493;
        Tue, 23 May 2023 00:15:57 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id x15-20020a5d490f000000b00306299be5a2sm10096239wrq.72.2023.05.23.00.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 00:15:57 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Tue, 23 May 2023 09:15:50 +0200
Subject: [PATCH v3 6/6] qcom: pmic_glink: enable altmode for SM8450
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230503-topic-sm8450-graphics-dp-next-v3-6-6c43d293995f@linaro.org>
References: <20230503-topic-sm8450-graphics-dp-next-v3-0-6c43d293995f@linaro.org>
In-Reply-To: <20230503-topic-sm8450-graphics-dp-next-v3-0-6c43d293995f@linaro.org>
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
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkbGgm6WlljbzOT5Ebr1dohSDk9ClWJzy9HlvwA/f0
 A/9B+JWJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZGxoJgAKCRB33NvayMhJ0SPgEA
 DEDRyKtKbsbfDCe80qP4eiPCG5tzJ8+4FRj5EMisHLJdYofti/C0lzSjEjbpFMV79pMP1Mvus8pGRY
 17EvHxpYpQJtB4kwHo1pUtvKXFW87g1RRY3BYT8eXLIVe2orFLAAhBCZBqLYHqrRyj2tsEpC60ybQV
 Iw0d0nm81h+NmSRxis5hel0FdMvdF5PbA2E1ibczb7xQ71hPc3ZPHfjma2RQdgTZPGMrmlkR1vtVo+
 UzHmZaYgbkzTWYL5NOlLk//waI1zzGgay7/KMIumVFEEpYKaFpAAFkwq32AZ5n8S2mbCrdh6Mf5QG2
 nofnyrh3ckMWoVo8IE9izjAxUIhTSTkyZmOjc7Ldptg7PnunrvCQnwGrGksbysemjBuSa1nhbXEP2C
 kgaBlhUJKSCpDKfUnfSrmTp0BtZuJ+72o6QDYh9/oQpxauLTbV5O2fwyq6Hzlos8HHUmlS/KMexqi8
 WkPhF60nmo+AKAQVQhqrUlZ/pD4/S4B64yYTv2CYYgNr7HP1RD+Vx/Ri4LW+IflLuY47hu9Umdv0V3
 pGAglRRKprzWmIftNxn0MlSKQQqgqV3B5odwLdS8cBTw+bIHj0P3dSw0ozpYPuSjxU0my37eTrfw5s
 Kry1pklsjRGvXp+L9LevylGWGeKQfQygn5Qnd4YU25u6b9W6o60nwK2dVskQ==
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

