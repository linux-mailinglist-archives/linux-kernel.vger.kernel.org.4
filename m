Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5863863744B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 09:43:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbiKXInm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 03:43:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbiKXInf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 03:43:35 -0500
Received: from us-smtp-delivery-115.mimecast.com (us-smtp-delivery-115.mimecast.com [170.10.133.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C8E712AE2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 00:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxlinear.com;
        s=selector; t=1669279353;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OKxjoXJRVhUevg2ny6svax9/xOJH1NA1wD73iH6x5No=;
        b=jlPE16zy1/+6oBXj2yf7Bj1h24mT5oZyQM7r+pEFIDRAqJ2U8kb4jjJXGejvoJVh7l6453
        EOFy0JKUG3qc2WRL03hlPnC8sOMMrI9C4ZUY8q1OaLUyHVJxSKSVsr2H3gqdD+ehLBBObV
        Lyycte+SJB1Wf/atFHji+BCwoUs8+GBFAEeQ8zcHTBMfhvQ/lDjBflkZb0wTaNNePSmfZs
        Y4hsETFNN4Gc5j5QYV3q/2l4V7WIH5xvDCuxx4/lF5aDJYDDStB19Htw/5UAkbzs2QbJ74
        p1V9guoVKfKstaGoJab3AXJcMC6CmK7amVI4k/wBMOkc2X3lta4uCKyBAKqtOA==
Received: from mail.maxlinear.com (174-47-1-84.static.ctl.one [174.47.1.84])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 us-mta-140-D7sP0d26MK-eDxU0Y_y5qg-1; Thu, 24 Nov 2022 03:42:32 -0500
X-MC-Unique: D7sP0d26MK-eDxU0Y_y5qg-1
Received: from sgsxdev001.isng.phoenix.local (10.226.81.111) by
 mail.maxlinear.com (10.23.38.119) with Microsoft SMTP Server id 15.1.2375.24;
 Thu, 24 Nov 2022 00:42:27 -0800
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
Subject: [PATCH v5 4/4] x86/of: Add support for boot time interrupt delivery mode configuration
Date:   Thu, 24 Nov 2022 16:41:43 +0800
Message-ID: <20221124084143.21841-5-rtanwar@maxlinear.com>
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

Presently, init/boot time interrupt delivery mode is enumerated
only for ACPI enabled systems by parsing MADT table or for older
systems by parsing MP table. But for OF based x86 systems, it is
assumed & hardcoded to legacy PIC mode. This causes boot time crash
for platforms which do not use 8259 compliant legacy PIC.

Add support for configuration of init time interrupt delivery mode
for x86 OF based systems by introducing a new optional boolean
property 'intel,virtual-wire-mode' for interrupt-controller node
of local APIC. This property emulates IMCRP Bit 7 of MP feature
info byte 2 of MP floating pointer structure.

Defaults to legacy PIC mode if absent. Configures it to virtual
wire compatibility mode if present.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Rahul Tanwar <rtanwar@maxlinear.com>
---
 arch/x86/kernel/devicetree.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/devicetree.c b/arch/x86/kernel/devicetree.c
index fcc6f1b7818f..458e43490414 100644
--- a/arch/x86/kernel/devicetree.c
+++ b/arch/x86/kernel/devicetree.c
@@ -167,7 +167,14 @@ static void __init dtb_lapic_setup(void)
 =09=09=09return;
 =09}
 =09smp_found_config =3D 1;
-=09pic_mode =3D 1;
+=09if (of_property_read_bool(dn, "intel,virtual-wire-mode")) {
+=09=09pr_info("Virtual Wire compatibility mode.\n");
+=09=09pic_mode =3D 0;
+=09} else {
+=09=09pr_info("IMCR and PIC compatibility mode.\n");
+=09=09pic_mode =3D 1;
+=09}
+
 =09register_lapic_address(lapic_addr);
 }
=20
--=20
2.17.1

