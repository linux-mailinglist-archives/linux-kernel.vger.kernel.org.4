Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8AD6359C7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 11:27:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236317AbiKWKZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 05:25:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236006AbiKWKYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 05:24:44 -0500
Received: from us-smtp-delivery-115.mimecast.com (us-smtp-delivery-115.mimecast.com [170.10.133.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60993F060
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 02:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxlinear.com;
        s=selector; t=1669198152;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xYvIQAHPDOiWXe8EWBzkMn7p0TefXGQ9AkwC3ZjhxhU=;
        b=ecVqpYYvb1vBLVnVn0bxgYW9e7bChmxLILoHmqkFsyIACsp6ehtoRLdasSfwQoNkvCblQq
        e/LixycDhTg00Zf2IlYvy3YRvJ86RtocWGh7jAl9TRIjpoENuUWD1OIG9ClvEjREJ9JBxQ
        Q4Ofbt6S0lMvifGb8AeH9OmNYFYX3ux8jTKNlWaxFELxRw+72Qm7RX+RofvBJ4ov7UQO8s
        dZOIxwZHdpUrQC6ihhIOIJWr1xR9va6BCgrt6I5qXpvXCGhVPpLEr2dowh/xQw3I0ptD7s
        q5mZVQSv0y9NQ6j0gDv0vX9hRGSmTLjePfcxGHg/hiHAyIyt0LBu5HdsQOZoKA==
Received: from mail.maxlinear.com (174-47-1-84.static.ctl.one [174.47.1.84])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 us-mta-120-j2fiLqKtMNO0Zuv7IMrxNg-1; Wed, 23 Nov 2022 05:09:07 -0500
X-MC-Unique: j2fiLqKtMNO0Zuv7IMrxNg-1
Received: from sgsxdev001.isng.phoenix.local (10.226.81.111) by
 mail.maxlinear.com (10.23.38.119) with Microsoft SMTP Server id 15.1.2375.24;
 Wed, 23 Nov 2022 02:08:59 -0800
From:   Rahul Tanwar <rtanwar@maxlinear.com>
To:     Rahul Tanwar <rtanwar@maxlinear.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Borislav Petkov" <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, <linux-lgm-soc@maxlinear.com>,
        <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v4 2/4] dt-bindings: x86: apic: Introduce new optional bool property for lapic
Date:   Wed, 23 Nov 2022 18:08:48 +0800
Message-ID: <20221123100850.22969-3-rtanwar@maxlinear.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221123100850.22969-1-rtanwar@maxlinear.com>
References: <20221123100850.22969-1-rtanwar@maxlinear.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: maxlinear.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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
index 88f320ef4616..ef47cb657335 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/intel,ce4100-l=
apic.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/intel,ce4100-l=
apic.yaml
@@ -35,6 +35,19 @@ properties:
   reg:
     maxItems: 1
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
@@ -46,4 +59,5 @@ examples:
     lapic0: interrupt-controller@fee00000 {
         compatible =3D "intel,ce4100-lapic";
         reg =3D <0xfee00000 0x1000>;
+        intel,virtual-wire-mode;
     };
--=20
2.17.1

