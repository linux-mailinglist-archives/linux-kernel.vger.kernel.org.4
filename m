Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 449AC6A989C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 14:37:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbjCCNhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 08:37:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbjCCNhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 08:37:33 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3868E4393D
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 05:37:20 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id y11so2700873plg.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 05:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1677850640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g9sxg5LZ/1sJSiDItv56ESM72UWoohRRXZed1vK0StQ=;
        b=Zsc6LaeJTpGX1sgtByVE6O8d9udmKb3fR8oUsq0FNYih6Tsi4uKgSRk6XDvsBjOfbl
         1KTWbpwaFjpI21q3iRGZkju0DVreKkZJb5upDlXkI5pllv+9x5Hq7n7Zaol2tB6zq5El
         zE7YMzWWP8RP8qm7jM/VyT4r+BHa1khQw75ZNQ+RCFrXbe9POTWcDU31NAc6erzEcWWp
         iXD/utPdJrbpDyEWHIy3hEvtWAnybAALp0Di7/6PkNLP0Kv4NpxQEz41nUnD9jHjZ7lB
         ynYP6TOiOHbSCvvXMA4pBxnLBS0SqnPSPI5mcnsUgiR9U0N8YmEuuWMQ5J/sNa6nt/Pe
         G+Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677850640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g9sxg5LZ/1sJSiDItv56ESM72UWoohRRXZed1vK0StQ=;
        b=SX4sqLh7A8CiNQnoxgkbk4MUPvRiPSdXQBkSGu19okVgxXMSTv6s5k7EKdJnI2UAcv
         ualpHXwI2hS4dKCWHpX7GrRMw32vUO89rQyWIbyAe0XtTnK63MYxxax/rv0+0Q6BMVNl
         OKR24DyTqwqCRY5kjVOQ3ewSXBLkkoDgSYdpHqgsQ183ktAnM58GkZHjDnCJhlJ6+Le2
         Yn+TkbTVzINVmIU1ZEBpFBuMMTWw/ZXbg+mc/MLHkCqAIu5H18SvaxbPIqqeYAXzmYA0
         JOFXA45RH+h2K06pHt098zrzSGVMxv4LUqgRw7b6RbATVDiWb6NGfFgIr/14yaKuGYY5
         x3NQ==
X-Gm-Message-State: AO0yUKXAZP7/WX2ZWJ+iF+LDBhu7BqXtZoKvJHpIaa1VeFGvkS3vA0K4
        huKUSSQW4fZinJQPivTcHIlvqA==
X-Google-Smtp-Source: AK7set/G1m0QP8TwASMfiHdCi9Qj8Nix2/s9AwyTOx8M1PebkEi+mADM4ez9JdpRzBLNQbgkk8W3Hg==
X-Received: by 2002:a17:902:e80a:b0:19d:243:d5d3 with SMTP id u10-20020a170902e80a00b0019d0243d5d3mr1978853plg.33.1677850639872;
        Fri, 03 Mar 2023 05:37:19 -0800 (PST)
Received: from localhost.localdomain ([49.206.14.226])
        by smtp.gmail.com with ESMTPSA id m9-20020a170902768900b0019ac5d3ee9dsm1533125pll.157.2023.03.03.05.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 05:37:19 -0800 (PST)
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
Subject: [PATCH V3 05/20] ACPI: OSL: Make should_use_kmap() 0 for RISC-V
Date:   Fri,  3 Mar 2023 19:06:32 +0530
Message-Id: <20230303133647.845095-6-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230303133647.845095-1-sunilvl@ventanamicro.com>
References: <20230303133647.845095-1-sunilvl@ventanamicro.com>
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

Without this, if the tables are larger than 4K,
acpi_map() will fail.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/osl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 3269a888fb7a..f725813d0cce 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -276,7 +276,7 @@ acpi_map_lookup_virt(void __iomem *virt, acpi_size size)
 	return NULL;
 }
 
-#if defined(CONFIG_IA64) || defined(CONFIG_ARM64)
+#if defined(CONFIG_IA64) || defined(CONFIG_ARM64) || defined(CONFIG_RISCV)
 /* ioremap will take care of cache attributes */
 #define should_use_kmap(pfn)   0
 #else
-- 
2.34.1

