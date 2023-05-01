Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFAC66F2C35
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 04:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbjEAC61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 22:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232192AbjEAC6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 22:58:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B8EE5C;
        Sun, 30 Apr 2023 19:57:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E1D0D615CC;
        Mon,  1 May 2023 02:57:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA1A9C4339B;
        Mon,  1 May 2023 02:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682909864;
        bh=3RQ3NpkUvKvMX1Q9TThOfZqbeNUdpgUUkq+Yf3PtgjM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mu8J4lgATEE3YhooCJV9LmzpLj7kc/BbZngHRRxCrjcqG8HzboUGk2qjG4Ok4jtc5
         6eZhOSoRn7IjzytWkVOtk3gV/0WklpW3H1wlq4R/ybFyZrX7Wro7qyMVXeXt0Oz9BY
         gIaP2pDfJuQ7m7pZTGcfI5/UTy1a1PN2K9XMAkwk9KXqna4pAQ625ri28tQTBSLgYl
         BUTtOPLq5cbDRihhc4vNATY33odA6b9j5h9sOZHyhlvH7rssLomH8veCINXm1fGtSp
         Hdt8dQQethKvsNUg2N/E56FFiPL1xmAp780Jp3wGHDManoNNuM633zksdMEr9Hr/SG
         X7PmODWMuDTgw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Mirela Rabulea <mirela.rabulea@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 6.3 13/44] media: imx-jpeg: Bounds check sizeimage access
Date:   Sun, 30 Apr 2023 22:56:01 -0400
Message-Id: <20230501025632.3253067-13-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230501025632.3253067-1-sashal@kernel.org>
References: <20230501025632.3253067-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kees Cook <keescook@chromium.org>

[ Upstream commit 474acc639fc8671fa4c1919d9e03253c82b6d321 ]

The call of mxc_jpeg_get_plane_size() from mxc_jpeg_dec_irq() sets
plane_no argument to 1. The compiler sees that it's possible to end up
with an access beyond the bounds of sizeimage, if mem_planes was too
large:

        if (plane_no >= fmt->mem_planes)        // mem_planes = 2+
                return 0;

        if (fmt->mem_planes == fmt->comp_planes) // comp_planes != mem_planes
                return q_data->sizeimage[plane_no];

        if (plane_no < fmt->mem_planes - 1)     // mem_planes = 2
                return q_data->sizeimage[plane_no];

comp_planes == 0 or 1 is safe. comp_planes > 2 would be out of bounds.

(This isn't currently possible given the contents of mxc_formats, though.)

Silence the warning by bounds checking comp_planes for future
robustness. Seen with GCC 13:

In function 'mxc_jpeg_get_plane_size',
    inlined from 'mxc_jpeg_dec_irq' at ../drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c:729:14:
../drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c:641:42: warning: array subscript 2 is above array bounds of 'u32[2]' {aka 'unsigned int[2]'} [-Warray-bounds=]
  641 |                 size += q_data->sizeimage[i];
      |                         ~~~~~~~~~~~~~~~~~^~~
In file included from ../drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h:112,
                 from ../drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c:63:
../drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h: In function 'mxc_jpeg_dec_irq':
../drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h:84:41: note: while referencing 'sizeimage'
   84 |         u32                             sizeimage[MXC_JPEG_MAX_PLANES];
      |                                         ^~~~~~~~~

Cc: Mirela Rabulea <mirela.rabulea@nxp.com>
Cc: NXP Linux Team <linux-imx@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
index f085f14d676ad..c898116b763a2 100644
--- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
+++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
@@ -637,6 +637,11 @@ static u32 mxc_jpeg_get_plane_size(struct mxc_jpeg_q_data *q_data, u32 plane_no)
 		return q_data->sizeimage[plane_no];
 
 	size = q_data->sizeimage[fmt->mem_planes - 1];
+
+	/* Should be impossible given mxc_formats. */
+	if (WARN_ON_ONCE(fmt->comp_planes > ARRAY_SIZE(q_data->sizeimage)))
+		return size;
+
 	for (i = fmt->mem_planes; i < fmt->comp_planes; i++)
 		size += q_data->sizeimage[i];
 
-- 
2.39.2

