Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A21B460C076
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 03:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbiJYBHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 21:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbiJYBGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 21:06:25 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF354A10C;
        Mon, 24 Oct 2022 17:13:22 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-12c8312131fso13797337fac.4;
        Mon, 24 Oct 2022 17:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IGPioqrvo9StUbHADKkHl19MNXlGRLsr8yyQyLq+9dw=;
        b=fw426MFVi8E8FV5waIk4Oob4n7Z60FaIvxuxFizMZl0Bqjgu6QzlV08gF9kneZoYMm
         aM3Nw2cEIDRftpvXafrojAp2ttB3ExekuZm6uEu/dkvjs/r5sEka0OeTmTHUR/G6vTZh
         Ubcx2hEBP00PzwyTFlvbwPhRoV0WRxQkwcoknaqUDOHz2afOVF08TOaj8NF9pw4yvQbC
         f4gge7qgH7clv0bv5m2IsWrdz0TYehwQr6r4CcSzgrcCL62nIXmmJwAlAvUAotzyPk/Q
         nFhEU4//YOMAU+BxrcC/UKKbpafDL7QclxfAopSt+u4dxWj4PAAIZUTtPj4v+pjgS355
         k5QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IGPioqrvo9StUbHADKkHl19MNXlGRLsr8yyQyLq+9dw=;
        b=Pc8M8c0lEjqy3ruDFuGTLaC7ayd0VP/IhLucLsSuFV955PTrx7reaa1M6rwpEM19k0
         JAYattwbK9ZOB1qs3RLP9/Lx9pOn83BJzg8EysyN+KY1i38Vr6i4fX8tkDzZCO7YH7XH
         Iwj5vSDm9j2OBrEdTwRw9exds/wgbFCYLfVRuupgMnEk9uUf9ktJOWDbm3uMcesm1Fer
         f/NlL287NHBtBsZ/rBaU6Cx5diDCsSm+KcuR6jKux/FRCB0WOA73g8PrfMJ/8Gliht/q
         D9CEkB2kmqtxDlrcIa6HBKulgquFuZ7J39WnrPP19piongaCVzzCW+fwr7ynDo3ye3Cl
         CQ0w==
X-Gm-Message-State: ACrzQf0bceRsxydes4iyepHyzO4wRCqFiwhPvnRDAfL4nxKUYbZJEadP
        sY5eFtPg65Q2irqKqGm0ZMU=
X-Google-Smtp-Source: AMsMyM568uBoXBTKTQH5tI8SsoA5Gk98p6XETIY9iE85DbOALaC6GXX/8hoMHb4avmS4PetrB7QuuQ==
X-Received: by 2002:a05:6870:4284:b0:13b:91b7:89a8 with SMTP id y4-20020a056870428400b0013b91b789a8mr5715289oah.284.1666656801702;
        Mon, 24 Oct 2022 17:13:21 -0700 (PDT)
Received: from gabriel-Nitro-AN515-54.. (201-27-204-68.dsl.telesp.net.br. [201.27.204.68])
        by smtp.gmail.com with ESMTPSA id k41-20020a05687095a900b00131c3d4d38fsm757823oao.39.2022.10.24.17.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 17:13:20 -0700 (PDT)
From:   Gabriel Lima Luz <lima.gabriel.luz@gmail.com>
To:     Rui Miguel Silva <rmfrfs@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Cc:     Gabriel Lima Luz <lima.gabriel.luz@gmail.com>
Subject: [PATCH v2] staging: media: imx: imx7-media-csi: Fix parenthesis alignment
Date:   Mon, 24 Oct 2022 21:12:39 -0300
Message-Id: <20221025001239.16345-1-lima.gabriel.luz@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adhere to Linux kernel coding style.

Reported by checkpatch:

CHECK: Alignment should match open parenthesis

Signed-off-by: Gabriel Lima Luz <lima.gabriel.luz@gmail.com>
---
Altered changes acording to feedback for a more readable code

 drivers/staging/media/imx/imx7-media-csi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/media/imx/imx7-media-csi.c b/drivers/staging/media/imx/imx7-media-csi.c
index cbc66ef0eda8..b241b68f456c 100644
--- a/drivers/staging/media/imx/imx7-media-csi.c
+++ b/drivers/staging/media/imx/imx7-media-csi.c
@@ -1704,7 +1704,8 @@ static int imx7_csi_init_cfg(struct v4l2_subdev *sd,
 		mf->xfer_func = V4L2_MAP_XFER_FUNC_DEFAULT(mf->colorspace);
 		mf->ycbcr_enc = V4L2_MAP_YCBCR_ENC_DEFAULT(mf->colorspace);
 		mf->quantization = V4L2_MAP_QUANTIZATION_DEFAULT(!cc->yuv,
-					mf->colorspace, mf->ycbcr_enc);
+							mf->colorspace,
+							mf->ycbcr_enc);
 
 		csi->cc[i] = cc;
 	}
-- 
2.34.1

