Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD9B35FC949
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 18:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbiJLQ3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 12:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbiJLQ3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 12:29:12 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C04BDFBCF5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 09:29:07 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id h10so16729073plb.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 09:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zEdWcD+PQjJsMWbU+rPCMKkfbd3uH2dO24A3yRJKCPI=;
        b=hZmmn5tNlXiy4LGhQryxBGEcMEBfQTUNUsGBnm0oq66GNqtpe9fxY/DhKQ54G+FOkv
         QMCuobV4ZxzQL0RKJpPcRxuap15nTWDRbdFPA04S83ClBCF1e6PoJhzGl7dXd3bClIZg
         YC6dHlpZblOGq482JtVxwdfiffvk5y6zCTS3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zEdWcD+PQjJsMWbU+rPCMKkfbd3uH2dO24A3yRJKCPI=;
        b=dDDjKtrKfhUr43ioBb2H3Lpzvahe5y33JgATsHRX4t2WAg3xTdWQKnSiva6sK5Q2wV
         5TbVuBg5A2EbhPMWMiB6B94M/Xa4Du0fitGd5fT4uqya2zc+/tLKqqP1fifTLHWkIvCv
         jf2TP07pzMp3ucm2wpjA7gd75pFxe7Ohpjb+A9BHdK68vNiffJVpvdEhc6Q06ok2m5aJ
         to2DYYYSOh8/7nN2Pb/T10tl03F28pjKrYJ0VsRNDOuH1UGtCQ5wvG8AQashjzemYKaD
         wkm8aaFC0whjm8KhhJzlEO4hqTaGTaV4R0AsjaTbtWPLI8wsfl/z33UcY3unhQzXBoL1
         /lMA==
X-Gm-Message-State: ACrzQf0xGdfQH9C+Mbmyv4rk0V2Q+DxjvkXMtDllQkf1UelgRJME20nN
        wI4qa2E1dW0cTJbYs7sBKyhVHQ==
X-Google-Smtp-Source: AMsMyM7B804zXyZ/q0Uyus/SbQjVuKl9zAvAwF04Rv9koXL1sV1gaVGkBT56mWBvmiM/3YmIPS+UDw==
X-Received: by 2002:a17:902:6907:b0:179:c9bc:dd73 with SMTP id j7-20020a170902690700b00179c9bcdd73mr30805355plk.159.1665592146555;
        Wed, 12 Oct 2022 09:29:06 -0700 (PDT)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:2921:f6a9:5848:18e1])
        by smtp.gmail.com with ESMTPSA id l4-20020a635704000000b0045dc85c4a5fsm9722163pgb.44.2022.10.12.09.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 09:29:05 -0700 (PDT)
From:   Pin-yen Lin <treapking@chromium.org>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Pin-yen Lin <treapking@chromium.org>,
        Allen Chen <allen.chen@ite.com.tw>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Hermes Wu <hermes.wu@ite.com.tw>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Clean up it6505 driver and improve synchronization
Date:   Thu, 13 Oct 2022 00:28:56 +0800
Message-Id: <20221012162900.2876686-1-treapking@chromium.org>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
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

The main purpose of this series is to improve the synchronizations of
it6505 driver. The first two patches are required for the third one, but
they alone can be clean ups to the driver.


Pin-yen Lin (3):
  drm/bridge: it6505: Initialize AUX channel in it6505_i2c_probe
  drm/bridge: it6505: Setup links in it6505_irq_hpd
  drm/bridge: it6505: Improve synchronization between extcon subsystem

 drivers/gpu/drm/bridge/ite-it6505.c | 99 +++++++++++++----------------
 1 file changed, 44 insertions(+), 55 deletions(-)

-- 
2.38.0.rc1.362.ged0d419d3c-goog

