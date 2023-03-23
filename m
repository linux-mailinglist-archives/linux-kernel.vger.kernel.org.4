Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66F2B6C5D3A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 04:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbjCWD2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 23:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjCWD2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 23:28:36 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 918312596C
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 20:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1679542114;
  x=1711078114;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=J7cKc0yUtxFCpk68r1db1vGpKLniNIdbosnQxyT8/nw=;
  b=ZfkJ4Lssn2Ii2m2XrI6QyYT8e6LUy1+YB+K9fg3F4YkC5X3m8YyiiXRf
   wWdT3akY1vovrBQ6PQd+vb2tMcfR1H3An1ycwaIbMQVo+JAu3tBhpkLuA
   rZvPOTM0uDiDOm41nKLDk9i+t2JQe5toiJ0BAi6VCoexM1dUg5AftYp+e
   tXSvFuAwQGjEg2cBAuIr4XAw8JvkFOuGz+e6euF6WX1y4JfI6VBwXCKmd
   Ko9w00oUEelJ6xftdSML2FdlnTLzF3tQ+MLBINTL2qaIxpoQKncfWERF0
   lcfdgpzxPnIa/Jc1ArMsleKAYJWCEkUdm2P24v4xIkKPn/tAEggG5upls
   g==;
From:   Hermes Zhang <chenhuiz@axis.com>
To:     <sre@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <robh+dt@kernel.org>, <afd@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <kernel@axis.com>,
        Hermes Zhang <chenhuiz@axis.com>
Subject: [PATCH v2 0/2] Add new ti,no-thermistor property
Date:   Thu, 23 Mar 2023 11:28:00 +0800
Message-ID: <20230323032800.416460-1-chenhuiz@axis.com>
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

Hermes Zhang (2):
  dt-bindings: power: supply: bq256xx: Add ti,no-thermistor property
  power: supply: bq256xx: Apply TS_IGNORE from devicetree

 .../bindings/power/supply/bq256xx.yaml        | 19 +++++++++++++
 drivers/power/supply/bq256xx_charger.c        | 28 +++++++++++++++++++
 2 files changed, 47 insertions(+)

-- 
2.30.2

