Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6940B6B5445
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 23:29:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231771AbjCJW3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 17:29:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbjCJW3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 17:29:03 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29356120491
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 14:29:02 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id i34so26419614eda.7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 14:29:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678487340;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=60PuEIm35j5/lTNeJPhlkXRZcGNjzFmtFVCVem+hEDw=;
        b=LEfc0zEi+LQ5St5qp/OpSxRZTLSGwJrZ1Hg1Bjj2BqrW0jf1MDtYIRP0HBSYpqADEj
         WF3P0M3JfPUzD+0gnosaMbTzjvm7A21OxNXWw1cCY3V/EijHD8A57mAb+tmulhwrtNmZ
         /ey6MnBObA52rMXrEjca40rbROCtoOkxo00ygLa6tTa4IPsuDoy8BCLW4mXNNsI/mb3R
         JtMWGx0rRuUOJTylIlHrwVyQ7uG44r5J62FtVEjBEXguCGv+0Um5Q7oEhqDemugm9lCP
         n2LNdiqGW9semV4b/A988X57tQIYizAda0dcfvCxdBt2WybsTGqY6mRciCT0f6OPhsrB
         qMNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678487340;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=60PuEIm35j5/lTNeJPhlkXRZcGNjzFmtFVCVem+hEDw=;
        b=0qw/Cz4RSNII0l+n/W0mA3v9e5CG4jsBCHxPoaowpLOCVhidKUzqxojY59XLridMy2
         PC+wwGqiIWgvZzkL02u3NsCUusfUryqauCCp6fzR5SimXIWZlq6a3MBcuxK/UO4qN2bm
         Q43UokPqplWhiColJOpcEOdzqDYleRVLREhIr9qp1Rvn2+pM/CpxPAAx7ww9DPhdVppo
         6Yuuzz4vEo8CwR/AiyYkWRB4XVDaHbp0EDeBVQgmyuR1c0n6Xts2uVEZOSCMiuB5P+ak
         fSVbozSCRdvtRLShSQUcY7TCy9Wo/+EtJPrH/Stsevpf1xUS6xaLy6yd5c8mtNHb/lm3
         dBwg==
X-Gm-Message-State: AO0yUKUW1XuNtG2qdmSLXpSb96LWZh4oko3+8Jjs0T9tCQlroXW3wQyU
        mFeeR4LTdmww5MEqcQHQ4pwsUQ==
X-Google-Smtp-Source: AK7set/w56mrFx7St5tpjzC1nqrpGgftY5conmyuZ6lJBZWH6ul1PMXKHMQPItpT75fNAsz/ObHAxg==
X-Received: by 2002:a05:6402:1506:b0:4ac:c7b3:8c27 with SMTP id f6-20020a056402150600b004acc7b38c27mr25909175edw.28.1678487340674;
        Fri, 10 Mar 2023 14:29:00 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:34:52e3:a77e:cac5])
        by smtp.gmail.com with ESMTPSA id x101-20020a50baee000000b004aeeb476c5bsm525467ede.24.2023.03.10.14.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 14:29:00 -0800 (PST)
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
Subject: [PATCH 01/16] spi: armada-3700: Drop of_match_ptr for ID table
Date:   Fri, 10 Mar 2023 23:28:42 +0100
Message-Id: <20230310222857.315629-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

  drivers/spi/spi-armada-3700.c:807:34: error: ‘a3700_spi_dt_ids’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/spi/spi-armada-3700.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-armada-3700.c b/drivers/spi/spi-armada-3700.c
index 6a7e605f73bf..feb7371940bc 100644
--- a/drivers/spi/spi-armada-3700.c
+++ b/drivers/spi/spi-armada-3700.c
@@ -919,7 +919,7 @@ static void a3700_spi_remove(struct platform_device *pdev)
 static struct platform_driver a3700_spi_driver = {
 	.driver = {
 		.name	= DRIVER_NAME,
-		.of_match_table = of_match_ptr(a3700_spi_dt_ids),
+		.of_match_table = a3700_spi_dt_ids,
 	},
 	.probe		= a3700_spi_probe,
 	.remove_new	= a3700_spi_remove,
-- 
2.34.1

