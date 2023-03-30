Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2FA56D00E0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 12:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229379AbjC3KPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 06:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjC3KPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 06:15:24 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF8EE1FFB;
        Thu, 30 Mar 2023 03:15:22 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id l14so12126979pfc.11;
        Thu, 30 Mar 2023 03:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680171322;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M7LtPZVH4RMzF9XBfm4hBW5uXz/iaLJHkdbDSB+7F64=;
        b=AUa6z5fwxkmqIEXU2H4JS8xNaBdaBvurgoNwkAY1SJznvW50gCQTPI1I8ckFWj5kqb
         kILLCZZkqxVeLKxK7xLF2dEdnKGs6mnTtSgrsEJUPdnscu8y7u1tVgPU1/0EOx11SDcL
         8HFd65yTz1tCg1xOHUlf7zm5r0If5skBqwZNeWJWKi9+v3FeCxA77lCM3zDLal89U8KI
         QvGofperKbjpwahlLI2WmSonCj4IF1IWX669cuGhjqiuxpcv0n80n5DD5TEpWnB05Bti
         WCmSJR9xs37Q1G2mZuPyrtnQ+v2KeAPHnUtZCJZxQLnBHSlI1AMDNl25wR8LrAp5esJk
         fXBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680171322;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M7LtPZVH4RMzF9XBfm4hBW5uXz/iaLJHkdbDSB+7F64=;
        b=Q24b6Eai2iJlBiK42R/yFQi/ngjBxq5g/LakfeyqXhqPUXy5f7MqGhInC1ZqaxP58L
         +f3du5WCV5b/tI5VxEdcGCeJCdMut7VgB2uGkAIuS2c86UlEJiKU/B4+N5XboXUvXdnX
         CxzkfIzxenQ1rKlWJwHUy8/tC7sqVDpll8u4N6gd2Sy0D+ydqHL2xxC907M2S0e3/xs4
         a0C1YJcgU/TD9uSdgeHpTQP8rvSH0EObPe4FbAIEyTd2rayM/El6+9Vz7KXPbj0U3WJk
         iRBCB83uqRLWQnRNdeQZWCkMxZBc9KQq/2MI1ty3Y2jdyJPyPpgBVYh/9DPVcG+EShuX
         HM3g==
X-Gm-Message-State: AAQBX9cImUXt8xamcgaAmu3wSLxv4C370O6IM/4OI+17r6lWmwKA4A5l
        4HhbdJ4TUdZ0xizJALxw4xiELfS7Ih3k+w==
X-Google-Smtp-Source: AKy350Y3Tbyj0a3V6M0/eIIO1fkoZCSjOo1+EjhuDLYwZd8uSV7koddvMYrs/i9z/ZS6qcSzaeGr7Q==
X-Received: by 2002:aa7:9542:0:b0:625:7536:7b0e with SMTP id w2-20020aa79542000000b0062575367b0emr20395943pfq.29.1680171321860;
        Thu, 30 Mar 2023 03:15:21 -0700 (PDT)
Received: from kelvin-ThinkPad-L14-Gen-1.. (94.130.220.35.bc.googleusercontent.com. [35.220.130.94])
        by smtp.gmail.com with ESMTPSA id x18-20020aa793b2000000b00627e55f383dsm22469210pff.3.2023.03.30.03.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 03:15:21 -0700 (PDT)
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
Subject: [PATCH v2 0/3] Move Loongson1 PWM timer to clocksource framework
Date:   Thu, 30 Mar 2023 18:15:03 +0800
Message-Id: <20230330101506.545040-1-keguang.zhang@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=3.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move Loongson1 PWM timer to clocksource framework
and update the Kconfig/Makefile options accordingly.

Changelog
V1 -> V2: Delete the obsolete header file regs-pwm.h

Keguang Zhang (3):
  MIPS: Loongson32: Remove deprecated PWM timer clocksource
  dt-bindings: timer: Add Loongson-1 clocksource
  clocksource: loongson1: Move PWM timer to clocksource framework

 .../timer/loongson,ls1x-pwmtimer.yaml         |  48 ++++
 .../include/asm/mach-loongson32/regs-pwm.h    |  25 --
 arch/mips/loongson32/Kconfig                  |  37 ---
 arch/mips/loongson32/common/time.c            | 210 ----------------
 drivers/clocksource/Kconfig                   |   9 +
 drivers/clocksource/Makefile                  |   1 +
 drivers/clocksource/timer-loongson1-pwm.c     | 236 ++++++++++++++++++
 7 files changed, 294 insertions(+), 272 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/timer/loongson,ls1x-pwmtimer.yaml
 delete mode 100644 arch/mips/include/asm/mach-loongson32/regs-pwm.h
 create mode 100644 drivers/clocksource/timer-loongson1-pwm.c


base-commit: f7b5a248213f0976c7944925f3f3ab7ff199e581
-- 
2.34.1

