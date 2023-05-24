Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4DE670E9E6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 02:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238852AbjEXAAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 20:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232416AbjEXAAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 20:00:40 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B814DB5
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 17:00:38 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5F5A31042;
        Tue, 23 May 2023 17:01:23 -0700 (PDT)
Received: from slackpad.fritz.box (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 78B243F67D;
        Tue, 23 May 2023 17:00:36 -0700 (PDT)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Lee Jones <lee@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>, Mark Brown <broonie@kernel.org>
Cc:     Martin Botka <martin.botka@somainline.org>,
        martin.botka1@gmail.com, Shengyu Qu <wiagn233@outlook.com>,
        Samuel Holland <samuel@sholland.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v11 0/3] regulator: Add X-Powers AXP15060/AXP313a PMIC support
Date:   Wed, 24 May 2023 01:00:09 +0100
Message-Id: <20230524000012.15028-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.35.8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this patch series adds support for the X-Powers AXP15060 and AXP313a
PMIC, which are general purpose PMICs as seen on different boards with
different SOCs, mostly from Allwinner.

This is mostly a repost of the previous patches, combining both the
AXP313a and AXP15060 series, rebased on top of v6.4-rc3, and omitting
the patches that already got merged.
The first two patches are the successors of the AXP313a v10 post,
the third patch is based on Shengyu's AXP15060 v3 post.

There were no code changes, just some tiny context differences due to
the rebase, plus I added the newly gained tags.

As the DT bindings and the AXP15060 MFD part are already in the tree,
this is just completing support with the MFD part for the AXP313a, and
the regulator support for both PMICs.

Shengyu, Martin: can you please give this a final test?

Cheers,
Andre

Changelog:

v3/v10 .. v11:
- add broonie's and Chen-Yu's review tags
- rebase on top of v6.4-rc3

AXP313a:
v9 .. v10:
- use MFD_CELL_RES macro
- mark dcdc-freq property as "false" for AXP313a
- add Lee's ACK

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

AXP15060:
v2 .. v3:
- Rebase to AXP313a series v10 [1] + newest (20230420) -next branch
- Disables DC-DC frequency setting
- Add axp_regulator_only_cells rather than directly using axp806_cells
  for cases that IRQ line isn't connected.
- Fix some whitespace
- Rename swout to sw to keep up with bindings
- Add check for setting DC-DC frequency

v1 .. v2:
- Move cpusldo before drivevbus (Krzysztof Kozlowski)


Martin Botka (2):
  mfd: axp20x: Add support for AXP313a PMIC
  regulator: axp20x: Add support for AXP313a variant

Shengyu Qu (1):
  regulator: axp20x: Add AXP15060 support

 drivers/mfd/axp20x-i2c.c             |   2 +
 drivers/mfd/axp20x.c                 |  78 ++++++-
 drivers/regulator/axp20x-regulator.c | 290 ++++++++++++++++++++++++++-
 include/linux/mfd/axp20x.h           |  32 +++
 4 files changed, 393 insertions(+), 9 deletions(-)

-- 
2.35.8

