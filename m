Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC6B67C38A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 04:34:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236135AbjAZDdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 22:33:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236127AbjAZDde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 22:33:34 -0500
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B5C457F2;
        Wed, 25 Jan 2023 19:33:31 -0800 (PST)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1pKt0w-0004Dw-1Y;
        Thu, 26 Jan 2023 04:33:26 +0100
Date:   Thu, 26 Jan 2023 03:33:19 +0000
From:   Daniel Golle <daniel@makrotopia.org>
To:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Jianhui Zhao <zhaojh329@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Edward-JW Yang <edward-jw.yang@mediatek.com>,
        Johnson Wang <johnson.wang@mediatek.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Fabien Parent <fparent@baylibre.com>,
        Miles Chen <miles.chen@mediatek.com>
Subject: [PATCH v5 0/3] add support for clocks on MT7981 SoC
Message-ID: <cover.1674703830.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MediaTek MT7981 SoC is quite similar to its big sibling, the
MT7986. Hence most drivers can be reused and not much is missing the
get also this SoC working on mainline Linux.

Start with a cleaned-up version of the clock drivers, based on what can
also be found in MediaTek's SDK[1].

Upon request of AngeloGioacchino Del Regno this series has been rebased
and adapted to be applied on top of the pending series
"MediaTek clocks cleanups and improvements"[2]

The complete tree used for testing (with still some to-be-cleaned-up
changes, esp. for the Ethernet driver) can be found on Github[3].

[1]: https://git01.mediatek.com/plugins/gitiles/openwrt/feeds/mtk-openwrt-feeds/+/refs/heads/master/target/linux/mediatek/files-5.4/drivers/clk/mediatek/clk-mt7981.c
[2]: https://patchwork.kernel.org/project/linux-clk/list/?series=714057
[3]: https://github.com/dangowrt/linux

Changes since v4:
 * add compatible string also for 'mediatek,apmixedsys', 'mediatek,ethsys' as
   well as 'mediatek,sgmiisys' bindings

Changes since v3:
 * fixed typos in commit descriptions

Changes since v2:
 * rebase on top of next-20230120 with v4 of AngeloGioacchino's series[2]
 * fix titles of dt-bindings commits (this time for real)
 * convert clk-mt7981-infracfg to use mtk_clk_simple_probe
 * make use of PLL_AO flag in clk-mt7981-apmixed
 * convert clk-mt7981-ethsys into platform driver, also using the generic
   probe function, allow building as module

Changes since v1:
 * rebase and adapt on top of [2]
 * split-off addition of dt-bindings header, fix filename
 * changed commit title as requested

Daniel Golle (3):
  dt-bindings: clock: Add compatibles for MT7981
  dt-bindings: clock: mediatek: add mt7981 clock IDs
  clk: mediatek: add MT7981 clock support

 .../bindings/arm/mediatek/mediatek,ethsys.txt |   1 +
 .../arm/mediatek/mediatek,infracfg.yaml       |   1 +
 .../arm/mediatek/mediatek,sgmiisys.txt        |   2 +
 .../bindings/clock/mediatek,apmixedsys.yaml   |   1 +
 .../bindings/clock/mediatek,topckgen.yaml     |   1 +
 drivers/clk/mediatek/Kconfig                  |  17 +
 drivers/clk/mediatek/Makefile                 |   4 +
 drivers/clk/mediatek/clk-mt7981-apmixed.c     | 102 +++++
 drivers/clk/mediatek/clk-mt7981-eth.c         | 117 +++++
 drivers/clk/mediatek/clk-mt7981-infracfg.c    | 207 +++++++++
 drivers/clk/mediatek/clk-mt7981-topckgen.c    | 422 ++++++++++++++++++
 .../dt-bindings/clock/mediatek,mt7981-clk.h   | 215 +++++++++
 12 files changed, 1090 insertions(+)
 create mode 100644 drivers/clk/mediatek/clk-mt7981-apmixed.c
 create mode 100644 drivers/clk/mediatek/clk-mt7981-eth.c
 create mode 100644 drivers/clk/mediatek/clk-mt7981-infracfg.c
 create mode 100644 drivers/clk/mediatek/clk-mt7981-topckgen.c
 create mode 100644 include/dt-bindings/clock/mediatek,mt7981-clk.h


base-commit: 9fbee811e479aca2f3523787cae1f46553141b40
-- 
2.39.1

