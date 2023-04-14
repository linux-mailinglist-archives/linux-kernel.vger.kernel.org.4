Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBEB56E250F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 16:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbjDNODe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 10:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbjDNODc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 10:03:32 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8441A24D
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 07:02:59 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id r9so5220766ljp.9
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 07:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1681480966; x=1684072966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pAsx/vtlSONsGJaMiUuvZrWP17NNhM0s9aopfUG3YMs=;
        b=Qi8J8nvWCtFhQJhd2UX1NuWmfKbSuxCdjqjnDbhKFiBYPv3xo/hUC6Do2yDnUCewAT
         tl4VOteQPr1vA9ehtzJx9//7fZlv2nySr+BsyVTmcwpIEX1nKSDMlvaAlyUlYHXNsEpx
         gRf0Q7SM1nyAeFaDsOuPiresr4FTfzZwyOvBn6qzJEFghHmpmtp+Uap2CZHpoeicqPFC
         TlO8OVPwTjnp/FJTOYL+dZPoyeFIcpk/Gn0o5iSNzBJScOAyrh8sVcPPbEZrjuWTThOR
         QJ0AsZSe1L+lXynCjQG2TIcE/AElygHP+mila0NJdBrRzO7TCSkxv+fOFSljBz39gnOD
         M3xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681480966; x=1684072966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pAsx/vtlSONsGJaMiUuvZrWP17NNhM0s9aopfUG3YMs=;
        b=C/FMo0u6q1OWPiCelLU+nrnapW1L3JEAzqkr2raohmRjPh8hquL3BN0GriX3XJ6TyW
         u8SWAHmmr9D15Rn7TNRUkQFqm3fOWQZKxqV1OmVxNLXQlGeyuiRT1DuPc+gSzMKqavCa
         //hFyeTRJ5VxZfZDHIs9zYMeJ9X3cwaYTckb32Ht5nn6nin+hp7t1/raCeq7drTjmmZh
         j9DXMmhQL25cBkd6iuQpQOP9VFvBZLC9oWdyjIFtX6JXgzrKH6g61JyZVzs/0raOa2mJ
         gA7iyL9pZ8bGGfFMuajWkOXF4tzW8EWvDE/NIVTlWDdTg93+vokfesjYTmdAL7Y53uSb
         wriw==
X-Gm-Message-State: AAQBX9esu1tZAP7+EJfEQB+2V6yggXHKLT9l/LgXFADZqtvC1i001Ew5
        mphxUaLR1Jy75f/7hLoWPyYXlT4SM3dOg1fDLCv73Q==
X-Google-Smtp-Source: AKy350Z+QDZGlS7XF9A1X0316HTp53Mi+Jrm8uEaFMhPQvNowT32YfQLUfNynbysrYJBu0ehToQ6JA==
X-Received: by 2002:a2e:9d84:0:b0:295:d7a8:559b with SMTP id c4-20020a2e9d84000000b00295d7a8559bmr1714528ljj.10.1681480965408;
        Fri, 14 Apr 2023 07:02:45 -0700 (PDT)
Received: from panikiel.roam.corp.google.com (staticline-31-182-201-26.toya.net.pl. [31.182.201.26])
        by smtp.gmail.com with ESMTPSA id 15-20020a2eb2cf000000b002a76e2dedbcsm828684ljz.139.2023.04.14.07.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 07:02:45 -0700 (PDT)
From:   =?UTF-8?q?Pawe=C5=82=20Anikiel?= <pan@semihalf.com>
To:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org
Cc:     perex@perex.cz, tiwai@suse.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dinguyen@kernel.org,
        lars@metafoo.de, nuno.sa@analog.com, upstream@semihalf.com,
        =?UTF-8?q?Pawe=C5=82=20Anikiel?= <pan@semihalf.com>
Subject: [PATCH 3/9] dt-bindings: ASoC: Add chv3-audio
Date:   Fri, 14 Apr 2023 16:01:57 +0200
Message-ID: <20230414140203.707729-4-pan@semihalf.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
In-Reply-To: <20230414140203.707729-1-pan@semihalf.com>
References: <20230414140203.707729-1-pan@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding for chv3-audio device.

Signed-off-by: Paweł Anikiel <pan@semihalf.com>
---
 .../bindings/sound/google,chv3-audio.yaml     | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/google,chv3-audio.yaml

diff --git a/Documentation/devicetree/bindings/sound/google,chv3-audio.yaml b/Documentation/devicetree/bindings/sound/google,chv3-audio.yaml
new file mode 100644
index 000000000000..8b602b60eaee
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/google,chv3-audio.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/google,chv3-audio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Google Chameleon v3 audio
+
+maintainers:
+  - Paweł Anikiel <pan@semihalf.com>
+
+properties:
+  compatible:
+    const: google,chv3-audio
+
+  google,audio-cpu0:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: The phandle of controller #0
+
+  google,audio-codec0:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: The phandle of codec #0
+
+  google,audio-cpu1:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: The phandle of controller #1
+
+  google,audio-codec1:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: The phandle of codec #1
+
+required:
+  - compatible
+  - google,audio-cpu0:
+  - google,audio-codec0:
+  - google,audio-cpu1:
+  - google,audio-codec1:
+
+additionalProperties: false
+
+examples:
+  - |
+    sound {
+        compatible = "google,chv3-audio";
+        google,audio-cpu0 = <&i2s1>;
+        google,audio-codec0 = <&ssm2603>;
+        google,audio-cpu1 = <&i2s0>;
+        google,audio-codec1 = <&it68051>;
+    };
-- 
2.40.0.634.g4ca3ef3211-goog

