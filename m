Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC63B6291D5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 07:29:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232163AbiKOG24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 01:28:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232093AbiKOG2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 01:28:44 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A7A5E58
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 22:28:43 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id d59-20020a17090a6f4100b00213202d77e1so15983018pjk.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 22:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9mBggjsv2GqBICe6FMg0nBv1QbzL30nQillIj133bFg=;
        b=h9HAx1RYCL+85yBECtCTWfMwgCWVLWezO7TR3xa2myoeE/9GBNy1GPd2bVXJTCyHmp
         RyF0Me4sutzi/qhfcY1o7pZhIMu0oNX4vDlc9AwIRTOVceoUFeGMdgeywaZLuC2h9L78
         zI72oGlO3pPDEik9pwTxZKO2t7TaeOm8hPFgA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9mBggjsv2GqBICe6FMg0nBv1QbzL30nQillIj133bFg=;
        b=achsKeGleJuUsj2krAj4zDAwEOfUfKTB7f21DxjkTpPnv7F/FRtT4jO8OU+B6XLCjl
         G+J47YT5aTbEJd+gjNeyfp8QYmmwvI/muw8GWX1XYU8pie37QBZMvTMl6IGbGeFWU5xy
         TjY6Jxko0fSsryqe33xBb0R8pyfjDwRyEajyFKSaMfdGRPaKFFLw1AoHonvS0e8HVjbS
         TiNgxiw4CcitC/gWMB1Gka1bwiKh2TsxTOsYvgovgPGMbiS1eS8kaSbRdUyiFbOYtSCa
         9vw8xwd4E5sN74dUIHAdVkg5iLXcUIPXWJxgsU1Fh1bSHe3kl1+mNR4ygvipqy8zsAay
         Cq9A==
X-Gm-Message-State: ANoB5pl7/V7Mo3qhsey4R6ELFr9TG/vQ169hHEBbcdA6ASRoJscxFBkF
        HRGkzILxS9wDQiaTzvPDWDZczQ==
X-Google-Smtp-Source: AA0mqf4ZdtG1c1bBiabETrFV/B9eVEfGZPHGV8dOCo600f5jtC6bKO7vj0k8zeTsi/9EXykc/lZyAA==
X-Received: by 2002:a17:90a:d985:b0:212:e891:f08d with SMTP id d5-20020a17090ad98500b00212e891f08dmr144456pjv.18.1668493723030;
        Mon, 14 Nov 2022 22:28:43 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:17d2:e181:950d:967a])
        by smtp.gmail.com with ESMTPSA id b22-20020a630c16000000b004351358f056sm6956372pgl.85.2022.11.14.22.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 22:28:42 -0800 (PST)
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
Subject: [PATCH v5 2/3] drm/bridge: anx7625: register content protect property
Date:   Tue, 15 Nov 2022 14:28:34 +0800
Message-Id: <20221115062835.3785083-2-hsinyi@chromium.org>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
In-Reply-To: <20221115062835.3785083-1-hsinyi@chromium.org>
References: <20221115062835.3785083-1-hsinyi@chromium.org>
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
v4->v5: no change
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

