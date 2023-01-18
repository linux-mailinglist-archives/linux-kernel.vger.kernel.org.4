Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6EA7671ACF
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 12:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjARLgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 06:36:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjARLef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 06:34:35 -0500
X-Greylist: delayed 161094 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 18 Jan 2023 02:53:22 PST
Received: from smtp-bc08.mail.infomaniak.ch (smtp-bc08.mail.infomaniak.ch [45.157.188.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 875D34672B
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 02:53:17 -0800 (PST)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4NxjKB72wpzMr8gW;
        Wed, 18 Jan 2023 11:53:02 +0100 (CET)
Received: from unknown by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4NxjK91Q24zMpxwQ;
        Wed, 18 Jan 2023 11:53:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pschenker.ch;
        s=20220412; t=1674039182;
        bh=azzQVRfh2ssB7jTVxN2Jl5CzMmOtv/JXZkTC0wNRDYo=;
        h=From:To:Cc:Subject:Date:From;
        b=YoZ/fwdJBwKGVqyGM7M8u+tbFuaJ9Kg1Lf42vt5kqfySdL7afRkF9rRN4WP89jhBK
         IQ2f+Dx9nUzrEhC2taw9z5i6P+F97BKxKmR7CIBcoaJ85c+OFKrW2QEH8Q/0c7pUos
         beekTaUWaUsYWrEi8ZXeg9j7DUnxZpBlTHL5po+U=
From:   Philippe Schenker <dev@pschenker.ch>
To:     devicetree@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] arm64: dts: (imx8mm|imx8mp)-verdin-dev: Do not include dahlia dtsi
Date:   Wed, 18 Jan 2023 11:52:49 +0100
Message-Id: <20230118105251.6035-1-dev@pschenker.ch>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Philippe Schenker <philippe.schenker@toradex.com>


We so far included the Dahlia device-tree in the development board
devicetree in order to try to minimize code duplication.

This mainly gets rid of ''status = "okay"' lines. Plus we saw that some
settings in the audio-codec of verdin-imx8mm are inherited that are
wrong for the development board. Those did also lead to the DT Schema
checker to fail on multiple settings.

We decided to remove this include in order to get the audio-codec
settings correct and make the DT Schema checker return less warnings.
This introduces some code duplication which we consider being mostly
only configuration of the actual development/dahlia boards.

This series of two patches removes the include for both Verdin boards we
have at the moment.

This issue was spotted by Rob Herring. [1]

[1] https://lore.kernel.org/all/167182349408.373865.10339766752503211557.robh@kernel.org/


Philippe Schenker (2):
  arm64: dts: imx8mm-verdin-dev: Do not include dahlia dtsi
  arm64: dts: imx8mp-verdin-dev: Do not include dahlia dtsi

 .../boot/dts/freescale/imx8mm-verdin-dev.dtsi |  96 ++++++++++++++-
 .../boot/dts/freescale/imx8mp-verdin-dev.dtsi | 116 +++++++++++++++++-
 2 files changed, 208 insertions(+), 4 deletions(-)

-- 
2.39.0

