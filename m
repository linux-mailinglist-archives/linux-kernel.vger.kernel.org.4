Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29C34734E8C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 10:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjFSIuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 04:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231463AbjFSIt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 04:49:59 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD481BC7
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 01:48:58 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f6283d0d84so4014270e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 01:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687164537; x=1689756537;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sF2cMyWueJFSR5TkPmZGlAhqtXZxWsEsSEkaAm88ypQ=;
        b=XQd+u9lTrSgnCO0Qo9KbW8IQxo+yWt9dvjyBixrDcpBJna98f59YGrscomC1mI2aoa
         7tCip6Qk9qTNPjZnSuMAYxGS3qu4JToHshc0czJP/8uwYxeMRKueGe56zzV30og/yxxr
         zk2++2VHwo+zaVMXbBazwxLmks4p7ty8QqOp9jdKwwz1FpIBCr2yqveVO8YtAK2Xjdja
         kFGlKbr1WNtVXFwj0711zo3gK7icicGlyX4B+kG/gYX8e2bzoJuChIF0//AMTg60SxaK
         9Ltvc+K7vmloq4lMdxm8MLoF5t5kzHpXbkv+IMn+hA87YNQyzbzjqv0fCan5Y6rvNQ79
         5EHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687164537; x=1689756537;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sF2cMyWueJFSR5TkPmZGlAhqtXZxWsEsSEkaAm88ypQ=;
        b=XXkmuRoKjnMDDzwoGIfpWqRq+8shnbXbOkYfoDL0mOH9teTHubRmyg3R5kbg5CS+2P
         VCjOk7ViImnGnK7TDFu82ZH72tBtZ1Ldiv5534XNxZiTR60ouDYKOj3Tnif3LVIkbXs5
         4Fe1PsFM0kGs0tx633FjgUfaaDl8jtwjzbwZuyAIjj/qMq/0G3d1tcMK7lmsun56pvCm
         XmRx2gArvbb/uiSq+M15wrXagMGHPojqNHgZ6UBhieUIOvReRtRvwcQaRxoYHbDbE10h
         LxvUnRAsKsvtpvi4io33mJ8PSMYDip7IUnycXARrt23Fok0tgMJ6W8DXFQumg84ZFs/A
         N5Nw==
X-Gm-Message-State: AC+VfDxUzc3T63R+F+rEwOGYr/G9CDrJHf4bu3Clm/yQuqkcWlcoEn21
        m4s7mMwPyY6AVgMcab2HsYdX3g==
X-Google-Smtp-Source: ACHHUZ7/KTFTuJeVnNUhOyKvzj95aKeLmjUS8mMwmnJC8Zgg5HbvWicUv51Lv1OeRDIyg5EibiO6Fw==
X-Received: by 2002:ac2:5f99:0:b0:4f8:6cad:aae7 with SMTP id r25-20020ac25f99000000b004f86cadaae7mr1536250lfe.61.1687164537017;
        Mon, 19 Jun 2023 01:48:57 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id w19-20020a1cf613000000b003f8c5ceeb77sm9967769wmc.21.2023.06.19.01.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 01:48:56 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 19 Jun 2023 10:48:55 +0200
