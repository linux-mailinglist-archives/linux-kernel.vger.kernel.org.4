Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87510606618
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 18:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbiJTQqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 12:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbiJTQpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 12:45:40 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A506E108276
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 09:45:37 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id y72so261751oia.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 09:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vDumrWNAjxV0BcAyCgGrt674q5FMm5zVCvNU89iAQTg=;
        b=UZMHuGCifh3qmno7GQJPsOV2RwukwD3s4fLy7qas8iFuErv6L72H1IaEpeX2zkSD6Y
         5L7r7Qr34Rhn0hm3TbkM2FtLG9K9geMhesmiW3boTSlUWCZy/TNXGuQSX5XXpmuTt2Yz
         cNGN25iCn6Rwrs6Sxzn8nFiquqD+4hi7aCL+iDN1l6EshzxxXx6LLK3wDDxx30GQF1l+
         XcwW1qCSMdeo/VtURvC9vXYriRmCCEyQABzmLgahulWC3jpgffg1Jqleg7wcOqZ+FncY
         OXwQxiKn1LiNvr03OMxr7b53t3B6OViJPrw9ClQLqMBhlmP0456mp0Ihc0drQNhu+Cf+
         J6cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vDumrWNAjxV0BcAyCgGrt674q5FMm5zVCvNU89iAQTg=;
        b=VJsBGn6wsLH3rVcgrOZ9DOmsLQE+JJAeNrWEzLGpIOFJVck9LBq0yGLDDYJRC/FJby
         Sbu451GddEmSjXWB0n0vaeja3j75TVRcRIXhMn89CNz3RC6fuciTWXDRXN7ADjrkk4sn
         9rH1CvPx9rNfji7aSH6S8xdyb2EEPrNm+yCRinzZh8wMm1P9IGAigCdlHHaADjjCW9Kc
         TebyzsLWFK5cXZLz5YBff85PHRF07XbRsNLOkADdIBX0GjJ7hthSFV/OxHItV+JAWhh3
         ho/4rZJZd6yYwRNf+AgaXOUQS0iJKpF6fvjbaFQhn5BmGe4S4Xt0ItBYZEJMc+iZB9cq
         FVNw==
X-Gm-Message-State: ACrzQf2rtngRA8hwSryqmPnbAeN9MBy5YUlVokkXThXGZQCwxHZJM2b7
        wipCFUuLhbIx2SYeO22u1S7M1g==
X-Google-Smtp-Source: AMsMyM5f5alURJ/2bjgBdB5+7KDQFJLaHft3kuHLgebxdp2AkvVIgWt+byF7H5AbPeR+5HTHjHaZ/Q==
X-Received: by 2002:a05:6808:144d:b0:355:3bef:799b with SMTP id x13-20020a056808144d00b003553bef799bmr11100528oiv.283.1666284336311;
        Thu, 20 Oct 2022 09:45:36 -0700 (PDT)
Received: from fedora.. ([186.122.181.28])
        by smtp.gmail.com with ESMTPSA id u3-20020a056870d58300b0011f00b027bdsm9154325oao.45.2022.10.20.09.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 09:45:35 -0700 (PDT)
From:   Mauro Lima <mauro.lima@eclypsium.com>
To:     broonie@kernel.org
Cc:     mika.westerberg@linux.intel.com, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mauro Lima <mauro.lima@eclypsium.com>
Subject: [PATCH 2/2] spi: intel-spi: build the driver with hardware sequencing by default
Date:   Thu, 20 Oct 2022 13:45:08 -0300
Message-Id: <20221020164508.29182-3-mauro.lima@eclypsium.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20221020164508.29182-1-mauro.lima@eclypsium.com>
References: <20221020164508.29182-1-mauro.lima@eclypsium.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add menuconfig option to build the driver with hardware sequencing by
default and another to specify software sequencing support if needed.
For the software sequencing functionality preserve the *DANGEROUS* tag.

Signed-off-by: Mauro Lima <mauro.lima@eclypsium.com>
---
 drivers/spi/Kconfig           | 15 +++++++++--
 drivers/spi/spi-intel-swseq.c | 50 +++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index d1bb62f7368b..aec095988ab7 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -448,7 +448,7 @@ config SPI_INTEL
 	tristate
 
 config SPI_INTEL_PCI
-	tristate "Intel PCH/PCU SPI flash PCI driver (DANGEROUS)"
+	tristate "Intel PCH/PCU SPI flash PCI driver"
 	depends on PCI
 	depends on X86 || COMPILE_TEST
 	depends on SPI_MEM
