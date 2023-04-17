Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBAE96E4D6F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 17:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbjDQPlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 11:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231288AbjDQPlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 11:41:19 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B53959F4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 08:41:17 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2a7af0cb2e6so14668501fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 08:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681746075; x=1684338075;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gNAR3DHHJC576sjB6C7w6VlykVXtRCYWbXKleTgIMtU=;
        b=lqxVhSMkDgK0WQQQ6j6mWXdZCAKMy6ZCoyuZuBPf7iyGeBUCVclfaXJ0vtZv9gwILB
         whOHkmGCTzdOspRKQtaY5wdkH2h+YzDKnFAOmru1wAq3h89qSNHWdS4Bwa9WRzqLuJmm
         GaWTZEs9gvZUQ43v0ASLWnaxdW++mHBPEXKQ4BXKXodckOypxM++jSULkJ241hoox4A7
         uT3r1oi0rz4pXvGViegj1f+RFOJXjlbcT3NmETOW/Rlj4QPxuA+FSPEhru4IDVygp1iP
         o7bpFe/jmkZanXKeVs5vKTle2wwtHOYRm97R6AI6DYGHhNNDDk3KUBv7ig3XS77urcYo
         Xn7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681746075; x=1684338075;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gNAR3DHHJC576sjB6C7w6VlykVXtRCYWbXKleTgIMtU=;
        b=ZTA3N3xw9NhbrIL8H9h6bDlYF58QQ9TP98DtiJsvE4duk1PFabSm0JRr/WAQ6hvWEE
         RjhOMn/ROFVHIqccoB0FyxrcCMF/96qn6FEkXsUL+knXytBkW+jcdASh1ZBvl5wHTsx5
         Z39pjWn8A3zddu3PutI6TOnjIp3WlP05ikaq1f5gdOZ29lKHsdm5jFv88drInQM155qy
         UA28Vo8QCvx0RZbzUQkhXNnSKUE2Hf9E7pg2M4gA0B+l2UIim7iuAuDD2zrH/FiCbZwu
         n4jXUhdyIT6a4MHMzlX3sSy75SVtkI7Em3vjBiAy9wtVSE/PtV7blJT6bqYKy98P+td0
         EPmQ==
X-Gm-Message-State: AAQBX9dJ72kdYlO/f2ukT2cfD+RNBS1qicK2bG22L0HTClJoCExW0Vx7
        U61pE6W8g2/qvKrKPBEDL35Gig==
X-Google-Smtp-Source: AKy350aozgk1r5Jb/wfhVODFS97I8ZHEVfPFiXLG9ajKtf3QHi8XgpoqyMYmVFGZGJFbckexE/XItA==
X-Received: by 2002:a05:6512:98b:b0:4ed:c089:6e68 with SMTP id w11-20020a056512098b00b004edc0896e68mr1219950lft.41.1681746075603;
        Mon, 17 Apr 2023 08:41:15 -0700 (PDT)
Received: from [192.168.1.101] (abyk99.neoplus.adsl.tpnet.pl. [83.9.30.99])
        by smtp.gmail.com with ESMTPSA id w13-20020ac2442d000000b004e95a1aca1bsm2066458lfl.87.2023.04.17.08.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 08:41:15 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 17 Apr 2023 17:41:08 +0200
Subject: [PATCH] drm/panel: novatek-nt35950: Only unregister DSI1 if it
 exists
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230417-topic-maple_panel_fixup-v1-1-07c8db606f5e@linaro.org>
X-B4-Tracking: v=1; b=H4sIAJNoPWQC/x2N0QrCMAxFf2Xk2UK7Daf+ishIu+gCNQutE2Hs3
 xd8PId7uBtUKkwVbs0Ghb5ceRGDcGogzSgvcjwZQ+vbzvdhcJ9FObk3aqZRUSiPT/6t6sLg43n
 q8JKuEayOWMnFgpJm62XN2aQWsvX/7v7Y9wPRM+VffgAAAA==
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1681746074; l=1768;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=ow64D0ztle1HmCwm747eKsJ3DSYCPMzYtrfBJ40ZY7w=;
 b=Wn+uTmifJi38q2SDiT/M2w/1LL8ry3gAsuKx92D5PjdkIhxdbFhFIMQ0GYid46vs1uiFfoeeI0Qe
 4PI1zgdkDZORcLs5aclC8V87sgGqd+ju6XwawXnVxcFyoYL1Km3n
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 5dd45b66742a ("drm/panel: novatek-nt35950: Improve error handling")
introduced logic to unregister DSI1 on any sort of probe failure, as
that's not done automatically by kernel APIs.

It did not however account for cases where only one DSI host is used.
Fix that.

Fixes: 5dd45b66742a ("drm/panel: novatek-nt35950: Improve error handling")
Reported-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/panel/panel-novatek-nt35950.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-novatek-nt35950.c b/drivers/gpu/drm/panel/panel-novatek-nt35950.c
index 7498fc6258bb..8b108ac80b55 100644
--- a/drivers/gpu/drm/panel/panel-novatek-nt35950.c
+++ b/drivers/gpu/drm/panel/panel-novatek-nt35950.c
@@ -586,7 +586,8 @@ static int nt35950_probe(struct mipi_dsi_device *dsi)
 
 	ret = drm_panel_of_backlight(&nt->panel);
 	if (ret) {
-		mipi_dsi_device_unregister(nt->dsi[1]);
+		if (num_dsis == 2)
+			mipi_dsi_device_unregister(nt->dsi[1]);
 
 		return dev_err_probe(dev, ret, "Failed to get backlight\n");
 	}
@@ -606,7 +607,8 @@ static int nt35950_probe(struct mipi_dsi_device *dsi)
 		ret = mipi_dsi_attach(nt->dsi[i]);
 		if (ret < 0) {
 			/* If we fail to attach to either host, we're done */
-			mipi_dsi_device_unregister(nt->dsi[1]);
+			if (num_dsis == 2)
+				mipi_dsi_device_unregister(nt->dsi[1]);
 
 			return dev_err_probe(dev, ret,
 					     "Cannot attach to DSI%d host.\n", i);

---
base-commit: ab4f869fba6119997f7630d600049762a2b014fa
change-id: 20230417-topic-maple_panel_fixup-170b6d3a8c9b

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

