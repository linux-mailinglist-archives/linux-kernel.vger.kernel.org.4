Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C640772B832
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 08:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbjFLGn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 02:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233001AbjFLGnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 02:43:24 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A58361997;
        Sun, 11 Jun 2023 23:38:23 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-30fc6b513afso68008f8f.1;
        Sun, 11 Jun 2023 23:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686551678; x=1689143678;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0Wat54lnLjucqBUhCyCz2jjA942pDQtZohk+myr2KU4=;
        b=c2zzRyWDsD9NA/NQkSWJl9TYXJpYTRoWVyrQJIqWKkJge3T4w4eXHIbyqIM227yTDD
         +82SXmmwVQlQOmgWR0fmPw0cshkPbniT7JJ282anh1Ucg1zljdtJh5LL9zMrMN5n80tM
         AXtaE8Y2ghuoVNoX2CQoQGov2jouSHTdP7O3OA+ijRzjnObWic7xtk9O99Vidl0H3ik5
         2wbGJ5RZy0rhlIpYnv3LgmC5R1Sri99aLUaUOl9wGxyHLFWX9hQiAEf3LXV2GIjNuMM7
         BvboEyN7Uc1FJZAU2O84iaBhVClYWnI4aXlHjDkuGHm0XAxibzcrSeOh3w0zxyhD8pHP
         z4iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686551678; x=1689143678;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Wat54lnLjucqBUhCyCz2jjA942pDQtZohk+myr2KU4=;
        b=H5S2Uk6uw4zIiuTHgvkr0iyW483cYBWRjasydcYCEFflJ9ZL+PTTA2ZDDtgT7kCoNc
         1Ocd0wcrxOKywlKFS/BvD1exf6W0WovH9Il5Lct84iLfjLmsr7UzpTcSWwre3bLErkX5
         F/0Wy93M6WHZrnb41oo19uqxkscr6N04yZRWdr6DSPSrlx4LCbihW2P/P4tRG5OO3BRr
         WSMkHdSAJ1S7hXTbJg9WjnY8CYyNAIXAdpov/XC1Z7G599dKhQWSnXkFHu69e/o+Foi8
         JQe67lzlIW0WJ+Z3LuN+ugD4PLNITwFAmYtt2Xpmo34v+X0jW0ltu00R2kJo9aM7ELtU
         38Dg==
X-Gm-Message-State: AC+VfDyARvljZ1uuZvCJxIboJRrZkpb4xyc6Rsg+kf5Kj+wQJGLF9avN
        wxo5bI+yB666sIHi1jNl/hL1ugbeigSXae45
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

