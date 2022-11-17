Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E43EB62D987
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 12:37:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239670AbiKQLhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 06:37:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239622AbiKQLgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 06:36:52 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42FD0697CD
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 03:36:51 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id z18so2097126edb.9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 03:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yxMfjMiirY7i5b76cAjsj02YyQXT341SCmcBph5Qf+U=;
        b=N3eCNDBEJ+8l57N4d/x9r6FkVKlS2jcl6LFxZauI6rZhfJUbwC5ZX6bCZ5TnSTxqAk
         dorvUmZJmgAC7mZT+0cjBrimIQjcxsvRgJeTFZndPyO/3+ZSAJBUw18HBwqkCYqrwOB1
         HdIbVpR/Uof0e9HNc+o4Dm2E9mXQlmsB+3mHU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yxMfjMiirY7i5b76cAjsj02YyQXT341SCmcBph5Qf+U=;
        b=amZQE9z83x62zkCxp+rgv4Bat6Z8FByUeGRcnjgrc6EelPwg8zuym0G+5gAwqzi3fR
         d0RvIokMv90+05LvsjeEc0PDRq/kNzba3zB0ZJN/VmBRz3Lb4TRLLrzTHGCiYmOH3AcU
         D4LHkJRCUGwbSd+adlAg2bLl5T72aTB/kgOxwnuSYcmxD4CoZTqwmGOP+6TiwbNgsnop
         ZQrk29aeqlIB2xgghssDuazjGOeNKSfSlcJmtAWc6/u96WlFamOlcBf2jLAyOmiMEoRQ
         d5dtu1f6MUDZFIE3ZiNgL0GcjAnVjNzMiYgi1ufcynwX59gvRipz8rSOX46gAZhV3WBq
         e5iQ==
X-Gm-Message-State: ANoB5plER8gy+FVjWOKtAC7GgnDLnD/39EMJiczvdCw1PqOFMaiDTpXx
        WeUYLI8ohDiCdjalKXfxEOlSNtqx/PzNwQ==
X-Google-Smtp-Source: AA0mqf4LwN9I4lHe7fW0Tr4dbP1il3VAcVtfsnSz+I+H23yl+dOsCGmSKJh/Doj5kWYPVAzkeE7dlQ==
X-Received: by 2002:a05:6402:1399:b0:461:53b0:2ac0 with SMTP id b25-20020a056402139900b0046153b02ac0mr1740983edv.153.1668685009735;
        Thu, 17 Nov 2022 03:36:49 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.amarulasolutions.com (mob-5-90-137-239.net.vodafone.it. [5.90.137.239])
        by smtp.gmail.com with ESMTPSA id g3-20020aa7c843000000b0043bbb3535d6sm413897edt.66.2022.11.17.03.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 03:36:49 -0800 (PST)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-amarula@amarulasolutions.com, michael@amarulasolutions.com,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Anson Huang <Anson.Huang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Subject: [PATCH v2 2/5] clk: imx: replace osc_hdmi with dummy
Date:   Thu, 17 Nov 2022 12:36:34 +0100
Message-Id: <20221117113637.1978703-3-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20221117113637.1978703-1-dario.binacchi@amarulasolutions.com>
References: <20221117113637.1978703-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no occurrence of the hdmi oscillator in the reference manual
(document IMX8MNRM Rev 2, 07/2022). Further, if we consider the indexes
76-81 and 134 of the "Clock Root" table of chapter 5 of the RM, there is
no entry for the source select bits 101b, which is the setting referenced
by "osc_hdmi".
Fix by renaming "osc_hdmi" with "dummy", a clock which has already been
used for missing source select bits.

Tested on the BSH SystemMaster (SMM) S2 board.

Fixes: 96d6392b54dbb ("clk: imx: Add support for i.MX8MN clock driver")
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

(no changes since v1)

 drivers/clk/imx/clk-imx8mn.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8mn.c b/drivers/clk/imx/clk-imx8mn.c
index 72f9563a0ff6..0fae97e61e2c 100644
--- a/drivers/clk/imx/clk-imx8mn.c
+++ b/drivers/clk/imx/clk-imx8mn.c
@@ -108,27 +108,27 @@ static const char * const imx8mn_disp_pixel_sels[] = {"osc_24m", "video_pll1_out
 						      "sys_pll3_out", "clk_ext4", };
 
 static const char * const imx8mn_sai2_sels[] = {"osc_24m", "audio_pll1_out", "audio_pll2_out",
-						"video_pll1_out", "sys_pll1_133m", "osc_hdmi",
+						"video_pll1_out", "sys_pll1_133m", "dummy",
 						"clk_ext3", "clk_ext4", };
 
 static const char * const imx8mn_sai3_sels[] = {"osc_24m", "audio_pll1_out", "audio_pll2_out",
-						"video_pll1_out", "sys_pll1_133m", "osc_hdmi",
+						"video_pll1_out", "sys_pll1_133m", "dummy",
 						"clk_ext3", "clk_ext4", };
 
 static const char * const imx8mn_sai5_sels[] = {"osc_24m", "audio_pll1_out", "audio_pll2_out",
-						"video_pll1_out", "sys_pll1_133m", "osc_hdmi",
+						"video_pll1_out", "sys_pll1_133m", "dummy",
 						"clk_ext2", "clk_ext3", };
 
 static const char * const imx8mn_sai6_sels[] = {"osc_24m", "audio_pll1_out", "audio_pll2_out",
-						"video_pll1_out", "sys_pll1_133m", "osc_hdmi",
+						"video_pll1_out", "sys_pll1_133m", "dummy",
 						"clk_ext3", "clk_ext4", };
 
 static const char * const imx8mn_sai7_sels[] = {"osc_24m", "audio_pll1_out", "audio_pll2_out",
-						"video_pll1_out", "sys_pll1_133m", "osc_hdmi",
+						"video_pll1_out", "sys_pll1_133m", "dummy",
 						"clk_ext3", "clk_ext4", };
 
 static const char * const imx8mn_spdif1_sels[] = {"osc_24m", "audio_pll1_out", "audio_pll2_out",
-						  "video_pll1_out", "sys_pll1_133m", "osc_hdmi",
+						  "video_pll1_out", "sys_pll1_133m", "dummy",
 						  "clk_ext2", "clk_ext3", };
 
 static const char * const imx8mn_enet_ref_sels[] = {"osc_24m", "sys_pll2_125m", "sys_pll2_50m",
-- 
2.32.0

