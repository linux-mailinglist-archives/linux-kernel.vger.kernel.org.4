Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA69E6FE25B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 18:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235221AbjEJQYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 12:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjEJQXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 12:23:32 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 198817D97;
        Wed, 10 May 2023 09:22:56 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-969f90d71d4so347235566b.3;
        Wed, 10 May 2023 09:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683735774; x=1686327774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GMXjZD5TG12KlJC0oMszsNGKJaWk0DNrIhumCmxtZDQ=;
        b=EeiLouIo8Cw00Sa3M2/bq+acP9EsBNGgNlXg3uJ3iODy1v6EnM0Ve3NcOvg0nm1J77
         3v51DGXizh127Li3O3T6UmJUMRLFthAyw51Xu76O6cPH2fAL/TjvyokPMOnMMdud81Az
         VC1dI79sMhRb0c3b3htMcojLWb36HseGozRaa37rLTeYfAqqB1g37s8NxXgEIIFnIAma
         5OWVStih6zNUsYZk15XZLggo3pOoagipJsNkNHEKPlWvLB+BltE9z3hN8p3rCGIE1osT
         vb01nF6S0bU8THPlnNayKkOGd2UcuR302G+BdVDb2WXl/68c/xNjvA9aNLI7KskZiHm0
         o3tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683735774; x=1686327774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GMXjZD5TG12KlJC0oMszsNGKJaWk0DNrIhumCmxtZDQ=;
        b=VBzN/WbkoGZhsza95lNxLe+O4itgr94qNCzt2nE/y7c/CDM2eoHiGtUkKjEYTcEIuu
         hzDFohKib/DXNONi/vG7ALlv+0ddTF5sJcYzMqVIINdKIIMJHEdwyo6Exi8lkih418CD
         +NdzyTVUu6zHKtm0xp1JaXEJC1MFA0QSCRaXNPiTR9in7AvoHV5VEKQJXv9Z1Cpe5icb
         Tzz2MH/bgvHFdx5LVnqzL0CI3z+I4TMcHO5Mkuq9m+L7xpgZShZusCwhwvH1OJlYrKLp
         NH3IjzHDIs4L1JkiPudHMlgt5jVXoaluS6+m9wFPTkFeut9OzXbmYD3+CB+b7n538HgK
         bAXg==
X-Gm-Message-State: AC+VfDzutVD9Q+0QYrcabfajbJiEnDmcZgkfygpWgQAolae8qSNExIwd
        qy3A0INoofh7yN/xZt8/TsxscLPiDc+jyVZ7
X-Google-Smtp-Source: ACHHUZ5XPN408wS2lBWyQ4yYdwEaE77MCusU7dHw844FbLriB3z7Jix1NhLRpp0H6yI5tYoKJVTXcQ==
X-Received: by 2002:a17:907:1614:b0:956:f4f8:23b6 with SMTP id hb20-20020a170907161400b00956f4f823b6mr19575722ejc.43.1683735774026;
        Wed, 10 May 2023 09:22:54 -0700 (PDT)
Received: from fedora.dev.tbscz ([85.93.123.158])
        by smtp.gmail.com with ESMTPSA id m28-20020a17090677dc00b00947ed087a2csm2890149ejn.154.2023.05.10.09.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 09:22:53 -0700 (PDT)
From:   =?UTF-8?q?Martin=20Za=C5=A5ovi=C4=8D?= <m.zatovic1@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, gregkh@linuxfoundation.org,
        beanhuo@micron.com, nipun.gupta@amd.com, linus.walleij@linaro.org,
        mwen@igalia.com, bvanassche@acm.org, arnd@arndb.de,
        ogabbay@kernel.org, linux@zary.sk,
        jacek.lawrynowicz@linux.intel.com, geert+renesas@glider.be,
        benjamin.tissoires@redhat.com, masahiroy@kernel.org,
        yangyicong@hisilicon.com, devicetree@vger.kernel.org,
        =?UTF-8?q?Martin=20Za=C5=A5ovi=C4=8D?= <m.zatovic1@gmail.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCHv4 1/4] dt-bindings: wiegand: add Wiegand controller common properties
Date:   Wed, 10 May 2023 18:22:40 +0200
Message-Id: <20230510162243.95820-2-m.zatovic1@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230510162243.95820-1-m.zatovic1@gmail.com>
References: <20230510162243.95820-1-m.zatovic1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wiegand bus is defined by a Wiegand controller node. This node
can contain one or more device nodes for devices attached to
the controller(it is advised to only connect one device as Wiegand
is a point-to-point bus).

Wiegand controller needs to specify several attributes such as
the pulse length in order to function properly. These attributes
are documented here.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Martin Zaťovič <m.zatovic1@gmail.com>
---
 .../bindings/wiegand/wiegand-controller.yaml  | 39 +++++++++++++++++++
 MAINTAINERS                                   |  5 +++
 2 files changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/wiegand/wiegand-controller.yaml

diff --git a/Documentation/devicetree/bindings/wiegand/wiegand-controller.yaml b/Documentation/devicetree/bindings/wiegand/wiegand-controller.yaml
new file mode 100644
index 000000000000..8f36287e4fed
--- /dev/null
+++ b/Documentation/devicetree/bindings/wiegand/wiegand-controller.yaml
@@ -0,0 +1,39 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/wiegand/wiegand-controller.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Wiegand Generic Controller Common Properties
+
+maintainers:
+  - Martin Zaťovič <m.zatovic1@gmail.com>
+
+description:
+  Wiegand busses can be described with a node for the Wiegand controller device
+  and a set of child nodes for each SPI slave on the bus.
+
+properties:
+  $nodename:
+    pattern: "^wiegand(@.*|-[0-9a-f])?$"
+
+  pulse-len-us:
+    description:
+      Length of the low pulse in microseconds.
+
+  interval-len-us:
+    description:
+      Length of a whole bit (both the pulse and the high phase) in microseconds.
+
+  frame-gap-us:
+    description:
+      Length of the last bit of a frame (both the pulse and the high phase) in
+      microseconds.
+
+required:
+  - compatible
+  - pulse-len-us
+  - interval-len-us
+  - frame-gap-us
+
+additionalProperties: true
diff --git a/MAINTAINERS b/MAINTAINERS
index 7e0b87d5aa2e..55602888f084 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22697,6 +22697,11 @@ L:	linux-input@vger.kernel.org
 S:	Maintained
 F:	drivers/hid/hid-wiimote*
 
+WIEGAND BUS DRIVER
+M:	Martin Zaťovič <m.zatovic1@gmail.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/wiegand/wiegand-controller.yaml
+
 WILOCITY WIL6210 WIRELESS DRIVER
 L:	linux-wireless@vger.kernel.org
 S:	Orphan
-- 
2.40.0

