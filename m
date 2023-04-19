Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04D666E7847
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 13:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232969AbjDSLMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 07:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232890AbjDSLLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 07:11:21 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7982713FB9
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 04:10:41 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-63d4595d60fso6108536b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 04:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1681902635; x=1684494635;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QMTmZYX45TS17GLlk7oZqME3pRStBNddDLQwkiv9SHY=;
        b=46+5TNw+d2+58D3lEwkZD1Q8Gjos23n16w76kwCbjIECo1omLOWdsqJ46O7WHdtCVf
         D6qRVkiwMOMRAxvlv69gS5768jAdvZ3q7SLH2mCNoo7pA6DoTBc59/I15a15pUslSRDK
         /sazIdZh4izVkCBDGPfmF4UdHbNV47UlD3fcXsGPM4eRj25LcXDU0OhV/GDD0igGJuqH
         ml6QdIY3yH15VCschcFTjCoiOk0b8wP3ZHQkAxu3r7qM6fXIOAtfEp8TawssQfzZ+3jQ
         Pz4fkHwI1vBeH+6KTWIqpWvkeSeuRVl81TzDA/3EEnLNJgOPMIAgi3B1w0h0VX43lGZj
         JPxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681902635; x=1684494635;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QMTmZYX45TS17GLlk7oZqME3pRStBNddDLQwkiv9SHY=;
        b=c0KrounSb1pb/aU+QyqXHgtiv5yA/YBCj0mcXv4FbIxoUkgU90khQJyQ6lxZj0ib/5
         bKEmirmnS2TmFHdQJDi+LMDCingrgg72OYQ6YOlRkcbcMCK86a/iZQgj90Fc2xRhQB/F
         CMdh3BCpcG4T8jp9TV8EutCgNLH8rGxW9E2NcCJk4qwJqnejMCWCWOrnjYl5Jmm37Mju
         3TfjmMHDGZDQjHwDaIlBsiWibbeHU5wmpeSVLVo9ePRCwVzE73wZdgrxySRoBhmhWzW3
         3q/X0KSu0vTMW6vy/iA3enDxgR74W92oGGrzfwW3525KsBDdq24/Jrq1xOcRpP/VyeAK
         uOGA==
X-Gm-Message-State: AAQBX9e18TGrX5y2vmSJcHwP6NRdbJPYgMBv6ryNvOkSbX1W3EYlbVZp
        xaf3kZ4m0/YoGKfLZb/8XM1XpQ==
X-Google-Smtp-Source: AKy350bNtcXmBs3y7eW4IdMHqOa9Oa7W5HHD92Z47TlERpw2rIKTANDR14gbiWN3KKUZ+zGReRRKzw==
X-Received: by 2002:a17:902:fb06:b0:1a2:89eb:3d1a with SMTP id le6-20020a170902fb0600b001a289eb3d1amr2109505plb.6.1681902635547;
        Wed, 19 Apr 2023 04:10:35 -0700 (PDT)
Received: from x1.hsd1.or.comcast.net ([2601:1c2:1800:f680:eaf2:1d7a:7338:16cb])
        by smtp.gmail.com with ESMTPSA id g12-20020a1709026b4c00b001a24cded097sm11180774plt.236.2023.04.19.04.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 04:10:35 -0700 (PDT)
From:   Drew Fustini <dfustini@baylibre.com>
To:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Ved Shanbhogue <ved@rivosinc.com>,
        =?UTF-8?q?Kornel=20Dul=C4=99ba?= <mindal@semihalf.com>,
        Adrien Ricciardi <aricciardi@baylibre.com>,
        Nicolas Pitre <npitre@baylibre.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Babu Moger <babu.moger@amd.com>,
        Peter Newman <peternewman@google.com>, x86@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        James Morse <james.morse@arm.com>
Cc:     Drew Fustini <dfustini@baylibre.com>
Subject: [RFC PATCH 18/21] DO_NOT_MERGE soc: build Foobar SoC drivers
Date:   Wed, 19 Apr 2023 04:11:08 -0700
Message-Id: <20230419111111.477118-19-dfustini@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230419111111.477118-1-dfustini@baylibre.com>
References: <20230419111111.477118-1-dfustini@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Foobar SoC cache and memory controller drivers to the build.

