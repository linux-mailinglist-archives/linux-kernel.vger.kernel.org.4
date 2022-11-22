Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4937A6335FD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 08:40:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232491AbiKVHkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 02:40:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232448AbiKVHk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 02:40:28 -0500
Received: from us-smtp-delivery-115.mimecast.com (us-smtp-delivery-115.mimecast.com [170.10.133.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 093FC17589
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 23:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxlinear.com;
        s=selector; t=1669102765;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uGSJ7DPtFsorciAkWhHmN4hRW1hAr3Y9mVSmMvM8cgs=;
        b=OXwjCA8EU08bfMp/IWSWlK4upsCRm/k6RIu1R08bvQCjppyapAmg+AoGCCIQ9/NEnJSruj
        IGqHtaieGnHWi+HRge5KmC84vPfNPlPxL8F1ehyAUTxhxhA8n9IbNeiq6s1MTKSFKRQfRV
        lksnnx3ozgi960jJK2Nc78YOFSKUo/fRMossnVAXB8QuZhS266tUBBsWL+CzhG+e2D92sl
        Xvk4wiAl8SFJB5kuaZDrp2g71JsPO7serhn4wO4CGZKAeP6MwJ43zvU9uaV7xJY73fFZwf
        ROYSsj3iKVRHgqZDANMVmajNkJ3WdE+FvSWtuetAySH1sFRry9skWMvH/tjeyQ==
Received: from mail.maxlinear.com (174-47-1-84.static.ctl.one [174.47.1.84])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 us-mta-564-hiVtk4evPvGvvH9_C1TAOw-1; Tue, 22 Nov 2022 02:39:24 -0500
X-MC-Unique: hiVtk4evPvGvvH9_C1TAOw-1
Received: from sgsxdev001.isng.phoenix.local (10.226.81.111) by
 mail.maxlinear.com (10.23.38.119) with Microsoft SMTP Server id 15.1.2375.24;
 Mon, 21 Nov 2022 23:39:20 -0800
From:   Rahul Tanwar <rtanwar@maxlinear.com>
To:     <bigeasy@linutronix.de>, <robh@kernel.org>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>, <x86@kernel.org>,
        <hpa@zytor.com>
CC:     <andriy.shevchenko@linux.intel.com>, <dave.hansen@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-lgm-soc@maxlinear.com>,
        Rahul Tanwar <rtanwar@maxlinear.com>
Subject: [PATCH v3 2/4] x86/of: Introduce new optional bool property for lapic
Date:   Tue, 22 Nov 2022 15:39:08 +0800
Message-ID: <b20a2ddb59327962de430e259a7be154132d6e9a.1669100394.git.rtanwar@maxlinear.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1669100394.git.rtanwar@maxlinear.com>
References: <cover.1669100394.git.rtanwar@maxlinear.com>
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
index d4b99bf7bf6e..087f849e31ef 100644
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

