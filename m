Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5206960BA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 11:28:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232384AbjBNK2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 05:28:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjBNK2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 05:28:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FFC7222CC;
        Tue, 14 Feb 2023 02:28:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B73B2B81D02;
        Tue, 14 Feb 2023 10:28:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81045C433EF;
        Tue, 14 Feb 2023 10:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676370511;
        bh=VXmlpVfXufPNp5GbWFKiYEO94rbwAJ8jTU7CP3mRlNU=;
        h=From:To:Cc:Subject:Date:From;
        b=Ru3vjApGt+0QIZXiTYclPxmiljRyZE2ThkkptgivuodTb1QAE6MLtnssWQ23G+bIn
         H5YVd3tMvHWrPZycDwqAWFO7WIfzrb77OnyJOsXafqSstauuwOjwQDIz8G5elR0r/D
         FhsTzUGh7IlrqQYf2woOVpdc2kUJmWOXUuQBc6OTx12QqbENTovcV+uDPw32vffiAn
         4YfSDeaEdRa63mc3tNOAyFM7zk82npNxUyIUrCz1b8uTZEAwCvIn2iLxlvQD1ecQg8
         taS3ziI2sIqmtnqE/se3E/enPNNHvmOzPOLU0h3ZZIqu7yZd3JQJXc37M9YzEkDMz9
         Z/SIrieSzHjtg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Mirela Rabulea <mirela.rabulea@nxp.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Ming Qian <ming.qian@nxp.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] media: imx-jpeg: avoid array overflow
Date:   Tue, 14 Feb 2023 11:28:20 +0100
Message-Id: <20230214102827.920927-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

gcc-9 (unlike newer versions) reports a possible array overflow
in mxc_jpeg_dec_irq():

drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c: In function 'mxc_jpeg_dec_irq':
drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c:641:28: error: array subscript 2 is above array bounds of 'u32[2]' {aka 'unsigned int[2]'} [-Werror=array-bounds]
  641 |   size += q_data->sizeimage[i];
      |           ~~~~~~~~~~~~~~~~~^~~
drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c:641:28: error: array subscript 3 is above array bounds of 'u32[2]' {aka 'unsigned int[2]'} [-Werror=array-bounds]

The compiler clearly deduces that fmt->mem_planes is at least '2' if
this code line is reached, and that fmt->comp_planes must be at least
one more for the loop to make sense. However, this does not actually
seem to be the case in the initialized values, so I would guess that
this part of the function is never reached in practice.

As a workaround, add a compile-time condition that skips any out-of-range
array indices.

Fixes: ccc9f1db9c6b ("media: imx-jpeg: Support contiguous and non contiguous format")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
index f085f14d676a..7a667bfc2424 100644
--- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
+++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
@@ -638,7 +638,8 @@ static u32 mxc_jpeg_get_plane_size(struct mxc_jpeg_q_data *q_data, u32 plane_no)
 
 	size = q_data->sizeimage[fmt->mem_planes - 1];
 	for (i = fmt->mem_planes; i < fmt->comp_planes; i++)
-		size += q_data->sizeimage[i];
+		if (i < MXC_JPEG_MAX_PLANES)
+			size += q_data->sizeimage[i];
 
 	return size;
 }
-- 
2.39.1

