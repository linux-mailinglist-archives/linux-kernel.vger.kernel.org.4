Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40F616A835C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 14:18:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbjCBNSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 08:18:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjCBNSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 08:18:34 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0563A1E1F7
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 05:18:28 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id 16so9727508pge.11
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 05:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1677763107;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E166X9hjpFg3mdEW6iD+dySuMT8kiQ1PL60Qkh8UwsI=;
        b=TG5uXivyNeE/uoFeSDp+u5QoerHsyjFLS7lek+Tf1ikHN52gtt0elSpqkLtCPZW6ii
         W9CAReiVFbYFHVv+l7tSM7T26G7D7eRK5DYrTLuHGSw9CexbtpUHtZmti+kD/mvHiTb6
         mWvv4X7tHbBuKoClb79/qw+aiqm/2uT0784MQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677763107;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E166X9hjpFg3mdEW6iD+dySuMT8kiQ1PL60Qkh8UwsI=;
        b=qAZ+yBBv/zZmCCEApBA+oDUHzHrAW22oBky/lbF6e1dTKTKUnpB5uT0hhAHySNk99i
         Cj5BGTP8SXcfeONrBpMgRrV5Dhm5axynmYkLqWs1a1DGSsyOjnoHOpvHD8bih7QEtvv3
         VfnFN5wY+nh17Acw7vejFCngztiJJH+079zgrGyENmO2nNUK2gnqHOBjknHmjgfEi2N2
         abg+0xusG0kR2DCCjaLPXv3jcJgBujCU5ZNcg6iabH/ASaH+U3dzozEKA+3Dylt85cg1
         Wgm94jErbB5LOE5VPxL6UU6m9fjxSouNPvqCT1wWfKRHfjSps2zKGhcU4Vt9JnDu4V5M
         6QEw==
X-Gm-Message-State: AO0yUKUXgf2NVeqwvQzgAJcoTU9knhsHc1PeBrX7RMvDmTmWpjiCbGP/
        bs8iEVZyFcj5qa3sJEwNdTTkCQ==
X-Google-Smtp-Source: AK7set8K94g2rR6EFJDYXdaB7Du5j026byxnZEvzejgfLdVXgs+t85RvFhpPuQA9xTO2WjR7dpu7AA==
X-Received: by 2002:a62:4ec8:0:b0:5cb:eecd:387b with SMTP id c191-20020a624ec8000000b005cbeecd387bmr7538411pfb.33.1677763107334;
        Thu, 02 Mar 2023 05:18:27 -0800 (PST)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:739f:8bcf:3d43:dae5])
        by smtp.gmail.com with ESMTPSA id s15-20020aa7828f000000b005905d2fe760sm9840086pfm.155.2023.03.02.05.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 05:18:26 -0800 (PST)
From:   Pin-yen Lin <treapking@chromium.org>
To:     Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chen-Yu Tsai <wenst@chromium.org>, linux-media@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Pin-yen Lin <treapking@chromium.org>
Subject: [PATCH] media: mediatek: vcodec: Use 4K frame size when supported by stateful decoder
Date:   Thu,  2 Mar 2023 21:18:21 +0800
Message-Id: <20230302131821.2060936-1-treapking@chromium.org>
X-Mailer: git-send-email 2.39.2.722.g9855ee24e9-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit b018be06f3c7 ("media: mediatek: vcodec: Read max resolution
from dec_capability"), the stateful video decoder driver never really
sets its output frame size to 4K.

Parse the decoder capability reported by the firmware, and update the
output frame size in mtk_init_vdec_params to enable 4K frame size when
available.

Fixes: b018be06f3c7 ("media: mediatek: vcodec: Read max resolution from dec_capability")
Signed-off-by: Pin-yen Lin <treapking@chromium.org>
---

 .../mediatek/vcodec/mtk_vcodec_dec_stateful.c        | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateful.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateful.c
index 035c86e7809f..679f4dc9acfb 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateful.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateful.c
@@ -11,7 +11,7 @@
 #include "mtk_vcodec_dec_pm.h"
 #include "vdec_drv_if.h"
 
-static const struct mtk_video_fmt mtk_video_formats[] = {
+static struct mtk_video_fmt mtk_video_formats[] = {
 	{
 		.fourcc = V4L2_PIX_FMT_H264,
 		.type = MTK_FMT_DEC,
@@ -580,6 +580,16 @@ static int mtk_vcodec_dec_ctrls_setup(struct mtk_vcodec_ctx *ctx)
 
 static void mtk_init_vdec_params(struct mtk_vcodec_ctx *ctx)
 {
+	unsigned int i;
+
+	if (!(ctx->dev->dec_capability & VCODEC_CAPABILITY_4K_DISABLED)) {
+		for (i = 0; i < num_supported_formats; i++) {
+			mtk_vdec_framesizes[i].stepwise.max_width =
+				VCODEC_DEC_4K_CODED_WIDTH;
+			mtk_vdec_framesizes[i].stepwise.max_height =
+				VCODEC_DEC_4K_CODED_HEIGHT;
+		}
+	}
 }
 
 static struct vb2_ops mtk_vdec_frame_vb2_ops = {
-- 
2.39.2.722.g9855ee24e9-goog

