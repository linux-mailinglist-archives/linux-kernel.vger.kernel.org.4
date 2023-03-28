Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 775CA6CBE85
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 14:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbjC1MFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 08:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbjC1MFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 08:05:43 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D277DB1;
        Tue, 28 Mar 2023 05:05:17 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id o2so11413515plg.4;
        Tue, 28 Mar 2023 05:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680005117;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nPmXX1hgKpt/BYBMC6yN1gahjjJEjANZpQyVziEPpes=;
        b=ST4nocriMAAXBAacSI1ZwetD0Femj7VgBRIjRFPGLYGn7klPoTVq3Sfn5CvaIZQjgR
         nWUk/l6PWtl9uezfCCSC5EDPyIT4FOsd31j2VeOfesy9AeHwGGga3qvN87/nQo4Eoto5
         cx38g5oZb49oh/pHnf5FyYb06fQadrLr0l7Chnw7MHQhlSs3CPYBNGkwSE00R45iTjg/
         AL6Ss8uumL7ynJL6RVW1hsQTA4naoVjpQ3DzP2DMnKWkahwEtrxG/vJ9ea1HVBpXa0M1
         YSRWodEpr/rttG3N4dw2yHiHzb1KgFV8YyHADn88pTwwsFwZtAkD1SBRWbWSMHaDiWl3
         dbKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680005117;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nPmXX1hgKpt/BYBMC6yN1gahjjJEjANZpQyVziEPpes=;
        b=eakc3HVnDXxkQgkvvpT6k7Cq9V8udxn0eb4bHcR0Et2RhFkfXmFhXJWFt7DrSnM7MX
         K6kXfZv7ov761t6xLi/0xummq7Qdp5HnQknkH3ZmGgMFSf5sD+Zy95r3h2s0dXN0HCp/
         CXoI4oTM2l49f7/tsyu9i3ehN2pN27twSVzXGGEcnRyJuwLyK1Qyl0YhVW67Xce0FJZq
         bAv1vSZyImyVgfjp4zZ7CmJUMq36G8l0n+6h3Pccnk/8DO3HGU1u6CDlwta46wOTNlO5
         dA4VVvAk4oGA0ceFCepGQOHyjRnCzMZyKWhxMVbCyUSA3SjWcBTAtHGmZFjLtKnFb+Ij
         eBAw==
X-Gm-Message-State: AAQBX9cEq92J/GF42PE1VF/Djtg6TM1B0RZ76z/NrzxJxePytB9vAPa5
        y1rJ0qxNTdD6xTpIjPtDG+3jIZ/Pf+/qVA==
X-Google-Smtp-Source: AKy350ZgxWbNC6s6F1wnOqlzm1o/JQ1Ze0KdehbawRAn6htMsNtoi2+0+LeJiPJMiAByZ/zbgilhcg==
X-Received: by 2002:a17:902:f2ca:b0:1a1:c54c:1a36 with SMTP id h10-20020a170902f2ca00b001a1c54c1a36mr12338427plc.63.1680005116895;
        Tue, 28 Mar 2023 05:05:16 -0700 (PDT)
Received: from kelvin-ThinkPad-L14-Gen-1.. (94.130.220.35.bc.googleusercontent.com. [35.220.130.94])
        by smtp.gmail.com with ESMTPSA id ju10-20020a170903428a00b0019a83f2c99bsm21013956plb.28.2023.03.28.05.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 05:05:16 -0700 (PDT)
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
Subject: [PATCH 0/3] Move Loongson1 PWM timer to clocksource framework
Date:   Tue, 28 Mar 2023 20:05:03 +0800
Message-Id: <20230328120506.375864-1-keguang.zhang@gmail.com>
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

Keguang Zhang (3):
  MIPS: Loongson32: Remove deprecated PWM timer clocksource
  dt-bindings: timer: Add Loongson-1 clocksource
  clocksource: loongson1: Move PWM timer to clocksource framework

 .../timer/loongson,ls1x-pwmtimer.yaml         |  48 ++++
 arch/mips/loongson32/Kconfig                  |  37 ---
 arch/mips/loongson32/common/time.c            | 210 ----------------
 drivers/clocksource/Kconfig                   |   9 +
 drivers/clocksource/Makefile                  |   1 +
 drivers/clocksource/timer-loongson1-pwm.c     | 236 ++++++++++++++++++
 6 files changed, 294 insertions(+), 247 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/timer/loongson,ls1x-pwmtimer.yaml
 create mode 100644 drivers/clocksource/timer-loongson1-pwm.c


base-commit: f7b5a248213f0976c7944925f3f3ab7ff199e581
-- 
2.34.1

