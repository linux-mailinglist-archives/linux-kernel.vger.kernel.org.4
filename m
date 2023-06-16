Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0DA7333ED
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 16:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345235AbjFPOtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 10:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbjFPOtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 10:49:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 039C630E7;
        Fri, 16 Jun 2023 07:49:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 71A9863DCE;
        Fri, 16 Jun 2023 14:49:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E387DC433C8;
        Fri, 16 Jun 2023 14:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686926942;
        bh=8PHm9QC8vIhbyTtp0cJ+k53orRmf0g+m7GbXYTsDqoM=;
        h=From:To:Cc:Subject:Date:From;
        b=nOqxJkOV7qE4jg5x4HRQDLiMypRFcXeisOQMHsuoQd/mdYhyYyLs7zCQw9+Ly6I37
         rJVg1SMFN6QtkE4xwZrUWCpnKN3bvEMEi9JbMWTbEwPAwV7pQYcRT/nJcI5oCMX0Db
         LN9KxA7zAFEdvDeohI14t2WFwdyaUh3t86ekomcrEDmLivsp58UWLc+wf9P6xobh1x
         HAMK+KOMiEqeAehgZbI7oA4H6xln8FQD+ualLaWVlDJ9x3WYoTMfbDrk6EhILRku1a
         zC3X17HvXEk4CpDVo/zDAJzUHjD6NNzNj1IbGFeIpFlFmtj+P6QTuwzDwsVHGbw//o
         FVyipDF9zaRwQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, kernel test robot <lkp@intel.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] media: verisilicon: fix excessive stack usage
Date:   Fri, 16 Jun 2023 16:48:47 +0200
Message-Id: <20230616144854.3818934-1-arnd@kernel.org>
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

In some configurations, gcc decides not to inline the register accessor functions,
which in turn leads to lots of temporary hantro_reg structures on the stack that
cannot be eliminated because they escape into an uninlined function:

drivers/media/platform/verisilicon/rockchip_vpu981_hw_av1_dec.c:1022:1: warning: the frame size of 1112 bytes is larger than 1024 bytes [-Wframe-larger-than=]

Mark all of these as __always_inline so the compiler is able to completely
eliminate the temporary structures instead, which brings the stack usage
back down to just the normal local variables.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202306151506.goHEegOd-lkp@intel.com/
Fixes: 727a400686a2c ("media: verisilicon: Add Rockchip AV1 decoder")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/media/platform/verisilicon/hantro.h | 22 ++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/media/platform/verisilicon/hantro.h b/drivers/media/platform/verisilicon/hantro.h
index 6523ffb748812..6c5e56ce5b351 100644
--- a/drivers/media/platform/verisilicon/hantro.h
+++ b/drivers/media/platform/verisilicon/hantro.h
@@ -370,26 +370,26 @@ extern int hantro_debug;
 	pr_err("%s:%d: " fmt, __func__, __LINE__, ##args)
 
 /* Structure access helpers. */
-static inline struct hantro_ctx *fh_to_ctx(struct v4l2_fh *fh)
+static __always_inline struct hantro_ctx *fh_to_ctx(struct v4l2_fh *fh)
 {
 	return container_of(fh, struct hantro_ctx, fh);
 }
 
 /* Register accessors. */
-static inline void vepu_write_relaxed(struct hantro_dev *vpu,
+static __always_inline void vepu_write_relaxed(struct hantro_dev *vpu,
 				      u32 val, u32 reg)
 {
 	vpu_debug(6, "0x%04x = 0x%08x\n", reg / 4, val);
 	writel_relaxed(val, vpu->enc_base + reg);
 }
 
-static inline void vepu_write(struct hantro_dev *vpu, u32 val, u32 reg)
+static __always_inline void vepu_write(struct hantro_dev *vpu, u32 val, u32 reg)
 {
 	vpu_debug(6, "0x%04x = 0x%08x\n", reg / 4, val);
 	writel(val, vpu->enc_base + reg);
 }
 
-static inline u32 vepu_read(struct hantro_dev *vpu, u32 reg)
+static __always_inline u32 vepu_read(struct hantro_dev *vpu, u32 reg)
 {
 	u32 val = readl(vpu->enc_base + reg);
 
@@ -397,27 +397,27 @@ static inline u32 vepu_read(struct hantro_dev *vpu, u32 reg)
 	return val;
 }
 
-static inline void vdpu_write_relaxed(struct hantro_dev *vpu,
+static __always_inline void vdpu_write_relaxed(struct hantro_dev *vpu,
 				      u32 val, u32 reg)
 {
 	vpu_debug(6, "0x%04x = 0x%08x\n", reg / 4, val);
 	writel_relaxed(val, vpu->dec_base + reg);
 }
 
-static inline void vdpu_write(struct hantro_dev *vpu, u32 val, u32 reg)
+static __always_inline void vdpu_write(struct hantro_dev *vpu, u32 val, u32 reg)
 {
 	vpu_debug(6, "0x%04x = 0x%08x\n", reg / 4, val);
 	writel(val, vpu->dec_base + reg);
 }
 
-static inline void hantro_write_addr(struct hantro_dev *vpu,
+static __always_inline void hantro_write_addr(struct hantro_dev *vpu,
 				     unsigned long offset,
 				     dma_addr_t addr)
 {
 	vdpu_write(vpu, addr & 0xffffffff, offset);
 }
 
-static inline u32 vdpu_read(struct hantro_dev *vpu, u32 reg)
+static __always_inline u32 vdpu_read(struct hantro_dev *vpu, u32 reg)
 {
 	u32 val = readl(vpu->dec_base + reg);
 
@@ -425,7 +425,7 @@ static inline u32 vdpu_read(struct hantro_dev *vpu, u32 reg)
 	return val;
 }
 
-static inline u32 vdpu_read_mask(struct hantro_dev *vpu,
+static __always_inline u32 vdpu_read_mask(struct hantro_dev *vpu,
 				 const struct hantro_reg *reg,
 				 u32 val)
 {
@@ -437,14 +437,14 @@ static inline u32 vdpu_read_mask(struct hantro_dev *vpu,
 	return v;
 }
 
-static inline void hantro_reg_write(struct hantro_dev *vpu,
+static __always_inline void hantro_reg_write(struct hantro_dev *vpu,
 				    const struct hantro_reg *reg,
 				    u32 val)
 {
 	vdpu_write_relaxed(vpu, vdpu_read_mask(vpu, reg, val), reg->base);
 }
 
-static inline void hantro_reg_write_s(struct hantro_dev *vpu,
+static __always_inline void hantro_reg_write_s(struct hantro_dev *vpu,
 				      const struct hantro_reg *reg,
 				      u32 val)
 {
-- 
2.39.2

