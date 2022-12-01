Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8B0963F0AE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 13:40:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbiLAMkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 07:40:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiLAMkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 07:40:05 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F05685AE06
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 04:40:04 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id d3so1510525plr.10
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 04:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JDVN8n7be7B0/wylK2s/J0YT9jUx3OP/wVMDKZiwDvg=;
        b=dJrdRvSe8KMdfE5gN+fINZLIJXX/VXm0TAc++CWk5mFtZX6amsjp5PpwKxRNtXT7rB
         VYu+GTHHC5EcDNDjjMwbLyM9O1hlU3a++AHtRNU2svAi7VqmmGsw3vViHN0DctcdxCzV
         XNiVfjRd7zxsjLmPosFHYlXVJ9mPKp9A/d5qfspyVspp4Ikgf9GG4Wn8qXmvZhODH+BE
         3AoRs+4HQtsUtU/plaTWJoyCWM45ezYcQO3fVc6oZErZWoVLuh6C5w3Mt9b2jssK3cJv
         UC1DL2q16nL0oGNzgdL/3dx89rtxPUrlaGBiCfCZclPa+krPpkaUMqt3kqn8/mBvkzEZ
         7QCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JDVN8n7be7B0/wylK2s/J0YT9jUx3OP/wVMDKZiwDvg=;
        b=xpbU6QkhRsUtJsoGTmEjLvgKMKvt33PloB90AEkEh5ho2CJIhrejaIPOMxFr1sMJm/
         xqsAjnNjjaCrdFfjFahNuvLuiECx4b6Jx3Vf3UOY5URS0sheCHbxeGmACETPJpl41Qcb
         75Scamn+xSOa8f4AAoCX7+5lAEjXamq5Oq8/1xucAeJVodh29oSuaI/Q4zFLEbPJPESC
         MHgAilVmnXQzSLVmyAcRiwVXIGmLywymrPVzkHg8fzRcebbKFs89YOxbaYh1mDtmM1s9
         gTUQanRFXjxJx/+knd5H/jTFmj6nTb7lJed5lBIvoLgRAaNwbCWk8rM3Xd+LJsgk1amk
         wmgQ==
X-Gm-Message-State: ANoB5pkez87AuZgNQT/fj5JMszEJmfNZpqBo+w4694dUG6cjzqYukE9g
        ky3SiPbn9cFLkH/VK7xk2CjmKw==
X-Google-Smtp-Source: AA0mqf6cunRUAvtUCmUwa0kqMjczfEX9x8NDswgm0g3BXwbyrX5wsXjCNPF+VR8EYBKcTxOYNh5B5w==
X-Received: by 2002:a17:90b:1e0f:b0:213:c5ae:55ec with SMTP id pg15-20020a17090b1e0f00b00213c5ae55ecmr68341370pjb.182.1669898404308;
        Thu, 01 Dec 2022 04:40:04 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([171.76.81.69])
        by smtp.gmail.com with ESMTPSA id b65-20020a62cf44000000b0056f0753390csm3246981pfg.96.2022.12.01.04.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 04:40:03 -0800 (PST)
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
Subject: [PATCH v5 0/3] Improve CLOCK_EVT_FEAT_C3STOP feature setting
Date:   Thu,  1 Dec 2022 18:09:51 +0530
Message-Id: <20221201123954.1111603-1-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series improves the RISC-V timer driver to set CLOCK_EVT_FEAT_C3STOP
feature based on RISC-V platform capabilities.

These patches can also be found in riscv_timer_dt_imp_v5 branch at:
https://github.com/avpatel/linux.git

Changes since v4:
 - Update commit text of PATCH1 based on Samuel's comments
 - Renamed DT property "riscv,timer-can-wake-cpu" to
   "riscv,timer-cannot-wake-cpu" in PATCH2 and PATCH3
 - Updated description of DT property "riscv,timer-cannot-wake-cpu"
   in PATCH2

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
  RISC-V: time: initialize hrtimer based broadcast clock event device

 .../bindings/timer/riscv,timer.yaml           | 52 +++++++++++++++++++
 arch/riscv/kernel/time.c                      |  3 ++
 drivers/clocksource/timer-riscv.c             | 12 ++++-
 3 files changed, 66 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/timer/riscv,timer.yaml

-- 
2.34.1

