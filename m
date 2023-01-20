Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13F9C675CF0
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 19:45:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbjATSp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 13:45:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjATSpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 13:45:25 -0500
Received: from m-r2.th.seeweb.it (m-r2.th.seeweb.it [IPv6:2001:4b7a:2000:18::171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C176FD39
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 10:45:20 -0800 (PST)
Received: from TimeMachine.lan (adsl-dyn97.91-127-229.t-com.sk [91.127.229.97])
        by m-r2.th.seeweb.it (Postfix) with ESMTPA id 6DE4D3F43B;
        Fri, 20 Jan 2023 19:45:17 +0100 (CET)
From:   Martin Botka <martin.botka@somainline.org>
To:     martin.botka1@gmail.com
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Jami Kettunen <jamipkettunen@somainline.org>,
        Paul Bouchara <paul.bouchara@somainline.org>,
        Jan Trmal <jtrmal@gmail.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Martin Botka <martin.botka@somainline.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 0/3] regulator: Add X-Powers AXP313a PMIC support*
Date:   Fri, 20 Jan 2023 19:44:56 +0100
Message-Id: <20230120184500.1899814-1-martin.botka@somainline.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for the X-Powers AXP313a PMIC, which is
often bundled with Allwinner H616 or H313 SoCs.
Andre Przywara took over the series for v6 but I now have a bit more time
so I took over the series again.

Up to v5 this was speaking of the AXP1530, which seems to be some internal
name. The chips we have seen in the wild are all labeled AXP313a, so we
go with this name here, from now on. This is supported by the fact that
there is an AXP313a datasheet, but none for the AXP1530.

Patch 1 is the binding documentation (just the new compatible string),
patch 2 adds the MFD bits (mostly describing the extent of the regmap),
while patch 3 describes the actual AXP313a register definitions.
Since this ties neatly into the existing AXP and generic regulator
framework, the patches are indeed only structure definitions, there is no
new code.

For now Andre papered over this "fixed customizable" RTC-LDO regulator in the
same way this was done before for other PMICs (AXP803, for instance), Andre
thinks we can fix this properly with a follow-up patch, for all instances.

Please have a look!

Cheers,
Martin

Changelog:
v7 .. v8:
- Add check for dcdcfreq being zero

v6 .. v7:
- Use alphabetical ordering

v5 .. v6:
- change name from AXP1530 to AXP313a
- extend commit messages
- drop AXP*_FREQUENCY register (not used anyway)
- better vertically align struct definitions
- rename IRQs to match names used for other PMICs
- add RTC_LDO regulator
- use decimal numbers for selector ranges
- use macro definitions to name some values
- force DC/DC switching frequency to be fixed at 3 MHz
- change LDO source supply to VIN1 (as per datasheet)

v4 .. v5:
- Use alphabetical ordering in mfd
- Correct { placement line
- Replace spaces with tabs in 1 struct

v3 .. v4:
- Fix indentation

v2 .. v3:
- Move AXP1530 dt-binding to alphabetical order

v1 .. v2:
- Remove RSB support.
- Drop .id = 0
- Add dt-binding for the AXP1530

Martin Botka (3):
  dt-bindings: mfd: x-powers,axp152: Document the AXP313a variant
  mfd: axp20x: Add support for AXP313a PMIC
  regulator: axp20x: Add support for AXP313a variant

 .../bindings/mfd/x-powers,axp152.yaml         |  1 +
 drivers/mfd/axp20x-i2c.c                      |  2 +
 drivers/mfd/axp20x.c                          | 61 +++++++++++++++++++
 drivers/regulator/axp20x-regulator.c          | 60 ++++++++++++++++++
 include/linux/mfd/axp20x.h                    | 32 ++++++++++
 5 files changed, 156 insertions(+)

-- 
2.39.0

