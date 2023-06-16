Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FCDE7330EE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 14:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345294AbjFPMNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 08:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjFPMNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 08:13:47 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 125F3294C
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 05:13:46 -0700 (PDT)
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com [209.85.167.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id A51FA3F33C
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 12:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1686917624;
        bh=jjkvjCGEAka4RH5igFy+6Ctmq+VoeIh047CD5mFgF2Q=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=ihpz2129s7nzWiWff+40TiX4Ji/wAWeYyb6POaPA1A55KCDg7ZIy5KzFKBXqM25M1
         3Ogj9cffT3syOdNeZARnUHiaNMF7D2CD22DaX9zAT9gHQGxTrUHtI0NbJTLVtuWjBw
         U3IsOl6Pr+i1paz42lTRxRyEmbA73Hlqi31K9H4kPoi/3ep4P4hf/QvxnELTQ0p8D+
         YWDIxiRtKdOoza7q/qPOUNDlw2OTrGp31XaxBQ5sBtgYpJbIgrqTgQWEr7LOa2d9bJ
         kh2rWfvlRX73AMA3pRQUGRQwq1MTqop8K1rI3OSMt80jzZE/eEGH+oG2RSfQv5yODD
         4e/iNTzO7lgkg==
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-4f6255b3cd3so511979e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 05:13:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686917624; x=1689509624;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jjkvjCGEAka4RH5igFy+6Ctmq+VoeIh047CD5mFgF2Q=;
        b=VXM0UCdalrGu5EBYwutR285zOjrYoXeMeOtjmVLkFwC2cKbz8DNLTOjETO2hfsaBo2
         3uc23ZVJQoqrhrHu1mrI2EQRKmTPjo/PyUtLTSsbdGN/3g0PoWqp6/CfOMH1gMRXgkwA
         Dui6LZSmCdAvO+kKkLDmNQmNaH7lkvyhb02hlUwhS6y+uD3USZk6IMaa+fM34L4GsC2i
         ubD8U+DIFhvnBWyhhQqEzMSavqhwZrmvIwd0b7eKzn//Gbo7+TIoAf75F2HEOatPUhN7
         rB3cFewiJKgB/+cVOSOfx6/zk4Png+NdDR+70TN6hzSLFRDo++6RNUovLxvSyFrPqssC
         EPCg==
X-Gm-Message-State: AC+VfDyqAunsYUnsqew4XarR19svsyC0ZzDwMwA/uYaoQrP8EzfKO0QM
        AsCF4+RnhBwAycSSqAOHQ1exCSW/jQPNOiMzGDJ9+V8zlw71Kxbby8zJ6doBG0ulV+ONNrof60k
        vRFhe2iYErbBTzmF+Pbof1WOBWKn6Ar6Aq1XFfYe1zQ==
X-Received: by 2002:a19:6d0e:0:b0:4f8:4240:5308 with SMTP id i14-20020a196d0e000000b004f842405308mr1048770lfc.42.1686917624166;
        Fri, 16 Jun 2023 05:13:44 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ700sMZllYAWkxyIgKy/64sfYN91WIU+FJW9c47JxophbF/4xNj1sw9O0R778sGm02TsDe1mw==
X-Received: by 2002:a19:6d0e:0:b0:4f8:4240:5308 with SMTP id i14-20020a196d0e000000b004f842405308mr1048751lfc.42.1686917623807;
        Fri, 16 Jun 2023 05:13:43 -0700 (PDT)
Received: from localhost ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id f13-20020a7bcd0d000000b003f7ba52eeccsm2047601wmj.7.2023.06.16.05.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jun 2023 05:13:43 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
To:     andrzej.hajda@intel.com, neil.armstrong@linaro.org,
        rfoss@kernel.org, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@gmail.com, airlied@gmail.com,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org,
        Juerg Haefliger <juerg.haefliger@canonical.com>
Subject: [PATCH] drm/bridge: lt9611uxc: Add MODULE_FIRMWARE macro
Date:   Fri, 16 Jun 2023 14:13:41 +0200
Message-Id: <20230616121341.1032187-1-juerg.haefliger@canonical.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The module loads firmware so add a MODULE_FIRMWARE macro to provide that
information via modinfo.

Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>
---
 drivers/gpu/drm/bridge/lontium-lt9611uxc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
index 583daacf3705..6b2a4f8d6f78 100644
--- a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
+++ b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
@@ -1019,3 +1019,5 @@ module_i2c_driver(lt9611uxc_driver);
 
 MODULE_AUTHOR("Dmitry Baryshkov <dmitry.baryshkov@linaro.org>");
 MODULE_LICENSE("GPL v2");
+
+MODULE_FIRMWARE("lt9611uxc_fw.bin");
-- 
2.37.2

