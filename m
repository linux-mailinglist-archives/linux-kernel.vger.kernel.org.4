Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB6396B5B0A
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 12:20:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbjCKLTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 06:19:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbjCKLSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 06:18:22 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E2713E0A5
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 03:16:45 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id i34so30697508eda.7
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 03:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678533391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yrtfT+WjCcROcE+QdTDFyU4bOmVc6o+iYd5ZYM2WuGk=;
        b=NLJi/Jgb9MFehBfDaAsneEMvdcUVxckPWM1snXxurLCf4wEjxSKggJIkf0Zg3SBwxQ
         nj2BdrsaWs0mC5Swf+eM6U18dH6dzJBAUFQ+o6LC6LyQ1y216wc2CcHxQh5/BnLI4i5a
         lg1mzkJPDqOCrgakBFU0jVrIcH/YFp5jQw3PjhAk7qx01uGCJD57dkcua+TkhHLbFkRa
         EGNlEFpHBhn6lc+Q0U6NMJWAPWH5Hpa/sZ1yMWavZvj8HTOL/bkXnu64rLjSr1QPKqzP
         eR6+W0k10kTvj7VUS2g0fdO99V4firP1kIKAeIdQrCUsSYvPUH2DwPUnFw/ZT7CtR9p1
         MI9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678533391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yrtfT+WjCcROcE+QdTDFyU4bOmVc6o+iYd5ZYM2WuGk=;
        b=5BP1Asfjpiuj5Fk+xjYHcT04gEJO54Aav8wWvplPoX52VeHn0N5xVMcXREgELTHBcg
         5lqOQHDXjWsJxjREmaorHA3ql3exuicx/CXz0CFISqIGCSnstNICdToqN2rqYVT7SV68
         CF+6S5MXfO0PzHmk8rq3MYpAcXf7Kem/QNEkTLu3KqBsZ1v7orNpLB/1yIR7OkbYuh0e
         5zsWsjSdMyCZ8+9l12WDd13fklx/zTgJz/XaOs8HB85COFsHxdixi3zuK/+XXTQ1dpR7
         8yAVhzKVnWNiil3qmMgZgJ53P2vxuwR4V3cORKXOzyrNvuZVKJ5Uy10DBbGHRW/N09+t
         OtMg==
X-Gm-Message-State: AO0yUKXzf3injOdYOky7YXuaSQATjXwuACwDKB6X/5c/InKp+HVlPscZ
        8ibj/eoOpmtdlHVZfumEylDfcg==
X-Google-Smtp-Source: AK7set8Cy1NcwrHEtKyR0WQgTzlPPTsyPfY7ldl5p5xan1I+NL+GOcUks8a74cR3a1Y0HX0TQYHCrA==
X-Received: by 2002:a17:907:7f13:b0:884:3174:119d with SMTP id qf19-20020a1709077f1300b008843174119dmr38719772ejc.14.1678533391611;
        Sat, 11 Mar 2023 03:16:31 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:fa97:2d7c:bdd7:e1b])
        by smtp.gmail.com with ESMTPSA id l23-20020a170906939700b008c5075f5331sm981016ejx.165.2023.03.11.03.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 03:16:31 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Manivannan Sadhasivam <mani@kernel.org>,
        Cristian Ciocaltea <cristian.ciocaltea@gmail.com>,
        Lee Jones <lee@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] mfd: atc260x-i2c: drop of_match_ptr for ID table
Date:   Sat, 11 Mar 2023 12:16:29 +0100
Message-Id: <20230311111629.251830-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230311111629.251830-1-krzysztof.kozlowski@linaro.org>
References: <20230311111629.251830-1-krzysztof.kozlowski@linaro.org>
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
matching via PRP0001, even though it might not be relevant here).

  drivers/mfd/atc260x-i2c.c:44:34: error: ‘atc260x_i2c_of_match’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/mfd/atc260x-i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/atc260x-i2c.c b/drivers/mfd/atc260x-i2c.c
index 19e248ed7966..8e1491167160 100644
--- a/drivers/mfd/atc260x-i2c.c
+++ b/drivers/mfd/atc260x-i2c.c
@@ -51,7 +51,7 @@ MODULE_DEVICE_TABLE(of, atc260x_i2c_of_match);
 static struct i2c_driver atc260x_i2c_driver = {
 	.driver = {
 		.name = "atc260x",
-		.of_match_table	= of_match_ptr(atc260x_i2c_of_match),
+		.of_match_table	= atc260x_i2c_of_match,
 	},
 	.probe_new = atc260x_i2c_probe,
 };
-- 
2.34.1

