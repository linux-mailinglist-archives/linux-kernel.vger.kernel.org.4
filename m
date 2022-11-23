Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5988A6359C2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 11:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236350AbiKWKZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 05:25:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236252AbiKWKYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 05:24:46 -0500
Received: from us-smtp-delivery-115.mimecast.com (us-smtp-delivery-115.mimecast.com [170.10.129.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C65604F193
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 02:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxlinear.com;
        s=selector; t=1669198153;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AkBrFNa8JXU1rnG3IW0QD6QbjBzAOYoAULmyjQGwhog=;
        b=IeCorsSJOr+y1m9i+1yGIXKnlBTIrga/aKFaCx0deRDSObEoC7YJlfWlpIVMHH9mIn0zhx
        bJMEo5v3FW3ZAZ3b6xIjlwJQC19MKcr1C0fTyHEb0W8GVsdPYx1R3E6WGbWCXfBPIO/G8V
        WWCRBPy/pqkjaLMzYBs7aaCT+pSMUhl9RyBNeqgnagQyUz0NzVnixaMX/9Wz6ojqIF7UlH
        AWHtOXPeeNOI4vIORfbKWAOM6rWV1xTguTULLbWV+YnPBa1FkCgO7ZuaoPbNUI0eW8xf/O
        3sU41tQ2OIkVYyf8tx5zVXgtHtrnXLNM1Ok9ojKkIFDauAimG+Fv4Zf7eOy8rA==
Received: from mail.maxlinear.com (174-47-1-84.static.ctl.one [174.47.1.84])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 us-mta-121-HwGyz1NYO-ua-wzc3aoVTA-1; Wed, 23 Nov 2022 05:09:12 -0500
X-MC-Unique: HwGyz1NYO-ua-wzc3aoVTA-1
Received: from sgsxdev001.isng.phoenix.local (10.226.81.111) by
 mail.maxlinear.com (10.23.38.119) with Microsoft SMTP Server id 15.1.2375.24;
 Wed, 23 Nov 2022 02:09:04 -0800
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
Subject: [PATCH v4 3/4] x86/of: Replace printk(KERN_LVL) with pr_lvl()
Date:   Wed, 23 Nov 2022 18:08:49 +0800
Message-ID: <20221123100850.22969-4-rtanwar@maxlinear.com>
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use latest available pr_lvl() instead of older printk(KERN_LVL)
Just a upgrade of print utilities usage no functional changes.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Rahul Tanwar <rtanwar@maxlinear.com>
---
 arch/x86/kernel/devicetree.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/devicetree.c b/arch/x86/kernel/devicetree.c
index 5cd51f25f446..fcc6f1b7818f 100644
--- a/arch/x86/kernel/devicetree.c
+++ b/arch/x86/kernel/devicetree.c
@@ -248,7 +248,7 @@ static void __init dtb_add_ioapic(struct device_node *d=
n)
=20
 =09ret =3D of_address_to_resource(dn, 0, &r);
 =09if (ret) {
-=09=09printk(KERN_ERR "Can't obtain address from device node %pOF.\n", dn)=
;
+=09=09pr_err("Can't obtain address from device node %pOF.\n", dn);
 =09=09return;
 =09}
 =09mp_register_ioapic(++ioapic_id, r.start, gsi_top, &cfg);
@@ -265,7 +265,7 @@ static void __init dtb_ioapic_setup(void)
 =09=09of_ioapic =3D 1;
 =09=09return;
 =09}
-=09printk(KERN_ERR "Error: No information about IO-APIC in OF.\n");
+=09pr_err("Error: No information about IO-APIC in OF.\n");
 }
 #else
 static void __init dtb_ioapic_setup(void) {}
--=20
2.17.1

