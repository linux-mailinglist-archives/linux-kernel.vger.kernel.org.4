Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8F56B6648
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 14:14:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbjCLNOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 09:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjCLNOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 09:14:00 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E43474D1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 06:13:41 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id y4so9042835edo.2
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 06:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678626821;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sj4f7lJPyQLZUYqaER8NG8pmeutfonQX6OO2yd6udaw=;
        b=haj+KB/z1L8vJsua2o1vxxCHMhlVmbnayBqVzvMfHTJAHqgBLjuc/m6H8B4mzyAIUc
         62++ksMk1muzp7U2CtB7D9P7OT9ysYz5szaVXEfN0VUDh7fKa3EjKwvqTewvN6LY1vAq
         uKTmvbqcscSxRnCGfJgPFBVKO1QsrON6N8UYL/HmXesYNb1v6+H+yFTBF0epod9JGCNQ
         sopNnojKfIUzWOI7GKiySLHrr51LfhfDQYqJ93VkkJkXadH8VzeSa2sdUn6eUFC1W+Gu
         SmuQmjfkoayusufLq8/6NhHZyZBJHob0DzV+rM0eAmzL5eNCUGhmohmS7ijIcVRPEuYc
         oUVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678626821;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sj4f7lJPyQLZUYqaER8NG8pmeutfonQX6OO2yd6udaw=;
        b=tMAv5DcPWQopq+JEe07hjbZjC6Qr9bv9rfi2+yHjvlNjHVB/nv223wpQSv/PLfu9ZE
         GqXkOpJb93CaIqupRnnQgvGw6uRcnF+YGqq2zvW78MAwbrP/cf70+GoB6psL5fVpk9tz
         esr4HJaxoO5sD9QbiCSEDcSEJ6B4qFC+hb1Kn0rodlgd/8kvPcz6bMtG4F+nIv68GHp9
         NICLpyiRrA4+AvtKLtEAz50i4csjlgcswfnXXHE+f2BYztZybRsHo/BJx+jxcDb8rdij
         v4tcUQDNHmWAsAPTF3ZyuomrZ6ge36Kij+2S1bDttWbsAKsLol657m1LIceL1KCa3iQR
         DNpA==
X-Gm-Message-State: AO0yUKUNuCcGwBoflmAMnedEFblJarKinFEUj+QXvWMAKvWBDX69cXOJ
        NsbMvoZ+PBiA9mTsco9LKdsUMA==
X-Google-Smtp-Source: AK7set/ermG5mPokgNtP87IO4WUZSbcbchCeAghNXlc5QJFzLjHi45cBPkYMiVQWjmGVImmiqhDubQ==
X-Received: by 2002:a17:906:4c8e:b0:8af:447a:ff8e with SMTP id q14-20020a1709064c8e00b008af447aff8emr28369686eju.20.1678626821501;
        Sun, 12 Mar 2023 06:13:41 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:d9f6:3e61:beeb:295a])
        by smtp.gmail.com with ESMTPSA id r19-20020a1709067fd300b008eddbd46d7esm2213279ejs.31.2023.03.12.06.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 06:13:41 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Joe Tessler <jrt@google.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Michael Tretter <m.tretter@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Wenyou Yang <wenyou.yang@microchip.com>,
        Bin Liu <bin.liu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Minghsiu Tsai <minghsiu.tsai@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Andrzej Pietrasiewicz <andrzejtp2010@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Yong Deng <yong.deng@magewell.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sean Young <sean@mess.org>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-rockchip@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 09/28] media: platform: samsung: s5p-jpeg: drop of_match_ptr for ID table
Date:   Sun, 12 Mar 2023 14:12:59 +0100
Message-Id: <20230312131318.351173-9-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230312131318.351173-1-krzysztof.kozlowski@linaro.org>
References: <20230312131318.351173-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver can match only via the DT table so the table should be always
used and the of_match_ptr does not have any sense (this also allows ACPI
matching via PRP0001, even though it might not be relevant here).  This
also fixes !CONFIG_OF error:

  drivers/media/platform/samsung/s5p-jpeg/jpeg-core.c:3124:34: error: ‘samsung_jpeg_match’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/media/platform/samsung/s5p-jpeg/jpeg-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/samsung/s5p-jpeg/jpeg-core.c b/drivers/media/platform/samsung/s5p-jpeg/jpeg-core.c
index 55814041b8d8..8be8e3596e07 100644
--- a/drivers/media/platform/samsung/s5p-jpeg/jpeg-core.c
+++ b/drivers/media/platform/samsung/s5p-jpeg/jpeg-core.c
@@ -3166,7 +3166,7 @@ static struct platform_driver s5p_jpeg_driver = {
 	.probe = s5p_jpeg_probe,
 	.remove = s5p_jpeg_remove,
 	.driver = {
-		.of_match_table	= of_match_ptr(samsung_jpeg_match),
+		.of_match_table	= samsung_jpeg_match,
 		.name		= S5P_JPEG_M2M_NAME,
 		.pm		= &s5p_jpeg_pm_ops,
 	},
-- 
2.34.1

