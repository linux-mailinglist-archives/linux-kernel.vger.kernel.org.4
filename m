Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDB696D15CB
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 05:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbjCaDCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 23:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbjCaDC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 23:02:27 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E0C18F85
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 20:02:17 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id e15-20020a17090ac20f00b0023d1b009f52so24022572pjt.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 20:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680231737;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tgWvZk/iYpzKLUB9q2hMoB7/A/zWlAyiQxZw3rH6JH8=;
        b=nwdcz7JvfPrKuBBFQbSTVzhnbveNuT0oeykwisT1ina7IqUJiTRcjS2JroFUBNSsmy
         xC6i4I30tn1w9bVPBxXRrAq0+1KV8vSxunewLOqpms6By0zg2pdO+fvyJiIbv0tWauC7
         379VgmdQeQw7CMx+2tJU3li4owlI9njsAI/fQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680231737;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tgWvZk/iYpzKLUB9q2hMoB7/A/zWlAyiQxZw3rH6JH8=;
        b=HMsLLO8M0ZzByEO04z2WPuDy4WmzvI2rrEWiobktGPmK7AUFIV92RLG3QLn1Z93dia
         FX17aW74lJZjSyzajhOuqJRL4kfB7rjF7+YjtiyHQ/jfEaRS3n6o7yxjIU/kSIS9o//+
         doN1AnpbvpxetFlxIdWI5SYgUnwqKQrBvnwfe7K/WwINZIe+wc6L0zreePVfYalaWhC3
         PrK7tH3tatHIxu6SJXy9rNZTGe0FmI5aB+laE70NUrW9YJLuZK0T8YFVYariqEOTDFWu
         7B0wP0dqcfcQG5pnPnS22MSYu7h0LDzJgoAzSNW2kWqRJ3lyJ73caK6hDkM8Q8E8atTs
         J1ug==
X-Gm-Message-State: AAQBX9ewuhWyKHCnIyb+hT/HxmyfhsXLR8N3W6qWb2SqvVwoNrbnFSbQ
        eeko1gC0Vt1v/mmvdl/qvlzLEg==
X-Google-Smtp-Source: AKy350YBPmqeZ+L0wfFVGJRQxmR8TfTsUMdXcRm/uj3m1QuxtTD528I3y2vtYKjKoem8ZXpz56msnw==
X-Received: by 2002:a17:902:e812:b0:19c:e440:9256 with SMTP id u18-20020a170902e81200b0019ce4409256mr31915039plg.35.1680231737143;
        Thu, 30 Mar 2023 20:02:17 -0700 (PDT)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:d07:95ff:f44a:71])
        by smtp.gmail.com with ESMTPSA id b19-20020a170902d89300b001a072be70desm429750plz.41.2023.03.30.20.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 20:02:16 -0700 (PDT)
From:   Pin-yen Lin <treapking@chromium.org>
To:     Douglas Anderson <dianders@chromium.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Pin-yen Lin <treapking@chromium.org>
Subject: [PATCH] drm/bridge: ps8640: Use constant sleep time for polling hpd
Date:   Fri, 31 Mar 2023 11:02:04 +0800
Message-Id: <20230331030204.1179524-1-treapking@chromium.org>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The default hpd_wait_us in panel_edp.c is 2 seconds. This makes the
sleep time in the polling of _ps8640_wait_hpd_asserted become 200ms.
Change it to a constant 20ms to speed up the function.

Signed-off-by: Pin-yen Lin <treapking@chromium.org>
---

 drivers/gpu/drm/bridge/parade-ps8640.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c b/drivers/gpu/drm/bridge/parade-ps8640.c
index b823e55650b1..c3eb45179405 100644
--- a/drivers/gpu/drm/bridge/parade-ps8640.c
+++ b/drivers/gpu/drm/bridge/parade-ps8640.c
@@ -184,7 +184,7 @@ static int _ps8640_wait_hpd_asserted(struct ps8640 *ps_bridge, unsigned long wai
 	 * actually connected to GPIO9).
 	 */
 	ret = regmap_read_poll_timeout(map, PAGE2_GPIO_H, status,
-				       status & PS_GPIO9, wait_us / 10, wait_us);
+				       status & PS_GPIO9, 20000, wait_us);
 
 	/*
 	 * The first time we see HPD go high after a reset we delay an extra
-- 
2.40.0.348.gf938b09366-goog

