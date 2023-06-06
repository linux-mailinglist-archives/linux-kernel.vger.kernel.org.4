Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF1C672460A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 16:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237926AbjFFOcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 10:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232596AbjFFOcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 10:32:13 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C25A810F4
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 07:32:03 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f6d7abe9a4so53991415e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 07:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686061922; x=1688653922;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f3FWgbLaTsMXyxlnHqLG8/53dcD+IHDf7oHMhEF25Eo=;
        b=XZzIrRVuLoimzz/NSHevNJnbsurxaneyPqFlR86WSk4yp9MEhtiAEydMWldCXWiZuN
         x3Tcf/1eGdlJXm0dU+WN42Kedj0XQEJnF21iyQ1rFDHd11xl+MdQotjeTFRR1GnOuhWf
         ez0CokClYUCEgJvUTBtkLfpmy0p7vaOKwFdhNE7ki4eM6F1uYFTsRSAmy1zyB9D0QPjp
         uBqDJR8VMBwOlTktEXsLAkK0oWSAabxqFRpo3PTXZPRFiCgqRZcbkwAp5ZSIwOFTikfJ
         WZCHlBbdYs78gBm5ly5M+6AaLxhP1feeEbU+X35HKRsN18jFUQ5vszbB7iU8AHros0qi
         +I3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686061922; x=1688653922;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f3FWgbLaTsMXyxlnHqLG8/53dcD+IHDf7oHMhEF25Eo=;
        b=V+GN7KBJgImSYnvEVMsnw/HPq4ZsJ5n7kaX6sNbECeZ5uRDj7gUhbJ0xsL3WYRQbDm
         0zVNDtbM92Szy0VkkfcOSQf+3drFLJOp5WFVC9xbknwiSWCZZCb+tDpV+sczUAnvjMbw
         wJlRhCe340CE43E/m/AUUAc4WbdWm54oZqfd5v5TwMt5NycnpxPgcj5itgUy1bv7JzTn
         dKH97w7EBz/YYXOUB4A3b5lM3DM3oQuzRFNK+XPPD3N8e7eVObVoP8fW3AiP+xNP2i0c
         7muYCz4TCY/V/DY7nxrbDAxmsmahG8/a5UPiujn4Y+QZddsHp68fwiA3ILWj3rkdM5AX
         I95g==
X-Gm-Message-State: AC+VfDzsChyY+7vyyT9kYrR/efm5aBKqrf25cNwpluXMpkNLJGGHT3Q3
        3XUi4ctJkNe/4y+NKj08VXREVcQMXiIvwgmcB55eyGqI
X-Google-Smtp-Source: ACHHUZ6IJLZ6iGkLQ8I2sRoB41wz0InmXh+lWBUEREnX0XqvTRvivEZWkXmcdQ8LwJFs8/dZk+vQAw==
X-Received: by 2002:a1c:f206:0:b0:3f6:f4b:38bd with SMTP id s6-20020a1cf206000000b003f60f4b38bdmr2346928wmc.8.1686061922174;
        Tue, 06 Jun 2023 07:32:02 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id fc14-20020a05600c524e00b003f61177faffsm3883600wmb.0.2023.06.06.07.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 07:32:01 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH RFC 0/4] input: touchscreen: add initial support for Goodix
 Berlin touchscreen IC
