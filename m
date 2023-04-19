Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB926E7844
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 13:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233085AbjDSLMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 07:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232953AbjDSLLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 07:11:21 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E6E13FAD
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 04:10:40 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1a52667955dso35501915ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 04:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1681902632; x=1684494632;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hTUdiTLb+sfXCVtetWlAgKKAKfkEOw5o717LduaEZcE=;
        b=xsELkwofXkO/cQsRhRzGSc4LNBA8d5ZwB4JnQLYCH4ZaGVuBP+nbM8feALhCz/sIMz
         MyuAV7iJQoGOCditkX7ry8YYdS0Nawh0XkuVc25RdlnISTlsepB5DEmsSviF6P1Gq8W4
         sluFvFa7S6qFMHylgIRnoWU+6wHZRBJBUaeX7Sg9yxxQWXO1Q99it5uMYgycZZad/mrL
         L8gpu72e7D0hEFnYS3yPVgIo9Q/KR5HvUJJ8GoySwWCZyTXYyPT6AAPNupIgcX6fR6M5
         jjYX2ppBNUoKa7qiG/Pd8D5X9175xTqsx/8xUD1d+dBmEDXhg71wkyYYTOIWDsckkHdb
         50sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681902632; x=1684494632;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hTUdiTLb+sfXCVtetWlAgKKAKfkEOw5o717LduaEZcE=;
        b=k6ZKBUWBof64kBxTSyCMk/O3cG4vjLI0OU3i/zOKExiIgQQW3TRGX3sNTJJ7rylBN2
         GbsOfqGNpyKvlb7syq9j9eh+KlNB8bf34SndEjNeEQLrPH+uxA+H7bg2zD9fOUVtTkcY
         yD/7u9RVWM0MDi70lOfK7fZXsShz+ZzFvSCzLwCZZ6ll3zLx1rG5v0BVLVdvGYuvrS4J
         BShHm70AcY+yeoHFvsOilZC8hzpMU0MEtudrQKe0F08WvUCWYU1xRfLpxvuamZ8KlocV
         YPFGgTSt7dJks43X4p1qw8zKTNBTDf1Cawk//h2ftwZyf92kkuXboesGvfjBwAorOau5
         +iOQ==
X-Gm-Message-State: AAQBX9cMxrkE4c6TnSlgdOFhcSkaUm0uvAqEa90P/U0k1rk2GH/DXyaB
        qEtXrEXDFkrgBdNILyKOB+H98YHQZWrn7z9iEQM=
X-Google-Smtp-Source: AKy350brfXXAlUzH+qw561taTYPU1WAFCWw0yqnL0lAKNxrOpHa9fu+9+OhVuIBQrfZgZmagCJ0UZw==
X-Received: by 2002:a17:902:b60a:b0:1a5:5e7:a1cc with SMTP id b10-20020a170902b60a00b001a505e7a1ccmr4412371pls.58.1681902631792;
        Wed, 19 Apr 2023 04:10:31 -0700 (PDT)
Received: from x1.hsd1.or.comcast.net ([2601:1c2:1800:f680:eaf2:1d7a:7338:16cb])
        by smtp.gmail.com with ESMTPSA id g12-20020a1709026b4c00b001a24cded097sm11180774plt.236.2023.04.19.04.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 04:10:31 -0700 (PDT)
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
Subject: [RFC PATCH 15/21] DO_NOT_MERGE dt-bindings: soc: add Foobar SoC memory controller
Date:   Wed, 19 Apr 2023 04:11:05 -0700
Message-Id: <20230419111111.477118-16-dfustini@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230419111111.477118-1-dfustini@baylibre.com>
References: <20230419111111.477118-1-dfustini@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for an example SoC memory controller that implements CBQRI.

Co-developed-by: Adrien Ricciardi <aricciardi@baylibre.com>
Signed-off-by: Adrien Ricciardi <aricciardi@baylibre.com>
Signed-off-by: Drew Fustini <dfustini@baylibre.com>
---
 .../soc/foobar/foobar,memory-controller.yaml  | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/foobar/foobar,memory-controller.yaml

diff --git a/Documentation/devicetree/bindings/soc/foobar/foobar,memory-controller.yaml b/Documentation/devicetree/bindings/soc/foobar/foobar,memory-controller.yaml
new file mode 100644
index 000000000000..859ee52680d5
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/foobar/foobar,memory-controller.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/foobar/foobar,memory-controller.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Foobar SoC Memory Controller
+
+maintainers:
+  - Drew Fustini <dfustini@baylibre.com>
+
+description:
+  Foobar SoC memory controller implements the RISC-V CBQRI interface for
+  capacity allocaiton and usage monitoring.
+
+allOf:
+  - $ref: /schemas/riscv/riscv,cbqri.yaml#
+
+properties:
+  compatible:
+    items:
+      - const: foobar,memory-controller
+  reg:
+    maxItems: 1
+    description: A memory region containing registers as defined in CBQRI spec
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+
+    memory-controller@fff12000 {
+        compatible = "foobar,memory-controller";
+        reg = <0xfff12000 0x2000>;
+        riscv,cbqri-rcid = <64>;
+        riscv,cbqri-mcid = <256>;
+    };
+
+...
-- 
2.34.1

