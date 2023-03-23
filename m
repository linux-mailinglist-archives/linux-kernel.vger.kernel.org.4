Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE5BC6C7357
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 23:51:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbjCWWv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 18:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231311AbjCWWvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 18:51:44 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F3F2C660;
        Thu, 23 Mar 2023 15:51:42 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id z1so78242iot.11;
        Thu, 23 Mar 2023 15:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679611901;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+UnBIsoL06ul586Qa3bwXtsOpGTIU2c/qhQKSFEV/y8=;
        b=nKZyXAxk53A9/NUyEBnydGtUJrcnMT7bMgYIDhdaaKoxVaGnnqN1FcxsfhjeufLu3w
         9wfZIBv0FyTO4F+gN1pDr87wzeAHZABZjYwYh+axa+CfMOf68O890vIASPikrDoC9Asl
         oBRhvyztk4tNGCLiSUYnfaDsqHEvpSISNzP7UYOly/O9mFB2pmHB8ffScAQ9rvFPYMqx
         lBklGW0BpZXs22ud/9W7wECYJ/x9dDiVxE7QAdfDzEFERyco7wiNqo6tTb+xHId5toTo
         MBPTOVawjzlwdd8NCHuvaXxzJ4Ew14TcHcDEI3k92MkSRva8VKPLvwDyOD+DXCS3kJj3
         R12g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679611901;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+UnBIsoL06ul586Qa3bwXtsOpGTIU2c/qhQKSFEV/y8=;
        b=IBKIk9zxx5sjmYzdfWo9K93yGkTrxXkxV44MXAc3n8qBCxPNjql3tr7rLVz+CnZFHn
         Q4IaxClbCRtwqTkDzWM3918m6nPY1qxp/a84eKu46FB19KjJikgZSXmnkab+ZP4y4rvZ
         mY4bAo8aY5DLO7Df+60Bv+cm/SDyYrgfrsHj9Nx9cotgTO+pVQ1BJPFtTSBjiWl2qjUL
         QG9JYDprwurSw6BzaeAHaD0zm2bej6ANj2BHf5f75xyoYW/qEG6Kt3p2gEIbXDrZ6Mkt
         boZljVQjl2KR2JfFAOI4hRFZzreOhZSUqtK5MyEPLMqZYh5wZceYgwWCXdRnldOooyZh
         ZX0g==
X-Gm-Message-State: AO0yUKXT40VP5BzURXKWXyZrcXD8tz8+rIDPYUxjDzFa2d+XtaZUnQgr
        aYcR6w9NAYMdqwc1P6vfHs8gIV5whi4=
X-Google-Smtp-Source: AK7set+mtHynBG5wPBpiwElgQd2SKyuTocEl+HCMtbl8s56W8aYQs3B1SPdVz6s2zkNm92V4R5exGw==
X-Received: by 2002:a6b:5b17:0:b0:758:6e42:83e4 with SMTP id v23-20020a6b5b17000000b007586e4283e4mr599306ioh.11.1679611901273;
        Thu, 23 Mar 2023 15:51:41 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:447:d001:897f:f38d:f05d:4666:1249])
        by smtp.gmail.com with ESMTPSA id f102-20020a0284ef000000b0040631e8bf89sm6266988jai.38.2023.03.23.15.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 15:51:40 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 0/4] clk: imx: Improve imx8mm/imx8mn LCDIF clocks
Date:   Thu, 23 Mar 2023 17:51:24 -0500
Message-Id: <20230323225128.117061-1-aford173@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both the i.MX8M Mini and Nano have a video_pll which can be used 
to source a clock which feeds the lcdif interface.  This interface
currently fixes video_pll and divides down the clock feeding LCDIF.
However, when connected to an HDMI bridge chip that supports a
variety of video resolutions and refresh rates, the only settings
that properly sync are ones that evenly divide from the video_pll_out
clock.

This series adds the ability for the clk-compolsite-8m to
request a better parent clock rate if the proper clock flag is
enable and sets that flag in the corresponding imx8mm and 
imx8mn video_pll clocks to increase the number of resolutions
and refresh rates timings that the LCDIF can produce.

This also has a side benefit of allowing the video-pll to run
at a lower clock speed which can potentially save some power
depending on the requested resolution and refresh rate.

V3:  Change the name of clk_divider_determine_rate to
      imx8m_clk_divider_determine_rate
V2:  Split off the new imx8m_clk_hw_composite_flags definition
     into its own patch and re-order to fix build error.
      
Adam Ford (3):
  clk: imx: composite-8m: Add support to determine_rate
  clk: imx8mm: Let IMX8MM_CLK_LCDIF_PIXEL set parent rate
  clk: imx: Let IMX8MN_CLK_DISP_PIXEL set parent rate

 drivers/clk/imx/clk-composite-8m.c | 7 +++++++
 drivers/clk/imx/clk-imx8mm.c       | 2 +-
 drivers/clk/imx/clk-imx8mn.c       | 2 +-
 drivers/clk/imx/clk.h              | 4 ++++
 4 files changed, 13 insertions(+), 2 deletions(-)

-- 
2.34.1