Subject: [PATCH] drm/bridge: dw-hdmi: use curr_conn instead of connector
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230619-topic-amlogic-upstream-fix-hdmi2-v1-1-c3d0262b5fd7@linaro.org>
X-B4-Tracking: v=1; b=H4sIAHYWkGQC/x2N2wrCMBBEf6XsswtN1F78FfEhSddmITeSVoTSf
 3fxaTgDc+aARpWpwaM7oNKHG+ckoC4dOG/SSsiLMOheX/tBzbjlwg5NDHmV3EvbKpmIb/6iXyJ
 rdLMd7pOabuNIIBprGqGtJjkvorSHIGWpJIv/7/N1nj+EMV8ohwAAAA==
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <treding@nvidia.com>,
        =?utf-8?q?Ville_Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        "Lukas F. Hartmann" <lukas@mntre.com>,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2235;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=Nb4BnS0/cUSQoQgoig/fwJxu9bAtFxm8VFV6SBQ50Go=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkkBZ3/0Rf5Tvhg/A1rfbEVRqdq7G85yQUD75m1dy2
 ocGv3/aJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZJAWdwAKCRB33NvayMhJ0QO3D/
 sHqK18tNE8KymC1WOj/BPF5dR6i/R5wqyrXEndJoSRzSpsVrb/nF4IiQvf2nzNI7v09//yZOVGXlgK
 E/frlcu95OXDWjPTO7+lsmdWAuawWcnc6se2tTaQRkwEDEKKUmPO17/8MpgHHRXTvBUvgZHbs9eQFo
 RFmGDDx3d6Wjq1DljwnCSh5/4lFa5HgPNcgkIGtS7GyyTvBCXnbYPgpvNk9zsU7u8/dRyMtYU7lr0Q
 xOPuknT06LFOeZGKHUHPVim2I3lCxcFUtzDCfwg6t4O7ij8wu6Ig+2EFfkhTs8YTQLrIKrjcyOxOee
 TIfn7KA1Eao0KSKWBhq5t7Zls/xv6h2HFkgSDJX32LrKo4mVSiJrDGHvc3nmqWFXRu0qJ8xRk4fHfy
 YEqx/gqgL+mZq4jt1blPArO5qHjoxVVa5I4g9OJErW8AGs+E6M75pLPs4PaZpmnsohjlAJgULsGACB
 SVIgPd19mWlI0J9OWN7Fp4zGKbC0g4s/HDzPyfXcwSPCgqgyzpP8p3DCkxDgn748JrHbFk08+zClO5
 dg3vefgcZf5+x/E36ytDcLTviW8p3q3VgfjGLe3j0hucH0jhApwLuyR3V0RHXG9MWqXXKB67s8yoBK
 bwKusKwrE8R62o93DhOj9SbVpw5ntvZiUV8qKJCsTLRqKspi+MoAqeRZbByg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The struct dw_hdmi connector is only valid when not using the
DRM_BRIDGE_ATTACH_NO_CONNECTOR, thus this leads to kernel crash
on Amlogic platforms when connected to HDMI2 capable displays.

Use hdmi->curr_conn instead which holds the current connector
the current bridge chain is connected to.

Reported-by: Lukas F. Hartmann <lukas@mntre.com>
Fixes: 5d844091f237 ("drm/scdc-helper: Pimp SCDC debugs")
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index 9d6dcaf317a1..7262238cb014 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -1426,9 +1426,9 @@ void dw_hdmi_set_high_tmds_clock_ratio(struct dw_hdmi *hdmi,
 	/* Control for TMDS Bit Period/TMDS Clock-Period Ratio */
 	if (dw_hdmi_support_scdc(hdmi, display)) {
 		if (mtmdsclock > HDMI14_MAX_TMDSCLK)
-			drm_scdc_set_high_tmds_clock_ratio(&hdmi->connector, 1);
+			drm_scdc_set_high_tmds_clock_ratio(hdmi->curr_conn, 1);
 		else
-			drm_scdc_set_high_tmds_clock_ratio(&hdmi->connector, 0);
+			drm_scdc_set_high_tmds_clock_ratio(hdmi->curr_conn, 0);
 	}
 }
 EXPORT_SYMBOL_GPL(dw_hdmi_set_high_tmds_clock_ratio);
@@ -2116,7 +2116,7 @@ static void hdmi_av_composer(struct dw_hdmi *hdmi,
 				min_t(u8, bytes, SCDC_MIN_SOURCE_VERSION));
 
 			/* Enabled Scrambling in the Sink */
-			drm_scdc_set_scrambling(&hdmi->connector, 1);
+			drm_scdc_set_scrambling(hdmi->curr_conn, 1);
 
 			/*
 			 * To activate the scrambler feature, you must ensure
@@ -2132,7 +2132,7 @@ static void hdmi_av_composer(struct dw_hdmi *hdmi,
 			hdmi_writeb(hdmi, 0, HDMI_FC_SCRAMBLER_CTRL);
 			hdmi_writeb(hdmi, (u8)~HDMI_MC_SWRSTZ_TMDSSWRST_REQ,
 				    HDMI_MC_SWRSTZ);
-			drm_scdc_set_scrambling(&hdmi->connector, 0);
+			drm_scdc_set_scrambling(hdmi->curr_conn, 0);
 		}
 	}
 

---
base-commit: 47045630bc409ce6606d97b790895210dd1d517d
change-id: 20230619-topic-amlogic-upstream-fix-hdmi2-c9b65818477e

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

