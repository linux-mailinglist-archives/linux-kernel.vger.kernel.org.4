Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 575A96335FE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 08:40:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232526AbiKVHku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 02:40:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232449AbiKVHkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 02:40:33 -0500
Received: from us-smtp-delivery-115.mimecast.com (us-smtp-delivery-115.mimecast.com [170.10.133.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FEFB2CDD3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 23:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxlinear.com;
        s=selector; t=1669102773;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NIxTZz2RzC+iXQFQE7e0/V45lRrJ5i50zwbfXYW5JwA=;
        b=IsAIDmzitw9T3PISuGOEoATYC3ZrvJpZODtdTKZGxIfvrOdnlYUFCdM16dkGaunED5w3en
        SSSRzs06a9l5EUWY4UxMoaj5rzLb9eaD4+hm/FVyiZJZwzG7WW1+dNATRuwhhcNSSfrR8P
        IcActC+tGHr2tax5KZXVAVhqA0EqPBgP4L0Q6zJXwCyLAIZFpV/iEednRp/c+UF+I9T1nX
        BPdfSpRjLQAgE64ndYM6LCtlKGjDwa/kcOaWHuzZ8Be83vXYJhkQ/uT3ZvjNoOQqpJL+wN
        fZMKZS6BdEXKJfS+JGmSiFyf5QHa/dz5ZUXqWfvtBsJyrnipbU4Lx9AB3fZuHg==
Received: from mail.maxlinear.com (174-47-1-84.static.ctl.one [174.47.1.84])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 us-mta-648-F9bOVu-HOg-Z6mcJPGgXxg-1; Tue, 22 Nov 2022 02:39:30 -0500
X-MC-Unique: F9bOVu-HOg-Z6mcJPGgXxg-1
Received: from sgsxdev001.isng.phoenix.local (10.226.81.111) by
 mail.maxlinear.com (10.23.38.119) with Microsoft SMTP Server id 15.1.2375.24;
 Mon, 21 Nov 2022 23:39:26 -0800
From:   Rahul Tanwar <rtanwar@maxlinear.com>
To:     <bigeasy@linutronix.de>, <robh@kernel.org>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>, <x86@kernel.org>,
        <hpa@zytor.com>
CC:     <andriy.shevchenko@linux.intel.com>, <dave.hansen@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-lgm-soc@maxlinear.com>,
        Rahul Tanwar <rtanwar@maxlinear.com>
Subject: [PATCH v3 4/4] x86/of: Add support for boot time interrupt delivery mode configuration
Date:   Tue, 22 Nov 2022 15:39:10 +0800
Message-ID: <c62b81d5b91514e905d97e37feff6920f598e0ac.1669100394.git.rtanwar@maxlinear.com>
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
structure.

Defaults to legacy PIC mode if absent. Configures it to virtual
wire compatibility mode if present.

Fixes: 3879a6f32948 ("x86: dtb: Add early parsing of IO_APIC")
Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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

