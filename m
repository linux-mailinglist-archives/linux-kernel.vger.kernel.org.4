Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44EB56E2511
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 16:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbjDNODk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 10:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbjDNODe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 10:03:34 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF0FA5FF
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 07:03:00 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id bi41so5400276lfb.7
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 07:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1681480967; x=1684072967;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L6n77Uz+PsEL5Zjj7L5BoLRIOYIh+FfJEj7GLcVMFvg=;
        b=to1vKMIM1WC0fNpuIs5zm3Xd24aEi6aKDV9OLiqX3WkQ186p1OuycU1BZvA94dDYsT
         r09kVB9ndrgzrg5+P/PlIVIj6pggSuDLvitGJaAe+apJV9pcgVmTgO5MbPN5TvD/C6IL
         0EtgNlqLzaUciDl3qcozHuoFcBoCWUVp+BLw+RrVuKI8qRirPnozw5rxTutWT69uV17+
         kN29a9NOcNSqMukp4uOHgo0o0MbaVDiICQZpYsoHoF+uMeXyqgAMD1r/CBKX7CUpimbT
         1r/morRdVUAFqIRIASuMeGpTdR3NjQC7ZlYp/eI2C4He8BfW4P+1LR9KmoDtUFbzgXAQ
         vCeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681480967; x=1684072967;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L6n77Uz+PsEL5Zjj7L5BoLRIOYIh+FfJEj7GLcVMFvg=;
        b=e7A8o5kRj72xvITgvgYeduLZbqc/1HHamdkT2g0s0NYEMfYB21xqwMgT7/ihfZoOQK
         c26qQV03f6tN9DOnDRXH88vu6UAXc6uZBIHhX4NyXBZDwAaMIbM8rIg5Pefdndn1Fg4a
         9B20Msrko9RWNMcJEifGowTBCeim5tp4zKH5br1VRBMKTjzQ45Z3zRcCp/Hr50MuN4UJ
         ZwmeMA5JKn30BI5Ci1VCAAo6ZQfwtJWaFRB6TUrFTJcfThAZRerDaCsU5mvGt4EOcvbN
         6rzLI3GhZK2q052g1IVUzkwCnkWJTpG1GFl79Ln28r0XTPkDkC6f901gMi5yA6Rk90BF
         kJ1A==
X-Gm-Message-State: AAQBX9ceCcrOEdszqZerx1GjC+yhuK/8yk2Lx58kwSUzs7Kg+mhKvjqc
        n23lIdIgyebzpacvWFZg3z/E1w==
X-Google-Smtp-Source: AKy350ZSXgVjOCNXI2VQYGW1Lkq/T4J5v7tUI1rYH+arf0uiLVP1zRg1drMxe3NixehsPq/kIrQ5fw==
X-Received: by 2002:a05:6512:4012:b0:4eb:2b62:134f with SMTP id br18-20020a056512401200b004eb2b62134fmr2780018lfb.16.1681480966909;
        Fri, 14 Apr 2023 07:02:46 -0700 (PDT)
Received: from panikiel.roam.corp.google.com (staticline-31-182-201-26.toya.net.pl. [31.182.201.26])
        by smtp.gmail.com with ESMTPSA id 15-20020a2eb2cf000000b002a76e2dedbcsm828684ljz.139.2023.04.14.07.02.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 07:02:46 -0700 (PDT)
From:   =?UTF-8?q?Pawe=C5=82=20Anikiel?= <pan@semihalf.com>
To:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org
Cc:     perex@perex.cz, tiwai@suse.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dinguyen@kernel.org,
        lars@metafoo.de, nuno.sa@analog.com, upstream@semihalf.com,
        =?UTF-8?q?Pawe=C5=82=20Anikiel?= <pan@semihalf.com>
Subject: [PATCH 4/9] dt-bindings: ASoC: Add it68051
Date:   Fri, 14 Apr 2023 16:01:58 +0200
Message-ID: <20230414140203.707729-5-pan@semihalf.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
In-Reply-To: <20230414140203.707729-1-pan@semihalf.com>
References: <20230414140203.707729-1-pan@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding for it68051 device.

Signed-off-by: Paweł Anikiel <pan@semihalf.com>
---
 .../bindings/sound/ite,it68051.yaml           | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/ite,it68051.yaml

diff --git a/Documentation/devicetree/bindings/sound/ite,it68051.yaml b/Documentation/devicetree/bindings/sound/ite,it68051.yaml
new file mode 100644
index 000000000000..341c171b8a8a
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/ite,it68051.yaml
@@ -0,0 +1,23 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/ite,it68051.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: it68051 audio codec
+
+maintainers:
+  - Paweł Anikiel <pan@semihalf.com>
+
+properties:
+  compatible:
+    const: ite,it68051
+
+required:
+  - compatible
+
+examples:
+  - |
+    it68051: audio-codec {
+        compatible = "ite,it68051";
+    };
-- 
2.40.0.634.g4ca3ef3211-goog

