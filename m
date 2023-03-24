Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 743066C7D32
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 12:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbjCXLat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 07:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjCXLas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 07:30:48 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A5C5F1ABCD;
        Fri, 24 Mar 2023 04:30:46 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 716A411FB;
        Fri, 24 Mar 2023 04:31:30 -0700 (PDT)
Received: from donnerap.arm.com (donnerap.cambridge.arm.com [10.1.197.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 828263F6C4;
        Fri, 24 Mar 2023 04:30:44 -0700 (PDT)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Lee Jones <lee@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Martin Botka <martin.botka@somainline.org>,
        martin.botka1@gmail.com, Shengyu Qu <wiagn233@outlook.com>,
        Samuel Holland <samuel@sholland.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v9 0/3] regulator: Add X-Powers AXP313a PMIC support
Date:   Fri, 24 Mar 2023 11:30:10 +0000
Message-Id: <20230324113013.254371-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for the X-Powers AXP313a PMIC, which is
often bundled with Allwinner H616 or H313 SoCs.
It's my turn again for this revision of the series, after Martin did
v7 and v8.
I addressed the comments that Chen-Yu gave (many thanks for that
review!), which adds the power button interrupt and should fix the
shutdown functionality (which is typically unused since PSCI takes
precedence). For a complete changelog see below.

Up to v5 this was speaking of the AXP1530, which seems to be some internal
name. The chips we have seen in the wild are all labeled AXP313a, so we
go with this name here, from now on. This is supported by the fact that
there is an AXP313a datasheet, but none for the AXP1530.

Patch 1 is the binding documentation (just the new compatible string),
patch 2 adds the MFD bits (mostly describing the extent of the regmap),
while patch 3 describes the actual AXP313a register definitions.
Since this ties neatly into the existing AXP and generic regulator
framework, the patches are indeed only structure definitions, there is
little new code.

For now we papered over this "fixed customizable" RTC-LDO regulator in the
same way this was done before for other PMICs (AXP803, for instance), We
think we can fix this properly with a follow-up patch, for all instances.

Please have a look!

Cheers,
Andre

Changelog:

v8 .. v9:
- use MFD_CELL_NAME macro
- fix LDO regulator names to match the datasheet
- only mark changing registers as volatile
- use correct register for shutdown operation
- add power key resources
- disallow x-powers,dcdc-freq in the DT binding
- drop unused OUTPUT_MONITOR register name, add SHUTDOWN_CTRL
- require dcdcfreq being 0 (non-present DT property default)

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

 .../bindings/mfd/x-powers,axp152.yaml         | 12 +++
 drivers/mfd/axp20x-i2c.c                      |  2 +
 drivers/mfd/axp20x.c                          | 82 ++++++++++++++++++-
 drivers/regulator/axp20x-regulator.c          | 60 ++++++++++++++
 include/linux/mfd/axp20x.h                    | 32 ++++++++
 5 files changed, 187 insertions(+), 1 deletion(-)

-- 
2.25.1

