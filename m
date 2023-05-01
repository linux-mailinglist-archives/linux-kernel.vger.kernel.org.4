Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 647776F2CFB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 05:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232557AbjEADGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 23:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232520AbjEADEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 23:04:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2300D19BD;
        Sun, 30 Apr 2023 20:01:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 48107616DD;
        Mon,  1 May 2023 02:59:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70184C433EF;
        Mon,  1 May 2023 02:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682909980;
        bh=YKojEJiiV1QvwHI5f0ezVGrRBJg+sS7nU5ba/bX9Vb8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p9AzbP/kx+wSby7ytTnMivAm3jk1V+SGZZXz941qqCeaVX9eCs+7ZYNfAiDa/v+iJ
         ThW+a+ZicUbSPKwJ5lWDqFIrytV1nZbsaktsHB8dSFAsOOidhwUoYo8RRSXr/xtLCg
         npqYgTaCz5kS32kTyZe1s5mmErZHrztaoXsIZvPEbt8WlC+L8LZ0xMuBla+UUVx4IV
         34NQQAGU7ZG4GRT4dLDIt5vb/JohOqqbgaMhz/4O2oV8j+HFjzysaPpCyPPnR03w43
         EHsSUa/0J5X0mqRagA/PpqpgFG5M2UeIeqqLSKmcUZu30dFnq6ls7z/NbryxePF58T
         hlQ3fAX5fzhPA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Wei Chen <harperchen1110@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sasha Levin <sashal@kernel.org>, tiffany.lin@mediatek.com,
        andrew-ct.chen@mediatek.com, yunfei.dong@mediatek.com,
        matthias.bgg@gmail.com, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH AUTOSEL 6.3 42/44] media: mediatek: vcodec: Fix potential array out-of-bounds in decoder queue_setup
Date:   Sun, 30 Apr 2023 22:56:30 -0400
Message-Id: <20230501025632.3253067-42-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230501025632.3253067-1-sashal@kernel.org>
References: <20230501025632.3253067-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Chen <harperchen1110@gmail.com>

[ Upstream commit 8fbcf730cb89c3647f3365226fe7014118fa93c7 ]

variable *nplanes is provided by user via system call argument. The
possible value of q_data->fmt->num_planes is 1-3, while the value
of *nplanes can be 1-8. The array access by index i can cause array
out-of-bounds.

Fix this bug by checking *nplanes against the array size.

Signed-off-by: Wei Chen <harperchen1110@gmail.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
index 641f533c417fd..173407664cf42 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
@@ -753,6 +753,13 @@ int vb2ops_vdec_queue_setup(struct vb2_queue *vq, unsigned int *nbuffers,
 	}
 
 	if (*nplanes) {
+		if (vq->type == V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE) {
+			if (*nplanes != q_data->fmt->num_planes)
+				return -EINVAL;
+		} else {
+			if (*nplanes != 1)
+				return -EINVAL;
+		}
 		for (i = 0; i < *nplanes; i++) {
 			if (sizes[i] < q_data->sizeimage[i])
 				return -EINVAL;
-- 
2.39.2

