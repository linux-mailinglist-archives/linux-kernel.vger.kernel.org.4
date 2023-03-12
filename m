Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33EFA6B663A
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 14:13:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjCLNNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 09:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbjCLNNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 09:13:33 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 446FB1F924
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 06:13:32 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id k10so38402864edk.13
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 06:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678626812;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CwcHrV5a02s5JB75+HpDxEu4ezBqVrMI6kJUFyMDg/I=;
        b=bV/PAEtQn1KGw/Zi6jTCgqYa5nRbO5IPf2+hM5MLwAk5Uk0e9xROyciD1SeTbKeIvo
         MlkLJZ7Bn9rWTiPWyy1rXLIb0NPN7l/0SUcmQ1gPA0Px803dGmfYFSsMi0zSxvCDYIEp
         xAfx/2AAA1BZBrfbtUqRJvxUVRAewGUUTagEKg9AHpIaQNB2T1bQ98IqMD5mo2GoWKwK
         +FQom24Ip58JAYs2KpB60hA0ik3xFPiniQmemJhG9dzrzLF06IvbDUiE2YiA/R8WS7FC
         c4jhRSJ9/XJbJhFhHSbrl0/vOmemeevZCwfrLAtLWu/L6nb0K50kiGKmyGQmjBDX2sbg
         iSvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678626812;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CwcHrV5a02s5JB75+HpDxEu4ezBqVrMI6kJUFyMDg/I=;
        b=1NQ7hMYw8stXuQYpizhIWc7svbDK97HM9+ijvo0XVGaZ8M0bc5Og7CgLRaU/VKRUsf
         dTslqqx0RuzhiyeIGuXt5NbBrqG1lPXeyoRz/r9yvlDOtP0lp887Yl9Vt+oBtxCRreHD
         D8bhJEWMmEoM7LA9DHYP3wqvJ/2sAHgQdskgFr0YYFE77GfeQ7YFbccccXIk3Yi6X6eG
         lQnwMZjnFTNiS/0kzqg8k0923LbnEzCa+MrN4zKnrF/ZTwbA9nlR2r7qwvA5XxG/u+CF
         hN4ublrow0Nr4t8CoMZeqR4vbE6/ffQRcDzyT9jOrGTd3DNyni72hORIhyJ4QM0hrPMq
         ZUCQ==
X-Gm-Message-State: AO0yUKUzDPkvl64mhtcWRISXyFtYxns27yjyOzZxc/CA9YfjaU5qvtf+
        g0oIrG8nEPaesV1nnaz5uRMXhA==
X-Google-Smtp-Source: AK7set9S2U41oyugwgVu8YTpoQzzlycJss1HXlDHk5bJDxiw4kxZXbt8ZreuYC74Gl5l/Mtsa+88Og==
X-Received: by 2002:a05:6402:1005:b0:4f9:f45e:c8b3 with SMTP id c5-20020a056402100500b004f9f45ec8b3mr5024696edu.27.1678626811779;
        Sun, 12 Mar 2023 06:13:31 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:d9f6:3e61:beeb:295a])
        by smtp.gmail.com with ESMTPSA id r19-20020a1709067fd300b008eddbd46d7esm2213279ejs.31.2023.03.12.06.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 06:13:31 -0700 (PDT)
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
Subject: [PATCH 04/28] media: rc: gpio-ir-recv: drop of_match_ptr for ID table
Date:   Sun, 12 Mar 2023 14:12:54 +0100
Message-Id: <20230312131318.351173-4-krzysztof.kozlowski@linaro.org>
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

  drivers/media/rc/gpio-ir-recv.c:197:34: error: ‘gpio_ir_recv_of_match’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/media/rc/gpio-ir-recv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/rc/gpio-ir-recv.c b/drivers/media/rc/gpio-ir-recv.c
index 8dbe780dae4e..ae1199cc73fd 100644
--- a/drivers/media/rc/gpio-ir-recv.c
+++ b/drivers/media/rc/gpio-ir-recv.c
@@ -205,7 +205,7 @@ static struct platform_driver gpio_ir_recv_driver = {
 	.remove = gpio_ir_recv_remove,
 	.driver = {
 		.name   = KBUILD_MODNAME,
-		.of_match_table = of_match_ptr(gpio_ir_recv_of_match),
+		.of_match_table = gpio_ir_recv_of_match,
 #ifdef CONFIG_PM
 		.pm	= &gpio_ir_recv_pm_ops,
 #endif
-- 
2.34.1

