Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1BF6B535C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 22:50:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbjCJVux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 16:50:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232269AbjCJVtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 16:49:55 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4EC515DA
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 13:46:56 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id k10so26002634edk.13
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 13:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678484758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fbyswuRmDGOGqggdQqXqT7Cs+m5LJh2VXeBWZLXjLIU=;
        b=L73u41NMzWu8lO1ELlHeKZd3WcB83MwnPVL4fICQlBj98zQVkgvU4JO60lmACXbvIA
         wdwAskhRGPhelfv11jYLOR+ppTUQPMprcl1EV7pZoO9zRqxbEVDyEEe7eOOl7qGl6rcJ
         x31FHExCqCNQGJT91GpVIPcdhxAm1qW8wDKHO2X1ogJZiqYeLj3+C2pPk0wkizUZCD4q
         tZ4TbpTuMKF/XCru+59zmJfA3EDy7ckr6vxQ7iHMstd2Cd9+J9p92b7qUD/TMY5hpkoc
         HRkI7ZyG9BdR7yn7wDteW8M8tnuubbC2EKyf8VxJvUh8e5l4AAqYhyi5u1bf454kDNj3
         sa8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678484758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fbyswuRmDGOGqggdQqXqT7Cs+m5LJh2VXeBWZLXjLIU=;
        b=IA7KfmgjnRyccfKjp37KXTh+IJEvvUO7N4vuANWn9SgWnxR2Qx0tjbRAAai2MdyzKG
         So/GhtB6nAMpbjkXyYlP/kltuMTeXPGZ8Ff6yhzMnfYgWlW5NFox0sDeKmSJ4GmRNDpk
         9q1d4rm0DZChMHLUlaPyqG0i/kMTF747DWbWgpgOf3XDiH79hAqR4Alsqvb0o88iMMU/
         /KudF5xDxJYT9IerPmgU+7SyLhDNptcAr6TvWpb23lhASlk6ALPpKh4kHMvNek0ZvyPs
         fpDFjZEOCpqdVo6CNBF7rGp3F9s4tI1rMcwfQXnznry98C6lv7Rsm9lXI154qOgV9OGs
         EVwQ==
X-Gm-Message-State: AO0yUKUktI+JxCan3L0ci1nXGOpkjcUJPp2s4A0bDmYsASm70JkJHhtS
        7EIkI2KOpphbE6lI9aaXeMY2Lw==
X-Google-Smtp-Source: AK7set9Jf40AEyHbOmvy87vpw1Xb+IaWlreNsCXG2RxDHOTbxWqUwmXTuwkUpr4oApOCilH/43fEng==
X-Received: by 2002:aa7:cb4b:0:b0:4af:7bdc:1891 with SMTP id w11-20020aa7cb4b000000b004af7bdc1891mr3712523edt.11.1678484757769;
        Fri, 10 Mar 2023 13:45:57 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:34:52e3:a77e:cac5])
        by smtp.gmail.com with ESMTPSA id u7-20020a50d507000000b004be11e97ca2sm471873edi.90.2023.03.10.13.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 13:45:57 -0800 (PST)
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
Subject: [PATCH 2/9] regulator: max20086: Mark OF related data as maybe unused
Date:   Fri, 10 Mar 2023 22:45:46 +0100
Message-Id: <20230310214553.275450-2-krzysztof.kozlowski@linaro.org>
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

The driver can be compile tested with !CONFIG_OF making certain data
unused:

  drivers/regulator/max20086-regulator.c:289:34: error: ‘max20086_dt_ids’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/regulator/max20086-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/max20086-regulator.c b/drivers/regulator/max20086-regulator.c
index b8bf76c170fe..c98a72f43935 100644
--- a/drivers/regulator/max20086-regulator.c
+++ b/drivers/regulator/max20086-regulator.c
@@ -286,7 +286,7 @@ static const struct i2c_device_id max20086_i2c_id[] = {
 
 MODULE_DEVICE_TABLE(i2c, max20086_i2c_id);
 
-static const struct of_device_id max20086_dt_ids[] = {
+static const struct of_device_id max20086_dt_ids[] __maybe_unused = {
 	{
 		.compatible = "maxim,max20086",
 		.data = &(const struct max20086_chip_info) {
-- 
2.34.1

