Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90D266278E9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 10:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236712AbiKNJVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 04:21:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236421AbiKNJVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 04:21:23 -0500
Received: from us-smtp-delivery-115.mimecast.com (us-smtp-delivery-115.mimecast.com [170.10.129.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A154FE0C7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 01:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxlinear.com;
        s=selector; t=1668417619;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YgauXixAJJD9XtFDMaahyOPCpv34fcIn9lLW9e+Ynmc=;
        b=I0ZaDDgxWT3olqzTC5InMn8OBB+lpfHlIHdS8g7FsIHM2DksUc+Ddsi4zRFtwsmJfgoJVO
        GwmFRjU+8u/J4Kqhtq0z6N+I0BcYrwQGWhljiOOPimYHgDv/HqtD47gcJbEAhUOPnLr5Yz
        EdnaGIqFqk0bDNc1rQllF9O8Zn30eAQuw5ss0LLo7j2tWvIz2b3QARxu2NXNW7FVtC3yDp
        D2Nh9cggkL7Oc0k+JLMF33SqVTxtzdSVnjvAdXvzzU1NGDQ34KIy4xMkfFnVB30dQAnymf
        N0/+9gUViJKM3jga1UCsvvLj4fDQ3Ty1iTNXQvG2/3rj2wo/9BFIQa/b/EbvOQ==
Received: from mail.maxlinear.com (174-47-1-83.static.ctl.one [174.47.1.83])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 us-mta-185-dNQ69yRpNIGhgA6xj5F7cw-1; Mon, 14 Nov 2022 04:20:18 -0500
X-MC-Unique: dNQ69yRpNIGhgA6xj5F7cw-1
Received: from sgsxdev001.isng.phoenix.local (10.226.81.111) by
 mail.maxlinear.com (10.23.38.120) with Microsoft SMTP Server id 15.1.2375.24;
 Mon, 14 Nov 2022 01:20:13 -0800
From:   Rahul Tanwar <rtanwar@maxlinear.com>
To:     <bigeasy@linutronix.de>, <robh@kernel.org>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>, <x86@kernel.org>,
        <hpa@zytor.com>
CC:     <andriy.shevchenko@linux.intel.com>, <dave.hansen@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-lgm-soc@maxlinear.com>,
        Rahul Tanwar <rtanwar@maxlinear.com>
Subject: [PATCH RESEND 1/1] x86/of: Add support for boot time interrupt mode config
Date:   Mon, 14 Nov 2022 17:20:06 +0800
Message-ID: <37cc31242d0edda1bb0900cc62bba87954a7e892.1668403214.git.rtanwar@maxlinear.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1668403214.git.rtanwar@maxlinear.com>
References: <cover.1668403214.git.rtanwar@maxlinear.com>
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

Presently, init/boot time interrupt delivery mode is enumerated only
for ACPI enabled systems by parsing MADT table or for older systems
by parsing MP table. But for OF based x86 systems, it is assumed &
fixed to legacy PIC mode.

Add support for configuration of init time interrupt delivery mode for
x86 OF based systems by introducing a new optional boolean property
'intel,no-imcr' for interrupt-controller node of local APIC. This
property emulates IMCRP Bit 7 of MP feature info byte 2 of MP
floating pointer structure.

Defaults to legacy PIC mode if absent. Configures it to virtual wire
compatibility mode if present.

Fixes: 3879a6f329483 ("x86: dtb: Add early parsing of IO_APIC")
Signed-off-by: Rahul Tanwar <rtanwar@maxlinear.com>
---
 arch/x86/kernel/devicetree.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/devicetree.c b/arch/x86/kernel/devicetree.c
index 5cd51f25f446..1e4ed420478b 100644
--- a/arch/x86/kernel/devicetree.c
+++ b/arch/x86/kernel/devicetree.c
@@ -167,7 +167,14 @@ static void __init dtb_lapic_setup(void)
 =09=09=09return;
 =09}
 =09smp_found_config =3D 1;
-=09pic_mode =3D 1;
+=09if (of_property_read_bool(dn, "intel,no-imcr")) {
+=09=09pr_info("    Virtual Wire compatibility mode.\n");
+=09=09pic_mode =3D 0;
+=09} else {
+=09=09pr_info("    IMCR and PIC compatibility mode.\n");
+=09=09pic_mode =3D 1;
+=09}
+
 =09register_lapic_address(lapic_addr);
 }
=20
--=20
2.17.1

