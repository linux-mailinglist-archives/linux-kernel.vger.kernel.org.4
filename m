Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 716E96CFC19
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 08:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbjC3G7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 02:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbjC3G7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 02:59:23 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB9876A72
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 23:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1680159562;
  x=1711695562;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/k1x7gXOzK/Hfl3bMJQd/0F2RgJV2UO5q9mGL/YjdCM=;
  b=XivBGgGw4y/khsOBSkG5A7z/cO/lajYKYvV9xTOPX8iT8xmwaTwWwTsy
   PjfBq3ubpHEUQ3IxjQZVJ1+JkDMc4OJxKoYOr34S7gZITFvvmI2f0YH7U
   c2jVsCtY30K2K6Yqy2SoP3SqebgZs1uCOBZrD40xZpJJSey6sGEYb3B7g
   w9tH9Wo1YR7gcb+ToN7e7QiV5SXwA0ALfSkJsiWZUsBuStPKDTvpsggBk
   Ou86PMtgjBoU7h6tzzMNg3Lw39dLqAWcTC8Gdla2/FyNpkiKWb6fA30oh
   wkAwphwyhoNv19KVsimrOzUR2LqoTf8ChXtwhYwotWwweG+iR+LY2fUvL
   g==;
From:   Hermes Zhang <chenhuiz@axis.com>
To:     <krzysztof.kozlowski+dt@linaro.org>, <sre@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel@axis.com>,
        Hermes Zhang <chenhuiz@axis.com>
Subject: [PATCH v4 0/2] Add new ti,no-thermistor property
Date:   Thu, 30 Mar 2023 14:59:15 +0800
Message-ID: <20230330065915.1350585-1-chenhuiz@axis.com>
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

    v4: rebase bq256xx_charger.c

Hermes Zhang (2):
  dt-bindings: power: supply: bq256xx: Add ti,no-thermistor property
  power: supply: bq256xx: Apply TS_IGNORE from devicetree

 .../bindings/power/supply/bq256xx.yaml        | 18 ++++++++++++
 drivers/power/supply/bq256xx_charger.c        | 28 +++++++++++++++++++
 2 files changed, 46 insertions(+)

-- 
2.30.2

