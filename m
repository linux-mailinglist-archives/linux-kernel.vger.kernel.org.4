Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8714870E6EB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 22:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238255AbjEWUzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 16:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237846AbjEWUzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 16:55:25 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EEEE192;
        Tue, 23 May 2023 13:55:23 -0700 (PDT)
Received: from [192.168.122.1] (84-115-214-73.cable.dynamic.surfer.at [84.115.214.73])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 71CDCCFBBF;
        Tue, 23 May 2023 20:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1684875322; bh=aDpqE5sNhXGbjAX9JLCTPksROWy3/PvZ9EHy0OnWauA=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=dBJGw0gNdyu9hLScQKC0ssdduM3zm+nPw8O/5x8SHaR0J4p/RSXDNa54ThzTXDlVd
         SJfCws/2257g+JAwUKr1OoejAwceNSg5HasXrO2Gf6X/SeCytSsv6nJ8hrkLjvSVH8
         XcfAUXIGK3euMBI6qjMst5LA5pDlt2xqVmB2dA/0=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Tue, 23 May 2023 22:55:12 +0200
Subject: [PATCH v2 5/6] soc: qcom: ocmem: Add support for msm8226
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230506-msm8226-ocmem-v2-5-177d697e43a9@z3ntu.xyz>
References: <20230506-msm8226-ocmem-v2-0-177d697e43a9@z3ntu.xyz>
In-Reply-To: <20230506-msm8226-ocmem-v2-0-177d697e43a9@z3ntu.xyz>
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
 h=from:subject:message-id; bh=aDpqE5sNhXGbjAX9JLCTPksROWy3/PvZ9EHy0OnWauA=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBkbSgzjZe8geHMxNlgyKmC13XCKhTjhGg2GPOE9
 ld3edkHq/6JAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZG0oMwAKCRBy2EO4nU3X
 Vso5D/9pWg+T3ytFhvltXhLKg4OxDz/EMvbbSNNzrZB4bVUbuKY/6k8cWdhDEQhQ15Wv36ZJd65
 d2ZeKmYS8S41v+62hXe9B1kuNCaQ9GMnoH2Allq27TwqQAyTKjUvTtMgqSW04fN+Yc8jsgNXKGh
 B4j6JrOuDasfFZUxjBNVLS/Gh68NW/XCPAUKio9Aj24Oeo/ectjxzAtPRJHntTTX3+wSBfmvGyK
 cv6wipk5jF3prvqN6dqRRFqyj1W5+JnVqUAwjUYnqVGJ6j8TAd6SPozkWm+SGB9NaB75lj+gjaC
 CAOl0Jak8EXDLHHgtoBEKmKyyaWQJPuz0mYTZGNizSxOWQfnPETRz43FbwVGJynlu6HjdYrZ3/n
 V8dbVUk12muHSi0AfYtGJmMobHEw85a49S+kEi6lnH9KS/YwQBavPzhYH74eOotA09gz2YWnptQ
 eHX45WDg2UmN+nvaZb1escdrt5Qr7c8cB8lOBLIFl1Zojn1iqg4ud2TgKWPPRub4Q8II+4kB2Bm
 q8qekReGj8Fi4pWagrCpTdb1o6PuJx/uMloFFTX5shWJIH07aWfP/MximXWMM7wa7bmWCfws1WI
 2Y22wW8P0+GVKnZfPk8WOmjs5z/Rx3JjT52jf3KajmLIon7Nvaq/x0ztdcvrccqA9UKhZt1Ohm/
 kumzeN7IPlmiHpA==
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
index 6235065d3bc9..d5892ce999c9 100644
--- a/drivers/soc/qcom/ocmem.c
+++ b/drivers/soc/qcom/ocmem.c
@@ -413,12 +413,18 @@ static int ocmem_dev_remove(struct platform_device *pdev)
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
2.40.1

