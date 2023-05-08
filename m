Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8A4F6FB102
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 15:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233896AbjEHNOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 09:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232161AbjEHNO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 09:14:28 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C37E346A4;
        Mon,  8 May 2023 06:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1683551667;
  x=1715087667;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=mwiNk8d92A4aFHHJWlAJe/9rlrNM++TYqFzol8J4zms=;
  b=iJOlRUutk0HL+rFE2nJ+5XEsl5SloLsfKXbEaMYzYfwMNZW9rVf8MGLv
   VF73LAMGxQBI6fsbPc2uZME8+gbzhLZp2Nsm4XumkeQO9bDDDQNNjIDge
   HzJk4LZcLhF5fA0HkPOxg3vwUYajcXzHLZZRNn8V79rYeE8dz2XFQeMM4
   +1h8pH7GLbhDd94t7aT2I6+ZDdg+JsQzaVul5xYWBmZRTcwfdk8n0f/2s
   T1a1HdlodrF6xV2xI1LcUIue2QPhZc78Na7ZCnXX+YvZcAUq/Idm3V7m2
   ZvW4rq2PIkt56ke3MlqL+YyD8Z4lizsd5tk3ch9sLUv0lC13ZelfWGWYL
   w==;
From:   =?utf-8?q?M=C3=A5rten_Lindahl?= <marten.lindahl@axis.com>
Subject: [PATCH v3 0/2] regulator: Add support for TPS6287x
Date:   Mon, 8 May 2023 15:14:06 +0200
Message-ID: <20230502-tps6287x-driver-v3-0-e25140a023f5@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAJ71WGQC/4WNOQ6DMBBFr4Jcx5E3MKTKPaIUXoYwBYtsZBEh7
 h6bKk2U8s3o/beTCAEhklu1kwAJI85TBnmpiBvM9AKKPjMRTEhWM0HXJTai1Rv1ARMEanqutLK
 Scw4kW9ZEoDaYyQ3FG01cIZTHEqDH7Uw9npkHjOsc3mc58XL9HUmcMqp91wjFpLa+vZsN49XNI
 ylTSfzRRdZ7WyveedU41X3px3F8AOF/XFsFAQAA
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <kernel@axis.com>,
        =?utf-8?q?M=C3=A5rten_Lindahl?= <marten.lindahl@axis.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1683551664; l=1870;
 i=marten.lindahl@axis.com; s=20230329; h=from:subject:message-id;
 bh=TMBdzmNmERfop/Y8HvPBMUIEhv3U3++6HDUci+m58DQ=;
 b=w5j3WGDholXRzzQqc2f2/fOAp+l0p5V3D9Zz1UYmJvV97u8QveL10uQArU7cVrPs1QnZfnSGs
 IIZC7hDIhHOAR/8qG3JfCUWU51dWFr5y6TnOkxv1F6Zq5gU+Z10TPbZ
X-Developer-Key: i=marten.lindahl@axis.com; a=ed25519;
 pk=JfbjqFPJnIDIQOkJBeatC8+S3Ax3N0RIdmN+fL3wXgw=
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds basic support for TI's TPS62870/TPS62871/TPS62872/
TPS62873 high-frequency single-channel step-down converters with an
I2C interface.

The devices can operate in power save mode for maximum efficiency, or
forced-PWM mode for best transient performance and lowest output
voltage ripple. All chip variants have four output voltage ranges and
the driver changes active range depending on the requested voltage
setting.

There are differences in the electrical characteristics and packaging
between the variants, but the register interfaces are identical.

Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
---
Changes in v3:
- dt-bindings: Changed subject prefix "regulator:" => "regulator: dt-bindings:".
- dt-bindings: Dropped 'regulators' and 'vout' nodes.
- dt-bindings: Added description for regulator-initial-mode.
- Call of_get_regulator_init_data to read the regulation constraints from driver probe.
- Drop local get/set voltage functions and use helper functions get/set/list_pickable_regmap
  with linear_ranges/linear_range_selectors mappings instead.
- Link to v2: https://lore.kernel.org/r/20230502-tps6287x-driver-v2-0-fb5419d46c49@axis.com

Changes in v2:
- No changes. v2 was v1

---
Mårten Lindahl (2):
      regulator: dt-bindings: Add bindings for TPS6287x
      regulator: Add support for TI TPS6287x regulators

 .../devicetree/bindings/regulator/ti,tps62870.yaml |  52 ++++++
 drivers/regulator/Kconfig                          |  11 ++
 drivers/regulator/Makefile                         |   1 +
 drivers/regulator/tps6287x-regulator.c             | 188 +++++++++++++++++++++
 4 files changed, 252 insertions(+)
---
base-commit: 457391b0380335d5e9a5babdec90ac53928b23b4
change-id: 20230502-tps6287x-driver-af1474b3111e

Best regards,
-- 
Mårten Lindahl <marten.lindahl@axis.com>

