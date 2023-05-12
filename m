Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF9007005BB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 12:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240690AbjELKiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 06:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240319AbjELKiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 06:38:05 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C62C2173F;
        Fri, 12 May 2023 03:37:32 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-64395e2a715so9825416b3a.3;
        Fri, 12 May 2023 03:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683887851; x=1686479851;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IgQuUXmZ4WixIr+d0XxzAxPcJbzSxGbi2RXLR6xLwjE=;
        b=LsZnkVp2z5gmBN59ZR6NmCkIlcYpFR+zYSP8VdW0xUsUued/kO7rFSV40YrS/rVOoa
         o0cER8YR4yfJKbI3cRE5nCX8gBkMs72tcNKfgzwHO4LCiXniphKa8IqWPFQy+sbxtN/M
         NegSZrFMIJHKY/5WCPDJLUaHpam+Ke3UQtsFskWqF+AXXqx01LWEV2bRlU9TItWG043w
         sabR8m3ldxyJgFuyQB+uCOWzR6cxU7PmiHb4s8mjlIkdimL/0zFHlpdsZkgstC28WSel
         awXDU7wZUkiRfT3AO9oGv8TkBBiSsXYwob3lDvzN7OR9KxCkbEAq4eWgqQBxTNtqb+fw
         ovJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683887851; x=1686479851;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IgQuUXmZ4WixIr+d0XxzAxPcJbzSxGbi2RXLR6xLwjE=;
        b=bGih5u31i8chjFPtjBe7o1npu/YWaFjaR9YYcg07Tc8CL9hY5by5zwZm8vSGkNrTe8
         /GNwbTDO5kHD5QO1WQ4s5g1HTQ5+vTWvCwWNnTesp0jqEKZ38BNhWbEe+9T0uTdlAhyU
         Y/nf2H+GkmomK7y/umNP9GBQlJPIycTOmHcMb86o6ikNR7JbXtiQYKniQ6Rde5pypMQN
         16/P0nKpQ5qt7R0vNVgNHIb9f2PB2ejm6cRNPnKB6yU+mpxhf1MX9e+zapKpmbMhUgl2
         ARNTA76MicqO8cKmsbbQIh0IPM970YSI7CyNXamCGn7MckyLX9IbuCeCBQ/kTum9v8ac
         xYHQ==
X-Gm-Message-State: AC+VfDxK2NKrf8r7yaID9F6m/Bl864wbJ508wLRelmAiTwFZomQ0em5N
        Fcqs4t0JE32tQm5jRD0JSFV481lu/ZBBYn/p
X-Google-Smtp-Source: ACHHUZ7axvkFryBWCSaFpqkGoWejsIOwOUONkvM7CqGo0HKtZXYBYOzUgOQhiqiU2lcA6/lEPRLw2Q==
X-Received: by 2002:a05:6a00:b55:b0:648:c1be:496 with SMTP id p21-20020a056a000b5500b00648c1be0496mr11634178pfo.22.1683887850992;
        Fri, 12 May 2023 03:37:30 -0700 (PDT)
Received: from kelvin-ThinkPad-L14-Gen-1.lan ([103.184.129.7])
        by smtp.gmail.com with ESMTPSA id k5-20020aa792c5000000b0063b89300347sm7009485pfa.142.2023.05.12.03.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 03:37:30 -0700 (PDT)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Keguang Zhang <keguang.zhang@gmail.com>
Subject: [PATCH v4 0/3] Move Loongson1 PWM timer to clocksource framework
Date:   Fri, 12 May 2023 18:37:21 +0800
Message-Id: <20230512103724.587760-1-keguang.zhang@gmail.com>
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

Move Loongson1 PWM timer to clocksource framework.
Adapt the driver to clocksource framework with devicetree support.
Update the Kconfig/Makefile options accordingly.

Changelog
V3 -> V4: Replaced the wildcard compatible string with specific one
V2 -> V3: Remove the reference to regs-pwm.h
V1 -> V2: Delete the obsolete header file regs-pwm.h

Keguang Zhang (3):
  MIPS: Loongson32: Remove deprecated PWM timer clocksource
  dt-bindings: timer: Add Loongson-1 clocksource
  clocksource: loongson1: Move PWM timer to clocksource framework

 .../timer/loongson,ls1x-pwmtimer.yaml         |  48 ++++
 .../include/asm/mach-loongson32/loongson1.h   |   1 -
 .../include/asm/mach-loongson32/regs-pwm.h    |  25 --
 arch/mips/loongson32/Kconfig                  |  37 ---
 arch/mips/loongson32/common/time.c            | 210 ----------------
 drivers/clocksource/Kconfig                   |   9 +
 drivers/clocksource/Makefile                  |   1 +
 drivers/clocksource/timer-loongson1-pwm.c     | 236 ++++++++++++++++++
 8 files changed, 294 insertions(+), 273 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/timer/loongson,ls1x-pwmtimer.yaml
 delete mode 100644 arch/mips/include/asm/mach-loongson32/regs-pwm.h
 create mode 100644 drivers/clocksource/timer-loongson1-pwm.c


base-commit: 31c6ed4e89187beef8fe2f979c8881ca94839427
-- 
2.39.2

