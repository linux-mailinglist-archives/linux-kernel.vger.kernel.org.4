Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D42B46B5B03
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 12:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbjCKLSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 06:18:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbjCKLQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 06:16:51 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 064F6139D24
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 03:15:49 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id y4so1277222edo.2
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 03:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678533338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uznhd3PaZMFBLcetE5uxOnwFeJd1Kvz0kbb3FEDLHu4=;
        b=ECTsPmKyLrp9lBDJPgIVuF22lAIFATWjk2IraqByzFRhCziUnH1U7SReDEcfXx0tnw
         Yax/l/LZHhK1Xgj4fC5Fn5LIlpwcbY8/7inPctx+mtLHyZOKMYYu6ZKLwFY/LobucJ7U
         lCOGJSKl26WaoOPHR3NdKLuKZA0aJoEwriyDpj2UKb/6pWDyZ59nHP0bgjU/vq0Gy3pJ
         7ZM1Me0hCd3asABEY3YOptuWjZAax9ixVwl/fyewWJlimRroaeW8OpQqp/ahXj8OJwCl
         j4oZvqzw5lW6SJ5Kc0FSi0WIPoWVBZZhePh5TfJgGultdU7HLFBJvy47YsKrgrkxwNT3
         xUcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678533338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uznhd3PaZMFBLcetE5uxOnwFeJd1Kvz0kbb3FEDLHu4=;
        b=IE8prj4lodz5HZHagfQbRn0y1qH0Fgl1ovWZSfc5B7902xP+GdjyDJtE6jgk0kgl+Y
         evJm3eXYIt+mbooDHbn2cM42LBmMHN4uQz9A7mJ76XKRRFSpp3u+Ux+Dv2WAYHntRI+3
         3uEkVJ1scUJKrq7+7mhs/Ji5kURvw8PdWWej9Wtc7n3PpZVcyDQ2Kaq/TmrTE6FUyfts
         x5EUZTm2wW5SRWvn2/c998tAPzXCW99hzhk/aQLdpm3PLZ838o+a0VCstEhw+2tdjko+
         qAPG315pJJalc5Byo/Cy62SBZuets44ilTiobkrFADwKLPFW+Zmv8Ck+VIkA3tNAjmTY
         3B2w==
X-Gm-Message-State: AO0yUKUhveVk3rwBFvZPnQu3T+bm1Xkkj2Zkt4BbDJ57QhgtsZpsSV9i
        RabUTzaIbWoInrnT2N7Me8DrUg==
X-Google-Smtp-Source: AK7set9IyxLBcFMyhRiPSnl96+6aM5tzfrsjVKILFy3hmVR0DK5phIUs5wKfYhSJQja4y6L2yglStA==
X-Received: by 2002:a05:6402:7ce:b0:4c0:57b:47a9 with SMTP id u14-20020a05640207ce00b004c0057b47a9mr25746879edy.35.1678533337882;
        Sat, 11 Mar 2023 03:15:37 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:fa97:2d7c:bdd7:e1b])
        by smtp.gmail.com with ESMTPSA id w15-20020a50c44f000000b004bf28bfc9absm1064150edf.11.2023.03.11.03.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 03:15:37 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 4/6] power: supply: ltc4162-l-charger: mark OF related data as maybe unused
Date:   Sat, 11 Mar 2023 12:15:30 +0100
Message-Id: <20230311111532.251604-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230311111532.251604-1-krzysztof.kozlowski@linaro.org>
References: <20230311111532.251604-1-krzysztof.kozlowski@linaro.org>
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

The driver can be compile tested with !CONFIG_OF making certain data
unused:

  drivers/power/supply/ltc4162-l-charger.c:911:34: error: ‘ltc4162l_of_match’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/power/supply/ltc4162-l-charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/ltc4162-l-charger.c b/drivers/power/supply/ltc4162-l-charger.c
index 0e95c65369b8..285580845e2f 100644
--- a/drivers/power/supply/ltc4162-l-charger.c
+++ b/drivers/power/supply/ltc4162-l-charger.c
@@ -908,7 +908,7 @@ static const struct i2c_device_id ltc4162l_i2c_id_table[] = {
 };
 MODULE_DEVICE_TABLE(i2c, ltc4162l_i2c_id_table);
 
-static const struct of_device_id ltc4162l_of_match[] = {
+static const struct of_device_id ltc4162l_of_match[] __maybe_unused = {
 	{ .compatible = "lltc,ltc4162-l", },
 	{ },
 };
-- 
2.34.1

