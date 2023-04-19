Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6D1E6E7843
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 13:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233019AbjDSLLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 07:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232917AbjDSLLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 07:11:19 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B539D13C23
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 04:10:37 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1a526aa3dd5so36470825ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 04:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1681902627; x=1684494627;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IeP1c5FHkO2iYuai0o4JGoTDumRIxR3IsfyyPznXUZQ=;
        b=koEw/uiEXJ4P6r+2zoaiHPM5ok/d28q5pyhF5LbHc6I1XBnEv7ikHPdbKOO5lffn/K
         pKDES30EiXACKywfHsDUvjjt0cOPKfvLpyg9IeEb5NLAba+5aa/Q/MLSvGSDEPWntDpi
         abS8us22/q+V5R+SCMXTfaaDbuG1buySAT/syibcEKpDziulkNwfG1g/R2vwvlaUG+P7
         fl09D+ZXUj4CtB6cdojZ/MWvx8OjwgAgpdsksCYdzZrmbJqBWSzxhAdKGStPebuYbxLb
         xjGTza0fpYTfOqnhex0mFm1BxYCeEx7xKzQ1po6NxzdlGYosdnG647RnUtd+HmnyvEj7
         uvrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681902627; x=1684494627;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IeP1c5FHkO2iYuai0o4JGoTDumRIxR3IsfyyPznXUZQ=;
        b=lftrJp8u2BSGvcuIbEoM/G/a+5IproN+BNi2Vile958YREEK3QWcxqW5nkGTbH2/ds
         mxxQWfdeaQNAKYJvjt4MXm29UQHkr48cZXYyhCijG5IpQuEPUpEx1mMSVD+zjZVplJZp
         JC/4FOL67gV4n/qdNVoSx7MuJBIBzd/r3BRj1dIzkqbczkBDd7Z+7E7acAtqK35l5D3/
         6V5/QHA2ZxZBG3c8nCbV0oSsFxPKAP79mOE2GpYd9Ao300IMn5GX972cWlC/g1gEtx4B
         wUPcLDR2IM6xv+vB71t11tS0fwzwvaf75YNZqUZdPKQnAeA5p+rsDIem56TZSXr2fYTy
         Qawg==
X-Gm-Message-State: AAQBX9eeUUP8fvlmxg0HloDePV7c5y75ND2xsYk7J38u46L0azULsZqn
        CXsidOAjT6y7jQ1M42WuZ95VwQ==
X-Google-Smtp-Source: AKy350as/KHWHZ+shgMkN9Cq1xyi0sRUDBIGVeroXLacVjHMk99lR8iksTM1dFoEjEk5V5sXMqlvAA==
X-Received: by 2002:a17:903:11cf:b0:1a6:81bd:c4d9 with SMTP id q15-20020a17090311cf00b001a681bdc4d9mr5507947plh.39.1681902627683;
        Wed, 19 Apr 2023 04:10:27 -0700 (PDT)
Received: from x1.hsd1.or.comcast.net ([2601:1c2:1800:f680:eaf2:1d7a:7338:16cb])
        by smtp.gmail.com with ESMTPSA id g12-20020a1709026b4c00b001a24cded097sm11180774plt.236.2023.04.19.04.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 04:10:27 -0700 (PDT)
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
Subject: [RFC PATCH 12/21] dt-bindings: riscv: add riscv,cbqri bindings
Date:   Wed, 19 Apr 2023 04:11:02 -0700
Message-Id: <20230419111111.477118-13-dfustini@baylibre.com>
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

Document properties that can be used in the bindings for controllers
that implement the RISC-V CBQRI specification.

Co-developed-by: Adrien Ricciardi <aricciardi@baylibre.com>
Signed-off-by: Adrien Ricciardi <aricciardi@baylibre.com>
Signed-off-by: Drew Fustini <dfustini@baylibre.com>
---
 .../bindings/riscv/riscv,cbqri.yaml           | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/riscv/riscv,cbqri.yaml

diff --git a/Documentation/devicetree/bindings/riscv/riscv,cbqri.yaml b/Documentation/devicetree/bindings/riscv/riscv,cbqri.yaml
new file mode 100644
index 000000000000..3f017c6b1fb1
--- /dev/null
+++ b/Documentation/devicetree/bindings/riscv/riscv,cbqri.yaml
@@ -0,0 +1,28 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/riscv/riscv,cbqri.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: RISC-V Capacity and Bandwidth Register Interface (CBQRI) properties
+
+description: |
+  Common properties for cache and memory controllers that implement the
+  RISC-V CBQRI specification:
+  https://github.com/riscv-non-isa/riscv-cbqri/blob/main/riscv-cbqri.pdf
+
+maintainers:
+  - Drew Fustini <dfustini@baylibre.com>
+
+properties:
+  riscv,cbqri-rcid:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: The maximum number of RCIDs the controller supports
+
+  riscv,cbqri-mcid:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: The maximum number of MCIDs the controller supports
+
+additionalProperties: true
+
+...
-- 
2.34.1

