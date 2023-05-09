Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 522456FCAC6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 18:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235704AbjEIQJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 12:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbjEIQJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 12:09:15 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02EF818C;
        Tue,  9 May 2023 09:09:12 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id E257FFF816;
        Tue,  9 May 2023 16:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1683648551;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=XDvcIZLjCP+8xu4zO/3UciqUCkhBzDJuHbcBf2HG88E=;
        b=kG52DJBeAxb2TVi8gOSoH+e2Pijux1idmzZT5Ic5pB3G5nLrsg2h8iiAANCIZH13Y1mILQ
        VwDl9kIGtc+/ukntzd8ki2eAEwObaSyW0FYV7tPoACU+bcfltKEJIewRaFMQ0GOeHWVRPO
        Uz78dLipKttcsfdwdHpBWvr7D1Pwu11EbBv+KkeVslt311UlanjEjUgFSonBW1o7mVQz9/
        wVt5R6yOkSh9mNyWnYiE949Kd7m6YP2TeM/0veQppq6hJMrxx7Mx291zjhSLgQExhHW/E5
        h4VlD59F8Sbf6Wi4TRTV5KFqpgB9O8SJryfsNStVG3hU8G+8GYzyyPV2vlAF9w==
From:   Herve Codina <herve.codina@bootlin.com>
To:     Herve Codina <herve.codina@bootlin.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v4 0/3] Add the Renesas X9250 potentiometers IIO support
Date:   Tue,  9 May 2023 18:08:49 +0200
Message-Id: <20230509160852.158101-1-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The Renesas X9250 integrated four digitally controlled potentiometers.
On each potentiometer, the X9250T has a 100 kOhms total resistance and
the X9250U has a 50 kOhms total resistance.

Compare to the previous iteration
  https://lore.kernel.org/linux-kernel/20230421085245.302169-1-herve.codina@bootlin.com/
This v4 series updates the binding, introduced the power-supply
regulators and the write-protect gpio, uses spi_write_then_read(),
removes spi_get_device_id(spi)->name, removes spi_set_drvdata() call.

Best regards,
Herve Codina

Changes v3 -> v4
  - Patch 1
    Remove iio.yaml.
    Add 'vcc-supply', 'avp-supply' and 'avn-supply'.
    Add 'wp-gpios'

  - Patch 2
    Get and enable the regulators.
    Manage the write-protect gpio.
    Use spi_write_then_read().
    Remove the unneeded spi_setup() call.
    Get name from field added in struct x9250_cfg instead of
    spi_get_device_id(spi)->name.

  - Patch 3
    No changes

Changes v2 -> v3
  - Patch 1
    Remove the reg property description
    Use 'potentiometer' for the node name in the example.

  - Patch 2 and 3
    No changes

Changes v1 -> v2
  - Patch 1
    No changes

  - Patch 2
    Use a define for the 0x50 value used multiple times.

  - Patch 3
    No changes

Herve Codina (3):
  dt-bindings: iio: potentiometer: Add the Renesas X9250 potentiometers
  iio: potentiometer: Add support for the Renesas X9250 potentiometers
  MAINTAINERS: add the Renesas X9250 driver entry

 .../iio/potentiometer/renesas,x9250.yaml      |  78 ++++++
 MAINTAINERS                                   |   7 +
 drivers/iio/potentiometer/Kconfig             |  10 +
 drivers/iio/potentiometer/Makefile            |   1 +
 drivers/iio/potentiometer/x9250.c             | 223 ++++++++++++++++++
 5 files changed, 319 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/potentiometer/renesas,x9250.yaml
 create mode 100644 drivers/iio/potentiometer/x9250.c

-- 
2.40.1

