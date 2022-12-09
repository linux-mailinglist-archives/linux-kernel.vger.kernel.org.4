Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69139647B81
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 02:33:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbiLIBdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 20:33:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiLIBd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 20:33:28 -0500
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C2286F65;
        Thu,  8 Dec 2022 17:33:27 -0800 (PST)
Received: by codeconstruct.com.au (Postfix, from userid 10000)
        id BFB4C2014B; Fri,  9 Dec 2022 09:33:21 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codeconstruct.com.au; s=2022a; t=1670549601;
        bh=ucE4NfgBowpZ8cxr+out2h6hZKjFsNKDxR1YbmxvS6M=;
        h=From:To:Subject:Date;
        b=lJk7Q5nPoXFU0Gzdt3PiOELSroXbNfKYvmyq1GnJWN/t9fGOOxQ5bgfaYyj+q/mkU
         5msqqWBdQJCeUfOGGo/xIcMkDlbqcAgQCy/YIVdqRuAWvs2NNLPRdv/LFuE/+j7LTj
         VaiqB6Bkc6UoL4hMo9r6YG1lU2RDHKse3d+KOMT5+mQZc9RnZkQd9ZNCZFlNf2cQSV
         gQG6i4JxEoZGsaNXBByjL49g8blbxBUB90yDKQVeULvhTYuBcob+ZAnSNuORAynb23
         UCyvTHCT6HBcFVARVJ0K2Xp3rhfZv4SZq8Ya7yYxJv/VhYlDNblrpv8r+Zl+73JYWG
         8+7fT6Dt8pSQw==
From:   Jeremy Kerr <jk@codeconstruct.com.au>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mark Brown <broonie@kernel.org>
Subject: [RFC PATCH v2 0/3] Add reset control for mfd syscon devices
Date:   Fri,  9 Dec 2022 09:33:06 +0800
Message-Id: <20221209013309.407879-1-jk@codeconstruct.com.au>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This RFC series adds a facility for syscon devices to control a reset
line when probed; we have instances of simple register-only syscon
resources that need deassertion of a reset line for the register set to
be accessible.

Rather than requiring a specific driver to implement this, it'd be nice
to use the generic syscon device and the generic resets linkage to do
so.

Any comments/queries/etc are most welcome.

Cheers,


Jeremy
---
v2:
 * do reset control in the early of_syscon_register() path, rather than
   the platform device init, which isn't used.
 * consequently, add regmap infrastructure to attach a reset
   controller, in a similar way to attaching clocks

Jeremy Kerr (3):
  dt-bindings: mfd/syscon: Add resets property
  regmap: mmio: allow reset control in a MMIO regmap
  mfd: syscon: allow reset control for syscon devices

 .../devicetree/bindings/mfd/syscon.yaml       |  3 +++
 drivers/base/regmap/regmap-mmio.c             | 22 +++++++++++++++
 drivers/mfd/syscon.c                          | 27 ++++++++++++++-----
 include/linux/regmap.h                        |  3 +++
 4 files changed, 49 insertions(+), 6 deletions(-)

-- 
2.35.1

