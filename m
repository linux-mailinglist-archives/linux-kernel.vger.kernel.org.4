Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66A28654162
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 13:55:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235279AbiLVMza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 07:55:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235133AbiLVMzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 07:55:24 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E608E275C7;
        Thu, 22 Dec 2022 04:55:22 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id z8-20020a17090abd8800b00219ed30ce47so5609212pjr.3;
        Thu, 22 Dec 2022 04:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W/70G/iNRFg0+tqFbgre+zSYvcngTPI1dr+sS/6Z8gg=;
        b=JKAltLDQ3krQAXiX8vfnL7ROx6AVWxgu47kG7d/yv6i/PcLUOmDydXX8GFy0H7/AUo
         rHbbLRBbM5kbCSAE5VE7Q0xVGjFzsQyj7QwPAC1RmBbLdHV42VAd2ZqdRmgF5JMwhrMe
         GM9gtEHX18SQDz2xaMBEs1qA4O6UiFwQSXJK+fepF9E8FKJnZxbg7dl6fVRMYhfiljVX
         nX/jC3qN5dlX4sMnWAa6Z4+YguoeWz7t7OZa2Ct8ckw2nwb67nnH+pozxHCQVK4LMCQs
         ZZimW2gQ84jUJZB+LaQaXpaDkHoaZAHt8IXBTz4tF8hwfIPVEDAxlGy+9LHT7EpicHNB
         S6fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W/70G/iNRFg0+tqFbgre+zSYvcngTPI1dr+sS/6Z8gg=;
        b=UIPa0aWpKWE/V2NCdFlTaVouDiNtgs5q/tGGLJEYcP6F66gRGdDTLXbms4pew9NDmI
         3f967P2TWwJz9MVa95TKP1ayjRa7x6XPe2m6SS1PvbeqMSXPnaXhvvJxIuw3hXjJDeHh
         wccIc2vl4ET00IUohnP5UOXoom3kAn8BgCvPv/CwSsnxL/un+ESuH+6YBSKThLlHag+o
         ckOKhZ+VRIlvcyqNfowBJmMFTd3zvfdSNRhWCptvV1xngQlWZUenGpkirkGAubBcA9Ad
         NekxQGi9OBLjxauM+cw3SYVMGkV+UJVYdes/44Uf/IivRSFN15qak2ZUZ3SW13mRSyKk
         RJwg==
X-Gm-Message-State: AFqh2krfQzNkL72W+JJjAmyxLCfIJwgJoGxjrjdakMisNS3mtW+X9F/a
        tWFvIRvvTi9Hz0Q6vXX8vdY=
X-Google-Smtp-Source: AMrXdXu+UkvaD+1wradcsdg55khU6E+1KfnZ/StEOvUkENC+h47PnAfvm4EN7g3Z98Nv8lvs2/Hy/A==
X-Received: by 2002:a17:902:b58a:b0:186:def0:66f2 with SMTP id a10-20020a170902b58a00b00186def066f2mr5511853pls.11.1671713722425;
        Thu, 22 Dec 2022 04:55:22 -0800 (PST)
Received: from localhost.localdomain ([45.62.172.3])
        by smtp.gmail.com with ESMTPSA id t8-20020a170902e84800b0017849a2b56asm503048plg.46.2022.12.22.04.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 04:55:22 -0800 (PST)
From:   Jianhua Lu <lujianhua000@gmail.com>
To:     Lee Jones <lee@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Helge Deller <deller@gmx.de>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-fbdev@vger.kernel.org, Jianhua Lu <lujianhua000@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 2/2] dt-bindings: leds: backlight: Add Kinetic KTZ8866 backlight
Date:   Thu, 22 Dec 2022 20:54:41 +0800
Message-Id: <20221222125441.1547-2-lujianhua000@gmail.com>
X-Mailer: git-send-email 2.38.2
In-Reply-To: <20221222125441.1547-1-lujianhua000@gmail.com>
References: <20221222125441.1547-1-lujianhua000@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Kinetic KTZ8866 backlight binding documentation.

Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Changes in v2:
  - Remove "items" between "compatible" and "const: kinetic,ktz8866"
  - Change "additionalProperties" to "unevaluatedProperties"

Changes in v3:
  - Add Krzysztof's R-b

 .../leds/backlight/kinetic,ktz8866.yaml       | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/backlight/kinetic,ktz8866.yaml

diff --git a/Documentation/devicetree/bindings/leds/backlight/kinetic,ktz8866.yaml b/Documentation/devicetree/bindings/leds/backlight/kinetic,ktz8866.yaml
new file mode 100644
index 000000000000..c63c21bf69d6
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/backlight/kinetic,ktz8866.yaml
@@ -0,0 +1,36 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/backlight/kinetic,ktz8866.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Kinetic Technologies KTZ8866 backlight
+
+maintainers:
+  - Jianhua Lu <lujianhua000@gmail.com>
+
+description: |
+  The Kinetic Technologies KTZ8866 is a high efficiency 6-sinks led backlight
+  with dual lcd bias power.
+  https://www.kinet-ic.com/ktz8866/
+
+allOf:
+  - $ref: common.yaml#
+
+properties:
+  compatible:
+    const: kinetic,ktz8866
+
+required:
+  - compatible
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    backlight {
+        compatible = "kinetic,ktz8866";
+
+        pinctrl-names = "default";
+        pinctrl-0 = <&bl_en_default>;
+    };
-- 
2.38.2

