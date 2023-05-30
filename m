Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F107716C39
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 20:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233384AbjE3SYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 14:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233343AbjE3SYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 14:24:32 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25BFFB2;
        Tue, 30 May 2023 11:24:31 -0700 (PDT)
Received: from [192.168.122.1] (84-115-214-73.cable.dynamic.surfer.at [84.115.214.73])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id D5211CFC41;
        Tue, 30 May 2023 18:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1685471069; bh=Jm/DdiEm/EekWEu0ec6gDTbUQ0p4VEB89p93cuEm6n4=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=mycR7qYsLce6FBxgGw28MtPfQFw+WpoJGsGABjhBI0BZtp1+9B56yS62AEraHMywe
         5Q4zIi1NY0j3GbSfhlf7fjwECAg0quYIfb5S8II3HApMlx6IV2qejtdu4hRkopJJxY
         GuflD4Dw6UTTuimlsUOGiv0MdLMguuVlK410LUEY=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Tue, 30 May 2023 20:24:14 +0200
Subject: [PATCH v2 4/7] drm/msm/mdp5: Add MDP5 configuration for MSM8226
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230308-msm8226-mdp-v2-4-e005b769ee28@z3ntu.xyz>
References: <20230308-msm8226-mdp-v2-0-e005b769ee28@z3ntu.xyz>
In-Reply-To: <20230308-msm8226-mdp-v2-0-e005b769ee28@z3ntu.xyz>
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2734; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=Jm/DdiEm/EekWEu0ec6gDTbUQ0p4VEB89p93cuEm6n4=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBkdj9Uk2BW8z4RaEC0gTLiiQmyOGKzlZ0zHZ0d1
 ux9DaKzGmGJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZHY/VAAKCRBy2EO4nU3X
 VsmWD/98Q38eOeI2Mgj+4zC48f5Bf0ZAsOFOS7iSElZ5hi/bQxwdWrmmgYncUtBYCHDc9WfiSRS
 20mPjy10xzD7KAVV7klvDrrvyQ2n7/E0N/b4twW12mhy87OCuqmgUjjY2yCK9tyUv1CpaytiRMY
 qMA38L/n4MfO3MgdYbMa+ecR+OmW3c+vecMvOo7sBpN1C/wb+0uaSfaLdICajcJVM+rXQPS2WuX
 +FplQFknYHqw2jxqC5r0YFiwXUuoyj7udvwdFUUduJFqF+I/7e9CmmsVQGmgU2Xu+ySMXZHWVoG
 Ly4XRT3Kep3p9Wjpp+xmr8wX3Uovr2akgGLoyPgqRdGdpXJ5VUQJzuQX4huR5hbrX2Zy2fRuwfq
 aFUXk0/rVcIyM96Jr8XdhGDKGGuNwYjX7WLovYuT2lLw5coAG/c8yb6zGvkJNQRbQP5g81RX5Qe
 UG7FcQWiyDXz9UHhKt0SBB25iXkmTKFZMp6wAkj6EbNSFYPG/ATcJ541iu4x5IZJGf7b+YNh3xM
 +WOS4DLAotWrnHpux0+OpcHtWK6HccZNGY9xqe2KbeFGDnMZZwyZ1eAJeMZGAf943+EnCRbgVxn
 uva/8wo5kiI8myTC4tkPEIfn1lriVlRVTCQ/LkwUhuaSt7Eey2kT3j077F1eUoe4HeWBwk84+kY
 wTPEKLdV6XMVNQQ==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the required config for the v1.1 MDP5 found on MSM8226.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.c | 82 ++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.c
index 2eec2d78f32a..694d54341337 100644
--- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.c
+++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.c
@@ -103,6 +103,87 @@ static const struct mdp5_cfg_hw msm8x74v1_config = {
 	.max_clk = 200000000,
 };
 
+static const struct mdp5_cfg_hw msm8x26_config = {
+	.name = "msm8x26",
+	.mdp = {
+		.count = 1,
+		.caps = MDP_CAP_SMP |
+			0,
+	},
+	.smp = {
+		.mmb_count = 7,
+		.mmb_size = 4096,
+		.clients = {
+			[SSPP_VIG0] =  1,
+			[SSPP_DMA0] = 4,
+			[SSPP_RGB0] = 7,
+		},
+	},
+	.ctl = {
+		.count = 2,
+		.base = { 0x00500, 0x00600 },
+		.flush_hw_mask = 0x0003ffff,
+	},
+	.pipe_vig = {
+		.count = 1,
+		.base = { 0x01100 },
+		.caps = MDP_PIPE_CAP_HFLIP |
+			MDP_PIPE_CAP_VFLIP |
+			MDP_PIPE_CAP_SCALE |
+			MDP_PIPE_CAP_CSC   |
+			0,
+	},
+	.pipe_rgb = {
+		.count = 1,
+		.base = { 0x01d00 },
+		.caps = MDP_PIPE_CAP_HFLIP |
+			MDP_PIPE_CAP_VFLIP |
+			MDP_PIPE_CAP_SCALE |
+			0,
+	},
+	.pipe_dma = {
+		.count = 1,
+		.base = { 0x02900 },
+		.caps = MDP_PIPE_CAP_HFLIP |
+			MDP_PIPE_CAP_VFLIP |
+			0,
+	},
+	.lm = {
+		.count = 2,
+		.base = { 0x03100, 0x03d00 },
+		.instances = {
+				{ .id = 0, .pp = 0, .dspp = 0,
+				  .caps = MDP_LM_CAP_DISPLAY, },
+				{ .id = 1, .pp = -1, .dspp = -1,
+				  .caps = MDP_LM_CAP_WB },
+			     },
+		.nb_stages = 2,
+		.max_width = 2048,
+		.max_height = 0xFFFF,
+	},
+	.dspp = {
+		.count = 1,
+		.base = { 0x04500 },
+	},
+	.pp = {
+		.count = 1,
+		.base = { 0x21a00 },
+	},
+	.intf = {
+		.base = { 0x00000, 0x21200 },
+		.connect = {
+			[0] = INTF_DISABLED,
+			[1] = INTF_DSI,
+		},
+	},
+	.perf = {
+		.ab_inefficiency = 100,
+		.ib_inefficiency = 200,
+		.clk_inefficiency = 125
+	},
+	.max_clk = 200000000,
+};
+
 static const struct mdp5_cfg_hw msm8x74v2_config = {
 	.name = "msm8x74",
 	.mdp = {
@@ -1236,6 +1317,7 @@ static const struct mdp5_cfg_hw sdm660_config = {
 
 static const struct mdp5_cfg_handler cfg_handlers_v1[] = {
 	{ .revision = 0, .config = { .hw = &msm8x74v1_config } },
+	{ .revision = 1, .config = { .hw = &msm8x26_config } },
 	{ .revision = 2, .config = { .hw = &msm8x74v2_config } },
 	{ .revision = 3, .config = { .hw = &apq8084_config } },
 	{ .revision = 6, .config = { .hw = &msm8x16_config } },

-- 
2.40.1

