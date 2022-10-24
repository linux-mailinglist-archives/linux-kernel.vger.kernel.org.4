Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 825EE609EE9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 12:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbiJXKXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 06:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiJXKX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 06:23:28 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B7D7578A3;
        Mon, 24 Oct 2022 03:23:27 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id AC50366026E6;
        Mon, 24 Oct 2022 11:23:24 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666607005;
        bh=3oXoEhWg3+MHoIyDaeamIWAKLeunxv0N4TGhq6yceYE=;
        h=From:To:Cc:Subject:Date:From;
        b=igH0GyikvyoTw9qwOrQiZ9nd7thTOOXfuysbEppszIcfj8HDJCdfogCpK81ZIft7e
         ahMDdRrvTh1kL/r7bdf12b9gcUhHzdbcn7hGZ9JHJjd4Dvahz4tZEB5gdq3XEYuB2j
         QtrqVf0pwjZtx/a30mtdDcBfHeNMZWXM7rEOFLh6fL514nhaFtndYkI43Oy27PBmSS
         CS955CVEz6BNahHAv3i9Za9YeM+yBTmV+sc9lwZPWsuaoCiOI/TfC9a6Daogx2gDKK
         lIOdiD2FjATme8QP5GFfyxQbHxlQ78Ggjp3jnTn8t5YNGq4WQ0fYvrdAf8gJUcFjEy
         1yNUzz1VnT2mw==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     sboyd@kernel.org
Cc:     mturquette@baylibre.com, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, wenst@chromium.org,
        miles.chen@mediatek.com, nfraprado@collabora.com,
        rex-bc.chen@mediatek.com, chun-jie.chen@mediatek.com,
        jose.exposito89@gmail.com, yangyingliang@huawei.com,
        msp@baylibre.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 00/10] MTK: Undesired set_rate on main PLLs and GPU DVFS
Date:   Mon, 24 Oct 2022 12:22:57 +0200
Message-Id: <20221024102307.33722-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no reason to declare CLK_SET_RATE_PARENT on main system PLL
dividers, as any rate change on those (mainpll, syspll, univpll) will
change clock rates on critical system peripherals and busses.

This change was performed only on SoCs that I could test... I'm sure
that the same can (and should) be done on more MTK clock drivers for
practically all MTK SoCs, but I don't feel confident in pushing things
that I couldn't test, so that's done only for MT8173/83/86/92/95 and
on MT6795.
While at it, I've also added the much needed clock notifier treatment
on MT8186 for GPU DVFS, like done on other clock drivers in the past.

A broader explanation about why this series is needed can be found in
the first commit that drops this flag from fixed dividers of main and
univ PLLs (on MT8186) but, for the ones reading mainly the cover letter,
here's a copy-paste of that commit description:

The mainpll and univpll clocks are used as clock sources for multiple
peripherals of different kind, some of which are critical (like AXIs);
a rate change on any of these two will produce a rate change on many
devices and that's likely to produce system instability if not done
correctly: this is the reason why we have "fixed factor" clocks, used
by MUX clocks to provide different rates based on PLL output dividers.
    
Though, there's one fundamental issue that must be resolved somehow:
    
When performing GPU DVFS, we get a rate request that will try to change
the frequency of MAINPLL due to the CLK_TOP_MFG mux having clk26m,
mfgpll (the GPU dedicated PLL), mainpll_d3, mainpll_d5 (fixed factor
dividers) as possible parents.
    
In order to solve that, there are two ways:
 1. Add new "fake" mainpll_d3_fixed, mainpll_d5_fixed clocks, clones
    of mainpll_d3, mainpll_d5 clocks, for the only purpose of not
    declaring CLK_SET_RATE_PARENT; or
 2. Simply drop said flag from the original dividers.
    
After some careful validation, I cannot see anything calling a rate
change request during runtime for MAINPLL, nor for UNIVPLL (which would,
again, mean that we're reclocking lots of peripherals at once!), so it
is safe *and sane* to simply remove the CLK_SET_RATE_PARENT flag to all
of the main/univpll fixed factor divider clocks.
    
Besides, if for any (doubtful) reason main/univpll rate change will be
required in the future, it's still possible to call that on the PLL main
clocks, so we're still covered anyway.

AngeloGioacchino Del Regno (10):
  clk: mediatek: clk-mtk: Allow specifying flags on mtk_fixed_factor
    clocks
  clk: mediatek: mt8186-topckgen: Drop flags for main/univpll fixed
    factors
  clk: mediatek: mt8183: Compress top_divs array entries
  clk: mediatek: mt8183: Drop flags for sys/univpll fixed factors
  clk: mediatek: mt8173: Drop flags for main/sys/univpll fixed factors
  clk: mediatek: mt6795-topckgen: Drop flags for main/sys/univpll fixed
    factors
  clk: mediatek: mt8192: Drop flags for main/univpll fixed factors
  clk: mediatek: mt8195-topckgen: Drop flags for main/univpll fixed
    factors
  clk: mediatek: mt8186-mfg: Propagate rate changes to parent
  clk: mediatek: mt8186-topckgen: Add GPU clock mux notifier

 drivers/clk/mediatek/clk-mt6795-topckgen.c |  76 ++++----
 drivers/clk/mediatek/clk-mt8173.c          |  76 ++++----
 drivers/clk/mediatek/clk-mt8183.c          | 216 +++++++--------------
 drivers/clk/mediatek/clk-mt8186-mfg.c      |   5 +-
 drivers/clk/mediatek/clk-mt8186-topckgen.c |  89 ++++++---
 drivers/clk/mediatek/clk-mt8192.c          |  76 ++++----
 drivers/clk/mediatek/clk-mt8195-topckgen.c |  78 ++++----
 drivers/clk/mediatek/clk-mtk.c             |   2 +-
 drivers/clk/mediatek/clk-mtk.h             |   7 +-
 9 files changed, 293 insertions(+), 332 deletions(-)

-- 
2.37.2

