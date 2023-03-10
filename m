Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 926A56B5457
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 23:29:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbjCJW3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 17:29:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231700AbjCJW3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 17:29:13 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D15A9122CFB
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 14:29:07 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id cy23so26355237edb.12
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 14:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678487346;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f4hsdqWnTrZCw8a5RzNxKgld2eq5ESSNSd43t/rkHbA=;
        b=sQ9AnmWrtkGTib7XAuvnkd/mECJ9fJ3H135f812M5x+86PSP40RwLIlTRgQ1T4m70O
         /5u/uQm3FN3/qjs3kbzAn3amwi8BH54NeZ9ak/3qqOHRxONcHK+LS0jQ2lZFKn5gYTUc
         RpRtfSA2m+jUdaaoLfdezgQ0HnabwAw5Zd5UJ5dqV3uQXLsbWK3iN7ntET4GLmfonbHG
         HqTHQEpi57dXBQigF2FBMVwrXUfCvgWj/8SOoCpunzh11ZkB+PNH65nvKVZkueb62SGb
         mXX9xdEOWyKpvgeLMJaW+kaCM65dZySOzCAtYIZjl7k+9cAThGz1l/FTIQEQq4iT2/ER
         RJ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678487346;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f4hsdqWnTrZCw8a5RzNxKgld2eq5ESSNSd43t/rkHbA=;
        b=uZYN+WGUPwC0rh1TtEd2V+n/j6L1Hy4bGXVZZEnXAK48eTsrJEvU8nMdyez0dgVHC4
         5wS+2BPB0uaj5cu8FsD1ogw8cmorkQ7+TShnTOAiS3n0TrrgLlMsxlYxzMTyhZjxrZu6
         LQnLDyZKsuRkrupOukgNWc48ewp8kQOQ+beNBkUXEivARCGJHNbyYFOsxlUm7OUixd8t
         MTaURRUuQEi6ni5indAFowEiC5RMij5ungow4ESHdpujTBjS+vGgKR2yGB5iefaI9pmh
         KqXo1TpayP0j3eZcZbf63QYA5fQ18fBTB67UlogLQMuSgbrNe6w7iknU+M2vZ7GARaLf
         PSxA==
X-Gm-Message-State: AO0yUKV/6XcWo7Gcj4hjLSwqcY0Vdg+ttz5VWQnpCWuhJJ3c9ZXUqbBS
        u/vTUD76T0ThhREyX+94YuutpA==
X-Google-Smtp-Source: AK7set8req7DR8ncW0h8QB4fOrmA/Kz78djHJzJDXsGh0OSt5DpOgdDc5EHeCp2kQeLQUU4yam/Ccw==
X-Received: by 2002:a05:6402:2028:b0:4af:70a5:55ee with SMTP id ay8-20020a056402202800b004af70a555eemr23535448edb.3.1678487346365;
        Fri, 10 Mar 2023 14:29:06 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:34:52e3:a77e:cac5])
        by smtp.gmail.com with ESMTPSA id x101-20020a50baee000000b004aeeb476c5bsm525467ede.24.2023.03.10.14.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 14:29:06 -0800 (PST)
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
Subject: [PATCH 05/16] spi: orion: Drop of_match_ptr for ID table
Date:   Fri, 10 Mar 2023 23:28:46 +0100
Message-Id: <20230310222857.315629-5-krzysztof.kozlowski@linaro.org>
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

  drivers/spi/spi-orion.c:615:34: error: ‘orion_spi_of_match_table’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/spi/spi-orion.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-orion.c b/drivers/spi/spi-orion.c
index e79d1fe0bca4..c63b75c1829a 100644
--- a/drivers/spi/spi-orion.c
+++ b/drivers/spi/spi-orion.c
@@ -852,7 +852,7 @@ static struct platform_driver orion_spi_driver = {
 	.driver = {
 		.name	= DRIVER_NAME,
 		.pm	= &orion_spi_pm_ops,
-		.of_match_table = of_match_ptr(orion_spi_of_match_table),
+		.of_match_table = orion_spi_of_match_table,
 	},
 	.probe		= orion_spi_probe,
 	.remove_new	= orion_spi_remove,
-- 
2.34.1

