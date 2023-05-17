Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8174E706BC8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 16:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232258AbjEQOxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 10:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232197AbjEQOxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 10:53:11 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F39F8684
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 07:52:53 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id 5b1f17b1804b1-3f4c6c4b51eso8852465e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 07:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1684335171; x=1686927171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9mr1L/m4ima+2h/NhXtcjqbHddpi6u41EWoGArxh1iQ=;
        b=pdG2+3ODw0cGuNg/LORzvNsUqX1IiweDfrWioVGocQZDWZOWLRqkDaX4MTzyiQe1c7
         pkyEeUQ7xqMrhFPqgtTXbdZp3T0rwW0l0BIMsILSnzXcX/Sd7NVDoMo/aiSxsYvHmvbE
         9CFhqMy1vU2U8NqgvLhl8WgFol9WpTF6r6EFUqq/RKyHw1v7dAJHBpN4C35EGlhKFu2m
         bv8X2zua8yim+q2TU1Nwjf+yYUMToKg1IrzAFE9ZZPxUgS9V2JJXJY3xZezoYKEGwVXh
         5JUMdyDg8DXWWvuNp3X07uEX8GvfXlSZm2H1ourLwVfh0bfHuRQHtAUbRtnalP8rK24w
         5aJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684335171; x=1686927171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9mr1L/m4ima+2h/NhXtcjqbHddpi6u41EWoGArxh1iQ=;
        b=FK91trCQ77mNNXTeBVMRVzCXMwHbab9B48/lOkACQC5H+ApKxIlth4JEPejEDXZXrK
         Tc6PVwmaWOENtnGHi+mt+G+bakUpWfnZUpfob+s/GygGhnYjS96bu70M43bUQU/4JHvT
         8q04YrI527YNSqniOdz9ktGKOVTyVJzmkn0afWM+01VVkcRYky/5ij5wjBv3BkH/ja2h
         V7UTB2Ve0ca495FubUBbkkzJZj585s8FXxeZKvxL1zQWgkvjb7xm5jxfOEKHRBx3Rw25
         NjN2w3tuU0+PFtv7UhaJMvIDXS1zMolXUKoSMSAwgCb8/gFvUbbRp/saNnw6dHMc7EJp
         XBRQ==
X-Gm-Message-State: AC+VfDwm9KELZCYcC4ZdkLFFpyzwKqlGJVBC1NyWj+YkO5R9tXvx2b1e
        PJAovpPfugCcLv0bQGbfZrsR3w==
X-Google-Smtp-Source: ACHHUZ7D+XIYOY7fwEt1VA+EKenIzVfyhPoXQPx4ACohe42JP1CZtzERdmroTv625PctD16NHx1kmg==
X-Received: by 2002:adf:e450:0:b0:307:97dd:1de2 with SMTP id t16-20020adfe450000000b0030797dd1de2mr930581wrm.25.1684335171626;
        Wed, 17 May 2023 07:52:51 -0700 (PDT)
Received: from blaptop.baylibre (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id v11-20020a5d678b000000b002f7780eee10sm2979098wru.59.2023.05.17.07.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 07:52:51 -0700 (PDT)
From:   Alexandre Bailon <abailon@baylibre.com>
To:     airlied@gmail.com, daniel@ffwll.ch,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, sumit.semwal@linaro.org,
        christian.koenig@amd.com, jstephan@baylibre.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, khilman@baylibre.com,
        nbelin@baylibre.com, bero@baylibre.com,
        Alexandre Bailon <abailon@baylibre.com>
Subject: [PATCH 7/7] dt-bindings: Add bidings for mtk,apu-drm
Date:   Wed, 17 May 2023 16:52:37 +0200
Message-Id: <20230517145237.295461-8-abailon@baylibre.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230517145237.295461-1-abailon@baylibre.com>
References: <20230517145237.295461-1-abailon@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the device tree bindings for the APU DRM driver.

Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
Reviewed-by: Julien Stephan <jstephan@baylibre.com>
---
 .../devicetree/bindings/gpu/mtk,apu-drm.yaml  | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpu/mtk,apu-drm.yaml

diff --git a/Documentation/devicetree/bindings/gpu/mtk,apu-drm.yaml b/Documentation/devicetree/bindings/gpu/mtk,apu-drm.yaml
new file mode 100644
index 000000000000..6f432d3ea478
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpu/mtk,apu-drm.yaml
@@ -0,0 +1,38 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/gpu/mediatek,apu-drm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: AI Processor Unit DRM
+
+properties:
+  compatible:
+    const: mediatek,apu-drm
+
+  remoteproc:
+    maxItems: 2
+    description:
+      Handle to remoteproc devices controlling the APU
+
+  iova:
+    maxItems: 1
+    description:
+      Address and size of virtual memory that could used by the APU
+
+required:
+  - compatible
+  - remoteproc
+  - iova
+
+additionalProperties: false
+
+examples:
+  - |
+    apu@0 {
+      compatible = "mediatek,apu-drm";
+      remoteproc = <&vpu0>, <&vpu1>;
+      iova = <0 0x60000000 0 0x10000000>;
+    };
+
+...
-- 
2.39.2

