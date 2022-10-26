Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD51260E18E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 15:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233840AbiJZNH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 09:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232823AbiJZNHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 09:07:21 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C574FAA46;
        Wed, 26 Oct 2022 06:07:17 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id c3-20020a1c3503000000b003bd21e3dd7aso1456909wma.1;
        Wed, 26 Oct 2022 06:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U4gTLQJXz8CMD4MLdfjgD1120eev/1EzGcTrgRnh7XU=;
        b=aXDDaKjTkIvcxKodmX/+BaVYCdDTU7FaI3gq/pU7TC2XjKNFpp/AHW+uYK8oP9xRVY
         4/PoYLl2z4sh4Y/pCgKIQWYKVh3QCrPFTDnhLzPR/IjY6MX10weZ4Bc7cGAuwIo1LKYB
         XlhIoL9uOSxkSbSFx1gs/y4OOafXKeZtubOE3GRqLTbF1chhS3LeAdI10G8eAg0/cQwS
         hbIJQCNj+JeVVKyaBMkd7HW7w/oPltgUbLEXLBZ3ftIA7WogWr8CAe3QHdaQgbI4BOyh
         6EDw4nhON1NoZl0AWE7scf/eByvEDw6NlvBR1EkOnzW8GvgUt+ObhBKDNHo1NyJYJNvU
         vKRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U4gTLQJXz8CMD4MLdfjgD1120eev/1EzGcTrgRnh7XU=;
        b=s2rcbYcPAxyyfInZu/J2C5mfQG80hfatyk+jJa+zhlj5CDpO0DPwQ3zNFLebhqclgg
         +7LMhS/n2BGkg0hq5wq7uIwTp9PzB2YjG97TzRuAl22EYtX7siTD7fhCNiWI4ZXa+kCF
         cDJ3UBZ3QygQJTXxcQ0N3EsEDijBCFZO3piML9t7+RZ/l4jX7MRLf5UN1a4RnIEnYfgA
         fTiJq6WidKb5fgW3zJHHqwY5Fck1DPnaGXcYh60X8ccTUG3eO999AFET2FWWpM7oQgGt
         8ApI5qL/NLaSkhWcXcUsVayChK3WGaVnT2ubNYl8h4Ko26KsOh67QfwVUP5ezeIAJrS6
         reTA==
X-Gm-Message-State: ACrzQf0rPd62mYqMf3wzVrZ6CJcUq8UndZB/NqOzL2MrR8zpD6YBDpRq
        EZnxv+rCb2wyIc8O7rSXJ54=
X-Google-Smtp-Source: AMsMyM48kddrD6lp9ckBPpw7UY4pEAXskQBW0gVtLLEqOUJGtxCXskiv0N20wQEPWzQJKQgfPomwJA==
X-Received: by 2002:a7b:cc15:0:b0:3b4:ca90:970d with SMTP id f21-20020a7bcc15000000b003b4ca90970dmr2458810wmh.198.1666789635445;
        Wed, 26 Oct 2022 06:07:15 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:cc:c67c:46e:319e])
        by smtp.gmail.com with ESMTPSA id l3-20020adfa383000000b002366eb01e07sm5245433wrb.114.2022.10.26.06.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 06:07:14 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Shawn Tu <shawnx.tu@intel.com>, Jacopo Mondi <jacopo@jmondi.org>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v3 0/9] media: i2c: ov5645 driver enhancements
Date:   Wed, 26 Oct 2022 14:06:49 +0100
Message-Id: <20221026130658.45601-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Hi All,

The main aim of this series is to add Runtime PM support to the sensor
driver alongside some cleanups and fixes.

v2 -> v3
- Included patch#1 [2] as part of this series
- Patched all in-tree DTS for dropping the clock preoperty to
  avoid dt warnings
- Fixed review comments pointed by Sakari and Laurent for the Runtime
  PM patch
- Now sending the error code of first error while stream off.
- Included RB tags from Laurent

v1-> v2
- patch #1 is infact a v3 [1] no changes
- patch #2 fixed review comments pointed by Sakari
- patch #3 [0] no changes 
- patches #4 and #5 are new

[0] https://patchwork.linuxtv.org/project/linux-media/patch/20220927202005.750621-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
[1] https://patchwork.linuxtv.org/project/linux-media/patch/20220919153540.178732-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
[2] https://patchwork.kernel.org/project/linux-media/patch/20220919143350.176746-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

Lad Prabhakar (9):
  media: i2c: ov5645: Drop fetching the clk reference by name
  ARM: dts: imx6qdl-pico: Drop clock-names property
  ARM: dts: imx6qdl-wandboard: Drop clock-names property
  arm64: dts: renesas: aistarvision-mipi-adapter-2.1: Drop clock-names
    property
  media: dt-bindings: ov5645: Convert OV5645 binding to a schema
  media: i2c: ov5645: Use runtime PM
  media: i2c: ov5645: Drop empty comment
  media: i2c: ov5645: Don't return early on failures for s_stream(0)
  media: i2c: ov5645: Call ov5645_entity_init_cfg() before registering
    the subdev

 .../devicetree/bindings/media/i2c/ov5645.txt  |  54 ------
 .../bindings/media/i2c/ovti,ov5645.yaml       | 104 ++++++++++++
 arch/arm/boot/dts/imx6qdl-pico.dtsi           |   1 -
 arch/arm/boot/dts/imx6qdl-wandboard.dtsi      |   1 -
 .../aistarvision-mipi-adapter-2.1.dtsi        |   1 -
 drivers/media/i2c/Kconfig                     |   2 +-
 drivers/media/i2c/ov5645.c                    | 157 +++++++++---------
 7 files changed, 186 insertions(+), 134 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/media/i2c/ov5645.txt
 create mode 100644 Documentation/devicetree/bindings/media/i2c/ovti,ov5645.yaml

-- 
2.25.1

