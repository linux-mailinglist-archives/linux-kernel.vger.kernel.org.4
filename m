Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C40FC6C2838
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 03:32:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbjCUCcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 22:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCUCcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 22:32:10 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42180392AD;
        Mon, 20 Mar 2023 19:31:48 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id h83so6351839iof.8;
        Mon, 20 Mar 2023 19:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679365907;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hGWpPpB5KAPHuRmiWoisUus8Y5OkM2ck0KEKmSz4i0U=;
        b=hU9torN5JJeGKeHoR13hNgl4i1vbBpcHwPlpjyMoH7uOhgqKvpUbRwZNSp3Nub3QdL
         Fmhe/G2gn003kMTGkrgBAYEK+0w3cNVcw3qtvFl+sAtGrAjVqdlUsbnPkNacm+utFYqy
         oQlD6bnF+J6wZH52ytBCPpGuivIMhJ8vjVAyW8tJhk7KoO9/51JFLaHp7d2qJWhsCJ8Q
         sS5qS2VdAxxzqU/BNxXgSLm1mmx/YbsTkovGW5fsO/D5/5Cl82NQQ44/3F0vTVPxashl
         FxMMBAtCOk+Y4BA2Kj7t1h768M7VM5QV13oWKhVGqd72/66W4+wIP+cT6Sv5J1fMaWy3
         vJdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679365907;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hGWpPpB5KAPHuRmiWoisUus8Y5OkM2ck0KEKmSz4i0U=;
        b=PSM0r+T8/n3OJ4XayvHiQsOdWJBwqcXK5QFFAp8+Fg8GLWYblbwDjCos46zgmtd8Lf
         4Bci2Ij3QXcgKirebKu3DmS7bT/crC9x3lyYYSkoXuWnfj7gBTQfXNXW1EFYfmeX0zHU
         p+8nKnwFW5mgI77lQBsD0nTGMyh2aUvE95CgdVwL5Tc24dfm4nUeAaXItzL/TBbXYKOf
         n95pq9UQMNVNyw1iPEG+VXxpkqg08l8AV59CCUsw5xNEPqCl76dk5ftftbj2NXQuMIvv
         kpBO9KaGp2I76vPhfCuMjjWr/nrUBvJYXnhiLMpSr4qfEiJjCxAAyHnu9FdTezpI/yHF
         PYQA==
X-Gm-Message-State: AO0yUKUWLcUQZBwmlLqEUOQO6VykYC64/SBXC817FEZhWOKfLlwiU8wl
        qGeQYTJCTAgNzV6XZAznn18lSDGbXt4=
X-Google-Smtp-Source: AK7set9w1XKjD1VYw1ftP2NWhLjXE38EiYgy8vCM8TNbmCGRj+JCVdTaCCuzqE5aKGwjln31H1qDtg==
X-Received: by 2002:a5e:8f4a:0:b0:753:876:5bf9 with SMTP id x10-20020a5e8f4a000000b0075308765bf9mr840035iop.6.1679365907244;
        Mon, 20 Mar 2023 19:31:47 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:447:d001:897f:1387:3268:b209:f4ec])
        by smtp.gmail.com with ESMTPSA id a28-20020a027a1c000000b004065ad317fdsm2241200jac.151.2023.03.20.19.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 19:31:46 -0700 (PDT)
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
Date:   Mon, 20 Mar 2023 21:31:32 -0500
Message-Id: <20230321023136.57986-1-aford173@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
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

