Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B45F272B8DD
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 09:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234822AbjFLHlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 03:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234913AbjFLHlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 03:41:37 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ECEE173C;
        Mon, 12 Jun 2023 00:40:51 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-973bf581759so714183766b.0;
        Mon, 12 Jun 2023 00:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686555566; x=1689147566;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0Wat54lnLjucqBUhCyCz2jjA942pDQtZohk+myr2KU4=;
        b=IULr1N6/8iwfaIDWmsQtedvf0fRuF6udh0VtaxLABRQA+5vlx6LjWMtsCcHu3/BTm1
         l2cFDJ5eQpFewGNJHJxXMm1czgBynzkOSt2hRRLL56K5kNIiHL0C+MF6pMWSFtRmWqJb
         ewQUiXurepCnmvQXxTUbirpcNLmI0rC0WiKQf5Y9JFm1YXeGTSv/J558x93kiSm3JQvr
         Vq7gyHQHrnCz7j8DuH6HoMb9ucPUU7x0+z0h1/oPJMIw6RjYsCm4HxSHc2S3aXVrFN4c
         HizrtEd3fbpAAuYkEMUho6bc93nAf/4W4RILOi4ZBt/YewkxpVmm2z02BqgwIBV1olWZ
         QAcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686555566; x=1689147566;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Wat54lnLjucqBUhCyCz2jjA942pDQtZohk+myr2KU4=;
        b=j6gZ0d92K0CEr4nrBmd4P5Ak1PpvyyHsWIrE6eFkBoIO7Ix+h4vdFrdySsVLOTn6lE
         KBhDAehXtXmdOpy5H+cThWvgghtUxPYuOeLKDmaeXt8A9KkzVJEp1Q4fvMujyIJnJEoc
         PX8KkvzJhJSjFFu+mMjAydtOT8rmfcFeBgmjfrdj00eosmyssnmHLn4j16rWNxbRiLmP
         sNKu+o29PRWKLqxXMG//wsiXbLCsWekTqfATOwHKeyMM8LyeafGlFbJJK0f9RpRRF31J
         W+QHtpSUKDmzSLigA1w+7NwBhmOE2uWXLOZirFL5yr1CLRP0Z98LrztjclrZXL/7sYVS
         HhPQ==
X-Gm-Message-State: AC+VfDxslkkigGeMax2XtVRBcVfcO6XcMPGReLlNsOYva71+X+JWD0XA
        wwpnoZRklPCUGNMELcCxnZIQkjP2X8yUYv6J
X-Google-Smtp-Source: ACHHUZ4U/ycWnSfITPfKvps91ZElflobta8YYppwQmKfPG5h9wzmgirJll+nMPk5Wu6GeYuJqEpRtw==
X-Received: by 2002:a5d:5704:0:b0:30f:bc21:1ce4 with SMTP id a4-20020a5d5704000000b0030fbc211ce4mr2153510wrv.14.1686551677565;
        Sun, 11 Jun 2023 23:34:37 -0700 (PDT)
Received: from user-PC.. ([178.134.198.138])
        by smtp.gmail.com with ESMTPSA id o7-20020adfeac7000000b002fed865c55esm11484811wrn.56.2023.06.11.23.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jun 2023 23:34:37 -0700 (PDT)
From:   Maksim Kiselev <bigunclemax@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Maksim Kiselev <bigunclemax@gmail.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-riscv@lists.infradead.org
Subject: Add D1/T113s thermal sensor controller support
Date:   Mon, 12 Jun 2023 09:34:16 +0300
Message-Id: <20230612063429.3343061-1-bigunclemax@gmail.com>
X-Mailer: git-send-email 2.39.2
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

This series adds support for Allwinner D1/T113s thermal sensor controller.
THIS controller is similar to the one on H6, but with only one sensor and
uses a different scale and offset values.

v4:
- Dropeed DT bindings example

v3:
- Fixed SoB tag again

v2:
- Fixed SoB tag
- Moved binding patch before driver changes

v1:
- Initial version

Maxim Kiselev (3):
  dt-bindings: thermal: sun8i: Add binding for D1/T113s THS controller
  thermal: sun8i: Add D1/T113s THS controller support
  riscv: dts: allwinner: d1: Add thermal sensor and thermal zone

 .../thermal/allwinner,sun8i-a83t-ths.yaml     |  7 ++++-
 .../boot/dts/allwinner/sunxi-d1s-t113.dtsi    | 26 +++++++++++++++++++
 drivers/thermal/sun8i_thermal.c               | 13 ++++++++++
 3 files changed, 45 insertions(+), 1 deletion(-)

-- 
2.39.2

