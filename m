Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEA71681905
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 19:26:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238124AbjA3S0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 13:26:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238095AbjA3S0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 13:26:17 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E64FCFF0F
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 10:24:25 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id c10-20020a17090a1d0a00b0022e63a94799so1472336pjd.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 10:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0GmsS1bMG3vhs9nYaH5ehvEVh7IMrCbQji3r9uemxws=;
        b=FdQa5Nr8gTa9dhRoHNHv6DLl9MMrt0b8LGra3FlgdVR0HXDLToZe7M4Vw8FA842bxO
         ANogiCr8CkEluK5rksyrobBwZAKJ8A7G98bpLiz8xri62Tumhak9vvXobe/T1z4+dIij
         Jlqnftn2IXrjlaveSNTGwhALA2SpVI2d8kvV9HY86Y4JMm+idqkTZW4FJJkA1grLa2sm
         x0PYL9hJD9yklIp6Iu+3fct8g4Ub4r9NHKkc2cqYsfctvGHE+Vyr3INej/nu/6q7BWpl
         03u7GIFOwrw/uDqPq7+wghYTYt8n5mYmkRz3QQNQr2axPeRxPYEMQorPSn4SyB0vyC3z
         ggHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0GmsS1bMG3vhs9nYaH5ehvEVh7IMrCbQji3r9uemxws=;
        b=fNNF7ylX1J2Z8F04debuqXzcyngyElqqRVBnf5pZTWqa6/8WKgb4U0oMI/SXzPZ4OY
         xWXxJvcC1r47m2kczGpqF1DOyJInHSkf/nqnIJGCSUzFVYoXjQEVke4soEkG/95Q3H9O
         Wpt1hYQnYd0cAHS/RZJZnlJxi0Fmhh2vRW/I64ePSifySBMjnaSM4WnQaLtFnNU/Y7BL
         nn8GleijOJT7J2S1KC26L9XMmbwUwr38IrxtDK75qPntXZFuWiQjwuB5Nb7O0BCV4t4v
         IojDwmsQm1IpjekkczUiQey6+dQzxoz89FCk3zyaph3f0UU9pHVO87Y6oKEHv5gZI13i
         bZCw==
X-Gm-Message-State: AO0yUKUdpqy8xVlM/FsmMP419b3daGXtHz0QJvfjtoO/Zi9jLnbAKqx1
        1h2w4m1AoVr2RS7PckdYZ+WAKw==
X-Google-Smtp-Source: AK7set/NaUdxXOXi68TuA9LtTnJuAZDAOVCnERp8kT07lTkCp48tqSeuSCZp3ML1m7atqGjopshDlQ==
X-Received: by 2002:a05:6a20:841f:b0:be:7d46:e5 with SMTP id c31-20020a056a20841f00b000be7d4600e5mr4161873pzd.56.1675103059928;
        Mon, 30 Jan 2023 10:24:19 -0800 (PST)
Received: from kerodipc.Dlink ([49.206.9.96])
        by smtp.gmail.com with ESMTPSA id j193-20020a638bca000000b00478162d9923sm7000291pge.13.2023.01.30.10.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 10:24:19 -0800 (PST)
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>,
        Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH 23/24] MAINTAINERS: Add entry for drivers/acpi/riscv
Date:   Mon, 30 Jan 2023 23:52:24 +0530
Message-Id: <20230130182225.2471414-24-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20230130182225.2471414-1-sunilvl@ventanamicro.com>
References: <20230130182225.2471414-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ACPI defines few RISC-V specific tables which need
parsing code added in drivers/acpi/riscv. Add maintainer
entries for this newly created folder.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8a5c25c20d00..b14ceb917a81 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -450,6 +450,13 @@ S:	Orphan
 F:	drivers/platform/x86/wmi.c
 F:	include/uapi/linux/wmi.h
 
+ACPI FOR RISC-V (ACPI/riscv)
+M:	Sunil V L <sunilvl@ventanamicro.com>
+L:	linux-acpi@vger.kernel.org
+L:	linux-riscv@lists.infradead.org
+S:	Maintained
+F:	drivers/acpi/riscv
+
 ACRN HYPERVISOR SERVICE MODULE
 M:	Fei Li <fei1.li@intel.com>
 L:	acrn-dev@lists.projectacrn.org (subscribers-only)
-- 
2.38.0

