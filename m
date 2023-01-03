Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C69F65C18C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 15:11:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233449AbjACOLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 09:11:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237620AbjACOLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 09:11:14 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC814FEF
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 06:11:13 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id 60-20020a17090a0fc200b002264ebad204so9585294pjz.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 06:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M0/1+xwVSOl78TtVqWGcIupt5yvD4IwY5jPVM8+Y5Bk=;
        b=b0mGnvztdBrz/eFLximm769v/H7VgZ64bULZnXcY5BP0X4aY19eZweFY+waU5/QooG
         JmUWQQHr+hn3/TtqZOSyPS6mFTXwdf6PhGkfrXSmEA4TNhjgLBxIxHkRHV0c8hz0BKT2
         /H7eyFQzYemg3dfTSZFFoTrrMKWhcR46MNtPiTGtwsh14OUxM6OBuS5os8Fn4+As5QrB
         bOTFU0CT+KUHb/P7Xp6NBofRzWCWucg8dwS2wKmm6YIRzl01+r0nhoQwBdo5tvNrDs+w
         8gDhkNyhJeCNh3fr0b6u8AEq3033XVJUMkih7YFwGh1xHLHyQ074kLOvyvtFy03HEalP
         sLHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M0/1+xwVSOl78TtVqWGcIupt5yvD4IwY5jPVM8+Y5Bk=;
        b=RrP6BVLbvbEfSMcnvwVw9tWfyDTlLdN4GUjjvn4edezqguPKzUAU3nAxUbUe6qsTe2
         OrO9TNWrQJzmhtojwrDx4/rWjpbTqOsIsnzhcnRdHkai5Qy8nsduBmCpyGZfNmRQtYUN
         QlYSOhjLX3LfTzqcMGLl8p8ymnJiF9JMFaIK+LQ+jsyqU7WdbGUCjWskJvTltYK6dtk4
         +Zeh0/WFKWRjLTMCE/TNx8DL4RUrotjdr+p5BtgH7Hf1SKpTNP9k5w+Z4xx3gkaXynzi
         uafv/hzxhVD7i7gMxhmDViaFDt+KJD6Cu/dBUPRl16bBqiK6Lp+17VlJWuOgIDaVnUPo
         H4bw==
X-Gm-Message-State: AFqh2krgIYRgRo32VGdMFfxc61NfszGA46dLGPRDaMHRC6c0fAGJ2rC2
        HQoQljWLBIOH6BBeDINJ5XRYzQ==
X-Google-Smtp-Source: AMrXdXvZtg4dkclTJdJxMSBRmE+LwGZZpjGtJv3rOMeS6rPZv3VYVAEdULNyKHSxQUobkk4F+RecJA==
X-Received: by 2002:a17:902:c382:b0:191:4378:ec06 with SMTP id g2-20020a170902c38200b001914378ec06mr51792779plg.61.1672755073254;
        Tue, 03 Jan 2023 06:11:13 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([171.76.85.241])
        by smtp.gmail.com with ESMTPSA id l3-20020a170902e2c300b00192bf7eaf28sm6146117plc.286.2023.01.03.06.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 06:11:12 -0800 (PST)
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
Subject: [PATCH v6 0/3] Improve CLOCK_EVT_FEAT_C3STOP feature setting
Date:   Tue,  3 Jan 2023 19:40:59 +0530
Message-Id: <20230103141102.772228-1-apatel@ventanamicro.com>
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

These patches can also be found in riscv_timer_dt_imp_v6 branch at:
https://github.com/avpatel/linux.git

Changes since v5:
 - Rebased on Linux-6.2-rc2

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
 drivers/clocksource/timer-riscv.c             | 10 ++++
 3 files changed, 65 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/riscv,timer.yaml

-- 
2.34.1

