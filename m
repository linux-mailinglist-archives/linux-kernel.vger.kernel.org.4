Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 719896C73CC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 00:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjCWXBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 19:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjCWXBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 19:01:31 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE51B464;
        Thu, 23 Mar 2023 16:01:30 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id x6so115560ile.3;
        Thu, 23 Mar 2023 16:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679612489;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pPqDmp+SBYUPkyZN8UhcDZUrkfkVFMO4W0RttnOJbtY=;
        b=mQpNdjs7M+Ev36O2zSyoaogUdmrQDPW67sv4YUR6epz911MznPqNZNR3L8rHOFZWp9
         ujv13QAHO5+2qMVF6v5UvWiHYWb27PbQ2sNJUNqu6D4oCOqT8ExvlY8iaZxtlb160FZ6
         /xu3fMLoobF0zYMZZ8spVF9s4lDTseFJ7fYTLADkSnLBIb9vAktON4UboprZ/2xr+Fzz
         ZXVRHTm//EoFW8PScDspAkBFked/040iDu2arY1hDiT9qv05PsgOFQGJ8ggiM0W2v/no
         0k/275sV2Mkvpqqq3eViJyHRhqA5URUaZfbn2HI0ag1BoSqzNSuGszvgepQwN3ek54/R
         +6uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679612489;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pPqDmp+SBYUPkyZN8UhcDZUrkfkVFMO4W0RttnOJbtY=;
        b=rrjQqSvWl2vktOwt0R+sqAwgtItykxe+BdRjANeY/RwGxYthmZKbuzRQ8OLuzz2fkq
         3PDcq/L0KxfGsIIlWR63O102NvlxhCb0TR39bc9QxtZuSqHfsjMZHmoPBs2SZxJPqnZ7
         FlzjBHwK6SCN1ocd4R63ubS4Ah2vq5RD/qwu3bHbaMZCDrhwG4QzOkrQsLtqfT4b2Gyr
         bXZxs2oszNSZl6/vYa6pvwGD7UcS/YmpN8pNyTLtvGVlv2MG3FqEaC+o9vgyVj6Fb2C1
         dlgb77iUE1sSTlzWfthQndLl7xPQXiFT6Ud6Ljrq6q561MJvnyfPjotgmY7LiStPji36
         jeUw==
X-Gm-Message-State: AAQBX9f2lwXPjoSriwWTQVVilJbtOg4Pb6N2DwZSETCIJH1SFzpqqs6Q
        zE5szesODPSW3ZROGH5MM28qU53EIMg=
X-Google-Smtp-Source: AKy350by9GmGBR/q76uqCBg2XxclGimtrW30GK+j3/4zQoMlEJhJHFUWsGY1S/AL0g1VMOZPBn4GHg==
X-Received: by 2002:a92:c6c3:0:b0:325:b220:1973 with SMTP id v3-20020a92c6c3000000b00325b2201973mr1006610ilm.12.1679612489468;
        Thu, 23 Mar 2023 16:01:29 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:447:d001:897f:f38d:f05d:4666:1249])
        by smtp.gmail.com with ESMTPSA id w20-20020a056e0213f400b00314201bcbdfsm5405492ilj.3.2023.03.23.16.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 16:01:28 -0700 (PDT)
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
Subject: [PATCH V4 0/4] clk: imx: Improve imx8mm/imx8mn LCDIF clocks
Date:   Thu, 23 Mar 2023 18:01:23 -0500
Message-Id: <20230323230127.120883-1-aford173@gmail.com>
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

v4:  Sorry for the noise.  I forgot to 'git ammend' so V4
     is what V3 should have been.
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

