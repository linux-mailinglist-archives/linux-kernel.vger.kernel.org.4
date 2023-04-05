Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5AA06D7E79
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 16:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238377AbjDEOD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 10:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238356AbjDEOCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 10:02:41 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7ADA618F;
        Wed,  5 Apr 2023 07:01:27 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id d11-20020a05600c3acb00b003ef6e6754c5so18362465wms.5;
        Wed, 05 Apr 2023 07:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680703285;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=G5kwguWxkAgYjChN2JcXRMJaOaIUOoAW4NUgaQMeXwg=;
        b=cB4vFld7agy3nSnxcp+5f4KqgGtPh/FWXNnH3fizc4ogBwTKgMtNHt4BODSwd3mSei
         C1kVJ61Y8d4cyBuYZI4xaVHvtXU5mDhKtu899XdVZUlDeWuy8K8KVIxAACj9pBqAN5cc
         PEbddg+hPU/RxwhpsHPii898/uXgDWF5nr/E/vnmsHYbXBdqCiMboYH/MlxzYOc1L+i3
         6/j17Uy/0w/ndAVIM86u6LbzXJ3n/MGtabF2ck9T+TJfTWJifuyBX6NbuhSRCkFquOxn
         cp/XfOPKsD2RWx5t6LTweraDR2Ok+IX9Or3NJVpi2Dm32kcbLreoVv9akxn01VcPFi3d
         3q+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680703285;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G5kwguWxkAgYjChN2JcXRMJaOaIUOoAW4NUgaQMeXwg=;
        b=amCoRa8JQWD+tgOuI38v02qyQ228Tj3WhShrXHuneKknMQKtF3HUCTuCjvpL7FvkoI
         Dv18QwGSt8+FqD+sXzDZ/1fbaC3+GIb+cgMYo4pdECqwRQWioCl2evDfQTGBdKVavKtK
         5Y2tFxtGunlB7lBxui1bmAYvdF/RI28eNjAbpM5+F0VIDcVz7hdlridVE3ehMW60KB6r
         Op6owHAmuQconjInPtRFmsnbyCCj+wL3NVNnysgm1vEeHx5dcoqN+WrejKBMFXa9f+1W
         iNVd2M6P7RZE7zXL7ChCr1QxIjBeaLeAMq50ZiIUfDG9hA7hIiUtBioi+Zqzsp1Fqexs
         4Wnw==
X-Gm-Message-State: AAQBX9cZdpeMI7jl8tWLRA53fIo8FLclspir3icLXG2hIoHnlG3oymzp
        RwZrmJvB2EfDh1/ikG2pDr8=
X-Google-Smtp-Source: AKy350brcBoEW7IgS0jXdaIT48stNoGHbjEyB3ASoSZmfZ3EM1VWROwogLnOGT7jqLNDkC2VqLHgzA==
X-Received: by 2002:a05:600c:b56:b0:3ed:316d:668d with SMTP id k22-20020a05600c0b5600b003ed316d668dmr4500906wmr.5.1680703285333;
        Wed, 05 Apr 2023 07:01:25 -0700 (PDT)
Received: from archbox.v.cablecom.net (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id g6-20020a05600c4ec600b003edc4788fa0sm2412383wmq.2.2023.04.05.07.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 07:01:24 -0700 (PDT)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Kory Maincent <kory.maincent@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Michael Welling <mwelling@ieee.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] Add MCP48XX bindings and driver support
Date:   Wed,  5 Apr 2023 16:01:10 +0200
Message-Id: <20230405140114.99011-1-frattaroli.nicolas@gmail.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series aims to add support for the following DAC chips by Microchip:
 - MCP4801 (8 bit, 1 channel)
 - MCP4802 (8 bit, 2 channels)
 - MCP4811 (10 bit, 1 channel)
 - MCP4812 (10 bit, 2 channels)
 - MCP4821 (12 bit, 1 channel)
 - MCP4822 (12 bit, 2 channels)

The chips' interface is compatible with that of the MCP49XX ones, but they
come with an internal 2.048V voltage reference, meaning there is no need
for an external voltage reference (and no way to use one.)

The first patch rectifies an issue with the mcp4922 bindings where there
was no vdd-supply property modeled. Those chips do have a second supply
aside from vref, the vdd-supply, which powers the digital logic side of
things.

Patch number 2 uses the vdd regulator in the driver. This is just fairly
boring "enable it here, disable it here" type stuff.

Patch number 3 adds the bindings for the MCP48XX chips. We add the whole
family, not just the ones that have an analogous 4922 enum. There is a
need for a separate binding as making vref only required for some in the
mcp4922 binding would make it more complicated than it's worth.

Patch number 4 finally makes all the driver changes to support the
MCP48XX chips.

All changes have been tested on an MCP4821. I don't own the full line of
MCP48XX and MCP49XX chips, so couldn't exhaustively test everything for
all of them, but if Microchip feels like sending some over then I am more
than happy to receive them.

Kind regards,
Nicolas Frattaroli

Nicolas Frattaroli (4):
  dt-bindings: iio: dac: mcp4922: add vdd-supply property
  iio: dac: mcp4922: get and enable vdd regulator
  dt-bindings: iio: dac: add mcp4822
  iio: dac: mcp4922: add support for mcp48xx series chips

 .../bindings/iio/dac/microchip,mcp4822.yaml   |  49 +++++++
 .../bindings/iio/dac/microchip,mcp4922.yaml   |   4 +
 drivers/iio/dac/mcp4922.c                     | 130 ++++++++++++++----
 3 files changed, 154 insertions(+), 29 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/dac/microchip,mcp4822.yaml

-- 
2.40.0

