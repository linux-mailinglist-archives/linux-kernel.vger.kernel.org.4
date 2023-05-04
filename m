Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAF4C6F6790
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 10:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbjEDIdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 04:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjEDIdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 04:33:23 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E930259FB;
        Thu,  4 May 2023 01:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1683189059;
  x=1714725059;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=HhTeVThYjqC5+zx24jz47KblfR0STIeFxg+9UBQHkxE=;
  b=WdfJFzDj2HDUlSHGIE/egn4OQkkN4CHY7FkYKHFmFsIwlgVEapx9eXFz
   N2qDaEOm71trj9xlR0nPXFFlhgMk7ju5bxlA3/QUysF2rkFVRjk32Imrj
   RKeQ+HvLoe2qkYMTr/hRTBrxc+u3Yc32vf8PHMZbG1EQJKtQsNCgUgFH2
   yWCAmOeT2c+fdIyoLabCM5ClB8UWM1FffT8YEriqghLsAZjD/HP5DaUiL
   pyI2p8k49OFmVSOTXfst2A7Dx6hRkcS1FfrvHzzQSQ9gRKht5Zn4GYv8a
   2xqKFvCaQ+TfQ/PS2I/syLqB/+r7y0KF591LBCg/vbP6HQrZAfQi0HqZB
   w==;
From:   =?utf-8?q?M=C3=A5rten_Lindahl?= <marten.lindahl@axis.com>
Subject: [PATCH v2 0/2] regulator: Add support for TPS6287x
Date:   Thu, 4 May 2023 10:30:25 +0200
Message-ID: <20230502-tps6287x-driver-v2-0-fb5419d46c49@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIACFtU2QC/3WNOw6DMBAFrxJtHUe2IZikyj0iChsvYQs+2kUWE
 eLuMfQp5z2NZgNBJhR4XjZgTCQ0jRns9QJt78cPKoqZwWpb6Lu2apmlsrVbVWRKyMp3pnRlKIw
 xCNkKXlAF9mPbH97gZUE+jpmxo/VMvZvMPcky8fcsJ3Os/yPJKK1cfFS21IULsX75leTWTgM0+
 77/AK99gcfGAAAA
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <kernel@axis.com>,
        =?utf-8?q?M=C3=A5rten_Lindahl?= <marten.lindahl@axis.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1683189034; l=1221;
 i=marten.lindahl@axis.com; s=20230329; h=from:subject:message-id;
 bh=hw3y+o1+BDEcAyYiL8zhlT5s48d44X6D8C3M/5vWEdc=;
 b=vA4Edp+B0E44f44phW9rS1WNhy12IQFxZxMfSKqqgKv58YGtSkijuDnpCpGH+lcPxxOCqRMmg
 rhvoN6CmSNVDDEECGwMguQ/lrOjLLVcpXI+tDjYb+JBNKW9aGNml2Cf
X-Developer-Key: i=marten.lindahl@axis.com; a=ed25519;
 pk=JfbjqFPJnIDIQOkJBeatC8+S3Ax3N0RIdmN+fL3wXgw=
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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
the active range is set via the I2C interface.

There are differences in the electrical characteristics and packaging
between the variants, but the register interfaces are identical.

Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
---
Mårten Lindahl (2):
      regulator: Add bindings for TPS6287x
      regulator: Add support for TI TPS6287x regulators

 .../devicetree/bindings/regulator/ti,tps62870.yaml |  62 +++++
 drivers/regulator/Kconfig                          |  11 +
 drivers/regulator/Makefile                         |   1 +
 drivers/regulator/tps6287x-regulator.c             | 289 +++++++++++++++++++++
 4 files changed, 363 insertions(+)
---
base-commit: 457391b0380335d5e9a5babdec90ac53928b23b4
change-id: 20230502-tps6287x-driver-af1474b3111e

Best regards,
-- 
Mårten Lindahl <marten.lindahl@axis.com>

