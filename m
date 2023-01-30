Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 496A0680AC6
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 11:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236039AbjA3K07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 05:26:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236442AbjA3K0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 05:26:45 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65DFF30B36
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 02:26:41 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id t7so2204935wrp.5
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 02:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZPoBz9/1/N6ODRgUu0zywPKZ5Pb9peKUsXrjhFsletU=;
        b=ZRyN6STZ1TLPVz4LQ6q3JE4PIWOJj1I9SrDzQgnNUxCnJuucnPb47K5T+FT5VJqJhK
         O7/cyqU8K6RTZ+xoZ92FBBgXMi1SXmIumyAw3zE49VeVoVkCg+xC4bMIp9CwVBpGwgV+
         y1MxJbFLq0iCWns2b+hVFDDcpyNc720nV1LmafAtHn/n2W96sBotkpDyOvna77pG9sP6
         pPdfwpT2P+ZdYR6Qk6guRYpEpokyLcJ7bBJ2yNGthRpuCqIw7AOsVGJ/Yib4yo/Oh8fN
         FVTH/apMKrbFOcEOzGxtAc29B7xT//JupyxHXJDrXcqSVdyNziI2+Z/zZVg0y0FIe7Fe
         jywQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZPoBz9/1/N6ODRgUu0zywPKZ5Pb9peKUsXrjhFsletU=;
        b=5o3K6I5MEp4rDVw8nBp1nBRyZGu1kdvgK9aYRCwQxXsBfF54W/t2RiGcM9aswQndCi
         wFtoCcdl0QPZIc3Sg2gTqxA2ShDVm4l26fUeN7VKcN3KCpA8x6xQ7hKS6jsJFxm0YoHY
         ty1Y3hW633AdLrtCnGvU+KqdEFOFcWoLlmvNbuVaue2TXpqR6EJrI4JvR5/rEFbNbBWz
         9CfJw+NaAISnz5gyNKjCbtMk+zfqe+eH9TyFFIOlU86OqnwaX9eboFgjFlMEDbqA8EVT
         mBGtvCUrGmRn6rNfOMMn8ICTik+tuk8S34z8yxRCvsCxFhCit4PXL6eff+0jht1fZ4rO
         NaIw==
X-Gm-Message-State: AFqh2koGL4oF8BpCKEXu1R+xhcxvqRhjBlID9dE+msgbKqbI+VZNiFXk
        6+GwWEtJpOret+/jGGrhwa0Pqg==
X-Google-Smtp-Source: AMrXdXsW7ZQDGKlzFTYhQEjR+p+Zk8AHHZFaUSI9MHLnvUkGztcTA7MZHFFlS/Gqk/Zh0lJ9wDVJ1g==
X-Received: by 2002:a05:6000:1e18:b0:2bc:846a:8ead with SMTP id bj24-20020a0560001e1800b002bc846a8eadmr46483687wrb.37.1675074399921;
        Mon, 30 Jan 2023 02:26:39 -0800 (PST)
Received: from alex-T14.baylibre (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id s5-20020a5d5105000000b002bdfcd8c77csm11426785wrt.101.2023.01.30.02.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 02:26:39 -0800 (PST)
From:   Alexandre Bailon <abailon@baylibre.com>
To:     yong.wu@mediatek.com, joro@8bytes.org, will@kernel.org
Cc:     robin.murphy@arm.com, matthias.bgg@gmail.com,
        krzysztof.kozlowski@linaro.org, robh+dt@kernel.org,
        iommu@lists.linux.dev, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Alexandre Bailon <abailon@baylibre.com>
Subject: [PATCH 3/3] dt-bindings: iommu: memory: Use unmanaged iommu domain for the APU
Date:   Mon, 30 Jan 2023 11:27:22 +0100
Message-Id: <20230130102722.133271-4-abailon@baylibre.com>
X-Mailer: git-send-email 2.38.2
In-Reply-To: <20230130102722.133271-1-abailon@baylibre.com>
References: <20230130102722.133271-1-abailon@baylibre.com>
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

This updates the iommu id to use unmanaged iommu domain for the APU.
This is required by remoteproc to use the iommu.

Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
---
 include/dt-bindings/memory/mediatek,mt8365-larb-port.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/dt-bindings/memory/mediatek,mt8365-larb-port.h b/include/dt-bindings/memory/mediatek,mt8365-larb-port.h
index 56d5a5dd519e7..86d82a8f6017d 100644
--- a/include/dt-bindings/memory/mediatek,mt8365-larb-port.h
+++ b/include/dt-bindings/memory/mediatek,mt8365-larb-port.h
@@ -24,8 +24,8 @@
 #define M4U_PORT_MDP_WROT0		MTK_M4U_ID(M4U_LARB0_ID, 7)
 #define M4U_PORT_MDP_RDMA1		MTK_M4U_ID(M4U_LARB0_ID, 8)
 #define M4U_PORT_DISP_FAKE0		MTK_M4U_ID(M4U_LARB0_ID, 9)
-#define M4U_PORT_APU_READ		MTK_M4U_ID(M4U_LARB0_ID, 10)
-#define M4U_PORT_APU_WRITE		MTK_M4U_ID(M4U_LARB0_ID, 11)
+#define M4U_PORT_APU_READ		MTK_M4U_UNMANAGED_ID(M4U_LARB0_ID, 10)
+#define M4U_PORT_APU_WRITE		MTK_M4U_UNMANAGED_ID(M4U_LARB0_ID, 11)
 
 /* larb1 */
 #define M4U_PORT_VENC_RCPU		MTK_M4U_ID(M4U_LARB1_ID, 0)
-- 
2.38.2

