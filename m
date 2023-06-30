Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 407A6743B76
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 14:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbjF3MGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 08:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233014AbjF3MFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 08:05:41 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1DAC46B8;
        Fri, 30 Jun 2023 05:04:56 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fbc12181b6so15461825e9.2;
        Fri, 30 Jun 2023 05:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688126687; x=1690718687;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XeWX/R3ALNQW7TMdg+WDALqzh4Qvq/B6Wn9m1S92myA=;
        b=JoLxtruYLIlTTHRqsCr+TZ6lLDf8IIj/rhFiwETu3Qp7dNG/lRPnCyfHxdG9aPgJB6
         GU6V1HDHQVP+/fmNPyCMlRtR01ZJFwB6zSQdKhfmmF+I64oT/LZgQmLsnXPdUA56A4Lw
         2VYwy6fOQ+IHOk22ddL0HSVBkQzaVy6e2EgtFHKtRSJlNW1XIerKAtPTSdTESwQZtqjO
         4nLDPvDASO64ceaPyBAoBkkW+CoS7rCOUMXP+8PMHSw50Fn6Nzqufe3IkFgaXUjv+igp
         PP17+yS3HmaVMEFX/M5qfduAK2KcImCsvNMCFwAcwFdpAUOvm8GtlljoNCKcBA76oND9
         YRBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688126687; x=1690718687;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XeWX/R3ALNQW7TMdg+WDALqzh4Qvq/B6Wn9m1S92myA=;
        b=C+j/0gl4OFwFJMHsjAkL9tB4l7+sJgohl1Pe6i3NE1d8AB2ZJkrWV3cyuioelCfoOv
         cqnxooNqOlX7m06ml7bs636jZDKsqqu7CtQ8dCW2Ya4PCBygbGcjpKmVh42NXnbPXj5k
         +KsUTy3Hc/fVCcXzlBR2LmcTsOJQQSwx5ni5oYPc7eeJ89sIyP0jLX1yU8A5pMDa8xNX
         le4HUTS28t30//V9QU2LV36aj1rBNatBn8yjr0zAfmuI73BHWC2GV7rFjewKbYMK0XHR
         kp6EDSGz/4mAijT/SvJSRbjzpHW8U5qNtQU4eO3G+xWlzgREUL9KyyQCpdoiakVj4Xqo
         ZqUw==
X-Gm-Message-State: AC+VfDxSJanoNgri6m1qJYm/0YLTch9QD6+hpMYnq9c/IQhu13phX8dB
        y12N5b1o+qq2fgZ8wLgTOGA=
X-Google-Smtp-Source: ACHHUZ4/eJQGJDNAiNsJSdVSI4ZAtA7L30Wt/03YbJalDCSU7kF5tE/eLGUmDlr4nRGqTwyJlmnqCw==
X-Received: by 2002:a05:600c:21ce:b0:3f8:d0e7:dad8 with SMTP id x14-20020a05600c21ce00b003f8d0e7dad8mr1784038wmj.3.1688126687111;
        Fri, 30 Jun 2023 05:04:47 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:dbbb:7082:18ec:f407])
        by smtp.gmail.com with ESMTPSA id k22-20020a05600c0b5600b003fb40f5f553sm11766912wmr.31.2023.06.30.05.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 05:04:46 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [RFC PATCH 0/4] Add missing pins for RZ/Five SoC
Date:   Fri, 30 Jun 2023 13:04:29 +0100
Message-Id: <20230630120433.49529-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Hi Geert,

This patch series intends to incorporate the absent port pins P19 to P28,
which are exclusively available on the RZ/Five SoC.

I am submitting this series as an RFC (Request for Comments) as the port
pins P19 to P28 cannot be utilized as GPIO but can be utilized as
multiplexed pins. Additionally, certain attributes such as setting the
ISEL would necessitate a device tree property to indicate ISEL. Therefore,
before proceeding with the addition of comprehensive support, I would
appreciate some input on whether an alternative approach could be considered.

Cheers,
Prabhakar

Lad Prabhakar (4):
  pinctrl: renesas: rzg2l: Include pinmap in RZG2L_GPIO_PORT_PACK()
    macro
  pinctrl: renesas: pinctrl-rzg2l: Add validation of GPIO pin in
    rzg2l_gpio_request()
  pinctrl: renesas: pinctrl-rzg2l: Add the missing port pins P19 to P28
  riscv: dts: renesas: r9a07g043f: Update gpio-ranges property

 arch/riscv/boot/dts/renesas/r9a07g043f.dtsi |   4 +
 drivers/pinctrl/renesas/pinctrl-rzg2l.c     | 263 +++++++++++++-------
 2 files changed, 176 insertions(+), 91 deletions(-)

-- 
2.34.1

