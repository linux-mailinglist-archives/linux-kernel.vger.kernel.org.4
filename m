Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 278145FD809
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 13:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiJMLE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 07:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiJMLEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 07:04:20 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D69C10B785
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 04:04:19 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id c20so1490517plc.5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 04:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NvbS/I8HlQoCFmjUFv0JtyT8eokdGYfA7wkL/lpFTWg=;
        b=Ay0J5G8NHLTOS6rXjLmiS8l9zTWmvHczbyNjwYRvR1qHrImNmrH1jY3wMiBONvPwm7
         7d61qgwf98/EqlwVd/mq+mqym9Goz9iqrqsVaezDsWE0Sljlcf7xwaCfGf4hUL/eN6ZW
         uaj9TlPhDqmQaOXG3ZBWqgI3oiS7Fns5x968k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NvbS/I8HlQoCFmjUFv0JtyT8eokdGYfA7wkL/lpFTWg=;
        b=jBgusorhBXkX8flwAjBBKLUSEnIKGzG+AWWBEmGFBrLqdbpuLmb/MzHmA1nY2iVV+z
         0hOhs8GJpW80+lDdU9c3f6SS2CB5FYo7mJ1DxtelI+D/jMShMhuG6VnUIRy2h6UWjRkl
         tm34kJtxaPStPOz08/vHwnJxMe46bIHH0shw6oFPM3PnHfmlftJ58EjbFA6FXubNC+KS
         Fz8nMaHF6yc9D9cJbPotRj29zS+ASERsWeSYM9I6LenQI1tnvnvbUyEkStKCyU1OWKMu
         6SS8WpMeHv8Gbl1rLLKyGsbWTGt0pk76mAwaPIJ6p/1ID9X+JdsFfSmEu5HdFr9/QGFI
         wW+w==
X-Gm-Message-State: ACrzQf23r1/5YofOKYNaDh+TLxdFPVlkWMdI6NTdDJH9UgJCXjqWrDEh
        2afVSdy059o6ugBL+JbZZNkhNg==
X-Google-Smtp-Source: AMsMyM6lUXvMM5tpyfSOIQtS1+CZpp68m5DYgKdzV5fiouCWtlb7eX/ojNAakZQwNCRsgJS2BE/c2Q==
X-Received: by 2002:a17:90b:23c5:b0:20b:1cb4:2ca9 with SMTP id md5-20020a17090b23c500b0020b1cb42ca9mr10755124pjb.139.1665659058897;
        Thu, 13 Oct 2022 04:04:18 -0700 (PDT)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:4b90:18ed:8d41:7622])
        by smtp.gmail.com with ESMTPSA id o11-20020a17090ab88b00b0020af2411721sm2914794pjr.34.2022.10.13.04.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 04:04:18 -0700 (PDT)
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
Subject: [PATCH v2 0/3] Clean up it6505 driver and improve synchronization
Date:   Thu, 13 Oct 2022 19:04:07 +0800
Message-Id: <20221013110411.1674359-1-treapking@chromium.org>
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

Changes in v2:
- Remove redundant spaces in it6505_detect
- Read sink count in it6505_irq_hpd
- Add the empty line back

Pin-yen Lin (3):
  drm/bridge: it6505: Initialize AUX channel in it6505_i2c_probe
  drm/bridge: it6505: Setup links in it6505_irq_hpd
  drm/bridge: it6505: Improve synchronization between extcon subsystem

 drivers/gpu/drm/bridge/ite-it6505.c | 106 +++++++++++++---------------
 1 file changed, 51 insertions(+), 55 deletions(-)

-- 
2.38.0.rc1.362.ged0d419d3c-goog

