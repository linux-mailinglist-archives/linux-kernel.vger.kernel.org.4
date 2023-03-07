Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D95AD6AE6C1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 17:36:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbjCGQgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 11:36:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjCGQfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 11:35:31 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD50596F18
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 08:34:18 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id az36so8198162wmb.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 08:34:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1678206856;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=McbTfENxEdZqEgXKH7PG/5bhwWFaGotxBfbxO1NPp48=;
        b=CJBz8WiNOmy4gjUADtEpDsBjuJUou+AtKRwUTLpoCDEHs3cI8vLGnmQRVurKXNvh2W
         MuIBICoZJEF4co+iHP8IbBNI7+qq7HJOcPtJ+vw1b2nzJkT8uIoz7DkwWQ2zjyn434mK
         9p5vbeRtkFRSAoLMAObkctsE4y93KuLjbxePxHYLUgoscI6O+JEQPyEk9O44gDD0XQfn
         aMxMK8Loje+t2Sh2N/XlW+I1DbIeE27F8xpstSTdrsF0gVKx6KH3arlLKUfSYO60igNX
         Hwmj6H/0+1N2flv56QXqcJ140LrAr95GrU0Np4wv3BhgKrj3UIwDVXzDXnmmXpcT+oi/
         A7EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678206856;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=McbTfENxEdZqEgXKH7PG/5bhwWFaGotxBfbxO1NPp48=;
        b=HZDvDlweMhU4PWht1FMjrkH6D13Cnl2sFrkFdzY7xQCFoUXy51zAnm5euQD1/ZLElh
         KN/D3LVdu43NIpbshsm/tUJziPyVqG6pK4Q/81Jz9un3tsAxaTR3OLT1uY7sBJrLLzuA
         bBBDvVNLQNnJIgwyvjYqB8FQsp1D4KrtSA+9WgbvrD5fFGIo1Ch8hciEmuR0nTo2htpd
         XjZhkMaOx8F9VcnCewhM76YCs4UVxnq34QuAbdIMFJpUMp0vh9R2D2ho5XHOvtZ4oEvH
         CR9jsR0pb9JcvAkRTXZ7PbwgsU+FcdSKubn7/FS2XHErQxD+yJL89l2oAkAIWQ94DZKf
         IwJA==
X-Gm-Message-State: AO0yUKXOXGJgQ476PAKpdTxINs8Y0v+/0RJAaSgUEY+WEt2qEgXugXT4
        uAccWwljVAedBs40RKpAML0WzA==
X-Google-Smtp-Source: AK7set8lgDaqUcBxQXAMw48pkJy8Px2UaNxydb31XT7KHAaWhBULcQb54e5gfZXZrkIR79Jma98IuA==
X-Received: by 2002:a05:600c:1d0e:b0:3eb:fc6:79cf with SMTP id l14-20020a05600c1d0e00b003eb0fc679cfmr14061185wms.6.1678206855945;
        Tue, 07 Mar 2023 08:34:15 -0800 (PST)
Received: from localhost.localdomain (laubervilliers-657-1-248-155.w90-24.abo.wanadoo.fr. [90.24.137.155])
        by smtp.gmail.com with ESMTPSA id t1-20020a5d49c1000000b002c563b124basm12778117wrs.103.2023.03.07.08.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 08:34:15 -0800 (PST)
From:   bchihi@baylibre.com
To:     daniel.lezcano@linaro.org, angelogioacchino.delregno@collabora.com,
        rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, rdunlap@infradead.org,
        ye.xingchen@zte.com.cn, p.zabel@pengutronix.de
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        khilman@baylibre.com, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com
Subject: [PATCH 1/4] dt-bindings: thermal: mediatek: Add LVTS thermal controller definition for mt8192
Date:   Tue,  7 Mar 2023 17:34:10 +0100
Message-Id: <20230307163413.143334-2-bchihi@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230307163413.143334-1-bchihi@baylibre.com>
References: <20230307163413.143334-1-bchihi@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Balsam CHIHI <bchihi@baylibre.com>

Add LVTS thermal controller definition for MT8192.

Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
---
 .../thermal/mediatek,lvts-thermal.h           | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/dt-bindings/thermal/mediatek,lvts-thermal.h b/include/dt-bindings/thermal/mediatek,lvts-thermal.h
index 8fa5a46675c4..5e9eb6217426 100644
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
2.34.1

