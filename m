Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF54765A4EA
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 15:28:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232339AbiLaO1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 09:27:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232052AbiLaO1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 09:27:32 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5BA2D2FD
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 06:27:30 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id c65-20020a1c3544000000b003cfffd00fc0so20638587wma.1
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 06:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VtovjFbpNrrJC+tTeD4MlQddSoN69F0yZoac9F9bQi0=;
        b=Lrr38/Y60W7DN0if/geXJh4j+Q2PtT7ixBA/cqXrBamdfKn2j2bmYI5vxaYiYamg/U
         3uLGuOdR8zup6qsxsjKqvKyRUD6v9mTEfuyT1hi8qdQEaXgRyqxMX+Vm4VFqkclLaCZm
         kGUm7pxiCZMHc9KF0lvw6DNKKTAh/+GD5+SfvXuPqLv+MTYu7NadpC67tpKo30YJ7eKj
         m7LumKtae0WgD1Wk90nRpxJRi2VyrYuX199pdZT94ScZTPcXumfuvWPYplv2lLsEw9c5
         eQrf2gXRA7+rMwZykIjlh5xgsQDBcszS/Gsd86uWrxA/VLqXHrgaF5IktNN9Tk1G5WOk
         qRuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VtovjFbpNrrJC+tTeD4MlQddSoN69F0yZoac9F9bQi0=;
        b=QzeA2isrcfVEhxpO3b7BigRpoppLrXgA02Y3+Fh6XlKWoRCQhIAZFBfGcK2hIz4RuK
         Q+jxuQJzoU2t3TbyRr5x50dKAZCE02Oe7RxDj+yoWnGmJ5U06kh1t/AO2Pkc6O+l4a+7
         0BPDGAwiDPsYdQV2tWbnLWwD8+wmsOdN0+hHOczxJDiTv09Fu0jFMHqgkVRZGayFFLLh
         M3qN82T1+/nvbpNf3qzzTSDjsSGfsqsukFjH6NSOBiRpXDDOKh1f2LWH912QJy3/0Hyw
         FEOJ2tAnPEg119STX0bYs8NyhT4e3nXleuJsItYZz+ia+DChWED38eRz6VpvpqcHTRl/
         uyPA==
X-Gm-Message-State: AFqh2kome0ywA5kkxfmqC8fY+Qe8FVUs6EyV6eJyJTKOt/+BSSMlouul
        6JUvdYRgyzg2wv73c4hRyb20dw==
X-Google-Smtp-Source: AMrXdXsGss0K1YKS6YAbGVQWHOwoui+21Zkk8ItLoec+rqhWxAjmZGtnSMSeaj3ter0pA7UCOFpnPg==
X-Received: by 2002:a1c:790a:0:b0:3d6:b691:b814 with SMTP id l10-20020a1c790a000000b003d6b691b814mr24817611wme.1.1672496849351;
        Sat, 31 Dec 2022 06:27:29 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id bg12-20020a05600c3c8c00b003d1e34bcbb2sm35729697wmb.13.2022.12.31.06.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Dec 2022 06:27:28 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Douglas Anderson <dianders@chromium.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Steev Klimaszewski <steev@kali.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 1/2] drm/panel-edp: fix name for IVO product id 854b
Date:   Sat, 31 Dec 2022 16:27:20 +0200
Message-Id: <20221231142721.338643-1-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The actual name is R133NW4K-R0.

Fixes: 0f9fa5f58c784 ("drm/panel-edp: add IVO M133NW4J-R3 panel entry")
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---

Assuming the information from here is correct:
https://raw.githubusercontent.com/linuxhw/EDID/master/DigitalDisplay.md

 drivers/gpu/drm/panel/panel-edp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 5cb8dc2ebe18..ef70928c3ccb 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -1891,7 +1891,7 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x1247, &delay_200_500_e80_d50, "N120ACA-EA1"),
 
 	EDP_PANEL_ENTRY('I', 'V', 'O', 0x057d, &delay_200_500_e200, "R140NWF5 RH"),
-	EDP_PANEL_ENTRY('I', 'V', 'O', 0x854b, &delay_200_500_p2e100, "M133NW4J-R3"),
+	EDP_PANEL_ENTRY('I', 'V', 'O', 0x854b, &delay_200_500_p2e100, "R133NW4K-R0"),
 
 	EDP_PANEL_ENTRY('K', 'D', 'B', 0x0624, &kingdisplay_kd116n21_30nv_a010.delay, "116N21-30NV-A010"),
 	EDP_PANEL_ENTRY('K', 'D', 'B', 0x1120, &delay_200_500_e80_d50, "116N29-30NK-C007"),
-- 
2.34.1

