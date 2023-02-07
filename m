Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34AE668E470
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 00:33:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjBGXdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 18:33:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjBGXdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 18:33:01 -0500
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19BCC27D59
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 15:32:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=5KKCxYUeoozeU27i58OD1InNHwJzW3SoY8B2DvPcOSg=; b=RdccXekeQ2yeF62bNcACqz+WqA
        jYCmL0ZdyUv38I/colbd7k8tHpi6t4FlEzbAvkoXtP1ImEzEdMdOkx2ERaEP1SsZ/q+szqTFsxVxj
        2pSZw363tpWFnxTBbJk4sqXmN3WwJBkIHA8k3ZJz+kkD8toc4yM208WM/V7AunKTQ/sZG29stVEhN
        XSiOTe7hTL/gH72pzbNCSkP6w++0GKoq5OJoW25/99bTax60hvh0G3HfreFclKkVBotxDqqme2dpX
        g/HeCaqjOFcy/pIsYz+80hbfEvaRRleJ+zDQ0W+Y1k1st0GoW9zVTT1Rl5hxkfvjYUH6xIUCIIklD
        qfbNt2vQ==;
Received: from [38.44.66.31] (helo=killbill.home)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1pPXSE-00CH3W-3v; Wed, 08 Feb 2023 00:32:50 +0100
From:   Melissa Wen <mwen@igalia.com>
To:     harry.wentland@amd.com, sunpeng.li@amd.com,
        Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch
Cc:     Xaver Hugl <xaver.hugl@gmail.com>,
        Martin Tsai <martin.tsai@amd.com>,
        Brian Chang <Brian.Chang@amd.com>,
        David Galiffi <David.Galiffi@amd.com>,
        Martin Leung <Martin.Leung@amd.com>, sungjoon.kim@amd.com,
        amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
        Melissa Wen <mwen@igalia.com>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/display: fix glitches on hw rotation without pipe split
Date:   Tue,  7 Feb 2023 22:32:35 -0100
Message-Id: <20230207233235.513948-1-mwen@igalia.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix glitches when moving cursor close to the edge on a rotated screen
for drivers with one pipe (without pipe split) by halving dst_x_offset.

Reported-by: Xaver Hugl <xaver.hugl@gmail.com>
Signed-off-by: Melissa Wen <mwen@igalia.com>
---

Hi,

I'm not sure if having dst_x_offset (or only for the one pipe case) is
the right solution, but it solves the issue on different devices when
the pipe split policy is AVOID.

Context:

Some artifacts appear on HW rotated screen when moving the cursor close
to the edge, as reported in:
https://gitlab.freedesktop.org/drm/amd/-/issues/2247

This issue was initially reported on DCN 3.0.1 and it's not present in
DCN 2.1 by default, for example. These two drivers follow different
pipe_split_policy, where there is no pipe split on DCN 3.0.1 (AVOID),
but we see pipe splitting on DCN 2.1 (MPC_SPLIT_AVOID_MULT_DISP).

Splitting (or not) the pipe changes the way DC calculates cursor
movements and its position, as we can see in
dcn10_set_cursor_position(). In addition, it's possible to reproduce the
same issue found on DCN 3.0.1 by setting DCN 2.1 to avoid pipe splitting
plus rotating the screen to any angle different from zero. However, from
my experiments, setting DCN 3.0.1 to a different pipe split policy makes
the system unstable and causes GPU reset (even though DYNAMIC seems to
be the default policy for DC).

I see that plugging/unplugging the charger changed the intensity of
these artifacts and also see some temporary changes with different power
performance settings. Keeping that in mind, I verified calculations and
register updates related to cursor movements
(dcn10_set_cursor_position(), hubp2_cursor_set_position()), and we can
see that some clk values participates in the final result of
dst_x_offset. After halving dst_x_offset, the artifacts no longer appear
and it solves the problem when pipe splitting is not allowed.

This change doesn't affect the correct behavior with more than one pipe,
but may affect the optimal setup of bandwidth and clocks. Perhaps, the
current values doesn't deliver the right performance when the pipe is
not split and halving dst_x_offset is exactly the right step for only
one pipe, but not for pipe split. 

Finally, if this is not the right solution, I appreciate any feedback to
address this problem correctly.

Thanks,

Melissa

 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c
index 4566bc7abf17..1ff85d81237e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c
@@ -1018,7 +1018,7 @@ void hubp2_cursor_set_position(
 		src_y_offset = y_pos - (cursor_height - y_hotspot);
 	}
 
-	dst_x_offset = (src_x_offset >= 0) ? src_x_offset : 0;
+	dst_x_offset = (src_x_offset >= 0) ? src_x_offset / 2 : 0;
 	dst_x_offset *= param->ref_clk_khz;
 	dst_x_offset /= param->pixel_clk_khz;
 
-- 
2.39.0

