Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB2B6B5364
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 22:51:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbjCJVvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 16:51:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232327AbjCJVuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 16:50:04 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3411B153371
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 13:47:12 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id ec29so26103923edb.6
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 13:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678484766;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R8KkEKWZ0gN3SHohoHksswAukmLUtCvLSzW/QOjaikM=;
        b=qrYJxUKirtzDvIQKoRJxygRyf4FPSqFSi0XVFQVFP019hUJJhetCebgkKhN79vrs3W
         CIKol9vmqcKXFzhdYjb1UTjEWhmCgRQnV+R2cqHNKf+j8Mpyg7DhTibGCY0vHIrFfqbK
         MYdEtrAnXuCYjFCFYcqYzaJdXR+JsnR/WpDdA+37QliqOcRHKYHhRM2Opif9wIh+NaJk
         nH2yk34ZI9d3FQKuBY2OmYQHDrkb0n+JgCsnkEqH0/5fLxA61A6woskfsucn1TYakkKH
         8fTp1iBBNuDjOcbESiG4v3E2y5Icd1y9w2E4PwTRKo37+BS1ebmSpl+iTtrjxBU4Yy0v
         2w5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678484766;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R8KkEKWZ0gN3SHohoHksswAukmLUtCvLSzW/QOjaikM=;
        b=qNU87JNnlmMxF7r3vHGVTcDxGJLmGxYiN8T+5vPbELtweVTr95djPKc7KdomIS0XJY
         S1i8Pzwlg+5uGVPkdimpsFSDdL0uEy3w9/AFtE8v5NXg5/+d47ThhjWTpB6K3mL//Zd9
         HniQwpPy/YMeTRbrqEaavIYzL2d8joN79gBP2XSnZrxIxD1VtbQU24WGEQPZ1u7h1D7m
         O5bmwT578AQ78ENUb6fuotH0OO+yOzEfvDG1PjOos5CBsf21/yZ4prtLuGFL22+mFcC6
         sFsBu6f9X/h2lXHQY/789ap6o3W6lcG15jadYiN6U9oC+MrSGunlGc03MLAt/b1iWk8C
         iPpQ==
X-Gm-Message-State: AO0yUKUaBTkPoRIO29zT8dETv5CANas6KYcH7DlqgXBPRQXP1haq/lDK
        kCcdVH+J6KaguwLhP9Hn0xb+fA==
X-Google-Smtp-Source: AK7set+C1404HGuunAfB3xCjsvxwrV5s95xwTHsN/mtfZYe+CBdiAMXV1CvssAAn+RAQCfGwoNG2gg==
X-Received: by 2002:aa7:d646:0:b0:4af:601e:6039 with SMTP id v6-20020aa7d646000000b004af601e6039mr24224761edr.22.1678484766010;
        Fri, 10 Mar 2023 13:46:06 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:34:52e3:a77e:cac5])
        by smtp.gmail.com with ESMTPSA id u7-20020a50d507000000b004be11e97ca2sm471873edi.90.2023.03.10.13.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 13:46:05 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Tony Lindgren <tony@atomide.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 8/9] regulator: twl: Drop of_match_ptr for ID table
Date:   Fri, 10 Mar 2023 22:45:52 +0100
Message-Id: <20230310214553.275450-8-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230310214553.275450-1-krzysztof.kozlowski@linaro.org>
References: <20230310214553.275450-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver can match only via the DT table so the table should be always
used and the of_match_ptr does not have any sense (this also allows ACPI
matching via PRP0001, even though it is not relevant here).

  drivers/regulator/twl-regulator.c:553:34: error: ‘twl_of_match’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/regulator/twl-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/twl-regulator.c b/drivers/regulator/twl-regulator.c
index e2a20d512152..fe80a5e20bd0 100644
--- a/drivers/regulator/twl-regulator.c
+++ b/drivers/regulator/twl-regulator.c
@@ -656,7 +656,7 @@ static struct platform_driver twlreg_driver = {
 	 */
 	.driver  = {
 		.name  = "twl4030_reg",
-		.of_match_table = of_match_ptr(twl_of_match),
+		.of_match_table = twl_of_match,
 	},
 };
 
-- 
2.34.1

