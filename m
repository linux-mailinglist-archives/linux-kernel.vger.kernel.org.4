Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02AEE6C608E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 08:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbjCWHXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 03:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCWHXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 03:23:04 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2FAD19A9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 00:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1679556182;
  x=1711092182;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=iu2QzuVxYK8UsCJsby5RP6kJKSqasSalQna8ewA31bs=;
  b=ewdg9300PAru+tkRVq2h+/6c8knw2yyzMmq8ok4+ksUgn1cU+jT/Ojyb
   jnSapa+ZrtrfPlTahtagPVNPOOxyC0hkH9bMWo3pfnuLfcuHOD/+4c0eX
   fPRF0cfquTqTKhQzrsNYEo37Sj/+uwRMVj1CF1qe7/n4EZ8BBksXsHe+b
   mCD+9X0lp5Z0oAf/FN9ZP7tULiXbanyGYKyW2rk7+RY7rYy/hiXWsnlCt
   54f9Wav/SGzp5JBfR2P/RUx2/PFT+ago8Le7mI6GXhYmALBydSzLAqu6g
   XBVVMYuL3clVlQ+AH+VpHJ8Bmq6ZZ1ui3vWEhH1n0QCIhY990cgRYiC76
   g==;
From:   Hermes Zhang <chenhuiz@axis.com>
To:     <krzysztof.kozlowski+dt@linaro.org>, <sre@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel@axis.com>,
        Hermes Zhang <chenhuiz@axis.com>
Subject: [PATCH v3 0/2] Add new ti,no-thermistor property
Date:   Thu, 23 Mar 2023 15:22:24 +0800
Message-ID: <20230323072224.438467-1-chenhuiz@axis.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TS pin is used to detect the temperature and suspend the charging
when it's voltage out of range. If the NTC is not connect in HW, the
TS_IGNORE bit need to be set to 1 to make charge work. The new
"ti,no-thermistor" is used to set TS_IGNORE to 1 when HW doesn't work
with NTC.

Description from datasheet:
Battery temperature qualification voltage input. Connect a negative temperature
coefficient thermistor (NTC). Program temperature window with a resistor divider
from REGN to TS to GND. Charge and Boost mode suspend when TS pin voltage is
out of range. When TS pin is not used, connect a 10-kΩ resistor from REGN to TS
and a 10-kΩ resistor from TS to GND or set TS_IGNORE to HIGH to ignore TS pin.
It is recommended to use a 103AT-2 thermistor.

Notes:
    v2: change property name to ti,no-thermistor

    v3: drop "|" in property description

Hermes Zhang (2):
  dt-bindings: power: supply: bq256xx: Add ti,no-thermistor property
  power: supply: bq256xx: Apply TS_IGNORE from devicetree

 .../bindings/power/supply/bq256xx.yaml        | 18 ++++++++++++
 drivers/power/supply/bq256xx_charger.c        | 28 +++++++++++++++++++
 2 files changed, 46 insertions(+)

-- 
2.30.2

