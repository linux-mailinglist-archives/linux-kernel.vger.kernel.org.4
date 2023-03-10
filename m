Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A47F16B544C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 23:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231845AbjCJW3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 17:29:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbjCJW3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 17:29:05 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C935121401
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 14:29:03 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id cw28so26492147edb.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 14:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678487342;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1fq28ODdLGdVrfwBbBqpAueEDlCBrl+e8GLAYfu+UZE=;
        b=YErFPXDcruuSCyquGlOEihSnf5WEX5TfRFUNUpk794YqO+3d2tGrz+SAukBB6cHeeY
         6f+NU1SAcvVQh206gJNQOLThJ1SeBSThVgv4zR1bXtJdov0FTIYm4pigzFzvKgXKFaCM
         O7ycG+h5VlOwwhKy3GFtQqV/qtNb0b1AcXMZV0wUHhPD7Basl1eKhl+JCDJqKZPWCnPT
         eiAullbhW79U2YRzArw66eDxZ8lqWSfLdRvprB+5f0RyrMcAqDsKHRdrQj5P5AgRZ/Kl
         lwTOuZL3qbuXuP2Vo/rSeZNkzRlTRJvk32snxMw8+KJAOonVRC+QO+iD6crmCf0gb4de
         Lk7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678487342;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1fq28ODdLGdVrfwBbBqpAueEDlCBrl+e8GLAYfu+UZE=;
        b=qQXxL7aIj1ciKS7/7jzdRMJm7AXxI1swcgyEAb6wwTkWqHMnRWUc6n71VwDz7vkayu
         bIK0pUQEtOD9ucgGwGGgG5j7YE/2+OqoflBsm8s02eU9B9sdo+Svme9pyf1iipeDY5ZI
         v+k7Yw2TvIWFyDmtqraqPbxtVgSMhpRx0n7IQT7aRUF1iRqxGw/fOlRpHrJ5SipbaMhi
         Wmk4QOxtoSCGvjmVd7wWUxHwIfRnoLeGiSrhOwB/a+6NDZcG3kRscDB2cuAD9c5OWyGV
         hwhc1CfKIGLGeirjhdx8wg5b1eSnBUehUMH4ARqYqWpn+gnFE068Z7/bITm9blLhJ36k
         zGnw==
X-Gm-Message-State: AO0yUKU6DtOY/CiTKxtENkUf+fu/q0VQ3OqzFzz2VCuSUrxiFXTQ+6q+
        987Xjj0KTDfcoOFQJWD2qVGciA==
X-Google-Smtp-Source: AK7set/MN1PmYbla+81mnyLbnX24dl5dsGO4HTEAGHBQdx8CwTY3seLWUkHX5GZDY+FpxIzcnKNvFg==
X-Received: by 2002:a05:6402:1804:b0:4fa:315a:cb55 with SMTP id g4-20020a056402180400b004fa315acb55mr597332edy.21.1678487341960;
        Fri, 10 Mar 2023 14:29:01 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:34:52e3:a77e:cac5])
        by smtp.gmail.com with ESMTPSA id x101-20020a50baee000000b004aeeb476c5bsm525467ede.24.2023.03.10.14.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 14:29:01 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Mark Brown <broonie@kernel.org>, Kamal Dasu <kdasu.kdev@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Heiko Stuebner <heiko@sntech.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andi Shyti <andi@etezian.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 02/16] spi: mtk-pmif: Drop of_match_ptr for ID table
Date:   Fri, 10 Mar 2023 23:28:43 +0100
Message-Id: <20230310222857.315629-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230310222857.315629-1-krzysztof.kozlowski@linaro.org>
References: <20230310222857.315629-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver can match only via the DT table so the table should be always
used and the of_match_ptr does not have any sense (this also allows ACPI
matching via PRP0001, even though it is not relevant here).

  drivers/spmi/spmi-mtk-pmif.c:517:34: error: ‘mtk_spmi_match_table’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/spmi/spmi-mtk-pmif.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spmi/spmi-mtk-pmif.c b/drivers/spmi/spmi-mtk-pmif.c
index ad511f2c3324..b8583917fa11 100644
--- a/drivers/spmi/spmi-mtk-pmif.c
+++ b/drivers/spmi/spmi-mtk-pmif.c
@@ -530,7 +530,7 @@ MODULE_DEVICE_TABLE(of, mtk_spmi_match_table);
 static struct platform_driver mtk_spmi_driver = {
 	.driver		= {
 		.name	= "spmi-mtk",
-		.of_match_table = of_match_ptr(mtk_spmi_match_table),
+		.of_match_table = mtk_spmi_match_table,
 	},
 	.probe		= mtk_spmi_probe,
 	.remove		= mtk_spmi_remove,
-- 
2.34.1