@@ -458,6 +458,8 @@ config SPI_INTEL_PCI
 	  master mode. This controller is present in modern Intel hardware
 	  and is used to hold BIOS and other persistent settings. Using
 	  this driver it is possible to upgrade BIOS directly from Linux.
+	  The driver will use hardware sequencing capabilities from the chip
+	  by default.
 
 	  Say N here unless you know what you are doing. Overwriting the
 	  SPI flash may render the system unbootable.
@@ -466,7 +468,7 @@ config SPI_INTEL_PCI
 	  will be called spi-intel-pci.
 
 config SPI_INTEL_PLATFORM
-	tristate "Intel PCH/PCU SPI flash platform driver (DANGEROUS)"
+	tristate "Intel PCH/PCU SPI flash platform driver"
 	depends on X86 || COMPILE_TEST
 	depends on SPI_MEM
 	select SPI_INTEL
@@ -476,6 +478,8 @@ config SPI_INTEL_PLATFORM
 	  Intel hardware and is used to hold BIOS and other persistent
 	  settings. Using this driver it is possible to upgrade BIOS
 	  directly from Linux.
+	  The driver will use hardware sequencing capabilities from the chip
+	  by default.
 
 	  Say N here unless you know what you are doing. Overwriting the
 	  SPI flash may render the system unbootable.
@@ -483,6 +487,13 @@ config SPI_INTEL_PLATFORM
 	  To compile this driver as a module, choose M here: the module
 	  will be called spi-intel-platform.
 
+config SPI_INTEL_SWSEQ
+	tristate "Intel SPI controller software sequencing support (DANGEROUS)"
+	depends on X86 || COMPILE_TEST
+	depends on SPI_MEM
+	help
+	  This enables software sequencing functionality to the SPI controller
+
 config SPI_JCORE
 	tristate "J-Core SPI Master"
 	depends on OF && (SUPERH || COMPILE_TEST)
diff --git a/drivers/spi/spi-intel-swseq.c b/drivers/spi/spi-intel-swseq.c
index 2597aa06a160..d7e4834be6db 100644
--- a/drivers/spi/spi-intel-swseq.c
+++ b/drivers/spi/spi-intel-swseq.c
@@ -12,6 +12,7 @@
 #include "spi-intel-common.h"
 #include "spi-intel-swseq.h"
 
+#if defined(CONFIG_SPI_INTEL_SWSEQ)
 bool mem_op_supported_on_spi_locked(const struct intel_spi *ispi,
 				    const struct spi_mem_op *op)
 {
@@ -178,4 +179,53 @@ void populate_opmenus(struct intel_spi *ispi, u32 *opmenu0, u32 *opmenu1)
 }
 EXPORT_SYMBOL(populate_opmenus);
 
+#else
+static inline void log_error_swseq_not_supported(const struct intel_spi *ispi)
+{
+	dev_err(ispi->dev, "SW sequencing is not enabled");
+}
+
+int handle_swseq_wren(struct intel_spi *ispi)
+{
+	log_error_swseq_not_supported(ispi);
+	return -EINVAL;
+}
+EXPORT_SYMBOL(handle_swseq_wren);
+
+bool mem_op_supported_on_spi_locked(const struct intel_spi *ispi,
+				    const struct spi_mem_op *op)
+{
+	log_error_swseq_not_supported(ispi);
+	return false;
+}
+EXPORT_SYMBOL(mem_op_supported_on_spi_locked);
+
+int intel_spi_sw_cycle(struct intel_spi *ispi, u8 opcode, size_t len,
+		       int optype)
+{
+	log_error_swseq_not_supported(ispi);
+	return -ENOTSUPP;
+}
+EXPORT_SYMBOL(intel_spi_sw_cycle);
+
+inline bool is_swseq_enabled(void)
+{
+	return false;
+}
+EXPORT_SYMBOL(is_swseq_enabled);
+
+void disable_smi_generation(const struct intel_spi *ispi)
+{
+	log_error_swseq_not_supported(ispi);
+}
+EXPORT_SYMBOL(disable_smi_generation);
+
+void populate_opmenus(struct intel_spi *ispi, u32 *opmenu0, u32 *opmenu1)
+{
+	log_error_swseq_not_supported(ispi);
+}
+EXPORT_SYMBOL(populate_opmenus);
+
+#endif
+
 MODULE_LICENSE("GPL v2");
-- 
2.34.3

