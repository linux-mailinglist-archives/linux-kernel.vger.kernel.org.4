Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9EA460D8EA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 03:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232523AbiJZBmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 21:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231645AbiJZBml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 21:42:41 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A7BEDDA31;
        Tue, 25 Oct 2022 18:42:39 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id bh7-20020a05600c3d0700b003c6fb3b2052so501692wmb.2;
        Tue, 25 Oct 2022 18:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Lh32i4f+ofJMoVw2+1sIHFoGr4ymoW3HnTFs2g7No1E=;
        b=XqsmMjmp+c0uQ/LhAyWTG7VY37rVLi3fOocIyx/VcPesJZJ1slnOJarCrv5RWDJFn1
         fY6Bd10om5csatGDS6bwMPDi6GBXltE5pB3dw/dsriiT5yebIQAj3X5b0dzLCVdN0z2l
         Pb9TM0xKk6JcWBD8dnFbVIc5J0g0OVD6+008Wm2JoLLQoKTzzo9WFGbhehm6abAgxksF
         wfe+ZlaHbTLG9nZpK0D2oy1jOAcOdRTxlGwygY0Rtu/nxqzn8BZJMkaiZ2Ko23jo6cHQ
         bs1TKe6Rlg78U5is5mP7UcryMDPaEHyjpSEWr6I0xn3Sg0dLB95dYOQRm7BbSUVB9AW2
         4Djw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lh32i4f+ofJMoVw2+1sIHFoGr4ymoW3HnTFs2g7No1E=;
        b=CyZFWe/EOt1E2CkaheObtyIeWwqD4Kdoe2Oqg5Af25xNnyyP7jprDTmTTv8aGHZr+4
         qcj2XJWAqOm0kWXYsdGxjnHPV8XNytCnPN0Rxr8CXmGgTbhvTIJy52UL+Bjomll0OjV7
         PmLfXnLwSIf5s6aYWspV2gnjbqei04ItBdKRyqwgnYw7U528TYrqnEXb7RmYbTf1SR/0
         MOCl4VJA0rHxol3nojcy2nE3QgjtR7d0HcCiZmkRujPIc+pms1z8+skBBXYCnclIO5VG
         OS9uoI/+H9UCy2ZesTiJ8ig6RX66/rSBXILABQvWqgWiQnNxPbEi2tBSoY5KEKkAXPYs
         CwDw==
X-Gm-Message-State: ACrzQf2R+a+gwLZoxcRoWsL5T/JyRPSNxFmFVx7oO/EJHluPRAglNUBN
        xRnkefqfIW6onBmfT/JV7Q4qrCvkIAT55Eug
X-Google-Smtp-Source: AMsMyM5JUW8TCtB+5aMGJEyoeb+CEzCehnvEUbOgiSfK6elNwIR09WhlKWHg6/bHkEhLBX2ZFqe1+g==
X-Received: by 2002:a05:600c:6889:b0:3cd:d83b:7993 with SMTP id fn9-20020a05600c688900b003cdd83b7993mr614695wmb.143.1666748558098;
        Tue, 25 Oct 2022 18:42:38 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:1d2a:d2a2:361e:a475])
        by smtp.gmail.com with ESMTPSA id x12-20020adff0cc000000b00236733f0f98sm3688956wro.107.2022.10.25.18.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 18:42:37 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 0/2] clk: renesas: RZ/G2L: Add support for no PM clocks
Date:   Wed, 26 Oct 2022 02:42:25 +0100
Message-Id: <20221026014227.162121-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

This patch series adds support for indicating MOD clocks as no PM
(if any). SoCs indicate no PM clocks by adding to no_pm_mod_clks[]
array.

Note this patch applies on top of [0] (rebased on renesas-clk-for-v6.2
branch).

[0] https://patchwork.kernel.org/project/linux-renesas-soc/patch/20221026012123.159790-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

v1 -> v2
* Dropped DEF_NO_PM() macro
* Added genpd member to struct rzg2l_cpg_priv
* Added no_pm_mod_clks and num_no_pm_mod_clks members
  to struct rzg2l_cpg_info
* Updated commit messages

RFC->v1
* Added no_pm_mod_clks and num_no_pm_mod_clks members as part of
  struct rzg2l_cpg_priv so that we dont loop the entire mod clocks
  array for each device probe.
* Patch#2 unchanged

RFC: https://patchwork.kernel.org/project/linux-renesas-soc/cover/20220927203044.751611-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

Cheers,
Prabhakar

Lad Prabhakar (2):
  clk: renesas: rzg2l: Don't assume all CPG_MOD clocks support PM
  clk: renesas: r9a07g044: Add CRU_SYSCLK and CRU_VCLK to no PM list

 drivers/clk/renesas/r9a07g044-cpg.c | 13 ++++++++++
 drivers/clk/renesas/rzg2l-cpg.c     | 37 ++++++++++++++++++-----------
 drivers/clk/renesas/rzg2l-cpg.h     |  4 ++++
 3 files changed, 40 insertions(+), 14 deletions(-)

-- 
2.25.1

