Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 939546D6B85
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 20:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235981AbjDDSVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 14:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236328AbjDDSVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 14:21:07 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB8FA4C2C
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 11:21:01 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id o2so32147464plg.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 11:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1680632461;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DdBAV21+tEDurt/JvTaHJyUQ0LBM5nBDKYeMtin7GIs=;
        b=MX30zIpzC4L+H3vLtz3ly3GSsB3XwuvpMQpmEupPQ85QZVU8HRpoYlIf3wBZNQKKLD
         VtbAaOHFd13vmPsqb8jFR5LHfURvqMEP4PmA952ogWkFFfdnVfA6YrYXGpbue16V0vz2
         wzM4ZbBEVPBt9Hfsf9CnBQoG/TblQOmhq56mLVUSCQGP5RHhy/qlytMlTEr8MhtER2mp
         ep3IM4xNIUVffLhgHfWRXOI6Sdbay9+pGr84nAbg1Szv5728VCO39Ewtymzy8/qMQ/Vj
         +CXTYu46xi73R7egRio2zBf/pxKsdmHgApX/2r5Q29nuT1f3Vx5xSeoQlA9ll5cHiE2e
         OURA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680632461;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DdBAV21+tEDurt/JvTaHJyUQ0LBM5nBDKYeMtin7GIs=;
        b=ozRvMPIBgI2zytf3o+2j1BgmHqwAZafI81UwY6jyI73/WcFg/rXtZowJ5KwdKV0oVB
         VAu+12TRifDVHvBXF9uGVWpcvj0IgOWY/ek2Zx73f14V0beUtcowm7PgQykkHimMkYnt
         m4+fNk7PBsZxpEYJjObr4wuNKwIGj0IjVsiAqRjVjtbRvWhtGMx8qLI74IMVyeLa5nQQ
         EqmTFEgqCS6oFOIcSfc06GuQ68ubtr2HaRBFSyayN0+QZOila8y6qvLE0hudtzDDM+RK
         FAvUgDqMNne9on61xAROQ8I1TDbj90w0yF5UdJNy71Q0RFtl6ceT75Sp1anrC8RSCrGI
         5Nyw==
X-Gm-Message-State: AAQBX9fsjbymUsnvtZMvDH0guwxPVpV+8qMPUByqZsqRu3/T4VOLMrCJ
        mNZSwBpLu9KLnTWj6sakRecNaA==
X-Google-Smtp-Source: AKy350ZMHM/cKvyT+rOOWpftInPEoGFfEdxrUaZ3Pg6Dhz7B1J2sE85PLnSoaYL4fu4p8GglqFgtxg==
X-Received: by 2002:a05:6a20:4c9f:b0:d9:ecba:b9fc with SMTP id fq31-20020a056a204c9f00b000d9ecbab9fcmr2623263pzb.54.1680632461193;
        Tue, 04 Apr 2023 11:21:01 -0700 (PDT)
Received: from localhost.localdomain ([106.51.184.50])
        by smtp.gmail.com with ESMTPSA id o12-20020a056a001bcc00b0062dcf5c01f9sm9018524pfw.36.2023.04.04.11.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 11:21:00 -0700 (PDT)
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-crypto@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        llvm@lists.linux.dev
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Len Brown <lenb@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Weili Qian <qianweili@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Marc Zyngier <maz@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH V4 02/23] ACPICA: MADT: Add RISC-V INTC interrupt controller
Date:   Tue,  4 Apr 2023 23:50:16 +0530
Message-Id: <20230404182037.863533-3-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230404182037.863533-1-sunilvl@ventanamicro.com>
References: <20230404182037.863533-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ACPICA commit bd6d1ae1e13abe78e149c8b61b4bc7bc7feab015

The ECR to add RISC-V INTC interrupt controller is approved by
the UEFI forum and will be available in the next revision of
the ACPI specification.

Link: https://github.com/acpica/acpica/commit/bd6d1ae1
Reference: Mantis ID: 2348
Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 include/acpi/actbl2.h | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index b2973dbe37ee..c432fd15db65 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -891,7 +891,8 @@ enum acpi_madt_type {
 	ACPI_MADT_TYPE_MSI_PIC = 21,
 	ACPI_MADT_TYPE_BIO_PIC = 22,
 	ACPI_MADT_TYPE_LPC_PIC = 23,
-	ACPI_MADT_TYPE_RESERVED = 24,	/* 24 to 0x7F are reserved */
+	ACPI_MADT_TYPE_RINTC = 24,
+	ACPI_MADT_TYPE_RESERVED = 25,	/* 25 to 0x7F are reserved */
 	ACPI_MADT_TYPE_OEM_RESERVED = 0x80	/* 0x80 to 0xFF are reserved for OEM use */
 };
 
@@ -1250,6 +1251,24 @@ enum acpi_madt_lpc_pic_version {
 	ACPI_MADT_LPC_PIC_VERSION_RESERVED = 2	/* 2 and greater are reserved */
 };
 
+/* 24: RISC-V INTC */
+struct acpi_madt_rintc {
+	struct acpi_subtable_header header;
+	u8 version;
+	u8 reserved;
+	u32 flags;
+	u64 hart_id;
+	u32 uid;		/* ACPI processor UID */
+};
+
+/* Values for RISC-V INTC Version field above */
+
+enum acpi_madt_rintc_version {
+	ACPI_MADT_RINTC_VERSION_NONE = 0,
+	ACPI_MADT_RINTC_VERSION_V1 = 1,
+	ACPI_MADT_RINTC_VERSION_RESERVED = 2	/* 2 and greater are reserved */
+};
+
 /* 80: OEM data */
 
 struct acpi_madt_oem_data {
-- 
2.34.1

