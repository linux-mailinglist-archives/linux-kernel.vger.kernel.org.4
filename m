Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B984B725CFE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 13:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238913AbjFGLYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 07:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235273AbjFGLYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 07:24:24 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C4D11715
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 04:24:24 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1b05e96dabbso41148155ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 04:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1686137063; x=1688729063;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LGtnZpGFXHvJErq+5YtK1G5nmM14Ut0VvzTCKEVh8OU=;
        b=ZXPfj0MjALIQxgTK4JMLeMGsSYfskXD1OL6gUULavvmiWhruVGK1X8iKTKU6aNcHP9
         3NWAxVHqevzhgKtq+ae3/t5C9/Z2I+XpNDQRCQrXRK/IFlaqRP7V9MEbZrFik+2cFfnl
         Xyn84fjufio8oQyAYrL2hA3FA2Y+7P/ysZUh+RbuxHgaUkrcwil4OgygZnnrOFV+FG3+
         lQ/xYEGfobGRRaIJaKfs0Af4uMIyN7FszS2vRzyyGBSpoK/seZMDQ/BiCjnt555O2QnF
         s9bAoTVhBwbtnGALpC5Ka065glKJpymS7Rvp7kxFCP+ZFnBqqNNiGzpFp5UtHvimg0Fk
         hhqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686137063; x=1688729063;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LGtnZpGFXHvJErq+5YtK1G5nmM14Ut0VvzTCKEVh8OU=;
        b=j4KTROQ2tu1ywuL0j7FMUdINwwR6m2jXgcP+BtsjLzgfO4+PrlQNAT6hUS9wgxOeIq
         ZgHEcB3QSD5V+amykt+hs4xY1vaOQNC1JjhJ/ytXqcfvgv6xE24VATZflX5vwMCD3qlT
         IrhyJHsxvjmh+4VRA7Oop40BHykR/C5io3P31U1QxPe6D9niLPMp43fi/PImmlgaRJXx
         F8Y8W6vyJuxUkLXeV5jUhdyY2QT1ltOO53vSfwvegtgLKDl1oSv/lP5mX7yWtBbywKcH
         ueGCtClkNSg1hKG2ypQIh31X6K0QaqkA52qkp/QU31DLAQf4Pax5DKu+ozsPQW80ExSn
         +i5A==
X-Gm-Message-State: AC+VfDwcu9NmKDeAwMBb5gABLd+wcGO513A6XKegjI3YfPIiLDs8hta9
        /G+mK2uvftXXzUkOF5S63kD2Ru1Qt5jsGcwUoDk=
X-Google-Smtp-Source: ACHHUZ6sATbQ1FwH9mwZ+Uz3V2RuFwNAayVWtafoqJ/+rV7t5PghA8X7YA8QPjBsx5ZhRGEhLUrqKg==
X-Received: by 2002:a17:902:f802:b0:1b1:8900:5211 with SMTP id ix2-20020a170902f80200b001b189005211mr2983874plb.28.1686137063635;
        Wed, 07 Jun 2023 04:24:23 -0700 (PDT)
Received: from kerodi.Dlink ([106.51.186.3])
        by smtp.gmail.com with ESMTPSA id o10-20020a1709026b0a00b001b2069072ccsm6228322plk.18.2023.06.07.04.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 04:24:23 -0700 (PDT)
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH v2 -next 0/2] RISC-V ACPI: Assorted fixes
Date:   Wed,  7 Jun 2023 16:54:15 +0530
Message-Id: <20230607112417.782085-1-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes couple of issues required to complete the previously
merged basic ACPI support series.

1) Kernel test bot has found a new warning using the sparse tool. Though
I believe this warning exists for other architectures also,
I don't see an issue fixing this for RISC-V.

2) When sscofpmf extension is enabled, the perf driver tries to
find out the root INTC domain to register the over flow interrupt
handler. However, this function is DT based and needs to be enhanced
to work on ACPI based systems.

Changes since v1:
	1) Added "Fixes:" tag
	2) Added RB tag from Conor

Sunil V L (2):
  RISC-V: ACPI : Fix for usage of pointers in different address space
  RISC-V/perf: Use standard interface to get INTC domain

 arch/riscv/kernel/acpi.c     |  4 ++--
 drivers/perf/riscv_pmu_sbi.c | 17 ++---------------
 2 files changed, 4 insertions(+), 17 deletions(-)

-- 
2.34.1