The hypothetical Foobar SoC serves as an example of an SoC with
controllers that implement the RISC-V Capacity and Bandwidth QoS
Register Interface (CBQRI) specification.

Link: https://github.com/riscv-non-isa/riscv-cbqri/blob/main/riscv-cbqri.pdf
Co-developed-by: Adrien Ricciardi <aricciardi@baylibre.com>
Signed-off-by: Adrien Ricciardi <aricciardi@baylibre.com>
Signed-off-by: Drew Fustini <dfustini@baylibre.com>
---
 drivers/soc/Kconfig         |  1 +
 drivers/soc/Makefile        |  1 +
 drivers/soc/foobar/Kconfig  | 21 +++++++++++++++++++++
 drivers/soc/foobar/Makefile |  4 ++++
 4 files changed, 27 insertions(+)
 create mode 100644 drivers/soc/foobar/Kconfig
 create mode 100644 drivers/soc/foobar/Makefile

diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
index 4e176280113a..8578f8c607ff 100644
--- a/drivers/soc/Kconfig
+++ b/drivers/soc/Kconfig
@@ -8,6 +8,7 @@ source "drivers/soc/aspeed/Kconfig"
 source "drivers/soc/atmel/Kconfig"
 source "drivers/soc/bcm/Kconfig"
 source "drivers/soc/canaan/Kconfig"
+source "drivers/soc/foobar/Kconfig"
 source "drivers/soc/fsl/Kconfig"
 source "drivers/soc/fujitsu/Kconfig"
 source "drivers/soc/imx/Kconfig"
diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
index 3b0f9fb3b5c8..37a77c2dab94 100644
--- a/drivers/soc/Makefile
+++ b/drivers/soc/Makefile
@@ -11,6 +11,7 @@ obj-y				+= bcm/
 obj-$(CONFIG_SOC_CANAAN)	+= canaan/
 obj-$(CONFIG_ARCH_DOVE)		+= dove/
 obj-$(CONFIG_MACH_DOVE)		+= dove/
+obj-y				+= foobar/
 obj-y				+= fsl/
 obj-y				+= fujitsu/
 obj-$(CONFIG_ARCH_GEMINI)	+= gemini/
diff --git a/drivers/soc/foobar/Kconfig b/drivers/soc/foobar/Kconfig
new file mode 100644
index 000000000000..4548e822357e
--- /dev/null
+++ b/drivers/soc/foobar/Kconfig
@@ -0,0 +1,21 @@
+# SPDX-License-Identifier: GPL-2.0
+
+config FOOBAR_CBQRI_CACHE
+	bool "Foobar cache controller for RISC-V CBQRI testing"
+	default y
+	help
+	  Support the cache controller in a hypothetical "Foobar" SoC that
+	  implements the RISC-V Capacity and Bandwidth QoS Register Interface
+	  (CBQRI) specification.
+
+	  If you do not care about testing RISC-V CBQRI, then choose 'N'.
+
+config FOOBAR_CBQRI_MEMORY
+	bool "Foobar memory controller for RISC-V CBQRI testing"
+	default y
+	help
+	  Support the memory controller in a hypothetical "Foobar" SoC that
+	  implements the RISC-V Capacity and Bandwidth QoS Register Interface
+	  (CBQRI) specification.
+
+	  If you do not care about testing RISC-V CBQRI, then choose 'N'.
diff --git a/drivers/soc/foobar/Makefile b/drivers/soc/foobar/Makefile
new file mode 100644
index 000000000000..e4f34058e39e
--- /dev/null
+++ b/drivers/soc/foobar/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_FOOBAR_CBQRI_CACHE)     += foobar_cbqri_cache.o
+obj-$(CONFIG_FOOBAR_CBQRI_MEMORY)     += foobar_cbqri_memory.o
-- 
2.34.1

