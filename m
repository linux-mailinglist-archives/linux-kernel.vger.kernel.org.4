Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EECF55BD2F0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 19:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbiISRA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 13:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbiISRA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 13:00:27 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 276F13D58C
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 10:00:06 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id r18so52561eja.11
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 10:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date;
        bh=7ewVwlqmSZNgETsEvZqoFNhQps11G0ZAn5b60e+kwmE=;
        b=ltJHkE9qpYoLEDSN5DAx3cZgruYpelRbpwQcuaGdFUMLM3WJOSSnmHPjq0mpUqr1/z
         gQmz4aIu1+C2XCgAurWgLJcYErvdR4pZCHRjigSIHMdLj1hHPhb1eZ0uKCN3yalxK9qu
         GQSLKUQSOH+ZG7+yYGBOCRSOxQjRklDOiAYlzLZkIXtvsZWEgeOzyAm7yN5N0KoblI5a
         Chf8ShDsXCqZKzCoTAj9MlcgaigL68bvRigo9a2jipo46Rdg4R3ClF/1eroZSV1j3O6z
         CgcSBUC0Z9qbQQR/6dtC3LdupnvTBwtPW3JXZNgAEGC0PifQtmrhh69LHGp9uY59knMO
         qdZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=7ewVwlqmSZNgETsEvZqoFNhQps11G0ZAn5b60e+kwmE=;
        b=ir+YLnp8KfG06hYvXyQbOcf5uYE9udxaGl6u213Exca44joQ3r1SmijK4RVcHK8Jom
         rfCuqFmJQSholha6aDeJIKhmQlwvVjz9zQiZGZG/1b0ukmmafYiKgdIHvYN9RWH6Y7FA
         VKIKq/0pvRKGN7lZsxbFUqeONvMXwP2ZYoGJuyk+OdXd9cvAQxcGt/2TCb5RkEZ4AT5N
         V+XYwvrf/CfVFTurN2fqid7EkBXTrNOidu9Qhq4eMCDiazRTJvrEYvP3C1BnhdvxVA/s
         hJijy0ofkN5scovbW79DRj8As8nQUFAoeNwc3RyxZihWP5aSBVkjUpbkx1A785CoVsft
         0Tsw==
X-Gm-Message-State: ACrzQf361QDCRhcCi11cMDef2eEprsVTnJZsvJ81kSx42xvQ8qDMeyC9
        FuFMiAgw5KsXNZbPzUveUK1dyA==
X-Google-Smtp-Source: AMsMyM67IRRVMY+Suw0izTU3sRzUSrYIHC8PsOPjPY/v4kIJUR1V+xpsamXrdF60dn5nXvO6vgqnpA==
X-Received: by 2002:a17:907:72d5:b0:77d:5d01:4f4f with SMTP id du21-20020a17090772d500b0077d5d014f4fmr13945767ejc.285.1663606804603;
        Mon, 19 Sep 2022 10:00:04 -0700 (PDT)
Received: from [127.0.0.1] (2a02-8440-6340-f287-3074-96af-9642-0003.rev.sfr.net. [2a02:8440:6340:f287:3074:96af:9642:3])
        by smtp.gmail.com with ESMTPSA id cf16-20020a0564020b9000b0044fc3c0930csm20424246edb.16.2022.09.19.10.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 10:00:04 -0700 (PDT)
From:   Guillaume Ranquet <granquet@baylibre.com>
Date:   Mon, 19 Sep 2022 18:56:08 +0200
Subject: [PATCH v1 10/17] drm/mediatek: hdmi: add frame_colorimetry flag
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20220919-v1-10-4844816c9808@baylibre.com>
References: <20220919-v1-0-4844816c9808@baylibre.com>
In-Reply-To: <20220919-v1-0-4844816c9808@baylibre.com>
To:     Vinod Koul <vkoul@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>, Jitao shi <jitao.shi@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-mediatek@lists.infradead.org,
        dri-devel@lists.freedesktop.org,
        Pablo Sun <pablo.sun@mediatek.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org,
        Guillaume Ranquet <granquet@baylibre.com>,
        devicetree@vger.kernel.org
X-Mailer: b4 0.10.0-dev
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a flag to indicate support for frame colorimetry.

Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>

diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_common.c b/drivers/gpu/drm/mediatek/mtk_hdmi_common.c
index 30407603d693..9fe086e2cd7c 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi_common.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi_common.c
@@ -120,6 +120,17 @@ int mtk_hdmi_setup_avi_infoframe(struct mtk_hdmi *hdmi, u8 *buffer, size_t bufsz
 		return err;
 	}
 
+	if (hdmi->conf->has_frame_colorimetry) {
+		frame.colorimetry = hdmi->colorimtery;
+		if (frame.colorimetry == HDMI_COLORIMETRY_EXTENDED)
+			frame.extended_colorimetry = hdmi->extended_colorimetry;
+
+		/* quantiation range:limited or full */
+		if (frame.colorspace == HDMI_COLORSPACE_RGB)
+			frame.quantization_range = hdmi->quantization_range;
+		else
+			frame.ycc_quantization_range = hdmi->ycc_quantization_range;
+	}
 	err = hdmi_avi_infoframe_pack(&frame, buffer, bufsz);
 
 	if (err < 0) {
diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_common.h b/drivers/gpu/drm/mediatek/mtk_hdmi_common.h
index 62a14435be69..75a9b62dccee 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi_common.h
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi_common.h
@@ -33,6 +33,7 @@ struct mtk_hdmi_conf {
 	bool cea_modes_only;
 	bool has_cec;
 	bool has_connector;
+	bool has_frame_colorimetry;
 	unsigned long max_mode_clock;
 	const struct drm_bridge_funcs *bridge_funcs;
 	void (*mtk_hdmi_output_init)(struct mtk_hdmi *hdmi);

-- 
b4 0.10.0-dev
