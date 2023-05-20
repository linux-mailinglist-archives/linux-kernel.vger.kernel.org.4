Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BBFD70A9AA
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 20:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbjETSTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 14:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231687AbjETSS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 14:18:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C6910EC;
        Sat, 20 May 2023 11:18:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7CF3460F97;
        Sat, 20 May 2023 18:18:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C959C433EF;
        Sat, 20 May 2023 18:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684606691;
        bh=qygkCaueoV0Y08cF/1bEx58wZi9wpmzZxDqhrtlsgaQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y44xKOQRwKM8KyjGgzaNnx9aBwqez2BvT9WEoslPP/ofPLN9vS0Ax2Gbr9X8n0+a/
         2NHgKGZ7uJWJNrfUVmXk81eeO9Zdu9kDZZ+4Zjo/7NgQqOiIkcSkXDV70GE6FJgc2q
         s0X6QJOZVFWIhHXSJrxpOPnvmfAKMgk0MP8uJjEpz12JmbTizlD0KQJ9HYRfLF8opv
         OqgkODFLwTqA+9Hrt+BLzJt4K4OYHPCy6ebUYIsVvYDYy0iDLbne4uVsE6eU66UAY2
         jobBk/Ywq3qZv2zZ6evRouqPjRPnYC3lCnqPHWs4eOdzqmV1/uWkapoEpMxMYaDiJX
         akCK8TNHlhs0g==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sasha Levin <sashal@kernel.org>, niklas.soderlund@ragnatech.se,
        mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH AUTOSEL 6.3 06/18] media: rcar-vin: Gen3 can not scale NV12
Date:   Sat, 20 May 2023 14:17:38 -0400
Message-Id: <20230520181750.823365-6-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230520181750.823365-1-sashal@kernel.org>
References: <20230520181750.823365-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

[ Upstream commit 879c5a458e532b95783ce27f704d1b21573066f7 ]

The VIN modules on Gen3 can not scale NV12, fail format validation if
the user tries. Currently no frames are produced if this is attempted.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/renesas/rcar-vin/rcar-dma.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/media/platform/renesas/rcar-vin/rcar-dma.c b/drivers/media/platform/renesas/rcar-vin/rcar-dma.c
index 98bfd445a649b..cc6b59e5621ae 100644
--- a/drivers/media/platform/renesas/rcar-vin/rcar-dma.c
+++ b/drivers/media/platform/renesas/rcar-vin/rcar-dma.c
@@ -1312,6 +1312,11 @@ static int rvin_mc_validate_format(struct rvin_dev *vin, struct v4l2_subdev *sd,
 	}
 
 	if (rvin_scaler_needed(vin)) {
+		/* Gen3 can't scale NV12 */
+		if (vin->info->model == RCAR_GEN3 &&
+		    vin->format.pixelformat == V4L2_PIX_FMT_NV12)
+			return -EPIPE;
+
 		if (!vin->scaler)
 			return -EPIPE;
 	} else {
-- 
2.39.2

