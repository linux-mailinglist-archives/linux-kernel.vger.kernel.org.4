Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12EDC714D28
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 17:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbjE2Pfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 11:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjE2Pfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 11:35:39 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E02D8
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 08:35:37 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f60e536250so29532805e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 08:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1685374536; x=1687966536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NxiLnH0M50rO/qW7JX7iQtyXgKtx4AkJoJmCH1LebW4=;
        b=L//I9S2COgnPuAqwzY7rwCqIEzLr5UHMuung9l2NZeScGr95y8DGnRo7M71Q/tqPWw
         SvJr/sEATWPr2CHBmeJBhJ2BfcjsfLxyGY1+uL+7Y4SFFBzM24GJx6VYHGhFaZD2b5jk
         hIFSHlRrdkkIW6UHyhfFd8N9PmLksxfsIuivGrqCSBPNWFjFh6CBsfzxITI36oKqBSxH
         lnn1P+cV8vu1e+h6hIGzrDnloX0bA3dQ18MBFpbS9Do/eDP79363UCIVnqeXfY1dojuh
         b4MOVW0XdNbQ56C1lX2iO3fT4QkkgcxZ7dHtoGzNiOcVdyK64i06Li+WYzO8nRAPAB3h
         RvUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685374536; x=1687966536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NxiLnH0M50rO/qW7JX7iQtyXgKtx4AkJoJmCH1LebW4=;
        b=Fw6axkmqVYX/MPbwJFsgnQrAXmtteZog9XQL26BqCMb4ilUhBZ0RR7hlFZHpSLKd+Z
         zcWEM2aHpjtoIOjWx+VggCqxiKCgwj0XzOaXKpKk+1SFn4mYFDIhy4Z+o9/1XhZVAMGh
         DcZy4EspmoXvotuZ+iXXG5gmHOpKoSOrqNQa7OpbJAPUu0ZBN9XL43GiVk8vBxFkuVPj
         aWCUdAsgFWoOYuSVkE6kWSM/upOxWSenSL/eo+Lg8/5Q7nd/HJyYShOaX5139wGej+6j
         L/Xz+/bOD1x04aqlwA/MdxlcxaXuVuvBzJFPkVRBNFA4hKMQtbD7bX4610s+tr9BBiEX
         GzJg==
X-Gm-Message-State: AC+VfDxBJ3q5OLkHE7jTtR5jZthXTs3VEDI7pm5GFeIkfSnwkMviyAI0
        7RWjT0idEWvdYgVPr06fcOzjEg==
X-Google-Smtp-Source: ACHHUZ7qZHxmF3+e+rNlw5j8VzdMDxKnKmfpbQTz65hzsyWKZLCH+2IuKfhVLZ3R2YbGPj0C8SGvvw==
X-Received: by 2002:adf:e544:0:b0:30a:8e6a:3d77 with SMTP id z4-20020adfe544000000b0030a8e6a3d77mr7670288wrm.1.1685374535793;
        Mon, 29 May 2023 08:35:35 -0700 (PDT)
Received: from ph18.baylibre (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id j27-20020a5d453b000000b003095a329e90sm269781wra.97.2023.05.29.08.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 08:35:35 -0700 (PDT)
From:   =?UTF-8?q?Bernhard=20Rosenkr=C3=A4nzer?= <bero@baylibre.com>
To:     daniel.lezcano@linaro.org, angelogioacchino.delregno@collabora.com,
        rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzystof.kozlowski+dt@linaro.org, rdunlap@infradead.org,
        ye.xingchen@zte.com.cn, p.zabel@pangutronix.de
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        wenst@chromium.org, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com, nfraprado@collabora.com,
        abailon@baylibre.com, amergnat@baylibre.com, khilman@baylibre.com
Subject: [PATCH v3 1/5] dt-bindings: thermal: mediatek: Add LVTS thermal controller definition for mt8192
Date:   Mon, 29 May 2023 17:35:28 +0200
Message-ID: <20230529153532.3541327-2-bero@baylibre.com>
X-Mailer: git-send-email 2.41.0.rc2
In-Reply-To: <20230529153532.3541327-1-bero@baylibre.com>
References: <20230529153532.3541327-1-bero@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Balsam CHIHI <bchihi@baylibre.com>

Add LVTS thermal controller definition for MT8192.

Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Bernhard Rosenkränzer <bero@baylibre.com>
---
 .../thermal/mediatek,lvts-thermal.h           | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/dt-bindings/thermal/mediatek,lvts-thermal.h b/include/dt-bindings/thermal/mediatek,lvts-thermal.h
index 8fa5a46675c46..5e9eb62174268 100644
--- a/include/dt-bindings/thermal/mediatek,lvts-thermal.h
+++ b/include/dt-bindings/thermal/mediatek,lvts-thermal.h
@@ -26,4 +26,23 @@
 #define MT8195_AP_CAM0  15
 #define MT8195_AP_CAM1  16
 
+#define MT8192_MCU_BIG_CPU0     0
+#define MT8192_MCU_BIG_CPU1     1
+#define MT8192_MCU_BIG_CPU2     2
+#define MT8192_MCU_BIG_CPU3     3
+#define MT8192_MCU_LITTLE_CPU0  4
+#define MT8192_MCU_LITTLE_CPU1  5
+#define MT8192_MCU_LITTLE_CPU2  6
+#define MT8192_MCU_LITTLE_CPU3  7
+
+#define MT8192_AP_VPU0  8
+#define MT8192_AP_VPU1  9
+#define MT8192_AP_GPU0  10
+#define MT8192_AP_GPU1  11
+#define MT8192_AP_INFRA 12
+#define MT8192_AP_CAM   13
+#define MT8192_AP_MD0   14
+#define MT8192_AP_MD1   15
+#define MT8192_AP_MD2   16
+
 #endif /* __MEDIATEK_LVTS_DT_H */
-- 
2.41.0.rc2

