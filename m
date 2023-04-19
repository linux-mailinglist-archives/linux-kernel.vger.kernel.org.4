Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7EA16E7834
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 13:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232852AbjDSLK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 07:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232881AbjDSLKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 07:10:49 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91DE915447
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 04:10:14 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1a66888cb89so25360155ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 04:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1681902614; x=1684494614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iSeKxrM1bks+EefhwDp2KyUEcfeaeDF9wQYuIpi9EW0=;
        b=49f1VRB4kGVGgl4N0u5BK8ILp9SHeHM+SfTX6b8+b51pY3zpNaPJ1K5jK6EgtzX3Y+
         kgWIGu6FPEKFP21/XhNG9ezgg8K2EDcY4BsaH8hKcEgdKBEuXmWAnn7TXhj2pKL8Q80X
         gsM5BK6Q5MzRmp5iQrFFtt4800JiQbPBCGAiDimIVHwL4tXsJ0gdBDYT/3nSwEGUZcEh
         WGOPTVgisYyoEj1/vrQ8+Yu0qA+ueJ9JN+d6q3LauLhlb+RVvV1B/ctylOExID/3S9N4
         IS3ZV6k4Wca8TNpiWs7+F0/PMjynSVx4U5joLQeEYF/fIm9t9xc4G8+hr0OJ8DDfaRLN
         aWZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681902614; x=1684494614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iSeKxrM1bks+EefhwDp2KyUEcfeaeDF9wQYuIpi9EW0=;
        b=eixoExBJNTph9URcu37etoOflRqekM18usv1mE+9Pf1Ae8p5pI8jdBjEXNe/gv/QJm
         UK/8hFRXR6IFFwQuzDDu9CrdKijbRxqrrRA6ste8doI+HiWgSt8unN+lV5TGzc0jtzRp
         HVPXMnIu82kcRMxWpsfESiaBGrunSbyzFrOW5peah3HZxzqfxlsfw3Uyl3V9Ev5NV1QE
         CX9Sh1aiIPyNegQvb7DxHScpP1wVwsHFxrEt3FBr5erLF12wV87t+u62AZivVYHdkdRp
         bTHz8KHFXGmIsZbvob4WqvKNPwRu1GoXRiR6XnHW4SBnMrCaQAlQ0EQ+9fmOrqfY2WVW
         W4ng==
X-Gm-Message-State: AAQBX9dakfTkaksL//fVSxZSVmyVdm3Nt9nGgCNVNb3hxwOe9Jb+26bg
        uDsul0TfpuP7PWFCmMHRNzfm/Q==
X-Google-Smtp-Source: AKy350YXwjwRD1sLQ1B+t50/t+W8RZ+WsFbplLKM9L7G1ogdxUChyw8fsx9ITeD7FpbPkTpMpgzC+Q==
X-Received: by 2002:a17:902:8d98:b0:1a6:ee5a:7208 with SMTP id v24-20020a1709028d9800b001a6ee5a7208mr4745154plo.18.1681902613761;
        Wed, 19 Apr 2023 04:10:13 -0700 (PDT)
Received: from x1.hsd1.or.comcast.net ([2601:1c2:1800:f680:eaf2:1d7a:7338:16cb])
        by smtp.gmail.com with ESMTPSA id g12-20020a1709026b4c00b001a24cded097sm11180774plt.236.2023.04.19.04.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 04:10:12 -0700 (PDT)
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
Subject: [RFC PATCH 03/21] RISC-V: QoS: define properties of CBQRI controllers
Date:   Wed, 19 Apr 2023 04:10:53 -0700
Message-Id: <20230419111111.477118-4-dfustini@baylibre.com>
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

Define data structure to represent the CBQRI properties that a driver
for an CBQRI-capable controller would discover during probe.

Each instance of a CBQRI-capable controller is added to a list that the
RISC-V CBQRI resctrl implementation will consume.

Co-developed-by: Adrien Ricciardi <aricciardi@baylibre.com>
Signed-off-by: Adrien Ricciardi <aricciardi@baylibre.com>
Signed-off-by: Drew Fustini <dfustini@baylibre.com>
---
 include/linux/riscv_qos.h | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 include/linux/riscv_qos.h

diff --git a/include/linux/riscv_qos.h b/include/linux/riscv_qos.h
new file mode 100644
index 000000000000..95016810b575
--- /dev/null
+++ b/include/linux/riscv_qos.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef __LINUX_RISCV_QOS_H
+#define __LINUX_RISCV_QOS_H
+
+#include <linux/iommu.h>
+#include <linux/types.h>
+
+#include <asm/qos.h>
+
+enum cbqri_controller_type {
+	CBQRI_CONTROLLER_TYPE_CAPACITY,
+	CBQRI_CONTROLLER_TYPE_BANDWIDTH,
+	CBQRI_CONTROLLER_TYPE_UNKNOWN
+};
+
+struct cbqri_controller_info {
+	unsigned long addr;
+	unsigned long size;
+	enum cbqri_controller_type type;
+	u32 rcid_count;
+	u32 mcid_count;
+	struct list_head list;
+
+	struct cache_controller {
+		int cache_level;
+		u32 cache_size; /* in bytes */
+		struct cpumask cpu_mask;
+	} cache;
+};
+
+extern struct list_head cbqri_controllers;
+
+#endif /* __LINUX_RISCV_QOS_H */
-- 
2.34.1

