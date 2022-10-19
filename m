Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDAB46039B5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 08:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbiJSGVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 02:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiJSGVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 02:21:00 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02E3E61DBD
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 23:20:59 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id n83so18145366oif.11
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 23:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QWZltT5Ik1403xLpYJWPCmlVFaiq2fqaz9yBCJYjcXI=;
        b=fHHz7Xzk5lYdiEDvHwu2jd21UdKcxPmzwJbiub7ibFHkmtsyteKF7RVeuJzxaHAhDX
         zetJ72PEeG8Sp6YVg5VSxQicLtOOjM1dVacrGrbAhczDxSxu9JP01G10ZvvpQ9vyyPLZ
         e95Ppe8WfALhzSbLN1l0LXT+pyzGo8OlieGSM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QWZltT5Ik1403xLpYJWPCmlVFaiq2fqaz9yBCJYjcXI=;
        b=h7Zmt86mD7HcIN0XSNFb3021d8T68vQse0lsc05frYXWoIVky+bWtMiMtCtjCPdgbk
         Bd8iFbHOEhhBV2GIMerb3I2eZscaDJiLhMOhXUao09OVcUSaETUL8gUTOPDbtIWNKQ3K
         EBWa5EG00hVkJ7Mf0J135hJaaOfTCHwsgpA2wq4v9WexKnY2fVd1LjCow6nFeAC12aWX
         EdLa8jz2CijgXm5yUHVvZ/ygBaxrkYzjd9zivNxntPuqwsqZGmWwImSJE+c22yXkn/IH
         CMeo0XJnply8vzmbi74NQmzIdrq8tEjjStkDx+J99flthRzJEbUAEfCPlfg/DaYVVngy
         m2gQ==
X-Gm-Message-State: ACrzQf3e26u7CFoYxo7yPyAoZlwCzh4LWhxTawPANSLMeaFQOoNexz+N
        dX3p0mP7ZHrlo7o9mBQihj1yFH5/YFTyHQ==
X-Google-Smtp-Source: AMsMyM5BvfkKcU86WNyaqzZgxnMa/8bi2ufukanMVEw2tKbJ6454+6pNOJAwp/pQAra0ihyl78QhkQ==
X-Received: by 2002:a17:90b:254e:b0:20b:7e26:f0a0 with SMTP id nw14-20020a17090b254e00b0020b7e26f0a0mr42047837pjb.203.1666160447265;
        Tue, 18 Oct 2022 23:20:47 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:39a:c061:1f1:ca67])
        by smtp.gmail.com with ESMTPSA id mg2-20020a17090b370200b0020d9ac33fbbsm9346563pjb.17.2022.10.18.23.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 23:20:46 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Sean Paul <seanpaul@chromium.org>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/mediatek: mtk-dpi: register content protect property
Date:   Wed, 19 Oct 2022 14:19:37 +0800
Message-Id: <20221019061936.3599965-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register content protect property in drm so that bridge can update
the property from userspace request.

HDCP property needs to be created after the connecter is initialized
and before the connector is registered. Since some bridge may be
attached without connector, register this property in drm driver if
CONFIG_DRM_DISPLAY_HDCP_HELPER is defined.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
Context: https://lore.kernel.org/lkml/20221012042030.573466-1-hsinyi@chromium.org/T/
---
 drivers/gpu/drm/mediatek/mtk_dpi.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
index 508a6d994e831..3374ebe82aeb2 100644
--- a/drivers/gpu/drm/mediatek/mtk_dpi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
@@ -18,6 +18,7 @@
 
 #include <video/videomode.h>
 
+#include <drm/display/drm_hdcp_helper.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_bridge.h>
 #include <drm/drm_bridge_connector.h>
@@ -799,6 +800,15 @@ static int mtk_dpi_bind(struct device *dev, struct device *master, void *data)
 		ret = PTR_ERR(dpi->connector);
 		goto err_cleanup;
 	}
+
+#if defined(CONFIG_DRM_DISPLAY_HDCP_HELPER)
+	ret = drm_connector_attach_content_protection_property(dpi->connector, true);
+	if (ret) {
+		dev_err(dev, "attach content protection: %d\n", ret);
+		return ret;
+	}
+#endif
+
 	drm_connector_attach_encoder(dpi->connector, &dpi->encoder);
 
 	return 0;
-- 
2.38.0.413.g74048e4d9e-goog

