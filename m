Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD3256E6696
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 16:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbjDROEt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 10:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbjDROEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 10:04:43 -0400
Received: from exchange.fintech.ru (exchange.fintech.ru [195.54.195.159])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930B613845
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 07:04:39 -0700 (PDT)
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.169) with Microsoft SMTP Server (TLS) id 14.3.498.0; Tue, 18 Apr
 2023 17:04:37 +0300
Received: from localhost (10.0.253.138) by Ex16-01.fintech.ru (10.0.10.18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 18 Apr
 2023 17:04:37 +0300
From:   Nikita Zhandarovich <n.zhandarovich@fintech.ru>
To:     Jani Nikula <jani.nikula@linux.intel.com>
CC:     Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        "Ankit Nautiyal" <ankit.k.nautiyal@intel.com>,
        Manasi Navare <manasi.d.navare@intel.com>,
        Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        <intel-gfx@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <lvc-project@linuxtesting.org>
Subject: [PATCH] drm/i915/dp: prevent potential div-by-zero
Date:   Tue, 18 Apr 2023 07:04:30 -0700
Message-ID: <20230418140430.69902-1-n.zhandarovich@fintech.ru>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.0.253.138]
X-ClientProxiedBy: Ex16-02.fintech.ru (10.0.10.19) To Ex16-01.fintech.ru
 (10.0.10.18)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drm_dp_dsc_sink_max_slice_count() may return 0 if something goes
wrong on the part of the DSC sink and its DPCD register. This null
value may be later used as a divisor in intel_dsc_compute_params(),
which will lead to an error.
In the unlikely event that this issue occurs, fix it by testing the
return value of drm_dp_dsc_sink_max_slice_count() against zero.

Found by Linux Verification Center (linuxtesting.org) with static
analysis tool SVACE.

Fixes: a4a157777c80 ("drm/i915/dp: Compute DSC pipe config in atomic check")
Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
---
 drivers/gpu/drm/i915/display/intel_dp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index 62cbab7402e9..c1825f8f885c 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -1533,6 +1533,11 @@ int intel_dp_dsc_compute_config(struct intel_dp *intel_dp,
 		pipe_config->dsc.slice_count =
 			drm_dp_dsc_sink_max_slice_count(intel_dp->dsc_dpcd,
 							true);
+		if (!pipe_config->dsc.slice_count) {
+			drm_dbg_kms(&dev_priv->drm, "Unsupported Slice Count %d\n",
+				    pipe_config->dsc.slice_count);
+			return -EINVAL;
+		}
 	} else {
 		u16 dsc_max_output_bpp = 0;
 		u8 dsc_dp_slice_count;
-- 
2.25.1

