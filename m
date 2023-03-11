Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD7DA6B5AFE
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 12:17:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbjCKLRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 06:17:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbjCKLQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 06:16:48 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74794EE746
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 03:15:43 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id i34so30692320eda.7
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 03:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678533335;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fYWLbP0o0BPJT+QU5FDRXNhad6YmNgjikMTXUdy900I=;
        b=umU7Tob1FhElfnpqwWwGmQVTbz0SgF9aOg2cryOiQicWIhIEo3pTUVEkuXt8w8wpF3
         f15QBlApflUDCcUzCCgemNWYMGXeTxy8vmiZx+MqqYOMlrUS/ogvUpn2jU7IOLzPXQTk
         0TW8BfIltJX39vdMBDEzPu/ED2/AljBYizMfnDZHs+swZHEwsM3cWNhCmIcLXObPn+50
         dWCctN3KNauTTt+U3Q1cgqUjpsRIIBucCJ0Mnf2WFmcu1Ml7FjcDTIfuKitxfCZea9zB
         tY05gcUoOMnjQNGriMq7Vua2UG+a5sVVQmGEizWP3YnlQNaKJd4rZnceQK5l9h8cfTzX
         lyJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678533335;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fYWLbP0o0BPJT+QU5FDRXNhad6YmNgjikMTXUdy900I=;
        b=HiTVkegVzbYme/FsD3h6I4kOdfovhalD1UPfNDnsw/sEISu4QTSCyOAFWv5i02TcDG
         sT/zHmS0za0hMpz/SFHCHoRjLOL4oQwCMkD5hmkuSLBgx/4+KLLypDivXFIFt4lthy57
         8wxpymGRLsUs/rv6TV76ma8nc4mFg8l8SxYFiJUvv97BSJyK4SHKp5C06+lhEidmIrf2
         SGe1idssa/uzYNrJpvB4Qcu+M3kSQ309y44U+9C5t7SwmRF9Ih0wpU8CfWIkdt+FW7oe
         0cyw3RqUUQAjlPOhCizzBRLywcdTAAi4w9gOxIcSWKv04uYkCrx8dSF3COm4Ai+ZB2cg
         7Ulw==
X-Gm-Message-State: AO0yUKV2VYjHib6nuUiTuGiCvOiNRYn5LG78TZTTYBhMfoNiNhUP9XiJ
        z/7jw6p8TttfXA6M3Sok6O3vDA==
X-Google-Smtp-Source: AK7set+7IpTQBuX+JwRr9nLlvyTwq8XQh4sf9RuB2igROCvVvLI2t3hBZa0WiFhb420amkKSdNC2tQ==
X-Received: by 2002:a17:907:6d1e:b0:878:7c18:8fd9 with SMTP id sa30-20020a1709076d1e00b008787c188fd9mr34833150ejc.44.1678533334894;
        Sat, 11 Mar 2023 03:15:34 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:fa97:2d7c:bdd7:e1b])
        by smtp.gmail.com with ESMTPSA id w15-20020a50c44f000000b004bf28bfc9absm1064150edf.11.2023.03.11.03.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 03:15:34 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/6] power: supply: rt9455_charger: mark OF related data as maybe unused
Date:   Sat, 11 Mar 2023 12:15:27 +0100
Message-Id: <20230311111532.251604-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

  drivers/power/supply/rt9455_charger.c:1725:34: error: ‘rt9455_of_match’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/power/supply/rt9455_charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/rt9455_charger.c b/drivers/power/supply/rt9455_charger.c
index 31fb6526a1fd..0149e00f2bf8 100644
--- a/drivers/power/supply/rt9455_charger.c
+++ b/drivers/power/supply/rt9455_charger.c
@@ -1722,7 +1722,7 @@ static const struct i2c_device_id rt9455_i2c_id_table[] = {
 };
 MODULE_DEVICE_TABLE(i2c, rt9455_i2c_id_table);
 
-static const struct of_device_id rt9455_of_match[] = {
+static const struct of_device_id rt9455_of_match[] __maybe_unused = {
 	{ .compatible = "richtek,rt9455", },
 	{ },
 };
-- 
2.34.1

