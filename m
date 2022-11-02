Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24C7D616189
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 12:14:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbiKBLNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 07:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiKBLNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 07:13:06 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA722793E
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 04:12:53 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id v17so13228650plo.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 04:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1OuwW2usJdNl/cGqK4nMOpD/moR27gN+SLRJ4Leuu4k=;
        b=dRw3oxn3H53aACjL3GYfw7dtwdvsMK1880QSOHc59/ENT8bkAlKRHZT/hOalamoG8/
         9lc50vfEbZWhSJJZjkhZLOmtLUSU31heslpkhmNAjYYxFkXjS8j/5WSP4db2CM/uG950
         Hl4ntpNuQxjSezhjmi+JIW4nge0sJbjJM0mrk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1OuwW2usJdNl/cGqK4nMOpD/moR27gN+SLRJ4Leuu4k=;
        b=Jo1IsgZ0QsVoa7uKl3d5Bijqbf8J48CbeXpQEDB+5vcyqoZkl3RqRBbE0AgAUx28zP
         sY/CeKOUwI9Lj41vvCpTffjMZulE3zgcMuQBfYMmhtL6BXUo5k9JMXUB1WGABdEihTQw
         7bpSUsR5E8GibfqyuCbZtoNBFDvTAluVEkC4pYl3W4tBg/3ID48LdcNqIhrN9rttCrEE
         ts5LtX9MzuCFTGbAP9QzIGNWuWgropJyAZRcrteaWPbeKy+oynsJLWHrvt6MYz/h5NyZ
         /155gbyPt/CidbNpW/r3x6MtrZmiGOWP76VGQtZmMxKlQ0AVh3xetCscaAs7yGqzu5p/
         MpoQ==
X-Gm-Message-State: ACrzQf3wWGsSrMVxUrL29slfALNPEr2BQHKfP0Irm0uYhZtbhvW2GCz5
        zn+4ur0NH7L37RGCfsmSQef+gQ==
X-Google-Smtp-Source: AMsMyM5kCsXr8PIzvmvnr/4VaFllwoBCEHVIe32zo8K09x0XPU02eVQneRy/Zg3f6cB6QlU9qF/Exw==
X-Received: by 2002:a17:90a:ca13:b0:213:b85a:3bdb with SMTP id x19-20020a17090aca1300b00213b85a3bdbmr21181722pjt.97.1667387514709;
        Wed, 02 Nov 2022 04:11:54 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:c30f:38e9:6ba:158b])
        by smtp.gmail.com with ESMTPSA id z20-20020aa79f94000000b0056246403534sm8251048pfr.88.2022.11.02.04.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 04:11:54 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Douglas Anderson <dianders@chromium.org>,
        Sean Paul <seanpaul@chromium.org>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] drm/bridge: anx7625: register content protect property
Date:   Wed,  2 Nov 2022 19:11:47 +0800
Message-Id: <20221102111148.1810314-2-hsinyi@chromium.org>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
In-Reply-To: <20221102111148.1810314-1-hsinyi@chromium.org>
References: <20221102111148.1810314-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
---
 drivers/gpu/drm/bridge/analogix/anx7625.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
index b0ff1ecb80a50..0636ac59c7399 100644
--- a/drivers/gpu/drm/bridge/analogix/anx7625.c
+++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
@@ -2680,6 +2680,7 @@ static int anx7625_i2c_probe(struct i2c_client *client,
 	platform->bridge.type = platform->pdata.panel_bridge ?
 				    DRM_MODE_CONNECTOR_eDP :
 				    DRM_MODE_CONNECTOR_DisplayPort;
+	platform->bridge.support_hdcp = true;
 
 	drm_bridge_add(&platform->bridge);
 
-- 
2.38.0.135.g90850a2211-goog

