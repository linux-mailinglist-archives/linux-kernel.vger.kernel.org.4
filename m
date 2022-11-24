Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2AE0637447
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 09:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbiKXIn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 03:43:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbiKXInW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 03:43:22 -0500
Received: from us-smtp-delivery-115.mimecast.com (us-smtp-delivery-115.mimecast.com [170.10.133.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E37F179927
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 00:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxlinear.com;
        s=selector; t=1669279342;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bSWgzt8uUrAzN6dnc8c6kjh1UlFQHYngZsNHw6hiwAw=;
        b=ayVJ013rLLdav8u5bh6oBGagZBRJjUXvx8QdYrh4zxiRkt68YIozHZcQ5pwZkUUK18IzcN
        /g4U9f0jT86PBZt8boC2pNmfiTiO5ntd6KCvsloLe+mNOueRgLZOTTKQn++sbZwR6mcS8g
        clNbBdai1E6+IW62/mbRvl5lqqAWS0ZBabIAiYQkSxg4KzpgVZMlxbwfD4wyI0pEItAEwv
        B8llqSAE9eUWnAK7L0rZWUoE/+sLcLWimRTJv9yYeq2N7pJboQZk5RuGzMsnXWF/24/FHn
        ZoiBt+VxRaoEdAPNglaHduPFEk7KeYEp/lqijBIZv80jbsnsxhiW0fV+9QiE5g==
Received: from mail.maxlinear.com (174-47-1-84.static.ctl.one [174.47.1.84])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 us-mta-316-Hfmy2PVaNgmf4o3uDeRJEg-1; Thu, 24 Nov 2022 03:42:20 -0500
X-MC-Unique: Hfmy2PVaNgmf4o3uDeRJEg-1
Received: from sgsxdev001.isng.phoenix.local (10.226.81.111) by
 mail.maxlinear.com (10.23.38.119) with Microsoft SMTP Server id 15.1.2375.24;
 Thu, 24 Nov 2022 00:42:15 -0800
From:   Rahul Tanwar <rtanwar@maxlinear.com>
To:     Rahul Tanwar <rtanwar@maxlinear.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Borislav Petkov" <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, <linux-lgm-soc@maxlinear.com>
Subject: [PATCH v5 2/4] dt-bindings: x86: apic: Introduce new optional bool property for lapic
Date:   Thu, 24 Nov 2022 16:41:41 +0800
Message-ID: <20221124084143.21841-3-rtanwar@maxlinear.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221124084143.21841-1-rtanwar@maxlinear.com>
References: <20221124084143.21841-1-rtanwar@maxlinear.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: maxlinear.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intel defines a few possible interrupt delivery modes. With respect
to boot/init time, mainly two interrupt delivery modes are possible.
PIC Mode - Legacy external 8259 compliant PIC interrupt controller.
Virtual Wire Mode - use lapic as virtual wire interrupt delivery mode.

For ACPI or MPS spec compliant systems, it is figured out by some read
only bit field/s available in their respective defined data structures.
But for OF based systems, it is by default set to PIC mode. Presently,
it is hardcoded to legacy PIC mode for OF based x86 systems with no
option to choose the configuration between PIC mode & virtual wire mode.

For this purpose, introduce a new boolean property for interrupt
controller node of lapic which can allow it to be configured to virtual
wire mode as well.

Property name: 'intel,virtual-wire-mode'
Type: Boolean

If not present/not defined, interrupt delivery mode defaults to legacy PIC
mode. If present/defined, interrupt delivery mode is set to virtual wire
mode.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Rahul Tanwar <rtanwar@maxlinear.com>
---
 .../interrupt-controller/intel,ce4100-lapic.yaml   | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/intel,c=
e4100-lapic.yaml b/Documentation/devicetree/bindings/interrupt-controller/i=
ntel,ce4100-lapic.yaml
index 55184cb49432..d2d0145cb889 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/intel,ce4100-l=
apic.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/intel,ce4100-l=
apic.yaml
@@ -39,6 +39,19 @@ properties:
   '#interrupt-cells':
     const: 2
=20
+  intel,virtual-wire-mode:
+    description: Intel defines a few possible interrupt delivery
+      modes. With respect to boot/init time, mainly two interrupt
+      delivery modes are possible.
+      PIC Mode - Legacy external 8259 compliant PIC interrupt controller.
+      Virtual Wire Mode - use lapic as virtual wire interrupt delivery mod=
e.
+      For ACPI or MPS spec compliant systems, it is figured out by some re=
ad
+      only bit field/s available in their respective defined data structur=
es.
+      For OF based systems, it is by default set to PIC mode.
+      But if this optional boolean property is set, then the interrupt del=
ivery
+      mode is configured to virtual wire compatibility mode.
+    type: boolean
+
 required:
   - compatible
   - reg
@@ -54,4 +67,5 @@ examples:
         reg =3D <0xfee00000 0x1000>;
         interrupt-controller;
         #interrupt-cells =3D <2>;
+        intel,virtual-wire-mode;
     };
--=20
2.17.1

