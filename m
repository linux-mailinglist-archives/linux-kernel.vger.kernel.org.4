Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA1068D294
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 10:20:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbjBGJUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 04:20:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbjBGJUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 04:20:24 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B4833803F;
        Tue,  7 Feb 2023 01:20:17 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id c10-20020a17090a1d0a00b0022e63a94799so17925209pjd.2;
        Tue, 07 Feb 2023 01:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nxkElKmgrqtTP5be0jVrJHJmBiDppX9Zdl7lKzzovCQ=;
        b=jx8S9Qdt4e94z5twK1nX5KVCvgxctmayeMLoJUjw/e//zQAxurC9ajeRWdx5GqVPqO
         F+DPxAKRR5F63lb+7A3dZADRrpEDK6lbGSDkfhQQ/Oeecrbez9iFe5ffG51XgGb2rw98
         5naQMqdtyxSDcfksu0067Egfm2PJ4QAhJHyAA33VPsC80VQpjZ8F+1QI9y4VVmv2mK4K
         P6TmLgjyn/amWRMTVhpEuj6gT8zE7ApAxSOArB0YvMSIBZRgmSJHuu0+a1j3Ov9VuGIJ
         T+n+iKte2dODH5C1a5fIrczYQ6OS3TkooS+Ago52iLthG0GXwt1bagUDCRRLvyn0OKxP
         7K4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nxkElKmgrqtTP5be0jVrJHJmBiDppX9Zdl7lKzzovCQ=;
        b=CLysGCwFZsYRcfQoc02qFU4gz66M28DpDDX2cn8917/KZjCA5zq6YlBn7pwQNngJOE
         p/NrbKi/Ndf2CmuQFAWsu8SDID/DF5t51882v0i7+y2eJhJMRzSD/tPJvQ5gq6VXCFtV
         dj1B5DoLE+h0o6Si9XWxfc96eVmGuTo/nGDtykr2Cp+/ERetricCr8S+0lvjDlSX/sun
         HyiAE4/O1wgjxQwMdUG9ylAQx+7D9mFliD9ZgREtZt6tQlP1KZhwtQyx1izz5+sL28Eu
         iVzZpZUWpiqltDdz8h8IzF7qrA9k6vfpHgnYF530BpAnGULp0AzWG6PCSmEuzDPWqrUe
         /o0A==
X-Gm-Message-State: AO0yUKV91Ci++kYrCMg34fFVmjZB8STJR6Jy5Xx06trwhXgeN7YqfOzI
        7eTTsly6LQUEV0WacCc63YM=
X-Google-Smtp-Source: AK7set8vzilXOFhkDUuUxNOjw4kQaE2wDpspWEjsB8rypoNfhnbBkZ2/OvEv8ION7oXovA6eEevWeQ==
X-Received: by 2002:a17:902:f0d5:b0:199:1fa:7abe with SMTP id v21-20020a170902f0d500b0019901fa7abemr1697355pla.58.1675761616474;
        Tue, 07 Feb 2023 01:20:16 -0800 (PST)
Received: from hcdev-d520mt2.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id io20-20020a17090312d400b0019934030f46sm545327plb.132.2023.02.07.01.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 01:20:16 -0800 (PST)
From:   Marvin Lin <milkfafa@gmail.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        andrzej.p@collabora.com
Cc:     devicetree@vger.kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        kwliu@nuvoton.com, kflin@nuvoton.com,
        Marvin Lin <milkfafa@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v11 3/7] dt-bindings: arm: nuvoton: Add NPCM GFXI
Date:   Tue,  7 Feb 2023 17:18:58 +0800
Message-Id: <20230207091902.2512905-4-milkfafa@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230207091902.2512905-1-milkfafa@gmail.com>
References: <20230207091902.2512905-1-milkfafa@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dt-bindings document for Graphics Core Information (GFXI) node. It
is used by NPCM video driver to retrieve Graphics core information.

Signed-off-by: Marvin Lin <milkfafa@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/arm/npcm/nuvoton,gfxi.yaml       | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/npcm/nuvoton,gfxi.yaml

diff --git a/Documentation/devicetree/bindings/arm/npcm/nuvoton,gfxi.yaml b/Documentation/devicetree/bindings/arm/npcm/nuvoton,gfxi.yaml
new file mode 100644
index 000000000000..c033128e567a
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/npcm/nuvoton,gfxi.yaml
@@ -0,0 +1,39 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/npcm/nuvoton,gfxi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Graphics Core Information block in Nuvoton SoCs
+
+maintainers:
+  - Joseph Liu <kwliu@nuvoton.com>
+  - Marvin Lin <kflin@nuvoton.com>
+
+description:
+  The Graphics Core Information (GFXI) are a block of registers in Nuvoton SoCs
+  that analyzes Graphics core behavior and provides information in registers.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - nuvoton,npcm750-gfxi
+          - nuvoton,npcm845-gfxi
+      - const: syscon
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    gfxi: gfxi@e000 {
+      compatible = "nuvoton,npcm750-gfxi", "syscon";
+      reg = <0xe000 0x100>;
+    };
-- 
2.34.1

