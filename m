Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BECF62D90C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 12:09:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239812AbiKQLJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 06:09:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239734AbiKQLIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 06:08:15 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCCDF42987
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 03:08:11 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id q1so1639189pgl.11
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 03:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9adTC/kCnTAWZTCymBogkO2KVEPuyw81zYQPMZxxoSo=;
        b=RuLMYR/7GIUlRh1mNcPgSb0/ogtrlYZLLuQLzBZM/cfwz01+rqe0iqeUeS/oXZ2/n+
         VlevcOghg3lFqNrl7iEEHHgvKdDffYOe2ShXsXSylfV9oMoM105qreZo9uEPdaFVVVdR
         RbdlIxs2BBKDo1mqk5/u+LrdZ1Hxmxqmsp3mg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9adTC/kCnTAWZTCymBogkO2KVEPuyw81zYQPMZxxoSo=;
        b=dR8MXkm3WiGLGiHoHqHM7JXHYVOdUPtShxW0pZBL/vB6GVW1PF/hmWIpgTEBT7BTeB
         syfLf2Ok3VmfEoAIZUjoJZIbfNT4nTlRgM+xvj/zl8P/KpGVsNZa5CF2mDZ5vmkQ7A/H
         tZLfAcyCdba/YnApsbTUpDaqQUdV4no2SRl7bvZ1CqtyiNf3ZXc1TFITknETkbU5msjT
         e3LKfQKkmzoAPQhEgdFE8/SpTP8L2dbk0kaK+1RYAFJMfiucPl2MQWEFXchc3qanfSoc
         gQYrvwv8KrQ5hGYRcj3IGu95pTzzK7vNJ+5g1SmL/vZgi+DGMX3oCcpHzaC2yWw0kKK9
         HK4Q==
X-Gm-Message-State: ANoB5pn6xM4ffDiBGGwBfAJ21SxGHNIA8YKfQYlV3/h6P0j0GpWI2FBB
        zh3ZtpHxub9vqjnAmGrf2gHNFBZxX0UUIw==
X-Google-Smtp-Source: AA0mqf5UvhJh1+5BA+ftKIjgtSrH/nEpcIRbmgpRI80uU8ijBGEp1TdPaC/eD3sh7ZMlCOAopARHuQ==
X-Received: by 2002:a63:180a:0:b0:470:63e5:5c59 with SMTP id y10-20020a63180a000000b0047063e55c59mr1579787pgl.172.1668683291132;
        Thu, 17 Nov 2022 03:08:11 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:e678:c7f5:9cb3:1a06])
        by smtp.gmail.com with ESMTPSA id z18-20020a170902ccd200b0017a032d7ae4sm1025540ple.104.2022.11.17.03.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 03:08:10 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Sean Paul <seanpaul@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Robert Foss <robert.foss@linaro.org>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Allen Chen <allen.chen@ite.com.tw>,
        David Airlie <airlied@gmail.com>
Subject: [PATCH v6 2/3] drm/bridge: anx7625: register content protect property
Date:   Thu, 17 Nov 2022 19:08:03 +0800
Message-Id: <20221117110804.1431024-2-hsinyi@chromium.org>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
In-Reply-To: <20221117110804.1431024-1-hsinyi@chromium.org>
References: <20221117110804.1431024-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set support_hdcp so the connector can register content protect proterty
when it's initializing.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
Reviewed-by: Sean Paul <seanpaul@chromium.org>
---
v5->v6: no change.
---
 drivers/gpu/drm/bridge/analogix/anx7625.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
index b0ff1ecb80a5..0636ac59c739 100644
--- a/drivers/gpu/drm/bridge/analogix/anx7625.c
+++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
@@ -2680,6 +2680,7 @@ static int anx7625_i2c_probe(struct i2c_client *client,
 	platform->bridge.type = platform->pdata.panel_bridge ?
 				    DRM_MODE_CONNECTOR_eDP :
 				    DRM_MODE_CONNECTOR_DisplayPort;
+	platform->bridge.support_hdcp = true;
 
 	drm_bridge_add(&platform->bridge);
 
-- 
2.38.1.431.g37b22c650d-goog

