Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2399E6CBC00
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 12:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232382AbjC1KKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 06:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232868AbjC1KKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 06:10:22 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A4E35B6;
        Tue, 28 Mar 2023 03:10:00 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-544787916d9so219553797b3.13;
        Tue, 28 Mar 2023 03:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679998198;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vSN9UmMWW8LKANBpEhn1gTCwWjUOTgkE62IMKkjwCg0=;
        b=VKawVm2n11k73FEhif7iJNjBvNdUJqFH/tZb8L3hni41QNgUr986enklitCdxEr1H9
         aglfr6ut9ISDMsImSU08X7AM/5JLuloPNB8dEZdJmILvc5I72/Wxyi7Svsewu//vqRRr
         YaxARdrzpkaVjdHRaOAysmfO8Z8u0b6pSbndKxfrbgIRbaO3OpuaQsneMGE7Bky/iHY3
         8aPKg/cDmgN/Ekctjkg9R8E8VAvTalNt7rtTqexMepUA/NTbg5xD0JJ9Sgu8ppbcWC2w
         7X6F7RGsmKlPec4O66T7QZeyivKqb0ScNt6J1gl+rwhz0Gv3nIQ4qDDjgyfUjwEm1OM2
         y7Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679998198;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vSN9UmMWW8LKANBpEhn1gTCwWjUOTgkE62IMKkjwCg0=;
        b=WAyqhQdmGLxC5hUHpjlUMfJWjOKP6gRtwY7S6OegEaDOwF2SIQtZDRqGhGorPu+hi5
         thOpTcFkk7fFcad4z9Xw4XznrMqPCeyzpdSEsI88SAn4Rq2KnwCB4m1m4+ffcDx52sSb
         3Xcfd2eS7WCHh1Gv8f+D4Xi1s0nTD2Roxa1iYxN4ebdf4yKWz/ejXP2KJEqU+aDAlEkD
         ggctRulL5gFneuYYaL5TiKr66dZKURzILXOk7LdHiuGY02sSbuNT1/HS24hJlqVVYjqM
         dHDxhxgYFItBVlpMyhfxK85Ldbo98gAIJgj50fLgeaWEwPFS0CJUQMDltHxqRtsJJk6g
         NT+w==
X-Gm-Message-State: AAQBX9cvQK5Bj0WrcIAmmD0G12XgcEshTC4JemOFGbFZZ05jXDMf1SIY
        4K3mnXLOFvIIKFfPXUipMgw=
X-Google-Smtp-Source: AKy350YWB4pruYmWkJDXlOTgbL/NI+go42y4drnV22+3AcxHJlRDgpq7qrITFtJgvL+E/d34H2rk2A==
X-Received: by 2002:a0d:e803:0:b0:541:826c:2101 with SMTP id r3-20020a0de803000000b00541826c2101mr15910680ywe.12.1679998198233;
        Tue, 28 Mar 2023 03:09:58 -0700 (PDT)
Received: from chcpu13.cse.ust.hk (191host119.mobilenet.cse.ust.hk. [143.89.191.119])
        by smtp.gmail.com with ESMTPSA id cp27-20020a05690c0e1b00b00545a08184aasm2339676ywb.58.2023.03.28.03.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 03:09:57 -0700 (PDT)
From:   Wei Chen <harperchen1110@gmail.com>
To:     tiffany.lin@mediatek.com
Cc:     andrew-ct.chen@mediatek.com, yunfei.dong@mediatek.com,
        mchehab@kernel.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Wei Chen <harperchen1110@gmail.com>
Subject: [PATCH] media: mediatek: vcodec: Fix potential array out-of-bounds in decoder queue_setup
Date:   Tue, 28 Mar 2023 10:09:51 +0000
Message-Id: <20230328100951.536955-1-harperchen1110@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

variable *nplanes is provided by user via system call argument. The
possible value of q_data->fmt->num_planes is 1-3, while the value
of *nplanes can be 1-8. The array access by index i can cause array
out-of-bounds.

Fix this bug by checking *nplanes against the array size.

Signed-off-by: Wei Chen <harperchen1110@gmail.com>
---
 drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
index 641f533c417f..cae34cc7c807 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
@@ -753,6 +753,13 @@ int vb2ops_vdec_queue_setup(struct vb2_queue *vq, unsigned int *nbuffers,
 	}
 
 	if (*nplanes) {
+		if (vq->type == V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE)
+			if (*nplanes != q_data->fmt->num_planes)
+				return -EINVAL;
+		else
+			if (*nplanes != 1)
+				return -EINVAL;
+
 		for (i = 0; i < *nplanes; i++) {
 			if (sizes[i] < q_data->sizeimage[i])
 				return -EINVAL;
-- 
2.25.1

