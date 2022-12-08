Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C68B647192
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 15:22:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbiLHOWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 09:22:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbiLHOVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 09:21:21 -0500
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6010E98554;
        Thu,  8 Dec 2022 06:20:54 -0800 (PST)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 1E190C0010;
        Thu,  8 Dec 2022 14:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1670509253;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l1d1C6XOR5CdMp7rtfdwwMdKTU/wg8Y6oozqFuEEadY=;
        b=ivdJdSy9X76V6OrTItBkoQRR+c4AdoISFooXkR8IGRL2MT3HVUScvIivkpWj1AdlsnPkc/
        UKHvMn44v8XAb4kZHG2uEvuC9S3D42mj7i6jp4YYcmmJ7Q5qaGg7OkcDKBkrrqCd7pfULv
        il6rbTPxXVDP1VJKyBYbb3ouJQaIiJrK2dpqi2pk4EdR+GHrIWcbSQOXuRmzOIbZNKxmDB
        P+BIzv2n2K+mIIns3UvNnTbY5fMAhoaes9bxgZzzNOsP02Z8OsHlckCVTNca/AUMMzJ76f
        3CO8V2NbEMBCDmo86DMYWnhoHJAqB6LAqRusyrYfnTcrS2fEXrc9gaXeAV+8HA==
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Cc:     Yong Deng <yong.deng@magewell.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Conor Dooley <conor@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH v3 12/12] media: sun6i-isp: params: Unregister pending buffer on cleanup
Date:   Thu,  8 Dec 2022 15:20:06 +0100
Message-Id: <20221208142006.425809-13-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221208142006.425809-1-paul.kocialkowski@bootlin.com>
References: <20221208142006.425809-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The state cleanup helper should unregister the pending buffer from
the state after returning it to v4l2, like it is done for other
buffers in the wait queue.

Before this change, the pending buffer from a previous run might have
been returned at the beginning of the next run, causing an error.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Fixes: e3185e1d7c14 ("media: staging: media: Add support for the Allwinner A31 ISP")
---
 drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_params.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_params.c b/drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_params.c
index 7b41a13162b9..e28be895b486 100644
--- a/drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_params.c
+++ b/drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_params.c
@@ -208,6 +208,8 @@ static void sun6i_isp_params_state_cleanup(struct sun6i_isp_device *isp_dev,
 		vb2_buffer = &state->pending->v4l2_buffer.vb2_buf;
 		vb2_buffer_done(vb2_buffer, error ? VB2_BUF_STATE_ERROR :
 				VB2_BUF_STATE_QUEUED);
+
+		state->pending = NULL;
 	}
 
 	list_for_each_entry(isp_buffer, &state->queue, list) {
-- 
2.38.1

