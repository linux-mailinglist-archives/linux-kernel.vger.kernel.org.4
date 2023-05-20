Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D15270A9B5
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 20:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbjETSTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 14:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231838AbjETSTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 14:19:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 437EAE66;
        Sat, 20 May 2023 11:19:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F2D8F611ED;
        Sat, 20 May 2023 18:18:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79BAAC433EF;
        Sat, 20 May 2023 18:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684606694;
        bh=kV3lnCQLNsX1P+lNMdGzqoGUQ+2ziiemz20pKJDmjMA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iz+zlLzXkGVdn0ygi6pQe+SG/B6cq2j7T/DIr2cJBUdTcg74d2zEMWDsJgucbUPem
         hOL/o3tvFV/ErjMoc+7zGDkW/xLIi40E4g1wm/mkLmzxGGyFem4If0cLKpnE0nnxC4
         xd4ODpgxMYttMRtNri6c2NwPUQn4QzfM2Z33fvJtBtbWYMGMsiqbMKcZeFPD9y6AbO
         utgtmx8F0F6fpoV19vDnTs8WqNqaClTRgxxDVb3fb5RWQNb3KvxpA2cX7E8/XAO39e
         eG2J5DWRERVOEFHzOJ7WLDCRAPl/u0R99Y5Ak+3D1z+BJE88tnU3cCTXKvH/Z7lxs0
         J/MkziuDabOEg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sasha Levin <sashal@kernel.org>, niklas.soderlund@ragnatech.se,
        mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH AUTOSEL 6.3 07/18] media: rcar-vin: Fix NV12 size alignment
Date:   Sat, 20 May 2023 14:17:39 -0400
Message-Id: <20230520181750.823365-7-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230520181750.823365-1-sashal@kernel.org>
References: <20230520181750.823365-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

[ Upstream commit cb88d8289fc222bd21b7a7f99b055e7e73e316f4 ]

When doing format validation for NV12 the width and height should be
aligned to 32 pixels.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/renesas/rcar-vin/rcar-dma.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/renesas/rcar-vin/rcar-dma.c b/drivers/media/platform/renesas/rcar-vin/rcar-dma.c
index cc6b59e5621ae..23598e22adc72 100644
--- a/drivers/media/platform/renesas/rcar-vin/rcar-dma.c
+++ b/drivers/media/platform/renesas/rcar-vin/rcar-dma.c
@@ -1320,9 +1320,15 @@ static int rvin_mc_validate_format(struct rvin_dev *vin, struct v4l2_subdev *sd,
 		if (!vin->scaler)
 			return -EPIPE;
 	} else {
-		if (fmt.format.width != vin->format.width ||
-		    fmt.format.height != vin->format.height)
-			return -EPIPE;
+		if (vin->format.pixelformat == V4L2_PIX_FMT_NV12) {
+			if (ALIGN(fmt.format.width, 32) != vin->format.width ||
+			    ALIGN(fmt.format.height, 32) != vin->format.height)
+				return -EPIPE;
+		} else {
+			if (fmt.format.width != vin->format.width ||
+			    fmt.format.height != vin->format.height)
+				return -EPIPE;
+		}
 	}
 
 	if (fmt.format.code != vin->mbus_code)
-- 
2.39.2

