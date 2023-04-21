Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F85F6EA649
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 10:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231734AbjDUIxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 04:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231636AbjDUIw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 04:52:57 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAAE2A5D0;
        Fri, 21 Apr 2023 01:52:50 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id 51CF21BF20C;
        Fri, 21 Apr 2023 08:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1682067169;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=wLh6sHdmNW/ZOlcY1Y6FMyOLEeuQzg3ieXpewGsn+vY=;
        b=GQlE+sc5iO7g0PJP3FvKgbcKkRsMZhMyMtbSyJ4+9nvlaVwhVUF3WvXGl5CHXs5lLeKqaW
        VDjsR0JwImGEYk0W782AkgcyMcLSHcPVy/HNvc5ELtylJZmeA1dkvE1i7DBvvRkW1w9oLQ
        hpcOMZc04FIKuuCl2ezv8TVglTwulanGT7QpY55oDXn3O7BXJZMtrWaU8qmZc8mQtppwPw
        SOLEVda496i5hrUXYhwnwhgAWyhp6JxQ+p5ZEz0w0YCTReHckPQskGcNuLa6ftJ2jmy1Jn
        o+jx/yZAFuFSjWzOJ6rIcSPICdmtuqvgRf6IZbeL6xs39ckJOjDiNbXJT6WOcw==
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
Subject: [PATCH v3 0/3] Add the Renesas X9250 potentiometers IIO support
Date:   Fri, 21 Apr 2023 10:52:42 +0200
Message-Id: <20230421085245.302169-1-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
  https://lore.kernel.org/linux-kernel/20230420161052.270366-1-herve.codina@bootlin.com/
This v3 series updates the binding.

Best regards,
Herve Codina

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

 .../iio/potentiometer/renesas,x9250.yaml      |  54 ++++
 MAINTAINERS                                   |   7 +
 drivers/iio/potentiometer/Kconfig             |  10 +
 drivers/iio/potentiometer/Makefile            |   1 +
 drivers/iio/potentiometer/x9250.c             | 234 ++++++++++++++++++
 5 files changed, 306 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/potentiometer/renesas,x9250.yaml
 create mode 100644 drivers/iio/potentiometer/x9250.c

-- 
2.39.2

