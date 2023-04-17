Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5FE6E54B6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 00:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjDQWhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 18:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjDQWhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 18:37:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 065C14211;
        Mon, 17 Apr 2023 15:37:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 95401622A0;
        Mon, 17 Apr 2023 22:37:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B68D1C433D2;
        Mon, 17 Apr 2023 22:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681771064;
        bh=4chkLext4acUulDFIohP7fhi352aObb1FKu9YKPstuE=;
        h=From:To:Cc:Subject:Date:From;
        b=hb/S2y/rigkJ/WkHNx0ib5MgI+9jzdccld4y2a7WmRgQJTQxWBrKxMP7/1migDa+l
         mpaq8omKobu5mJmldMLps29p1NJnyNs9tF06dbKH50Gf/FWwxCNxCIZC9Wb2i4Aacc
         Hffx1HHVTZmFhpypOzI0iUqXs2HyHvycFwhhVMz5NxqyGcm2k3IsYslMRfLclnOnHS
         W5tCxT5Sn5+0XBEmLmszFqMLEMG/odozdGjLAhawRNwFc5T66v4nnxd9kxCRYIx0mR
         5Va296OoFxxavFwIfnj8iln4VasY8gtLAKkmXCSCyrSGOdvr7nulYgpfX4ffysEdj8
         NY0G9CU4mBtiQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Christian Hemp <c.hemp@phytec.de>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Stefan Riedmueller <s.riedmueller@phytec.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] media: nxp: imx8-isi: fix buiding on 32-bit
Date:   Tue, 18 Apr 2023 00:37:27 +0200
Message-Id: <20230417223738.1811110-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
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

From: Arnd Bergmann <arnd@arndb.de>

The #if check is wrong, leading to a build failure:

drivers/media/platform/nxp/imx8-isi/imx8-isi-hw.c: In function 'mxc_isi_channel_set_inbuf':
drivers/media/platform/nxp/imx8-isi/imx8-isi-hw.c:33:5: error: "CONFIG_ARCH_DMA_ADDR_T_64BIT" is not defined, evaluates to 0 [-Werror=undef]
   33 | #if CONFIG_ARCH_DMA_ADDR_T_64BIT
      |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~

This could just be an #ifdef, but it seems nicer to just remove
the check entirely. Apparently the only reason for the #ifdef
is to avoid another warning:

drivers/media/platform/nxp/imx8-isi/imx8-isi-hw.c:55:24: error: right shift count >= width of type [-Werror=shift-count-overflow]

But this is best avoided by using the lower_32_bits()/upper_32_bits()
helpers.

