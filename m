Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9907063C1BA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 15:03:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234731AbiK2ODo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 09:03:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234639AbiK2ODY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 09:03:24 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1066418B37
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 06:03:24 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id b21so13478553plc.9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 06:03:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pjq0SJx9GK7fi74EZz816s2rBUHtlCxatQJYtnjVbuM=;
        b=HRYib5uKKfPx9dsXiXvzZ9/38Ir8ibfurUtJJpxA8EOiMLOSgoQHFo0Q/WYnFHaSTl
         BzDPFLTRFg2fHnyZBhxdlCj+Qe9hPUU0iFaM2kuBv46oMQYrqT40aZ/sx6zCL3/GrX9W
         8zO/EqcFiYmP0xGdhLWtk4LJmfOG5rnhWIDQvb5ORxKoCP6K1bgd9AK7HkpoQZfGVI1O
         20i54mss0essruIsuaaEnRJ1sFHCBT5j4OwNc53MDDMJqBL/h2zZyXQcANvlkqy5yqrg
         kCbVXVcWHFV8UD1naeeLA26+g43l0Wyx4KDkAtm1udPorYm9S/8OSIb5ie87X1aYLr5l
         DYGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pjq0SJx9GK7fi74EZz816s2rBUHtlCxatQJYtnjVbuM=;
        b=OVzYwiLKYZSfBslTAPZp4Q9c2/y4dDDBkdfWoOfu6843eKRu5TDpkDFwR6hr+IrffJ
         4UzO06E8D8nCzlpf8G5a1MCphX81jZb7X2rM2Jh177h7Q83tCR4zM7MXvsqRnh9sFAoJ
         akr6yQvKF1/F/oqlSK2Ab8fK7aatoK2s8K2L4GAp/oenf5a5FVIH3Ds3wP4G0NAdluLz
         gg3oCLZ0jUd0L//RnHarDZTCmnm6qWbQkfJTwcuxBjDz2cin2MwOTTHbE8CWViLKTDp+
         LtRc/tJo+tZtk8H5H+ByAAT/7Sk6ZUOycN6HHUET3h7ygNLsXn6CksV4w3mhob+XTcpx
         8rsw==
X-Gm-Message-State: ANoB5pkhODCvGwTPGHBhO7v4kFAqQyA7lk4+H8ERW262bO0t3EoFYhyK
        lglJkYWjfDwFVKsIf3KIGq6AzjT9vY7HWQ==
X-Google-Smtp-Source: AA0mqf5NLlwP8x1H+pb8ntntoBOW1EREsRhfbakgtMzchWSKW+8ALoxPQii4Oo+V7X44nfgwYVsrtg==
X-Received: by 2002:a17:90a:c68d:b0:219:80b:6ea with SMTP id n13-20020a17090ac68d00b00219080b06eamr24396424pjt.212.1669730603217;
        Tue, 29 Nov 2022 06:03:23 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([171.76.84.98])
        by smtp.gmail.com with ESMTPSA id k30-20020aa79d1e000000b00574f83c5d51sm6013747pfp.198.2022.11.29.06.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 06:03:22 -0800 (PST)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Andrew Jones <ajones@ventanamicro.com>,
        Atish Patra <atishp@atishpatra.org>,
        Samuel Holland <samuel@sholland.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Anup Patel <anup@brainfault.org>, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v4 0/3] Improve CLOCK_EVT_FEAT_C3STOP feature setting
Date:   Tue, 29 Nov 2022 19:33:10 +0530
Message-Id: <20221129140313.886192-1-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series improves the RISC-V timer driver to set CLOCK_EVT_FEAT_C3STOP
feature based on RISC-V platform capabilities.

These patches can also be found in riscv_timer_dt_imp_v4 branch at:
https://github.com/avpatel/linux.git

Changes since v3:
 - Rebased on Linux-6.1-rc7
 - Replaced PATCH1 with a patch to initialize broadcast timer

Changes since v2:
 - Include Conor's revert patch as the first patch and rebased other patches
 - Update PATCH2 to document bindings for separate RISC-V timer DT node
 - Update PATCH3 based on RISC-V timer DT node bindings

Changes since v1:
 - Rebased on Linux-5.19-rc8
 - Renamed "riscv,always-on" DT property to "riscv,timer-can-wake-cpu"

Anup Patel (2):
  dt-bindings: timer: Add bindings for the RISC-V timer device
  clocksource: timer-riscv: Set CLOCK_EVT_FEAT_C3STOP based on DT

Conor Dooley (1):
  RISC-V: time: initialize broadcast hrtimer based clock event device

 .../bindings/timer/riscv,timer.yaml           | 52 +++++++++++++++++++
 arch/riscv/kernel/time.c                      |  3 ++
 drivers/clocksource/timer-riscv.c             | 12 ++++-
 3 files changed, 66 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/timer/riscv,timer.yaml

-- 
2.34.1

