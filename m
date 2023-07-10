Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54EAA74D121
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 11:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbjGJJMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 05:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbjGJJMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 05:12:10 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7CFE8E
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 02:12:09 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-668709767b1so2252952b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 02:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688980329; x=1691572329;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kU6Mm9mplXh/rNIwHwAKhJYGQu+Q7/SpCWJyNAcPJ1A=;
        b=cbmC3W5c0r8kKiacXG8ia/aK1e8HTbZRDHEjiLIDGiSWvt9hK//RdDkvjBbx/S1/7/
         oFrfD8tCQT11tzzrKPz7AbRyzPsDsR+c3BbYSPcF5g4DX2Fqxsv5o4mKilNx3qjVq7Xq
         /UbaX/b5Gv7XHCXHsbkpCBtsM6tVPYHO5pzYk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688980329; x=1691572329;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kU6Mm9mplXh/rNIwHwAKhJYGQu+Q7/SpCWJyNAcPJ1A=;
        b=D1sJlGRQLbtzA3UHN5917lCOFIBe61eqoY/dT3p/ImIzDFhw5MAtVbw3qHUd4aHLGh
         WdjwufCrHZy9uyGrPCwyI5rWlWxN1duZ8mbdHMpwLTdECYNbmxpQwoNkZTNxsdvlX4nX
         UtGN1r1gH+rCeudncd/x/U6M43enZe1FoYXV9oe+u6tPc4xlIzSP64eRlJul/FcFH2BA
         3yEtxmGndu3O2oP6Zfe92ZogXldJQXxH/IHzt5yYTRelpMQ0GhnZC7hl0PBuOqW2En3s
         ACyHX8RcpKVuk2oaXFpd7Aoao/k1CEE3cA7DPktwoEvKDHToBuYDyQ50rUF19NSwXYv6
         8G2A==
X-Gm-Message-State: ABy/qLaZKIyxHT3npc/0RIjRsWOMvWp1vPC+t9MzlqugrITl7lutsw9H
        mLNecD4TuV430dhI6RDvuCfopgBeQL3yAdQWAeo=
X-Google-Smtp-Source: APBJJlG3bdCWRX8Ctlyd2UtPoIN5gLeqYlnJpoXjhGbIk5y6k6/CpCzBBNUSLrunyFPet8Q3pArDKw==
X-Received: by 2002:a05:6a00:884:b0:682:a62a:ec36 with SMTP id q4-20020a056a00088400b00682a62aec36mr12561365pfj.15.1688980329158;
        Mon, 10 Jul 2023 02:12:09 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:be97:1d05:f9b6:36a6])
        by smtp.gmail.com with ESMTPSA id q21-20020a62ae15000000b00640dbbd7830sm6944589pff.18.2023.07.10.02.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 02:12:08 -0700 (PDT)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Xin Ji <xji@analogixsemi.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/bridge: anx7625: Use common macros for HDCP capabilities
Date:   Mon, 10 Jul 2023 17:12:01 +0800
Message-ID: <20230710091203.1874317-1-wenst@chromium.org>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DRM DP code has macros for the DP HDCP capabilities. Use them in the
anx7625 driver instead of raw numbers.

Fixes: cd1637c7e480 ("drm/bridge: anx7625: add HDCP support")
Suggested-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/gpu/drm/bridge/analogix/anx7625.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
index 9db3784cb554..866d018f4bb1 100644
--- a/drivers/gpu/drm/bridge/analogix/anx7625.c
+++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
@@ -872,11 +872,11 @@ static int anx7625_hdcp_enable(struct anx7625_data *ctx)
 	}
 
 	/* Read downstream capability */
-	ret = anx7625_aux_trans(ctx, DP_AUX_NATIVE_READ, 0x68028, 1, &bcap);
+	ret = anx7625_aux_trans(ctx, DP_AUX_NATIVE_READ, DP_AUX_HDCP_BCAPS, 1, &bcap);
 	if (ret < 0)
 		return ret;
 
-	if (!(bcap & 0x01)) {
+	if (!(bcap & DP_BCAPS_HDCP_CAPABLE)) {
 		pr_warn("downstream not support HDCP 1.4, cap(%x).\n", bcap);
 		return 0;
 	}
-- 
2.41.0.255.g8b1d071c50-goog

