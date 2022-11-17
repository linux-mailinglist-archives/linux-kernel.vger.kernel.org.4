Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB07F62E614
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 21:41:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234380AbiKQUlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 15:41:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239771AbiKQUjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 15:39:12 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C71C78CB94
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 12:39:11 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id z3so2335744iof.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 12:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HFWkWqQjI46OeczyUCkFpr7MHjvDvFUokPuH4qzo/bw=;
        b=BNcRyYo1cs5H5wz/ooc/TaJyoeJQ8emL3WoCGbpKPrfUS1nlvORE78y9bqw3y0Z5w+
         w8ZqaO/V7hCEAv6ZwwP6eNc/npYjSfskSs1qpgMswcD5xRMpRkF/suTtrTX1DfSKkQzP
         IrFZpAM0rWr/KbthvifIe0mxC9QFGD97ng/4Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HFWkWqQjI46OeczyUCkFpr7MHjvDvFUokPuH4qzo/bw=;
        b=PUEMoMd/jObeN0LOu08Eas6dMT+Gagba+2n/KDWmpQzzVAkG8bMHKar1JL3pm/Wz4h
         QqHNkWT5MG91KCbM5D8ePKy1PGgSBcz/AmIf6cUGYUwAd97Q3Nv++Amt3mixAc5Gy9HQ
         asLMlcrIxOgWkiKgr9tNUuJOya63C1IhDeDbkG19blzGSYlpCFyAhjrFZRFsjim2Df6/
         dlDxp9QnEbZMMR9/w8hy+tLgSGrJGg5i7/TLYkjpT9OsgpHYwclTzMipvyPvWfYsD7Oe
         KreKMRy1d3psPsnP1bWemXLz+OQYBdAB+tJ2TJYe8cL+FTxxxar4POxVbDFGaRMCr9B/
         I1qQ==
X-Gm-Message-State: ANoB5pn8aHrxD1UeCcLy21Jn8pja4Y5E7E5GvNuI4a1xaE4gGZzWgues
        +Hf/ZkKloZk8AsdkuUBFj719Dw==
X-Google-Smtp-Source: AA0mqf5+BPEGrp46T/YWlC2wc+z8vnTOZvFcMl/0RZ2ToQg3vrCmVrcjDa9tb5KKgV2l07n5Xp5jIA==
X-Received: by 2002:a05:6638:4907:b0:375:ca55:284e with SMTP id cx7-20020a056638490700b00375ca55284emr1888278jab.248.1668717551175;
        Thu, 17 Nov 2022 12:39:11 -0800 (PST)
Received: from midworld.bld.corp.google.com ([2620:15c:183:200:b285:6808:3f3e:f538])
        by smtp.gmail.com with ESMTPSA id d191-20020a0262c8000000b00363da904602sm570192jac.13.2022.11.17.12.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 12:39:10 -0800 (PST)
From:   Drew Davenport <ddavenport@chromium.org>
To:     dri-devel@lists.freedesktop.org
Cc:     dianders@chromium.org, Drew Davenport <ddavenport@chromium.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] drm/bridge/parade-ps8640: Extend autosuspend
Date:   Thu, 17 Nov 2022 13:38:47 -0700
Message-Id: <20221117133655.4.If6153da69ec4bc9e83d5f095ef6e6b07283940a5@changeid>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
In-Reply-To: <20221117133655.1.I51639dc112bbbe27259df6bdad56dbabd655d91a@changeid>
References: <20221117133655.1.I51639dc112bbbe27259df6bdad56dbabd655d91a@changeid>
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

Same change as done for panel-samsung-atna33xc20. Extend the autosuspend
delay to avoid oscillating between power status during boot.

Signed-off-by: Drew Davenport <ddavenport@chromium.org>
---

 drivers/gpu/drm/bridge/parade-ps8640.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c b/drivers/gpu/drm/bridge/parade-ps8640.c
index 6a614e54b383c..f74090a9cc9e8 100644
--- a/drivers/gpu/drm/bridge/parade-ps8640.c
+++ b/drivers/gpu/drm/bridge/parade-ps8640.c
@@ -734,13 +734,13 @@ static int ps8640_probe(struct i2c_client *client)
 	pm_runtime_enable(dev);
 	/*
 	 * Powering on ps8640 takes ~300ms. To avoid wasting time on power
-	 * cycling ps8640 too often, set autosuspend_delay to 1000ms to ensure
+	 * cycling ps8640 too often, set autosuspend_delay to 2000ms to ensure
 	 * the bridge wouldn't suspend in between each _aux_transfer_msg() call
 	 * during EDID read (~20ms in my experiment) and in between the last
 	 * _aux_transfer_msg() call during EDID read and the _pre_enable() call
 	 * (~100ms in my experiment).
 	 */
-	pm_runtime_set_autosuspend_delay(dev, 1000);
+	pm_runtime_set_autosuspend_delay(dev, 2000);
 	pm_runtime_use_autosuspend(dev);
 	pm_suspend_ignore_children(dev, true);
 	ret = devm_add_action_or_reset(dev, ps8640_runtime_disable, dev);
-- 
2.38.1.584.g0f3c55d4c2-goog

