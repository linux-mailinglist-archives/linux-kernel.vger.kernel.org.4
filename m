Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66C006F684B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 11:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbjEDJav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 05:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjEDJau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 05:30:50 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA6EE8F
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 02:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1683192648;
  x=1714728648;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XqADOCrgZ/7ZLBFD5R+GS/7+HN4i58K0SO9r2T8jVdE=;
  b=BwGnnLESCCTuM/PxC8mBAvq3pvw7bJz1MllQQCL5uIT0AoM1uPIn5Lwl
   Zet8qJ8NjuYqonBiSnsNMvRUEfWOqQN0ZR23doWydpi2ET6QJuDMK0eO7
   0TjS4DzWRLEDZ/I1oSdPAgYaWXRb8XweAE31yUYKJ8GnRcN9/L/WjxNIj
   kxnZH8rhN6flXwVLCvmJP/edyeBlfHOulmrdYbcHMEQw4uY9EpgFAFKMg
   TbJjI0s3hrg6boZ3lJIYsaQAzIRHUuP8L6TC0FzBbq/OshCJoqLfxwBxX
   qfVEsg08kt8n+OY8GpRopK4y3v5BaecND5ly0YBBPHH8e6n14x37D8j3S
   A==;
From:   Hermes Zhang <chenhuiz@axis.com>
To:     <sre@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel@axis.com>,
        Hermes Zhang <chenhuiz@axis.com>
Subject: [PATCH v5 0/2] Add new ti,no-thermistor property
Date:   Thu, 4 May 2023 17:30:35 +0800
Message-ID: <20230504093037.2056146-1-chenhuiz@axis.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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

    v5: add Reviewed-by tag from Krzysztof Kozlowski

Hermes Zhang (2):
  dt-bindings: power: supply: bq256xx: Add ti,no-thermistor property
  power: supply: bq256xx: Apply TS_IGNORE from devicetree

 .../bindings/power/supply/bq256xx.yaml        | 18 ++++++++++++
 drivers/power/supply/bq256xx_charger.c        | 28 +++++++++++++++++++
 2 files changed, 46 insertions(+)

-- 
2.30.2

