Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3685070AA66
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 20:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232373AbjETS2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 14:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231908AbjETS1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 14:27:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 148D5198D;
        Sat, 20 May 2023 11:26:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 00E6960A24;
        Sat, 20 May 2023 18:24:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8201C433EF;
        Sat, 20 May 2023 18:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684607060;
        bh=dW1NgTsNOzopuYcGNJ5kIrt/3hgndm+ge9v3hE0088I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aIENLaJywDOxCqSsHJrzGn4YMBe95WR+YvKcF8IexiqCIsYMWQEp7+WKCO5uPJNx6
         cC9alxj+nVKSZ3p7DapAtFNYB47tWDW7DofUdomejPgL/zGFv6onH5aWDhz5b7Bn4+
         YNB6gvaYMYx3XJNjZvYKOjQsG5HwAXPyyWIlfp0DNjk7MA6zfdefjPpWTk8vsV/btW
         b3IhLwCJdzbGzDQDsX03XDlinalRi/MlitC9z+gjGxCrKB2MJrAVrkt00J0l8o6Fmg
         YXkSCAy1DugM+ucF1SmGxY7c5IFwR+FYwyM6mUzeF8Iog44puPOKFP37Eyi/4XCpyu
         OT8nTeZOAKE3g==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sasha Levin <sashal@kernel.org>, mchehab@kernel.org,
        linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 2/5] media: rcar-vin: Select correct interrupt mode for V4L2_FIELD_ALTERNATE
Date:   Sat, 20 May 2023 14:24:06 -0400
Message-Id: <20230520182412.860973-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230520182412.860973-1-sashal@kernel.org>
References: <20230520182412.860973-1-sashal@kernel.org>
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

[ Upstream commit e10707d5865c90d3dfe4ef589ce02ff4287fef85 ]

When adding proper support for V4L2_FIELD_ALTERNATE it was missed that
this field format should trigger an interrupt for each field, not just
for the whole frame. Fix this by marking it as progressive in the
capture setup, which will then select the correct interrupt mode.

Tested on both Gen2 and Gen3 with the result of a doubling of the frame
rate for V4L2_FIELD_ALTERNATE. From a PAL video source the frame rate is
now 50, which is expected for alternate field capture.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/rcar-vin/rcar-dma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/rcar-vin/rcar-dma.c b/drivers/media/platform/rcar-vin/rcar-dma.c
index 70a8cc433a03f..cc28e2cb23f11 100644
--- a/drivers/media/platform/rcar-vin/rcar-dma.c
+++ b/drivers/media/platform/rcar-vin/rcar-dma.c
@@ -633,6 +633,7 @@ static int rvin_setup(struct rvin_dev *vin)
 		vnmc = VNMC_IM_FULL | VNMC_FOC;
 		break;
 	case V4L2_FIELD_NONE:
+	case V4L2_FIELD_ALTERNATE:
 		vnmc = VNMC_IM_ODD_EVEN;
 		progressive = true;
 		break;
-- 
2.39.2

