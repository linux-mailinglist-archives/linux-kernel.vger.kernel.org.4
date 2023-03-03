Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6EE6A98CB
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 14:40:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbjCCNkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 08:40:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbjCCNjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 08:39:42 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BE2E60D64
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 05:38:42 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id i5so2695496pla.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 05:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1677850711;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Vlvg0s0GLD+Fr0ivx6kMGA1aXXCTSFKFG2h3P4PYF0=;
        b=exWsSVAjsb5xrqU9OsjnePPcRMPVFymkRMxa/0Zg/JS5MZsZeTcoPy7Jj1a57/qE3Z
         y0MKaDLCoFm4QAHfIIGRgs+EOngVZBEoLXvYaDJ8H8Bxqh/wFodNj3LPGSYzfGboMnYB
         TIpXH7wLYtV06/Tng5kIw5Jzmq0O37fl5rRCwgdMv/kn/4yxMd3rsPYyqC8S27gU7kyB
         GkHyve+lenzXGzQKZF28PfHnJjTx7h5915Eho/96E63Aq4Z8FvXGOF/mElyKKmcGeQRy
         wNRx0sFSKvetNr9NHLEvuSNXT+oVwuqVLkKUZr3IDMwT8hbJ7Sqba9O/Z68oZ0PiQpPn
         bw1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677850711;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Vlvg0s0GLD+Fr0ivx6kMGA1aXXCTSFKFG2h3P4PYF0=;
        b=yKEjtiXL3K2SuDMWVabI3x/MERuV0FjGiKVFZu15F2zi//XHi6JGwdRyPGfLeZZ1YZ
         yzxpsaWQ85aTS8vDObf33hAeiDEXT6SP6ejoHUTnzBYmZlzOk+/HN7t7uTu1Pod/F6Kr
         yI+VfWng9/KR6XZFpjGY2Gf5HArsPWtOn90+e1U3v7EiIgYlFbg5nKzn+KuK0h1dLifF
         6leLfNgdbm3o7FIRE5sx6ivtgHgVrRIrnnCG/yqASo6Jz1BY+HsZ7rQDLs2Yw2s7Jjs1
         M7xg6RycAKaMXjpV5KcwDiD+po9npuERpkPc4GOzLN6DcCG3YlA5OP2cZTabjdRZwqlm
         yi0Q==
X-Gm-Message-State: AO0yUKUNkFxW81k9WEV5Rong3WMzYVmlKi8MEMQ8ehJMV3gy2oRawvXa
        3y18apXmP2wLzihXXaxxi79OWg==
X-Google-Smtp-Source: AK7set96j6WJuUX/PTqb4gzc3U+7TJ6w7lLE7JxLO1itapAAlq/QR+Pp4g55TEo8ujxOweeMcThtuQ==
X-Received: by 2002:a17:903:110f:b0:19c:fc7b:69a4 with SMTP id n15-20020a170903110f00b0019cfc7b69a4mr1994559plh.65.1677850711284;
        Fri, 03 Mar 2023 05:38:31 -0800 (PST)
Received: from localhost.localdomain ([49.206.14.226])
        by smtp.gmail.com with ESMTPSA id m9-20020a170902768900b0019ac5d3ee9dsm1533125pll.157.2023.03.03.05.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 05:38:31 -0800 (PST)
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Anup Patel <apatel@ventanamicro.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>,
        'Conor Dooley ' <conor.dooley@microchip.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH V3 20/20] MAINTAINERS: Add entry for drivers/acpi/riscv
Date:   Fri,  3 Mar 2023 19:06:47 +0530
Message-Id: <20230303133647.845095-21-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230303133647.845095-1-sunilvl@ventanamicro.com>
References: <20230303133647.845095-1-sunilvl@ventanamicro.com>
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
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b0db911207ba..c299f88cb212 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -406,6 +406,14 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	drivers/acpi/arm64
 
+ACPI FOR RISC-V (ACPI/riscv)
+M:	Sunil V L <sunilvl@ventanamicro.com>
+L:	linux-acpi@vger.kernel.org
+L:	linux-riscv@lists.infradead.org
+S:	Maintained
+F:	arch/riscv/kernel/acpi.c
+F:	drivers/acpi/riscv
+
 ACPI SERIAL MULTI INSTANTIATE DRIVER
 M:	Hans de Goede <hdegoede@redhat.com>
 L:	platform-driver-x86@vger.kernel.org
-- 
2.34.1

