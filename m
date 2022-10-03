Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A61F5F280F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 07:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbiJCFDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 01:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiJCFDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 01:03:50 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D89A226ACA
        for <linux-kernel@vger.kernel.org>; Sun,  2 Oct 2022 22:03:46 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id z20so2196534plb.10
        for <linux-kernel@vger.kernel.org>; Sun, 02 Oct 2022 22:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=SKy3cphhGQOtK4Xw6hd/Ts0fN078Qz7EqtaRCbvqhGk=;
        b=evF13t2H4/zBulXqbx8awpnC7qze9+BdxG1hE8KwU+XFR0yd/OBV8HlrqObrvWI5YE
         qSi3E31cSjfxOnb4yNCdveHbiPD5ZBpnHK9nXaFqXS9QB46PnE7ZpcbUGwPMmhr/ZiAj
         SytNbXNLJhCiNtS6dMhYA7bGsSk3BI4EQcmOU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=SKy3cphhGQOtK4Xw6hd/Ts0fN078Qz7EqtaRCbvqhGk=;
        b=w/4RgVwU59O/VsY4jBZ6XHm1+ifgSXr/G2EsdomEUOwutR0eUQUXSU8GFs0B2oIn+a
         5NY1OokUpMJEK+HSk8v0NMkVGjD24X7uoWgX0Y1PV/MTPsL2jxhxE3P6JTzSz1xbySt7
         /jHVQkJCMEK6Iic0KrlgztdOFFiwJLXD+BI5suIogyMuGpDr0GuO8DNJg5u4XU/Z2acI
         Hh7XqYoxLo98XypfU+oBOa7rgmtn80buttCnM+KTu4cwmMz6b29uSty2SVpctlCAXaZ8
         xdU2D/aTVsJqGQiCLH/1nh6FXErqCg0b6p9NlQ12RwDKdGVUmbQMnJiAfqYzWva5GzCQ
         9p6A==
X-Gm-Message-State: ACrzQf2D1b+/+ne+qWHJT/MJeltw8pZs2Vm4iM58WPtROBzBmcwOoeP1
        AD7k1Eo7TGA7cn2LUb2G7rkuQYudjPUqjg==
X-Google-Smtp-Source: AMsMyM47kxxKPwIzvQ/AnnKgseNXS2gU3FfYWLvfmyT+I4DhmPL7viH3lMshF4vD1M0lSrBdnrbIMw==
X-Received: by 2002:a17:902:b089:b0:178:54cf:d692 with SMTP id p9-20020a170902b08900b0017854cfd692mr20306741plr.1.1664773426395;
        Sun, 02 Oct 2022 22:03:46 -0700 (PDT)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:dfa6:5a1a:b35a:db69])
        by smtp.gmail.com with ESMTPSA id y8-20020a170902b48800b0017680faa1a8sm6174628plr.112.2022.10.02.22.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Oct 2022 22:03:45 -0700 (PDT)
From:   Pin-yen Lin <treapking@chromium.org>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-kernel@vger.kernel.org, Hermes Wu <hermes.wu@ite.com.tw>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Allen Chen <allen.chen@ite.com.tw>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        dri-devel@lists.freedesktop.org,
        Pin-yen Lin <treapking@chromium.org>
Subject: [PATCH v2 0/2] drm/bridge: it6505: Power management fixes for it6505 bridge
Date:   Mon,  3 Oct 2022 13:03:33 +0800
Message-Id: <20221003050335.1007931-1-treapking@chromium.org>
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

This series contains 2 fixes related to it6505 power management.

Changes in v2:
- Handle the error from pm_runtime_get_sync in it6505_extcon_work

Pin-yen Lin (2):
  drm/bridge: it6505: Adapt runtime power management framework
  drm/bridge: it6505: Add pre_enable/post_disable callback

 drivers/gpu/drm/bridge/ite-it6505.c | 57 ++++++++++++++++++++++++-----
 1 file changed, 48 insertions(+), 9 deletions(-)

-- 
2.38.0.rc1.362.ged0d419d3c-goog

