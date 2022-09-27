Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99AF85ECE8C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 22:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232589AbiI0UbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 16:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbiI0UbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 16:31:06 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 829935BC33;
        Tue, 27 Sep 2022 13:31:05 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id ay36so7322229wmb.0;
        Tue, 27 Sep 2022 13:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=mmU6MAWQYLRop8W7eGjFsHnqBAwkExerJB26p3rO/nM=;
        b=IFd0Z5XafJhQnpRCaXG9dL/2hJUEt/ekzRRkHAhOMfHKKgPiC1M2Gorrnlls0gim8B
         t/b4W+nRMN0tXRFnws0mL3nbtq8ft4zq7bTy3uDPsyVovFx0SMN6vvOie1P/tuHMuLJ4
         ZdBYFHm+BVYFKGN+xn8u4O2Tp71T4+ICS7pkxaYOpG+WZdcAPfJJyDzsqMeKydmB8XIS
         kdkh0Ysryo9i8MqWXh+d4WlqHe+jyj214dDr4KkTX/AFqrHlJ3xFPiXjbkZKcZthlf9K
         PxTcnqFhmbvAZ3rxvvWzLlxHBgXZyrIJZWSgsaGbnzAfVRKgecuvV4ftbn1lOBkMt0Qn
         sdrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=mmU6MAWQYLRop8W7eGjFsHnqBAwkExerJB26p3rO/nM=;
        b=G/fPIhUN/XBubtydn/IoPaA5b83inNdhaElOq/aGeSvZG7BZPLXZYIyyC32F0fHfRy
         XVcJsWrUFpPV9mEtFoE9IbAiocya/Sz1DNVDgyFB+D/W5F1NPi5ZGPvDlGsahraHQTah
         XPvEavUGQq4CLFPCz9IGFS0T626/yqKL6CWMAEDuPDUwiT4eC1uS29ael+a+2PyiEPtL
         QMyAWljmtdaijGw5oPGOD1guBSLnt4sBAygZU/N40V4rMpOEaVvEMyf53kaHF7Dl5YcE
         KYDL6wKZW4Hn3ZyXfVZbnZQY/XOr9iTbPsjMOQePRWM/kND4MTwqa0zbRPr4mZVH3x6C
         yCzA==
X-Gm-Message-State: ACrzQf383l6Xl/fy0Gd9BkgmeHdxE9fevycru/yy7lGOi5M3T4kUmnXH
        V6fT4hdDWjZpyP3jGYn43CY=
X-Google-Smtp-Source: AMsMyM6d/pIdTNHAA0SmQgWPkY8NM5X1TWT4zFJ+rw7dZPZRdFK4K51FEwkMnm3LWaJutOf2k2dKtA==
X-Received: by 2002:a05:600c:1ca8:b0:3b4:a5d1:2033 with SMTP id k40-20020a05600c1ca800b003b4a5d12033mr4015703wms.23.1664310663866;
        Tue, 27 Sep 2022 13:31:03 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:c6a:3c62:baf6:511c])
        by smtp.gmail.com with ESMTPSA id ck16-20020a5d5e90000000b0022cc4b7861fsm754830wrb.97.2022.09.27.13.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 13:31:03 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [RFC PATCH 0/2] clk: renesas: RZ/G2L: Add support for no PM clocks
Date:   Tue, 27 Sep 2022 21:30:42 +0100
Message-Id: <20220927203044.751611-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
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

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Hi All,

This patch series adds support for indicating MOD clocks as no PM (if any). 
Patch#1 adds DEF_NO_PM() macro to flagup no PM clock and patch #2 switches
sysclk and vclk clocks to no PM.

Sending it as an RFC as there wasn't any way we could obtain the priv data
due to which I had to create a static global var for rzg2l_cpg_priv.

Cheers,
Prabhakar

Lad Prabhakar (2):
  clk: renesas: rzg2l: Don't assume all CPG_MOD clocks support PM
  clk: renesas: r9a07g044: Mark CRU_SYSCLK and CRU_VCLK as no PM

 drivers/clk/renesas/r9a07g044-cpg.c |  4 ++--
 drivers/clk/renesas/rzg2l-cpg.c     | 35 +++++++++++++++++++++++++----
 drivers/clk/renesas/rzg2l-cpg.h     | 12 +++++++---
 3 files changed, 42 insertions(+), 9 deletions(-)

-- 
2.25.1

