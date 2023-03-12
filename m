Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D25FA6B664B
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 14:14:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbjCLNOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 09:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjCLNOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 09:14:06 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75EF250992
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 06:13:45 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id fd5so4618012edb.7
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 06:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678626823;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=htfDeYfzO9faOo04zE1zbbujaGC8tJVc0LLIWYl/0E0=;
        b=tWY5RRrl1f9P7YtLpyoXwinY0arcCPoS91VIZamWggOmJA3famcby5+OZgSd6D+3Kd
         eCD1W8dLgS+FdEzVc+bFFH/FHIRuGvvJD4r5wyOs9K3SqnlcXv2Pyztgd4ay1djF+lM+
         a8t+bz5kIbyuWGHoN4lV0N1gIwWkDD5MJJKQvznugy0sbFLCTV1ZL6gVO+8oOav3hUya
         khEHKs6qBFkXPUX+JbMR5N7HurufkoAZ9eGkLnCr88gbiFg1n3dRqmAlnsPFAD8f20Uw
         /KWfOLBYYz6YW1zCZ2igu5mQ5/plPLyE2zQRCvIhjOFZXsYHGYEV4R7EwsQjMFRUaukp
         k9RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678626823;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=htfDeYfzO9faOo04zE1zbbujaGC8tJVc0LLIWYl/0E0=;
        b=6IHKRQWvFF+ZO9yPmyvKbN4kQ54/Xh5D+my5gn+P0sGUsfvKAphagMJvOqcv6fsVpw
         l3MgiZROOWb4Fq2eXWgPo7ClAeqSXsA0LVjW5cE/absUXS5O8DXD3nb8yNLlgYzfNhKJ
         43aSKf3qxPJe/mC23XZrCBR2BLAoGeiM7F9+SSimigNST0H95hj+HIuyBoT3XLkoIy4o
         U0momUJVDAENiJTcHY5nTGOI0QdjwCpS7aUuoCdM1KJzFgKQRxVxhh6KnLP7yTQ7BHMo
         9wafnn9q/Pk3hus+EGcTmC68h318bylT9X1qnBdYCXE0BCsOiLreW5gcqhguO1m3GeMD
         UBXw==
X-Gm-Message-State: AO0yUKXbA8Ebw8ZO/dTgZZgV0ROj8ENcEv+YuPKheAZ9iYDZ3sJ2MOu9
        reNmBuAuLuu2DB9aFMZ97GnsQg==
X-Google-Smtp-Source: AK7set8sFYEVlwjj96yBoYEcUC6q6umvvTijNA5/w5cBj5OSXSMnBWa3ubt3+oomwUIh2AE5fhzWng==
X-Received: by 2002:a17:906:d28c:b0:8e5:88ca:ebac with SMTP id ay12-20020a170906d28c00b008e588caebacmr31563524ejb.40.1678626823445;
        Sun, 12 Mar 2023 06:13:43 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:d9f6:3e61:beeb:295a])
        by smtp.gmail.com with ESMTPSA id r19-20020a1709067fd300b008eddbd46d7esm2213279ejs.31.2023.03.12.06.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 06:13:43 -0700 (PDT)
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
Subject: [PATCH 10/28] media: platform: sti: drop of_match_ptr for ID table
Date:   Sun, 12 Mar 2023 14:13:00 +0100
Message-Id: <20230312131318.351173-10-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230312131318.351173-1-krzysztof.kozlowski@linaro.org>
References: <20230312131318.351173-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver can match only via the DT table so the table should be always
used and the of_match_ptr does not have any sense (this also allows ACPI
matching via PRP0001, even though it might not be relevant here).  This
also fixes !CONFIG_OF error:

  drivers/media/platform/st/sti/c8sectpfe/c8sectpfe-core.c:1169:34: error: ‘c8sectpfe_match’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/media/platform/st/sti/c8sectpfe/c8sectpfe-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/st/sti/c8sectpfe/c8sectpfe-core.c b/drivers/media/platform/st/sti/c8sectpfe/c8sectpfe-core.c
index c38b62d4f1ae..67d4db0abd8a 100644
--- a/drivers/media/platform/st/sti/c8sectpfe/c8sectpfe-core.c
+++ b/drivers/media/platform/st/sti/c8sectpfe/c8sectpfe-core.c
@@ -1175,7 +1175,7 @@ MODULE_DEVICE_TABLE(of, c8sectpfe_match);
 static struct platform_driver c8sectpfe_driver = {
 	.driver = {
 		.name = "c8sectpfe",
-		.of_match_table = of_match_ptr(c8sectpfe_match),
+		.of_match_table = c8sectpfe_match,
 	},
 	.probe	= c8sectpfe_probe,
 	.remove	= c8sectpfe_remove,
-- 
2.34.1

