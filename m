Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AAB5730520
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 18:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234865AbjFNQhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 12:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235552AbjFNQgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 12:36:50 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C005212B;
        Wed, 14 Jun 2023 09:36:45 -0700 (PDT)
Received: from [192.168.178.23] (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 6E255CFDC4;
        Wed, 14 Jun 2023 16:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1686760571; bh=ZcQi4gcQ9xL6CFZvOAjPus5Or0PLbs0aejkO5TB4+r4=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=Cl3fWUm+cOdVqgXdDsCVWYcI7VRIy1kFDqZczlOVRUvL9oMkxFJCykiJ9jlE5RtV9
         W1PKp9GOd4b8NHjvbD5jRPmbEnlM+DYYHvB/jFDS59cSjaSEKEJ+6vQNjuolm1j/58
         9ZGl4Hi4Vvy2Y47RTm7ZZRCntL0AuvYobY5EYd10=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Wed, 14 Jun 2023 18:35:51 +0200
Subject: [PATCH v3 5/6] soc: qcom: ocmem: Add support for msm8226
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230506-msm8226-ocmem-v3-5-79da95a2581f@z3ntu.xyz>
References: <20230506-msm8226-ocmem-v3-0-79da95a2581f@z3ntu.xyz>
In-Reply-To: <20230506-msm8226-ocmem-v3-0-79da95a2581f@z3ntu.xyz>
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Brian Masney <masneyb@onstation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=964; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=ZcQi4gcQ9xL6CFZvOAjPus5Or0PLbs0aejkO5TB4+r4=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBkiex4a3dI1fG3YDwRky/rM6jnxOsN0G59nQMCj
 /YNxZXC0SaJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZInseAAKCRBy2EO4nU3X
 VkqMEAChw6VBJFtVhya2Ckv5YroFpmaQnmjcnIhuSVjZ/Vp+/MptkCNRsRSS5CpP3m2ZWMutALP
 vbaadfdKLiofuvBs9jdfVIaOnbmYs/fVOLmalRBT2w1eZzQeam2hIbdgxhCws7SMxjqGcPE9Mcc
 jliWT0o2FFgQiAxGcXqVgztJZctfntAiuOtzT4uc7GutZ1UUzZevhrpnKfPfDFGXzRoxi/VQf+o
 9zpcD+NAeOkIdjTtJ/VLkSmveeKZ3Y3KLOSZ2jrND2slkpbvVs6pYlN5uADEg5wuW6TU8M5Ek8I
 kqPfqDnvANinsI0CDHaiMfGMBnbZNv0ZTX/0RQV3ibZxPPymFw/EAHpgrHG2OTZeMNUnyukwAcZ
 r/5DfoQoYYc8jgTSHmqDFp23oSGcIsz9I2fj19P7sIGpdGo3w+CG8TTdAYNqPTdxNpuzSLSBHgk
 hRtE5Uh3J0F990srqzMJU0JuEfAzXgZzgWlahc4CDNRK9YpA0QfMfqNT6H78SynjmWT395QK7IB
 X+dV/bceHanOMfVaceokwjq3vv6GSgg7IB9AFQdzo6cntaS0LZlh+SYTIxaSEWI3yglSAn6Deex
 9gA1RaoK8M+tugkF2I360Yb9LU40tZwppu5GcLhuGY9FzQ+xnOVWVTKqHNVx4cPwTnQySKcNmcL
 Zk0bqSB8DGEQD1g==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The msm8226 SoC also contains OCMEM but with one region only.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 drivers/soc/qcom/ocmem.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/soc/qcom/ocmem.c b/drivers/soc/qcom/ocmem.c
index ff8d01b0ac68..2064e9512301 100644
--- a/drivers/soc/qcom/ocmem.c
+++ b/drivers/soc/qcom/ocmem.c
@@ -423,12 +423,18 @@ static int ocmem_dev_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct ocmem_config ocmem_8226_config = {
+	.num_regions = 1,
+	.macro_size = SZ_128K,
+};
+
 static const struct ocmem_config ocmem_8974_config = {
 	.num_regions = 3,
 	.macro_size = SZ_128K,
 };
 
 static const struct of_device_id ocmem_of_match[] = {
+	{ .compatible = "qcom,msm8226-ocmem", .data = &ocmem_8226_config },
 	{ .compatible = "qcom,msm8974-ocmem", .data = &ocmem_8974_config },
 	{ }
 };

-- 
2.41.0

