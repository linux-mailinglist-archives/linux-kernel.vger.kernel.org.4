Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07F775F3C37
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 06:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbiJDEt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 00:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiJDEtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 00:49:52 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 479BDDEDF
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 21:49:51 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id c7so11728903pgt.11
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 21:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=/xVdKxSIlA3DamunWOFIjrLXOpuuwkDNyivJpgCyiPU=;
        b=QK8w8Nbim8Dy4b7jBA6WMd0/bAxFA6dLjO9vWe3fw3TyZ/GBjHN8JXbKNa7rnSX/nG
         +XPUS37IimuizTqi1z6wAa7liidEbUFx2k3iUgNhmmBvAG157qymamz3mZ+2j4AgkUvp
         WtjaSi1e8D9m2ErJKJ1XN0bITDZX3dLTGr1Rc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=/xVdKxSIlA3DamunWOFIjrLXOpuuwkDNyivJpgCyiPU=;
        b=gKQBDEvmcjbXQxTq/108fm2tXZlfSIHdrxCx3mLzXkk6sQ8hJQBo7pmz0aqv2XLn43
         M/8dZ/necbv5pivXu4qLRjNO+2jLRbNcCgREHBQaVAKW9MpSrxQb6ENBwyqz0Xl+Is+d
         zNQx0/Y0iIkpgtfMMcJD4wx5O/Y0wigCeKHlyknn5X7yQ2p0MiUki9Ko0gSr0e3V+asG
         2T7gr5K5vIJ1ANmic4SfxJU5ertmTtHQyEWMj4tYGq1RXAIBh3VVQ5+k7EWv+5KtDOBG
         oTf3qcxiKWiWtDfwN+bNdn/cpVuddO7RvN3TDtoQVYZ1/obxUHGkI7fyjh1t5RsxS6iG
         53qw==
X-Gm-Message-State: ACrzQf1gHusCZDX664CsGd47AxEKo9ZwjIXyLxp9p8YAgIkT+VHdjeRe
        QKw8bo3jTrAtv5gtl3JHkO6UaQ==
X-Google-Smtp-Source: AMsMyM4ZLKqSUOaZeoB/LQLmyjuSOO6HvPUcObJzr5sJGGqZz1PKZWAFs+4r053KrZ5RlLuU492T0w==
X-Received: by 2002:a63:188:0:b0:43c:22e9:2d10 with SMTP id 130-20020a630188000000b0043c22e92d10mr21837722pgb.12.1664858990734;
        Mon, 03 Oct 2022 21:49:50 -0700 (PDT)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:5713:ccf0:f1dd:69d2])
        by smtp.gmail.com with ESMTPSA id gl1-20020a17090b120100b0020ab3f9c27dsm1095051pjb.55.2022.10.03.21.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 21:49:50 -0700 (PDT)
From:   Pin-yen Lin <treapking@chromium.org>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Hsin-Yi Wang <hsinyi@chromium.org>,
        dri-devel@lists.freedesktop.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-kernel@vger.kernel.org, Hermes Wu <hermes.wu@ite.com.tw>,
        Allen Chen <allen.chen@ite.com.tw>,
        Pin-yen Lin <treapking@chromium.org>
Subject: [PATCH v3 0/2] drm/bridge: it6505: Power management fixes for it6505 bridge
Date:   Tue,  4 Oct 2022 12:49:41 +0800
Message-Id: <20221004044943.2407781-1-treapking@chromium.org>
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

Changes in v3:
- Handle the error from extcon_get_state
- Collect review tag

Changes in v2:
- Handle the error from pm_runtime_get_sync in it6505_extcon_work

Pin-yen Lin (2):
  drm/bridge: it6505: Adapt runtime power management framework
  drm/bridge: it6505: Add pre_enable/post_disable callback

 drivers/gpu/drm/bridge/ite-it6505.c | 58 ++++++++++++++++++++++++-----
 1 file changed, 48 insertions(+), 10 deletions(-)

-- 
2.38.0.rc1.362.ged0d419d3c-goog

