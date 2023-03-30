Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10A426D0279
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 13:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbjC3LFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 07:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjC3LFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 07:05:37 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA55B8A5A;
        Thu, 30 Mar 2023 04:05:35 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id p3-20020a17090a74c300b0023f69bc7a68so19166899pjl.4;
        Thu, 30 Mar 2023 04:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680174335;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aSsBdFgmLEOw2PjCqJA6tCxvXim9qR7c1xKpf7wm/I0=;
        b=fGRKbjJl7EWwXKj8W17yfb2PBHkOS8UQKmMruulJjf3KF0yPrwvgBy0Esm1a4KSx3F
         bCzRZQBuQmvzXb3v41xeazqlVKrBQyT7B/Uw5DksnxIHpdUJgEplHqKcqm8HGme3CGmj
         kQ11ib1hHhNUuQlOhPOfDY/5ekovGK/11nlGs2R4HbptGotur2XOvmVqx536cuNFxS/3
         DiTxMZUkcrjJbFbDSyE/G1JyKpAWeBVDU3y/eGiE0i0vq66TtDGrjwt/WyjKEOcss0m+
         fayWCHmwx/msEgQh+HsBENa3sJUI0DDelM1J5iDDk4a5hC95O08j3ibBnRPSylF9pEvj
         50hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680174335;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aSsBdFgmLEOw2PjCqJA6tCxvXim9qR7c1xKpf7wm/I0=;
        b=sCAaoLSucZ0zsXXEpPg9tnmQeMktPo7fyfyxe0YlGH/QTYn32fR9uxP0+Dix59TFb9
         ZwogznG1UDKkboYVIJOpEN0AInlPG6lo0tQjlqhHqIUSNRhwPWuSTUqbXJniXv6Vq2qw
         S4wfwl5Sn915TJ6oxrxrlRWQ+2Vd33CNPBwd4PnMWGvJQMtCTTE34s+yrUsqdQFV5rY8
         nUmw1Jp2tVb9i63g0BzINFZuXzokdf4M++35j1W3tXyzhPwOotSD03B3659fwM2Y9Lkh
         QYOCgKle7sst01TZyoZeEWUi3Py+f+4hcd7uVNRHGXOkAG3a7p4PypNxYe62GkzYb4H5
         vDFQ==
X-Gm-Message-State: AO0yUKVuzrt59u8+w6Z6WW+6YZZQd6xaIGCy31TfU0rbqvjULkzq5+Db
        1VbHdt4AOJIZaabG3TKcYAglezoC7sUnxA==
X-Google-Smtp-Source: AK7set9iXsyf/GD4idtX+0+QUHhzsLAwQi6yJ4Opz5Ry5IDmgmweK8VHHo5nlCHzf57zJTks+ez0pQ==
X-Received: by 2002:a05:6a20:6589:b0:d9:3440:9a26 with SMTP id p9-20020a056a20658900b000d934409a26mr20527873pzh.20.1680174334882;
        Thu, 30 Mar 2023 04:05:34 -0700 (PDT)
Received: from kelvin-ThinkPad-L14-Gen-1.. (94.130.220.35.bc.googleusercontent.com. [35.220.130.94])
        by smtp.gmail.com with ESMTPSA id r1-20020a62e401000000b005e4c3e2022fsm24670922pfh.72.2023.03.30.04.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 04:05:34 -0700 (PDT)
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
Subject: [PATCH v3 0/3] Move Loongson1 PWM timer to clocksource framework
Date:   Thu, 30 Mar 2023 19:05:09 +0800
Message-Id: <20230330110512.549704-1-keguang.zhang@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Move Loongson1 PWM timer to clocksource framework
and update the Kconfig/Makefile options accordingly.

Changelog
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


base-commit: f7b5a248213f0976c7944925f3f3ab7ff199e581
-- 
2.34.1

