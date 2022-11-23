Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8937C635791
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 10:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238122AbiKWJnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 04:43:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238069AbiKWJmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 04:42:17 -0500
Received: from us-smtp-delivery-115.mimecast.com (us-smtp-delivery-115.mimecast.com [170.10.129.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A3F382BC2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 01:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxlinear.com;
        s=selector; t=1669196328;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Mc2NS0olCt0qUzsLi0zWfYaDeL0jAmHwQjCqJZ5SsT8=;
        b=An+fYJ1ak9yv+HUO0ga2BpCsZPO9Df4pTvxFghvP0cW+824ALgkMGhicTZYJmSsrjo8JUb
        n/AalJCBwe7cUsK6gN6bpL9fE6QQNEJVeCulSGGy7/y0Q+uS30bz3vHHvUUnwReV6I9CpG
        gnDyCXKPOxnxoPZ+yHwg/eg8WuOY7iKvSz5fOymXM7/jG7+rksyPkuuJpCAmO2BlKTVtw0
        IhcAhG2H7JDhflKokTTm2H4jg1KkPSV6bsjA4HT3yGKQF3+PmhmfNh5fqIVtkUfHe8/fGE
        ciJ+2v/1G3CDfGY3CWfqUXQpn7HbEO4buyJiNWYEMS2RpMTpJWTVujB4ji+30A==
Received: from mail.maxlinear.com (174-47-1-83.static.ctl.one [174.47.1.83])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 us-mta-665-BZZ1RMddN-WSVjCg2PoA3Q-1; Wed, 23 Nov 2022 04:38:47 -0500
X-MC-Unique: BZZ1RMddN-WSVjCg2PoA3Q-1
Received: from sgsxdev001.isng.phoenix.local (10.226.81.111) by
 mail.maxlinear.com (10.23.38.120) with Microsoft SMTP Server id 15.1.2375.24;
 Wed, 23 Nov 2022 01:38:39 -0800
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
        "H. Peter Anvin" <hpa@zytor.com>, <linux-lgm-soc@maxlinear.com>
Subject: [PATCH v4 4/4] x86/of: Add support for boot time interrupt delivery mode configuration
Date:   Wed, 23 Nov 2022 17:38:20 +0800
Message-ID: <20221123093820.21161-5-rtanwar@maxlinear.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221123093820.21161-1-rtanwar@maxlinear.com>
References: <20221123093820.21161-1-rtanwar@maxlinear.com>
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

