Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07D886EB89A
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 12:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjDVKjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 06:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjDVKjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 06:39:16 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC34A198A
        for <linux-kernel@vger.kernel.org>; Sat, 22 Apr 2023 03:39:15 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1a516fb6523so33318285ad.3
        for <linux-kernel@vger.kernel.org>; Sat, 22 Apr 2023 03:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682159955; x=1684751955;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VwFMHD30sqUe/T7ly/CJPme7mMd8qDj0hDd4kicbgfQ=;
        b=ewG2D7wdS60JREzAvKokBNWOZ7UcwGBzs908jvdjHMrHYP29OwKPg+EVXSR4yNUfnn
         fty/BawtqqosvAmOT6sFTxbv+1W46qp3nSFjYCvQZ0ncwAEKiNg0fAPlqyWNYkw3jwJ8
         T8p/cJyO/phS3fq38f4z75mTQD16C2swRQ10s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682159955; x=1684751955;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VwFMHD30sqUe/T7ly/CJPme7mMd8qDj0hDd4kicbgfQ=;
        b=VAaf3t0A/do1Sroh/fUvSBXEd998a6yi2M8LCFpyqOAnXfHy+ztYbVZ1KZD/Fu7+5r
         lG/5ZCWWUOFLwyE49EMAn0SAynKAmTMhOQ4qkAq6C0ztS7df8mPCh7TjDj1sdBVB5M81
         r/CRy2bszDex9yeGpGhIDU/9gOjtiJbVrc/CM/oyWtr21nrP1jvVUzvBn/Zw5GoDR490
         hwhLfFrOdjTh7ZF+jX+g2H1JDOh4yL6td0n03YfKx8piCeww9opQ8f3begV0xS8O8EgW
         h1L8clRl3qjNT6BUPuPgyvXsviEAJoSLQIsKOKk+prQaxQn7j7VwmTXjN5+Q1BXC4Xf/
         EIdg==
X-Gm-Message-State: AAQBX9fSYgnxy1K5Td/UiCtFtqMf5VxjO5h6xz0AW00k/AHPSp8qtnZ/
        7EYav71ko7D30zaUZHevHT/SQA==
X-Google-Smtp-Source: AKy350ZFr/ruuyY8q22yZySnT8vteG7lqkSxAD4UjnYogF8dD+F+Bkmuc4hJmjU41ovyHJpko1ErlQ==
X-Received: by 2002:a17:902:c94c:b0:1a5:2fbd:d094 with SMTP id i12-20020a170902c94c00b001a52fbdd094mr10186859pla.9.1682159955385;
        Sat, 22 Apr 2023 03:39:15 -0700 (PDT)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:c5d6:106b:dcb1:8d57])
        by smtp.gmail.com with ESMTPSA id ls17-20020a17090b351100b0023a9564763bsm5627694pjb.29.2023.04.22.03.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Apr 2023 03:39:14 -0700 (PDT)
From:   Pin-yen Lin <treapking@chromium.org>
To:     Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support),
        linux-kernel@vger.kernel.org (open list:ARM/Mediatek SoC support),
        linux-media@vger.kernel.org (open list:MEDIA INPUT INFRASTRUCTURE
        (V4L/DVB)),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support), Pin-yen Lin <treapking@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: [PATCH] media: mediatek: vcodec: Only apply 4K frame sizes on decoder formats
Date:   Sat, 22 Apr 2023 18:39:05 +0800
Message-ID: <20230422103905.1995271-1-treapking@chromium.org>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When VCODEC_CAPABILITY_4K_DISABLED is not set in dec_capability, skip
formats that are not MTK_FMT_DEC so only decoder formats is updated in
mtk_init_vdec_params.

Fixes: e25528e1dbe5 ("media: mediatek: vcodec: Use 4K frame size when supported by stateful decoder")
Signed-off-by: Pin-yen Lin <treapking@chromium.org>
---

 .../media/platform/mediatek/vcodec/mtk_vcodec_dec_stateful.c   | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateful.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateful.c
index 29991551cf61..0fbd030026c7 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateful.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateful.c
@@ -584,6 +584,9 @@ static void mtk_init_vdec_params(struct mtk_vcodec_ctx *ctx)
 
 	if (!(ctx->dev->dec_capability & VCODEC_CAPABILITY_4K_DISABLED)) {
 		for (i = 0; i < num_supported_formats; i++) {
+			if (mtk_video_formats[i].type != MTK_FMT_DEC)
+				continue;
+
 			mtk_video_formats[i].frmsize.max_width =
 				VCODEC_DEC_4K_CODED_WIDTH;
 			mtk_video_formats[i].frmsize.max_height =
-- 
2.40.0.634.g4ca3ef3211-goog

