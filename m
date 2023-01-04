Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BBCC65CFB6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 10:37:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233802AbjADJh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 04:37:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239136AbjADJhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 04:37:25 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C049207;
        Wed,  4 Jan 2023 01:37:24 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sendonly@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 8ADF141F72;
        Wed,  4 Jan 2023 09:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1672825042; bh=wFL5o824s6njbpw90C6rdrkcieXj4RdD7IB7plCdhis=;
        h=From:To:Cc:Subject:Date;
        b=HA+GtbzMSd6PMgKNFRMmMWVo3XY7vGSaudzxbGV4nrCy72NFVLx1Z0frbOL9ibNg+
         nTY3t4aohXhmkGerj3+0Imeqo34jbN50pLiIbqM8LQPoK6kjOhotemOVfZAIo2Psmf
         FlzCKd7V202jAoMYP39gZ/64GWBj8Gw96r1abcZLcIf27jbKbkbZeSZ3NGgoW97gEE
         m77bO2EcqQxFrF7AN2v+Bg09sNvaeL5BTtXY1SWThmpYz6iXzmRsQ6o/92vvEhJiqd
         d2S4zUK1m3NprTy/xoeWShe+FFuQiX2of/suF8aBsWIzT3BRfFgnzJb3qCo1n/tSI3
         5pkX2P5SfN89Q==
From:   Hector Martin <marcan@marcan.st>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        Janne Grunau <j@jannau.net>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        asahi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Hector Martin <marcan@marcan.st>
Subject: [PATCH 0/5] SPI core CS delay fixes and additions
Date:   Wed,  4 Jan 2023 18:36:26 +0900
Message-Id: <20230104093631.15611-1-marcan@marcan.st>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commits f6c911f3308c ("spi: dt-bindings: Introduce
spi-cs-setup-ns property") and 33a2fde5f77b ("spi: Introduce
spi-cs-setup-ns property") introduced a new property to represent the
CS setup delay in the device tree, but they have some issues:

- The property is only parsed as a 16-bit integer number of nanoseconds,
  which limits the maximum value to ~65us. This is not a reasonable
  upper limit, as some devices might need a lot more.
- The property name is inconsistent with other delay properties, which
  use a "*-delay-ns" naming scheme.
- Only the setup delay is introduced, but not the related hold and
  inactive delay times.

This series fixes the issues and adds support for the two missing
properties. Please pull in the first 3 patches as fixes for 6.2, to
avoid introducing a problematic DT API in this release. The last two
patches can wait until 6.3, though are probably harmless to throw in
as fixes too, since they're trivial.

Hector Martin (2):
  spi: dt-bindings: Rename spi-cs-setup-ns to spi-cs-setup-delay-ns
  spi: Rename spi-cs-setup-ns property to spi-cs-setup-delay-ns

Janne Grunau (3):
  spi: Use a 32-bit DT property for spi-cs-setup-delay-ns
  spi: dt-bindings: Add hold/inactive CS delay peripheral properties
  spi: Parse hold/inactive CS delay values from the DT

 .../bindings/spi/spi-peripheral-props.yaml    | 14 +++++++++--
 drivers/spi/spi.c                             | 24 +++++++++++++++----
 2 files changed, 32 insertions(+), 6 deletions(-)

-- 
2.35.1