Fixes: cf21f328fcaf ("media: nxp: Add i.MX8 ISI driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 .../media/platform/nxp/imx8-isi/imx8-isi-hw.c | 41 ++++++++++---------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/drivers/media/platform/nxp/imx8-isi/imx8-isi-hw.c b/drivers/media/platform/nxp/imx8-isi/imx8-isi-hw.c
index db538f3d88ec..f6112b83866a 100644
--- a/drivers/media/platform/nxp/imx8-isi/imx8-isi-hw.c
+++ b/drivers/media/platform/nxp/imx8-isi/imx8-isi-hw.c
@@ -29,11 +29,10 @@ static inline void mxc_isi_write(struct mxc_isi_pipe *pipe, u32 reg, u32 val)
 
 void mxc_isi_channel_set_inbuf(struct mxc_isi_pipe *pipe, dma_addr_t dma_addr)
 {
-	mxc_isi_write(pipe, CHNL_IN_BUF_ADDR, dma_addr);
-#if CONFIG_ARCH_DMA_ADDR_T_64BIT
+	mxc_isi_write(pipe, CHNL_IN_BUF_ADDR, lower_32_bits(dma_addr));
 	if (pipe->isi->pdata->has_36bit_dma)
-		mxc_isi_write(pipe, CHNL_IN_BUF_XTND_ADDR, dma_addr >> 32);
-#endif
+		mxc_isi_write(pipe, CHNL_IN_BUF_XTND_ADDR,
+			      upper_32_bits(dma_addr));
 }
 
 void mxc_isi_channel_set_outbuf(struct mxc_isi_pipe *pipe,
@@ -45,34 +44,36 @@ void mxc_isi_channel_set_outbuf(struct mxc_isi_pipe *pipe,
 	val = mxc_isi_read(pipe, CHNL_OUT_BUF_CTRL);
 
 	if (buf_id == MXC_ISI_BUF1) {
-		mxc_isi_write(pipe, CHNL_OUT_BUF1_ADDR_Y, dma_addrs[0]);
-		mxc_isi_write(pipe, CHNL_OUT_BUF1_ADDR_U, dma_addrs[1]);
-		mxc_isi_write(pipe, CHNL_OUT_BUF1_ADDR_V, dma_addrs[2]);
-#if CONFIG_ARCH_DMA_ADDR_T_64BIT
+		mxc_isi_write(pipe, CHNL_OUT_BUF1_ADDR_Y,
+			lower_32_bits(dma_addrs[0]));
+		mxc_isi_write(pipe, CHNL_OUT_BUF1_ADDR_U,
+			lower_32_bits(dma_addrs[1]));
+		mxc_isi_write(pipe, CHNL_OUT_BUF1_ADDR_V,
+			lower_32_bits(dma_addrs[2]));
 		if (pipe->isi->pdata->has_36bit_dma) {
 			mxc_isi_write(pipe, CHNL_Y_BUF1_XTND_ADDR,
-				      dma_addrs[0] >> 32);
+				      upper_32_bits(dma_addrs[0]));
 			mxc_isi_write(pipe, CHNL_U_BUF1_XTND_ADDR,
-				      dma_addrs[1] >> 32);
+				      upper_32_bits(dma_addrs[1]));
 			mxc_isi_write(pipe, CHNL_V_BUF1_XTND_ADDR,
-				      dma_addrs[2] >> 32);
+				      upper_32_bits(dma_addrs[2]));
 		}
-#endif
 		val ^= CHNL_OUT_BUF_CTRL_LOAD_BUF1_ADDR;
 	} else  {
-		mxc_isi_write(pipe, CHNL_OUT_BUF2_ADDR_Y, dma_addrs[0]);
-		mxc_isi_write(pipe, CHNL_OUT_BUF2_ADDR_U, dma_addrs[1]);
-		mxc_isi_write(pipe, CHNL_OUT_BUF2_ADDR_V, dma_addrs[2]);
-#if CONFIG_ARCH_DMA_ADDR_T_64BIT
+		mxc_isi_write(pipe, CHNL_OUT_BUF2_ADDR_Y,
+			      lower_32_bits(dma_addrs[0]));
+		mxc_isi_write(pipe, CHNL_OUT_BUF2_ADDR_U,
+			      lower_32_bits(dma_addrs[1]));
+		mxc_isi_write(pipe, CHNL_OUT_BUF2_ADDR_V,
+			      lower_32_bits(dma_addrs[2]));
 		if (pipe->isi->pdata->has_36bit_dma) {
 			mxc_isi_write(pipe, CHNL_Y_BUF2_XTND_ADDR,
-				      dma_addrs[0] >> 32);
+				      upper_32_bits(dma_addrs[0]));
 			mxc_isi_write(pipe, CHNL_U_BUF2_XTND_ADDR,
-				      dma_addrs[1] >> 32);
+				      upper_32_bits(dma_addrs[1]));
 			mxc_isi_write(pipe, CHNL_V_BUF2_XTND_ADDR,
-				      dma_addrs[2] >> 32);
+				      upper_32_bits(dma_addrs[2]));
 		}
-#endif
 		val ^= CHNL_OUT_BUF_CTRL_LOAD_BUF2_ADDR;
 	}
 
-- 
2.39.2

