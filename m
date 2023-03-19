Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 427CE6C01FE
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 14:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbjCSNVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 09:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjCSNVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 09:21:33 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C0F6222C0;
        Sun, 19 Mar 2023 06:21:32 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id i19so5253240ila.10;
        Sun, 19 Mar 2023 06:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679232091;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7oO5yasZy50THtoP01vEEeRvICSlmDhbdsPlQ6bpxyE=;
        b=Iweei3omL5R7EO2WveyUunV176KNcPBcN4f5G7mLnOivTmTfZYR40NJT/YwshPuZQf
         sdxs5Y/BmdBvLrmXLDkuM/nFyuGu6N1w3Lnq0DLK4rEsxLMb5FM1Dp5P45ezUKh2EVID
         dV9irgI0kv8mSfgnZExplIxCOeKJzCts7fjxO6V2QvLo1VQq+etbmrCiNXDL8mhsu4Bc
         tE5/IlsQV7fzumr0xpiAmGwI62cspv5x0Y+rXsav46pGt5eIsgVhpHDr8UT3YCwUBGsL
         sH5GZAdGAMz9qugkQiJpJEY9BpXiWFeMA66D5rE/U2/ZOTfF7wDetRXB07yl2zt6UzH6
         K2Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679232091;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7oO5yasZy50THtoP01vEEeRvICSlmDhbdsPlQ6bpxyE=;
        b=mFYBkTUYhFKZA1UsTW9nmxV3rlAJL7wHjFTnuomYl+WKkWLMs71BApZLob/QQ+m5fR
         KtUPWs2Fb0Qp1Ly9+ySaSXemVFsAMc8fJR2Bf3JodSxZT00jUz/WEnzSTq3ROluF79U4
         O5854hDiA3M6EyvESlxTMj2+IpO+rpqL8u2VidK5fEmulcT5jfyqR5UxjJLo7e5oQxg4
         ZuFXn0eCMx0pqg0CG5M/NbklWDM8mrkmBcQ2oWt/uqbNCShPMUQ2dpoDcxiBpp8saRTA
         Xygu74oZ/m9p5yCtT5C+ex4MjRCAyvbLHT5j/Eyy36qEFyisWEo6nWZmO97+2+XmCUjn
         TSEQ==
X-Gm-Message-State: AO0yUKVcpKzIEjV1TlsdhR+KWTQlTgPB5u3uaOaCqWMQlg8UvcN5S+Q1
        aRXiEFjbJCWMWlWDYMOdsoFopHf6vKs=
X-Google-Smtp-Source: AK7set8U8ZG7OjYyO8SnNNdm7hhY4pH9hcMwhAq5e/HCHWZh1Nx6SU6iz/HPFAHUPBdJPo5X+BorJQ==
X-Received: by 2002:a92:c9c1:0:b0:322:f0bd:9c71 with SMTP id k1-20020a92c9c1000000b00322f0bd9c71mr3723114ilq.9.1679232091443;
        Sun, 19 Mar 2023 06:21:31 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan (c-75-72-166-104.hsd1.mn.comcast.net. [75.72.166.104])
        by smtp.gmail.com with ESMTPSA id a23-20020a027357000000b00406227162fesm2363460jae.32.2023.03.19.06.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Mar 2023 06:21:30 -0700 (PDT)
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
Subject: [PATCH 0/3] clk: imx: Improve imx8mm/imx8mn LCDIF clocks
Date:   Sun, 19 Mar 2023 08:21:17 -0500
Message-Id: <20230319132120.6347-1-aford173@gmail.com>
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
request a better parent clock if the proper clock flag is
enabled, then sets that flag in the corresponding imx8mm and 
imx8mn clocks.

This also has a side benefit of allowing the video-pll to run
at a lower clock speed which can potentially save some power
depending on the requested resolution and refresh rate.

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

