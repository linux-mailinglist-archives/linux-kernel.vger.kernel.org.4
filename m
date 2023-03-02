Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75B556A8274
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 13:40:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjCBMkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 07:40:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjCBMku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 07:40:50 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 646964BEB8;
        Thu,  2 Mar 2023 04:40:49 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id f13so67024411edz.6;
        Thu, 02 Mar 2023 04:40:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677760848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NjhrqpxloWE6ONs+Pg7avedoS40plQhwR7tQyDf+1NI=;
        b=gbmgoI6laQc6/BL/YNgDPvv1PN2ZRWGhLBi8S8/A7u4bqe/ANj4oQc6GPQglRPVuA9
         Yy5YRPkTen1Z/Swqt6UwBSkjqBHDXSRN2O3YqSWBDguoqCFFm6gCQccnR5IsA258ikYg
         oMCBC4P720JczFNcfpEA3H0dXicB8rkA6JzF9u/wTpJXi5Ks81wDDmhY0ZD9GUKzGbW+
         0hv0t5GhorZ1+n8e8b01+06ahUUp/ZJW7nVQag2BC6XZhB5kR6BqzFUaMOK4SIubEVJ5
         77OlUgZ/nl/Z3IOneSqFlKA12SHBmJy9GApBvWJFi9B4VQueoGcGfT3oOBZqYz5vcTTk
         lcGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677760848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NjhrqpxloWE6ONs+Pg7avedoS40plQhwR7tQyDf+1NI=;
        b=bRG6yHty25WsLSHzRKGhlw+QpzPmoS8pdwzo6S0yghTcT3ARA8XnEjXtp2mXLRJiu1
         Y5BA0sgQyNIljsxIQLL5Je8b7aHwZLT6vNZVKAUPMUrwdFWCAg3ANo9qUkVwe9RseeJk
         vlW2CzBG7QGw7o1m3Ve2hP4JpfCCnJ726NPNUwsIkITt2iQbHgZEu3hQ4xIGxGJ4eVCI
         qnBUzKC0DZjKCjG4n2f/9Zjv35MA8db78GEGhfpyRMAxb8EpfHfgK4RKyM/+rQjRqMH8
         leJ4K0jHbwWt0qzlZBYLZdB0+RfIQCw/m8W0ZIu9ArFAqBhjBB4IoGE5P1/le6vcUVLn
         xF8w==
X-Gm-Message-State: AO0yUKUsXPW/M9V1Aych7k8vQpO5wLhS+V/ms8zuDQdQO2/Tg22I4oIe
        qXO2RShw1eHL0RIFTxOkriw=
X-Google-Smtp-Source: AK7set8/HK/oMZWKO35qnjajVW9FaD8X1JDnnELZEJrBvVOwMD1Ga4Z+YkLOvrNIWmDciTgh4LpShg==
X-Received: by 2002:aa7:d6d8:0:b0:4bf:d8d9:4b0e with SMTP id x24-20020aa7d6d8000000b004bfd8d94b0emr2145093edr.22.1677760847970;
        Thu, 02 Mar 2023 04:40:47 -0800 (PST)
Received: from localhost.localdomain ([95.183.227.97])
        by smtp.gmail.com with ESMTPSA id c22-20020a50f616000000b004c07b11deb8sm599036edn.64.2023.03.02.04.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 04:40:47 -0800 (PST)
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Yassine Oudjana <yassine.oudjana@gmail.com>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 1/2] dt-bindings: reset: Add binding for MediaTek MT6735 TOPRGU/WDT
Date:   Thu,  2 Mar 2023 15:40:14 +0300
Message-Id: <20230302124015.75546-2-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230302124015.75546-1-y.oudjana@protonmail.com>
References: <20230302124015.75546-1-y.oudjana@protonmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yassine Oudjana <y.oudjana@protonmail.com>

Add a DT binding for the MT6735 top reset generation unit/watchdog timer.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 .../bindings/watchdog/mediatek,mtk-wdt.yaml     |  1 +
 include/dt-bindings/reset/mediatek,mt6735-wdt.h | 17 +++++++++++++++++
 2 files changed, 18 insertions(+)
 create mode 100644 include/dt-bindings/reset/mediatek,mt6735-wdt.h

diff --git a/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml b/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
index 55b34461df1b..009ccdb60b84 100644
--- a/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
@@ -22,6 +22,7 @@ properties:
       - enum:
           - mediatek,mt2712-wdt
           - mediatek,mt6589-wdt
+          - mediatek,mt6735-wdt
           - mediatek,mt6795-wdt
           - mediatek,mt7986-wdt
           - mediatek,mt8183-wdt
diff --git a/include/dt-bindings/reset/mediatek,mt6735-wdt.h b/include/dt-bindings/reset/mediatek,mt6735-wdt.h
new file mode 100644
index 000000000000..c6056e676d46
--- /dev/null
+++ b/include/dt-bindings/reset/mediatek,mt6735-wdt.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+
+#ifndef _DT_BINDINGS_RESET_MEDIATEK_MT6735_WDT_H_
+#define _DT_BINDINGS_RESET_MEDIATEK_MT6735_WDT_H_
+
+#define MT6735_TOPRGU_MM_RST		1
+#define MT6735_TOPRGU_MFG_RST		2
+#define MT6735_TOPRGU_VENC_RST		3
+#define MT6735_TOPRGU_VDEC_RST		4
+#define MT6735_TOPRGU_IMG_RST		5
+#define MT6735_TOPRGU_MD_RST		7
+#define MT6735_TOPRGU_CONN_RST		9
+#define MT6735_TOPRGU_C2K_SW_RST	14
+#define MT6735_TOPRGU_C2K_RST		15
+#define MT6735_TOPRGU_RST_NUM		9
+
+#endif
-- 
2.39.2

