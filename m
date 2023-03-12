Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E42B36B6664
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 14:15:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbjCLNPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 09:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbjCLNOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 09:14:49 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5674D265BC
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 06:14:03 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id fd5so4619292edb.7
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 06:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678626835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hGcITVAy31UtuDH6LhnS9qeMquB4EE88f+CeXXPHp2U=;
        b=YkVf8PAZp1sjrWnpH/Du7l6KUolVfDrkiaYMszEc3PTGHc7Ipup3dDat3y6CTjWSPV
         ETjJlT78KfnQGOAf6MGNU+mOmPzuuxdMNRmlOdRXk4Hh25EaqGkuHgJn46FjE9ICHpMo
         7V+UVeVxiiXoAy3ZRT86gz6gnIRO7iPtSxI+cfDq1MEGhpzhtsPB6SS8I+i2QnJxByzS
         uUKomqVb1xWi/oYuHGL4pv+q/LGkQ88cq7n9QwVXNiYDoFyM1wGXCFuvUNF2LSDpOPrD
         QIP9fxEouE6Wi8b5wrPTL3FN+A5VP1IFQN0fwJnlBGvCFrGa9Re4rcFPt+1znXjsG5zv
         cFuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678626835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hGcITVAy31UtuDH6LhnS9qeMquB4EE88f+CeXXPHp2U=;
        b=nrNMi4EqgnW9TbAbVejaSY4FAyxBkmgZ093Ri9zF1tDZCHzQepqz5QkiFwavagDKZU
         naCtGJ4mamUb59bHxRfUDsCgtDCmnGyS3ze/yB3rhQeDFR9MkjnLU+xgeFnpizaz+G9C
         cbFWuLyQ3kgFyiPDGtRIWRdS/Lr4p7rqAJbt0ATWlvZDujYs8URV+R2S6Xj4eRY9a1Xm
         X+qa0lE5c8sjdih72hnn/EqKExVz3mnxdmfsTmc8F2xx5VBKCxcCZCLR6GXtQrL8durI
         TTV/IwNkmKnzSJzaGHnFYlHdyGvfCxAvt5q1GiIr0KPSFA6tETj+Mzg1iWBCZzrMc42z
         VXAQ==
X-Gm-Message-State: AO0yUKV7UIizbjtBlC56+NRZx30Y6wOrt3MVbJZgvYyR2NZ9uppcxMgf
        O3UWTlbT6Td8tMSMXAk+ql6YPg==
X-Google-Smtp-Source: AK7set/xivJKH0hcau66sU8fJqKK2GNHVix/5Dk94HStfVumSSriO/XOviLFoDjpZUHmFVs9JDdUDg==
X-Received: by 2002:a17:907:6d08:b0:887:dea8:b029 with SMTP id sa8-20020a1709076d0800b00887dea8b029mr36591244ejc.1.1678626835335;
        Sun, 12 Mar 2023 06:13:55 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:d9f6:3e61:beeb:295a])
        by smtp.gmail.com with ESMTPSA id r19-20020a1709067fd300b008eddbd46d7esm2213279ejs.31.2023.03.12.06.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 06:13:55 -0700 (PDT)
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
Subject: [PATCH 16/28] media: platform: sun6i-csi: drop of_match_ptr for ID table
Date:   Sun, 12 Mar 2023 14:13:06 +0100
Message-Id: <20230312131318.351173-16-krzysztof.kozlowski@linaro.org>
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

  drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c:401:34: error: ‘sun6i_csi_of_match’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
index e3e6650181c8..187a2419da96 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
@@ -429,7 +429,7 @@ static struct platform_driver sun6i_csi_platform_driver = {
 	.remove	= sun6i_csi_remove,
 	.driver	= {
 		.name		= SUN6I_CSI_NAME,
-		.of_match_table	= of_match_ptr(sun6i_csi_of_match),
+		.of_match_table	= sun6i_csi_of_match,
 		.pm		= &sun6i_csi_pm_ops,
 	},
 };
-- 
2.34.1

