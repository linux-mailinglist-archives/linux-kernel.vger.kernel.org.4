Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00AF66E30DE
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 12:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbjDOKsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 06:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbjDOKsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 06:48:05 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC8E6A72;
        Sat, 15 Apr 2023 03:47:36 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id xd13so17954212ejb.4;
        Sat, 15 Apr 2023 03:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681555625; x=1684147625;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O04Ye2MzXp7QKEfSemVWElXkh5JGH4p8WqqP9d/MZSE=;
        b=QZ2NGevF4bpWez9gHLYQPb3kG98YPHW3Dxiczr4FnG7PJcfpWiPdmDcQOHTbP37dbF
         groLwOQ9YguDs/v1WdalPZoJz2XFoeEgSuj19V1VKwKqZE5EhYXEWh/zfw1v+9GRAPdj
         k+AevlVI1t361tdpOE77dqxw2u85ij0tefIDjWbrQimHCWj+Gavslz+V+A+2ZrO2X8Wt
         G1lY0wYGd8RYOIrCNRim9Ed4DFIVQ0u700KG/MF3AWBQjHH4nhE3GunEcp6emqfckeTy
         V8aRYSincLppnfKgTfGsBca13Kc07lCZR8nAI/dCyx/zlHxtGjd9iB3X7Foj2yi0sQru
         kxmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681555625; x=1684147625;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O04Ye2MzXp7QKEfSemVWElXkh5JGH4p8WqqP9d/MZSE=;
        b=RF8WJHM7QeTmAF+QxzAWprf5hHexaNNeAW1ngybWXeEUIojKZAbW/cTqMZswqSzUWr
         0yS6XmX19iutgkPcbbDHnZpn4Yru97kUdYvQL3KMdaKoiZCzN8c59CmsvlpMSPNv6N+v
         v8R40ABlqICyORIa2ngRNdFz4A3bUJQqRGfbkjeACMTQ/jDgGzMe0EV9mXOOql6ogmIo
         ME/+8UFk2aKHPe0iGNoT0oEGf10azTx+EiWD5b0ZaL0AzAo5+WXatBJMrodcyy2cryJ9
         5+N5QnavPYsT5dhAn6JfM+B0ZGLjQ2/0ZsfcKRxSt1vc7m9n2zF+469BST3wFNZVpe5a
         4Huw==
X-Gm-Message-State: AAQBX9eiXj7Nvs81fKbxEbXFwyst+oqFj4Llp7FCGuyvG3sVBYukA9EQ
        yU2qIw62f2U5FQv2CT1VNA8=
X-Google-Smtp-Source: AKy350bwZkPIK+M4puxUx9p8YTSxs9X8ypJVNYd5v62q6WmJKob3N+gncOYlcJY70GiMJz9RM8YuZw==
X-Received: by 2002:a17:906:ad87:b0:94a:4b7a:9886 with SMTP id la7-20020a170906ad8700b0094a4b7a9886mr1727708ejb.12.1681555625592;
        Sat, 15 Apr 2023 03:47:05 -0700 (PDT)
Received: from localhost.localdomain (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id m15-20020a170906720f00b00947ab65d932sm3607034ejk.83.2023.04.15.03.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Apr 2023 03:47:05 -0700 (PDT)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     andrzej.hajda@intel.com, neil.armstrong@linaro.org,
        rfoss@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org,
        samuel@sholland.org
Cc:     Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-media@vger.kernel.org,
        hverkuil-cisco@xs4all.nl, Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH 2/3] drm/bridge: dw_hdmi: Handle snps,disable-cec property
Date:   Sat, 15 Apr 2023 12:46:12 +0200
Message-Id: <20230415104613.61224-3-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230415104613.61224-1-jernej.skrabec@gmail.com>
References: <20230415104613.61224-1-jernej.skrabec@gmail.com>
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

New DT property allows to skip CEC initialization.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index 603bb3c51027..e7e8199d2fb1 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -3615,7 +3615,9 @@ struct dw_hdmi *dw_hdmi_probe(struct platform_device *pdev,
 		hdmi->audio = platform_device_register_full(&pdevinfo);
 	}
 
-	if (!plat_data->disable_cec && (config0 & HDMI_CONFIG0_CEC)) {
+	if (!plat_data->disable_cec &&
+	    !of_property_read_bool(np, "snps,disable-cec") &&
+	    (config0 & HDMI_CONFIG0_CEC)) {
 		cec.hdmi = hdmi;
 		cec.ops = &dw_hdmi_cec_ops;
 		cec.irq = irq;
-- 
2.40.0

