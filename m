Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A503D7305CA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 19:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232479AbjFNRPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 13:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235423AbjFNRPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 13:15:05 -0400
Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk [188.40.203.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 952DFE69;
        Wed, 14 Jun 2023 10:15:03 -0700 (PDT)
Received: from [167.98.27.226] (helo=rainbowdash)
        by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
        id 1q9U5D-00Exj5-EM; Wed, 14 Jun 2023 18:14:59 +0100
Received: from ben by rainbowdash with local (Exim 4.96)
        (envelope-from <ben@rainbowdash>)
        id 1q9U5C-000I0h-0j;
        Wed, 14 Jun 2023 18:14:58 +0100
From:   Ben Dooks <ben.dooks@sifive.com>
To:     linux-pwm@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.dooks@codethink.co.uk, u.kleine-koenig@pengutronix.de,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        jarkko.nikula@linux.intel.com,
        William Salmon <william.salmon@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>,
        Ben Dooks <ben.dooks@sifive.com>
Subject: [PATCH v8 0/5] DesignWare PWM driver updates
Date:   Wed, 14 Jun 2023 18:14:52 +0100
Message-Id: <20230614171457.69191-1-ben.dooks@sifive.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is an update for the DesignWare PWM driver to add support for
OF (and split the PCI bits out if aynone else wants them). This is mostly
the same as the v7 series, but with code moved around and module-namespace
added, plus review comments processed.

Since we no longer have the hardware, the clock code hasn't been changed to
either lock the rate whilst the PWM is running, or to deal with any sort
of change callback. This is left to future work (and I would rather get
something in that does currently work) (second note, the hardware we did
use had a fixed clock tree anyway)

This account is probably going away soon, I have cc'd my main work
email to catch any responses.

Thank you all for the reviews.

The lengthy changelog:

v8:
 - updated reviewed tags
 - fix module name for pci version
 - fix config symbol bug in makefile
 - remove pci compile-test (mostly not used for pci)
 - push the compile-test into the platform/of driver
v7:
 - fixup kconfig from previous pcie changes
 - re-order kconfig to make dwc core be selected by PCI driver
 - move clk variable to patch it is used in
v6:
 - fix removal ordering of DWC_PERIOD_NS
v5:
 - fixed kconfig string error
 - merged pwm-nr into main of code
 - split of code from pci code
 - updated pwm-nr capping
 - fix duplicate error reporting in of-code
 - fix return in of-probe
 - remove unecessary remove function as devm_ functions sort this
 - fixed ordering of properties
 - added missing reg item
 - fixed missing split of the two clock sources.
 - get bus clock in of code
v4:
 - split pci and of into new modules
 - fixup review comments
 - fix typos in dt-bindings
v3:
- change the compatible name
- squash down pwm count patch
- fixup patch naming
v2:
- fix #pwm-cells count to be 3
- fix indetation 
- merge the two clock patches
- add HAS_IOMEM as a config dependency

Ben Dooks (5):
  pwm: dwc: split pci out of core driver
  pwm: dwc: make timer clock configurable
  pwm: dwc: add PWM bit unset in get_state call
  pwm: dwc: use clock rate in hz to avoid rounding issues
  pwm: dwc: add of/platform support

 drivers/pwm/Kconfig        |  24 ++++-
 drivers/pwm/Makefile       |   2 +
 drivers/pwm/pwm-dwc-core.c | 196 ++++++++++++++++++++++++++++++++++++
 drivers/pwm/pwm-dwc-of.c   |  78 +++++++++++++++
 drivers/pwm/pwm-dwc.c      | 198 +------------------------------------
 drivers/pwm/pwm-dwc.h      |  61 ++++++++++++
 6 files changed, 364 insertions(+), 195 deletions(-)
 create mode 100644 drivers/pwm/pwm-dwc-core.c
 create mode 100644 drivers/pwm/pwm-dwc-of.c
 create mode 100644 drivers/pwm/pwm-dwc.h

-- 
2.39.2