Date:   Tue, 06 Jun 2023 16:31:55 +0200
Message-Id: <20230606-topic-goodix-berlin-upstream-initial-v1-0-4a0741b8aefd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFtDf2QC/x2NQQrCMBAAv1L27EKsUqtXwQd4FQ+bdNsuxCRsU
 imU/t3gceYws0FmFc5wazZQ/kqWGCocDw24mcLEKENlaE17Mp3psMQkDqcYB1nRsnoJuKRclOm
 DEqQIebR0vXDPrh/PDmrKUma0SsHNNRYW76tMyqOs//cLno87vPf9B/IuzqOQAAAA
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Henrik Rydberg <rydberg@bitmath.org>
Cc:     linux-input@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1884;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=HpTYvEajINY4Y1VMwHDbzKbegLEdvB2suIe1KsahLI8=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkf0NfJoMrxdtP6eAK0YQ+0WEhVaRSveQFFXUN5K88
 a5CFuFqJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZH9DXwAKCRB33NvayMhJ0avPD/
 9WqTj1r1nreA4R7Q5h2H1dPOCO/bsyB1ANjAkK0TGBAn/I37s9vggSviGHMFGzQr0Ko0jjErdVNpZS
 2+TYTfAqPLYfXCeTbTcxFfAoYlzubyiZQKOFinIYyJ0D9NiAohh+V9TmpHCYdpwfC0xUGZURDE36RJ
 bl/PbaHZBneGgyT9VKsli69Oi6HiKXdteoQPG5EUVxzKWh4D8SsG93YMdONDHRYcpNBP7nIFTNuZxc
 1wnrFdqq61MlfKzWzBmKXMhGzeGQhAxr7c7KBOsbYzFqmQ+dZTEHweoAN5U7b4wZrF88/3TWDrAU8n
 cBxx0l5GBAvpJaDFwkK90Wxcz2jWvWW85b16DWtrKrkpsji8DCHQCHTCtPAAqBkQ1h2HemIukG7edI
 YKrkj3LHoDZLkWq/t2kPH46azM960ZIX8DnfjZ5ZTA8PdrWBRYAk4iyoPXvyRmUQwHELfSwmCZ8jv6
 gZ7NTor8sE82/9A/6RC7L/Z9Ledjv0XjCK3Tl53Mx2JYrdvSQWG0G8eV2SBVSmzeqcPxC0vSXrm9Gt
 ecderG6nppwMUI735pLaCH3/aR0ydsU4+3uYk2UuRIPtHVZXKX4dJAGngec+xCMrrCkvsMEUYQlmDR
 HmIyWH9MeuHz9xVd/KD6G+IXEOK/JJRI+IkBMLlNWd4JEmuWSmthDqPxpMbA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These touchscreen ICs support SPI, I2C and I3C interface, up to
10 finger touch, stylus and gestures events.

This initial driver is derived from the Goodix goodix_ts_berlin
available at [1] and [2] and only supports the GT9916 IC
present on the Qualcomm SM8550 MTP & QRD touch panel.

The current implementation only supports BerlinD, aka GT9916.

Support for advanced features like:
- Firmware & config update
- Stylus events
- Gestures events
- Previous revisions support (BerlinA or BerlinB)
is not included in current version.

The current support will work with currently flashed firmware
and config, and bail out if firmware or config aren't flashed yet.

[1] https://github.com/goodix/goodix_ts_berlin
[2] https://git.codelinaro.org/clo/la/platform/vendor/opensource/touch-drivers

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Neil Armstrong (4):
      dt-bindings: input: document Goodix Berlin Touchscreen IC
      input: touchscreen: add core support for Goodix Berlin Touchscreen IC
      input: touchscreen: add I2C support for Goodix Berlin Touchscreen IC
      input: touchscreen: add SPI support for Goodix Berlin Touchscreen IC

 .../bindings/input/touchscreen/goodix-berlin.yaml  |  81 ++
 drivers/input/touchscreen/Kconfig                  |  33 +
 drivers/input/touchscreen/Makefile                 |   3 +
 drivers/input/touchscreen/goodix_berlin.h          | 228 +++++
 drivers/input/touchscreen/goodix_berlin_core.c     | 935 +++++++++++++++++++++
 drivers/input/touchscreen/goodix_berlin_i2c.c      |  76 ++
 drivers/input/touchscreen/goodix_berlin_spi.c      | 183 ++++
 7 files changed, 1539 insertions(+)
---
base-commit: 6db29e14f4fb7bce9eb5290288e71b05c2b0d118
change-id: 20230606-topic-goodix-berlin-upstream-initial-ba97e8ec8f4c

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

