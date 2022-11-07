Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DFDB61FE5D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 20:12:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232192AbiKGTMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 14:12:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232910AbiKGTLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 14:11:36 -0500
Received: from msg-4.mailo.com (msg-4.mailo.com [213.182.54.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A702A248;
        Mon,  7 Nov 2022 11:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1667848286; bh=zWPAdToNUDwcfw6NFyLWvfacA3nb38cKYkYp0UwSEe0=;
        h=X-EA-Auth:Date:From:To:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=e+EjilvWCDu3GYPl50nMRQcJ3YfC61qnAQ4TnVjjx9VnoXN24iJaw3EzlJducIw1D
         i6AEctOqf2gK+tJ9k+Xw0xko7kxtxBsfXFE4Mqpsf/K4wgZfi8KArDvWNiumosR/RJ
         5aviiZDV4Xa83JS+xV+AkT7XZEKbnnM39F4sAiAc=
Received: by b-5.in.mailobj.net [192.168.90.15] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Mon,  7 Nov 2022 20:11:26 +0100 (CET)
X-EA-Auth: lhzqnxlKSukeYTArdeiVEjBhxUlWR9klVoDlFhWy14zVU6h0rU481r3lcJJeuxpO45fLMz+oj+pcg6mqQVqZdCkKc6VHGZrj
Date:   Tue, 8 Nov 2022 00:41:21 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-media@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: media: meson: vdec: use min() for comparison and
 assignment
Message-ID: <Y2lYWWKkDa73gcqm@qemulion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use of standard min() helper macro is preferred over using ternary
operator for logical evaluation and value assignment. This issue is
identified by coccicheck using the minmax.cocci file.

Signed-off-by: Deepak R Varma <drv@mailo.com>
---
 drivers/staging/media/meson/vdec/codec_vp9.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/media/meson/vdec/codec_vp9.c b/drivers/staging/media/meson/vdec/codec_vp9.c
index 897f5d7a6aad..da7265c8de37 100644
--- a/drivers/staging/media/meson/vdec/codec_vp9.c
+++ b/drivers/staging/media/meson/vdec/codec_vp9.c
@@ -1459,7 +1459,7 @@ static void vp9_tree_merge_probs(unsigned int *prev_prob,
 	if (den == 0) {
 		new_prob = pre_prob;
 	} else {
-		m_count = den < MODE_MV_COUNT_SAT ? den : MODE_MV_COUNT_SAT;
+		m_count = min(den, MODE_MV_COUNT_SAT);
 		get_prob =
 			clip_prob(div_r32(((int64_t)tree_left * 256 +
 					   (den >> 1)),
@@ -1513,7 +1513,7 @@ static void adapt_coef_probs_cxt(unsigned int *prev_prob,
 			/* get binary prob */
 			num = branch_ct[node][0];
 			den = branch_ct[node][0] + branch_ct[node][1];
-			m_count = den < count_sat ? den : count_sat;
+			m_count = min(den, count_sat);

 			get_prob = (den == 0) ?
 					128u :
@@ -1664,8 +1664,7 @@ static void adapt_coef_probs(int prev_kf, int cur_kf, int pre_fc,
 			if (den == 0) {
 				new_prob = pre_prob;
 			} else {
-				m_count = den < MODE_MV_COUNT_SAT ?
-						den : MODE_MV_COUNT_SAT;
+				m_count = min(den, MODE_MV_COUNT_SAT);
 				get_prob =
 				clip_prob(div_r32(((int64_t)
 					count[coef_count_node_start] * 256 +
--
2.34.1



