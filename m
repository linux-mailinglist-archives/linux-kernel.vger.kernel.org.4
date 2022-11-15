Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C890629665
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 11:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233025AbiKOKxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 05:53:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238434AbiKOKw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 05:52:28 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A422714E;
        Tue, 15 Nov 2022 02:51:48 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id t25-20020a1c7719000000b003cfa34ea516so776323wmi.1;
        Tue, 15 Nov 2022 02:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/TDg3jButA61q6p3uGjmgDDrbdJSU8F6g2ZLke3odgw=;
        b=X0R1NAZVLu4RBi5KgXypsvFBIg5QEFrylN7vFWF46f0VM1D7heC03jvVAYs8/RfUUE
         ZZUOiudVLMASxhStB1tFkgdOZl6Q284Wcct13khDndPxOAAUSwxIFTXN0vatgn6eqm+x
         wEa7a5ilhSjng5A5vAcvJdfdive6xOiVWg6DFMez3jEJkBdElUQ69+wFKoP6A9VsG0oR
         8vmTcSyqjrbY9INzbMykMohisfBoPUAazRc8lD3lTRS4TUTdoxFEOKNBeVRZ+xdwS7qT
         sa2EsEBZ1biakUh2yiaK5JgBXGlbPkyN4NK31EOohzsxU043oqLzjGXiDJwGPNp4SB4D
         kD2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/TDg3jButA61q6p3uGjmgDDrbdJSU8F6g2ZLke3odgw=;
        b=491Z73HBUG6xmfBpNUwH47j4Qsqq0ayJyJZydvt/9TgY2j0nnyrwaYOMq0/ofYJr75
         UcxSGP93jVY/eMS+EsTPf+OxIqgh7KXPLuMFEK3Zo48zjf3a7xQcU5J/3XOZdxwccCCJ
         Pn1OrwDx738o0Lbw/Hf3YBx0Cg2q1Xm4Ev13XQJA0YNbd5fnINC26rbtcgXntS3LlKHN
         Dc8ws+a/wO5e/EpsM5We1wq0Yfuwqeovj9PHg93vWTLq2bvXJlLJSavmTMx5FLZ5/HxC
         Yj8npZEqO01Cyuh1OeR5RX4vHpiWZJEZ06tYzUwReNNOo4WxSepWJQ53bB5h0pazsM/N
         gZVg==
X-Gm-Message-State: ANoB5pkWcV8P73OELhBWcUNw1cPFaHtswp28pGGpnHOzL8zFSOHoRcg3
        JozIwuTXt9z1g6SQbHLZlOg=
X-Google-Smtp-Source: AA0mqf6oFZeyqPUzVDWOKkiLPZSs86RgzmZPi/RIsvMouJL+GjY/VRXUWn9klGYGOgk3BINvu5Uomg==
X-Received: by 2002:a05:600c:5569:b0:3cf:63fd:cda8 with SMTP id ja9-20020a05600c556900b003cf63fdcda8mr1015353wmb.46.1668509506664;
        Tue, 15 Nov 2022 02:51:46 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2501:c701:d94a:6345:c378:e255])
        by smtp.gmail.com with ESMTPSA id az9-20020adfe189000000b002367ad808a9sm12210528wrb.30.2022.11.15.02.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 02:51:45 -0800 (PST)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Magnus Damm <magnus.damm@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 0/3] RZ/Five: Enable ADC/CANFD/I2C/OPP/Thermal Zones/TSU
Date:   Tue, 15 Nov 2022 10:51:32 +0000
Message-Id: <20221115105135.1180490-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Hi All,

This patch series aims to enable support for below blocks
on RZ/Five SoC/SMARC EVK:
- ADC
- CANFD
- I2C
- OPP
- Thermal Zones
- TSU

Note, patches apply on top of [0].

[0] https://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-devel.git/log/?h=renesas-riscv-dt-for-v6.2

Cheers,
Prabhakar

Lad Prabhakar (3):
  riscv: Kconfig: Enable cpufreq kconfig menu
  riscv: dts: renesas: r9a07g043f/rzfive-smarc-som: Enable
    ADC/OPP/Thermal Zones/TSU
  riscv: dts: renesas: rzfive-smarc: Enable CANFD/I2C

 arch/riscv/Kconfig                            |  2 ++
 arch/riscv/boot/dts/renesas/r9a07g043f.dtsi   |  2 ++
 .../boot/dts/renesas/rzfive-smarc-som.dtsi    | 11 --------
 arch/riscv/boot/dts/renesas/rzfive-smarc.dtsi | 27 -------------------
 4 files changed, 4 insertions(+), 38 deletions(-)

-- 
2.25.1

