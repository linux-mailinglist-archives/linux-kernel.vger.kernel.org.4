Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 570DD62B911
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 11:38:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233798AbiKPKh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 05:37:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233471AbiKPKff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 05:35:35 -0500
Received: from us-smtp-delivery-115.mimecast.com (us-smtp-delivery-115.mimecast.com [170.10.129.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0BC46429
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 02:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxlinear.com;
        s=selector; t=1668594517;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o2vFFZj0asvM/eG5j2z+UIf5OoA8cJ4FO5LVI46RoA8=;
        b=N0abli5il4jQti6/qWePPd61pmJvXpK7xK+Fz02GMpH8L2IdXROtZVL9ubERZxdec5HTWe
        O7PAiUEMqaw8vA3A3MAHUQI9i3uC1nmdaEVlDxIcalCfN4lK1mKrmd3JWxCNcGFDmGIEV7
        10ieYA44yIx+tJoarnmlDfHnuvn+zXumCT0yNW2S1k3oreQKlPh7r5h0vtZPuZES/UDiuF
        OL/S0QEJ0WDrQcb5w9e2ktFkLHbzFZ+3HGwZsWGhCK+XV12C9pEDrS6Lg+pAnk+V3VdBWJ
        SSdt0ZbmFTwxwIIhxc/GEML35i4LidMexRubYvacgZ7AJtMf1uq4YFVZ1cEoHQ==
Received: from mail.maxlinear.com (174-47-1-83.static.ctl.one [174.47.1.83])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 us-mta-119-9UH-ool9MTCCl9vGZhfhXQ-1; Wed, 16 Nov 2022 05:28:36 -0500
X-MC-Unique: 9UH-ool9MTCCl9vGZhfhXQ-1
Received: from sgsxdev001.isng.phoenix.local (10.226.81.111) by
 mail.maxlinear.com (10.23.38.120) with Microsoft SMTP Server id 15.1.2375.24;
 Wed, 16 Nov 2022 02:28:30 -0800
From:   Rahul Tanwar <rtanwar@maxlinear.com>
To:     <devicetree@vger.kernel.org>, <robh@kernel.org>,
        <andriy.shevchenko@linux.intel.com>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <hpa@zytor.com>,
        <alan@lxorguk.ukuu.org.uk>, <dirk.brandewie@gmail.com>,
        <grant.likely@secretlab.ca>, <sodaville@linutronix.de>,
        <devicetree-discuss@lists.ozlabs.org>,
        <linux-lgm-soc@maxlinear.com>,
        "Rahul Tanwar" <rtanwar@maxlinear.com>
Subject: [PATCH v2 1/2] x86/of: Add support for boot time interrupt delivery mode configuration
Date:   Wed, 16 Nov 2022 18:28:20 +0800
Message-ID: <9114810c7af7fbaf9d0b2823752afcef865bdda0.1668589253.git.rtanwar@maxlinear.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1668589253.git.rtanwar@maxlinear.com>
References: <cover.1668589253.git.rtanwar@maxlinear.com>
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

Presently, init/boot time interrupt delivery mode is enumerated
only for ACPI enabled systems by parsing MADT table or for older
systems by parsing MP table. But for OF based x86 systems, it is
assumed & hardcoded to legacy PIC mode. This is a bug for
platforms which are OF based but do not use 8259 compliant legacy
PIC interrupt controller. Such platforms can not even boot because
of this bug/hardcoding.

Fix this bug by adding support for configuration of init time
interrupt delivery mode for x86 OF based systems by introducing a
new optional boolean property 'intel,virtual-wire-mode' for
interrupt-controller node of local APIC. This property emulates
IMCRP Bit 7 of MP feature info byte 2 of MP floating pointer
structure [1].

Defaults to legacy PIC mode if absent. Configures it to virtual
wire compatibility mode if present.

[1] https://www.manualslib.com/manual/77733/Intel-Multiprocessor.html?page=
=3D40#manual

Fixes: 3879a6f329483 ("x86: dtb: Add early parsing of IO_APIC")
Signed-off-by: Rahul Tanwar <rtanwar@maxlinear.com>
---
 arch/x86/kernel/devicetree.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/devicetree.c b/arch/x86/kernel/devicetree.c
index 5cd51f25f446..2a8833f0f6ae 100644
--- a/arch/x86/kernel/devicetree.c
+++ b/arch/x86/kernel/devicetree.c
@@ -167,7 +167,14 @@ static void __init dtb_lapic_setup(void)
 =09=09=09return;
 =09}
 =09smp_found_config =3D 1;
-=09pic_mode =3D 1;
+=09if (of_property_read_bool(dn, "intel,virtual-wire-mode")) {
+=09=09printk(KERN_NOTICE "Virtual Wire compatibility mode.\n");
+=09=09pic_mode =3D 0;
+=09} else {
+=09=09printk(KERN_NOTICE "IMCR and PIC compatibility mode.\n");
+=09=09pic_mode =3D 1;
+=09}
+
 =09register_lapic_address(lapic_addr);
 }
=20
--=20
2.17.1

