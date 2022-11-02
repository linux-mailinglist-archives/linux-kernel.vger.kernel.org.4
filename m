Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E62DB616680
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 16:51:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbiKBPvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 11:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiKBPvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 11:51:21 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 060B22AC4E;
        Wed,  2 Nov 2022 08:51:20 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id y16so25146487wrt.12;
        Wed, 02 Nov 2022 08:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s+b8MGxoMM7dt63fJhCwSK3LN+dkZHgo46dIEwpUZaw=;
        b=pC2K6ewvN//7eO9Ct7Je49ZFsiMM1WDMN9bjl9f3ZOHKERloo4ZAEM8h1myLHMXtg9
         orJsVnQiTV0NfnInGAsb8+Ocw5h3GR9uLpHAXYom0EMENPg8BNze2K0O/zAr/S6kRrss
         Hl5qwRZuf3YnbBx4/8QS5LLOi8fGXc29tWdH13vvfMv0rFUQYwZVm4z20idmdAZwz+P9
         izQ+yVOXyRJ0uQkoII44efV+M/iE6mmtF/rv8iU2FMjIVpMtkjVrdw3tXXos7uu+vnjh
         N4x3yyUYKfmeUsA5knR+tihXsl4L3ZyzTATbT9I1og7ewtdA6ZxeOVr7cLA8XyWvr1O3
         6uBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s+b8MGxoMM7dt63fJhCwSK3LN+dkZHgo46dIEwpUZaw=;
        b=eBX1CHfx4EVSRRGaVTAJK8A9FxYEtJza/l1654JKpIZZkf2XHBoPgJlkIchfoizjr+
         /gU7b7FVDybxqR6IRU6U13iWXpJcS4HlmvLD8ZGgt1rffD51g1hsR2S/oUKDhHUMTBD3
         44FUPah89e9a3+za+2t6uzO7ajb4XNDk5hoN8DY8aif5+CTezy1bJsKMZqIdeQANXMI/
         ItlXxR2Z6FXwUi90yfIkokOT2kdjWmPpGWG/KDtNrnpO/XAbWnlxVLfVISO4u48Z3JSJ
         OasHEXcBbCPjeEE0fn+PxSVGp+fnsX8PIvlyRpjSLYnlpJF7BEnqkB+8s0PPJRptLirN
         EXcA==
X-Gm-Message-State: ACrzQf1KRd+WYgGb1t+dc0dJHz7EzVxpLBPp69Tf50vKIpKflv5JewaS
        b0Os2ZyXC5YJX84qcv07jQk=
X-Google-Smtp-Source: AMsMyM5Wwlmv2CJWkvj3LxDz4CVi/7lH8tn2cThpiZ+cLNFDmAmmJsj3Cp+SGWp6jkBZmz20okS9Aw==
X-Received: by 2002:adf:fe85:0:b0:236:7cde:a95d with SMTP id l5-20020adffe85000000b002367cdea95dmr15769632wrr.531.1667404278413;
        Wed, 02 Nov 2022 08:51:18 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id bi19-20020a05600c3d9300b003c6f3e5ba42sm2317093wmb.46.2022.11.02.08.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 08:51:17 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Dafna Hirschfeld <dafna@fastmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>, linux-media@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: rkisp1: make const arrays ae_wnd_num and hist_wnd_num static
Date:   Wed,  2 Nov 2022 15:51:17 +0000
Message-Id: <20221102155117.144570-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

Don't populate the const arrays on the stack, instead make them
static. Also makes the object code smaller.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/media/platform/rockchip/rkisp1/rkisp1-params.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-params.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-params.c
index d8731ebbf479..3482f7d707b7 100644
--- a/drivers/media/platform/rockchip/rkisp1/rkisp1-params.c
+++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-params.c
@@ -715,7 +715,7 @@ static void rkisp1_aec_config_v12(struct rkisp1_params *params,
 	u32 exp_ctrl;
 	u32 block_hsize, block_vsize;
 	u32 wnd_num_idx = 1;
-	const u32 ae_wnd_num[] = { 5, 9, 15, 15 };
+	static const u32 ae_wnd_num[] = { 5, 9, 15, 15 };
 
 	/* avoid to override the old enable value */
 	exp_ctrl = rkisp1_read(params->rkisp1, RKISP1_CIF_ISP_EXP_CTRL);
@@ -822,7 +822,7 @@ static void rkisp1_hst_config_v12(struct rkisp1_params *params,
 	u32 block_hsize, block_vsize;
 	u32 wnd_num_idx, hist_weight_num, hist_ctrl, value;
 	u8 weight15x15[RKISP1_CIF_ISP_HIST_WEIGHT_REG_SIZE_V12];
-	const u32 hist_wnd_num[] = { 5, 9, 15, 15 };
+	static const u32 hist_wnd_num[] = { 5, 9, 15, 15 };
 
 	/* now we just support 9x9 window */
 	wnd_num_idx = 1;
-- 
2.37.3

