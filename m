Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 788667228E4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 16:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbjFEOfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 10:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbjFEOfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 10:35:20 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A66B83
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 07:35:19 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-53fdae76f3aso4444000a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 07:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1685975719; x=1688567719;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q3khYtgeUULt7e5l5ueg0RsqVZIRlFDE+jq/4yBZsmo=;
        b=LIn8WJ/3LEHfU+pG64HvMCl4aGlrGhQZ2zXku7l5yzg/yQ5oY+T1DLfY2hMr3nBgR9
         R+tEN6blSMtmMkNW7F6b7MnIXCUiBn00INjPXZ7/45jmfgu4JJq0avOTUARyJD7bPae5
         9qHTq5bBIk95KCvgn+7lr/rg8LW5Lo1lBpZUkjgcLIBpBg7730ZUlQGfYck1rnxMZ5YL
         hvrTxUEUMcqkVqf5A/TrlckGdVwH7AqEPf6h3ZY45ecwpoDCeRBS2c2QdJGBv4VRz0gJ
         sMmVLwZK6v04jShn7c9wfDPeTiyjQzl20IuXWPiLPfgYf4n3KHk4I+5TLsQpJo/tuizr
         GYKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685975719; x=1688567719;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q3khYtgeUULt7e5l5ueg0RsqVZIRlFDE+jq/4yBZsmo=;
        b=K+t+Bb5977xU/jQJ1ouGctCzESdLty75wOXOW30c5y4gLw0oPZ2yisVwgWMQH9Aq8x
         oOf0ExVz9IhyKpf+fz0PbiK9/o+u2QCASA0Ict36le+Vu8ofbryc5vz84vQIeaNHULe3
         rYo+2izcZOrgy/TRfQ21LekM3FSo5jBbGdug5et2oDaDeIlfqEEy21WFajtdWQUQfIzQ
         5DadXVrKEV8+RGAjJrXRuhx1uPG9Xskl+ovb13RLEdZ0RMwfMKL8jHbz4x539IkZo//H
         kN1tcBYSpivx9eOqmQDZZsgXCOAiqf7Lie/1Pibiql+GvvsP0yB3GcW0iMDShtM1GuUP
         9AlQ==
X-Gm-Message-State: AC+VfDy7MIY1QYgSK9JaxOfxq1rFhPxFhkVtYj8suHI8SxoSG2amnQHn
        +k1XjepcHkGtQV2UJBsogC7pWN9rXkgfVkSt7ow=
X-Google-Smtp-Source: ACHHUZ5gp/nF86uqF74WMpv1cRmJIDO1sxPZeQJD6hGyHcVxGqwUGJgPklbYGDpA+Xzi3nA6Eihslg==
X-Received: by 2002:a17:90b:1204:b0:258:8609:f1e4 with SMTP id gl4-20020a17090b120400b002588609f1e4mr6540632pjb.24.1685975718828;
        Mon, 05 Jun 2023 07:35:18 -0700 (PDT)
Received: from kerodi.Dlink ([106.51.186.3])
        by smtp.gmail.com with ESMTPSA id z14-20020a17090a1fce00b00250334d97dasm8297069pjz.31.2023.06.05.07.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 07:35:18 -0700 (PDT)
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
Subject: [PATCH v1 -next 0/2] RISC-V ACPI: Assorted fixes
Date:   Mon,  5 Jun 2023 20:05:10 +0530
Message-Id: <20230605143512.707533-1-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
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

Sunil V L (2):
  RISC-V: ACPI : Fix for usage of pointers in different address space
  RISC-V/perf: Use standard interface to get INTC domain

 arch/riscv/kernel/acpi.c     |  4 ++--
 drivers/perf/riscv_pmu_sbi.c | 17 ++---------------
 2 files changed, 4 insertions(+), 17 deletions(-)

-- 
2.34.1

