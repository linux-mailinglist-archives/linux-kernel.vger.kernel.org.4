Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C56B7699C47
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 19:24:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbjBPSYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 13:24:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbjBPSXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 13:23:36 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC20152CDF
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 10:22:40 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id m2so2946804plg.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 10:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rc+EdRzJ0SRGUPyQRF18IAjDuJpqdPevv1iUeqHNSDY=;
        b=MT+u6Ji2DSotNL/3ZJ31+4cfLb/HUgIEAzHyb/4A3W3hXKL7CuBMT7DFaf8PRm7cRi
         hkX1t1QcAn6Fsh4g9bblEZv+ilGLrh4phGy+dWKqmPb5y5cpQtlH3TAu+YOU0SnV0Luk
         HDucHKXRMGxNFDuLtGBJm3I9tnzVAAQ1MUc6DNMO077XW2R/1eEDaW0Jd2emJHRAWPjM
         HGm8QIKeax6/ljYPvC/5GtfUEcuV0hqZzqfkU0/3+9ZK0znENu0rEkld1JzriqhbZHHh
         XyGAE624cdyEKo/bR2ibxnm20fA1861ECmsz+HbEDZY/Me4+oPLiv4hAMXBd3+rQsqSP
         LmUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rc+EdRzJ0SRGUPyQRF18IAjDuJpqdPevv1iUeqHNSDY=;
        b=lKwQnnrGYw51g7B7FhEIGOgyZre3MLVQNpQrYOQ9hb50wg9kUOjFpZrQluqSRPK+9s
         CSJ8oFIEAdkWja9xOvAnHWz2aRI7gLcCrYcImEY/CfKbCf7pyTbaukjcUOYyicK+SPH7
         pP0iygEs1qEqYR3YA4m++Mv/TSY/JFGtbfgT4FgPxxW0W3LesvlrJJccazypqprikqD5
         +2gq0c1yNHxcy5tOsI+/Pd/BoQCvRJ018Rwy2xaSzb8m0IZS56pWUHT3Wd32OTInXFwz
         sYVxr/QBY8WOqgTNT6DMwEuNe+S2e1q5chWRIE+tjCHTFuBPBBhui7KyUNrp+z3KDEFc
         Kz3Q==
X-Gm-Message-State: AO0yUKUw11K/UoquW9+rGP6U6Oo4dI0i0EeICTA6XVi4hpt57bf9szPR
        0XI320jd0Y7/o4dMe5rl2gJguQ==
X-Google-Smtp-Source: AK7set9M9fF7YNnpHhSlQVgpgwmmQbyWXyDh9qg54yswDsPTDVjsTPAME9mc2ETjA4Y1JYejJYwZog==
X-Received: by 2002:a05:6a20:d49b:b0:bd:278:f68f with SMTP id im27-20020a056a20d49b00b000bd0278f68fmr6832215pzb.52.1676571753281;
        Thu, 16 Feb 2023 10:22:33 -0800 (PST)
Received: from kerodi.Dlink ([49.206.14.226])
        by smtp.gmail.com with ESMTPSA id n21-20020a637215000000b004dff15fc121sm1517574pgc.36.2023.02.16.10.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 10:22:32 -0800 (PST)
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc:     linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH V2 21/21] Documentation/kernel-parameters.txt: Add RISC-V for ACPI parameter
Date:   Thu, 16 Feb 2023 23:50:43 +0530
Message-Id: <20230216182043.1946553-22-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230216182043.1946553-1-sunilvl@ventanamicro.com>
References: <20230216182043.1946553-1-sunilvl@ventanamicro.com>
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

With ACPI support added for RISC-V, this kernel parameter is also
supported on RISC-V. Hence, update the documentation.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 6cfa6e3996cf..b3a5a5844daa 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1,17 +1,17 @@
-	acpi=		[HW,ACPI,X86,ARM64]
+	acpi=		[HW,ACPI,X86,ARM64,RISC-V]
 			Advanced Configuration and Power Interface
 			Format: { force | on | off | strict | noirq | rsdt |
 				  copy_dsdt }
 			force -- enable ACPI if default was off
-			on -- enable ACPI but allow fallback to DT [arm64]
+			on -- enable ACPI but allow fallback to DT [arm64,riscv]
 			off -- disable ACPI if default was on
 			noirq -- do not use ACPI for IRQ routing
 			strict -- Be less tolerant of platforms that are not
 				strictly ACPI specification compliant.
 			rsdt -- prefer RSDT over (default) XSDT
 			copy_dsdt -- copy DSDT to memory
-			For ARM64, ONLY "acpi=off", "acpi=on" or "acpi=force"
-			are available
+			For ARM64 and RISC-V, ONLY "acpi=off", "acpi=on" or
+			"acpi=force" are available
 
 			See also Documentation/power/runtime_pm.rst, pci=noacpi
 
-- 
2.34.1

