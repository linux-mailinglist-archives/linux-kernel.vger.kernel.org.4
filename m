Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6FF16335FB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 08:40:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232473AbiKVHkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 02:40:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232429AbiKVHkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 02:40:23 -0500
Received: from us-smtp-delivery-115.mimecast.com (us-smtp-delivery-115.mimecast.com [170.10.129.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A18282F02B
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 23:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxlinear.com;
        s=selector; t=1669102769;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XtiwGqXBFxhLlETvxktwt1UqNvSglqTHBPfqfwhsYIM=;
        b=UcP263p6N2TG1BS4XSgvYyUErTmv6YA8VCzKnX4jKwyY49R+zQ/dYeYllwvYObWST3djcb
        XfbT/2DS0pje3R7oCXETGoaeVtF+2/TL5PI34Ay/oUdAQEMuT1g8Wlxu3/pDkoKAEGw6Be
        cLFSYPK5vFyVIVNgF02U8NCgIhrKvvu8ttMJHfGaAa8ZeBeFAz8kB2EGeobdm6KrCF5OP5
        RkAB/2GiBQJND7+XVPsmvm8l2f3b8PKpqazkPmBIx9iyp69gelEG1bYfK3GBQzZdHZ/NsK
        ccK3XWglzWqjszV23xHAu34VodndVs/7QGBHlCdMoeZu3RbSvGlQxjp9zlZN3g==
Received: from mail.maxlinear.com (174-47-1-84.static.ctl.one [174.47.1.84])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 us-mta-403-ZD30hwUhOOCueD0AViRi6g-1; Tue, 22 Nov 2022 02:39:27 -0500
X-MC-Unique: ZD30hwUhOOCueD0AViRi6g-1
Received: from sgsxdev001.isng.phoenix.local (10.226.81.111) by
 mail.maxlinear.com (10.23.38.119) with Microsoft SMTP Server id 15.1.2375.24;
 Mon, 21 Nov 2022 23:39:23 -0800
From:   Rahul Tanwar <rtanwar@maxlinear.com>
To:     <bigeasy@linutronix.de>, <robh@kernel.org>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>, <x86@kernel.org>,
        <hpa@zytor.com>
CC:     <andriy.shevchenko@linux.intel.com>, <dave.hansen@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-lgm-soc@maxlinear.com>,
        Rahul Tanwar <rtanwar@maxlinear.com>
Subject: [PATCH v3 3/4] x86/of: Replace printk(KERN_LVL) with pr_lvl()
Date:   Tue, 22 Nov 2022 15:39:09 +0800
Message-ID: <64a905649accf1b68f03c31a9b6ce205b03c6703.1669100394.git.rtanwar@maxlinear.com>
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

Use latest available pr_lvl() instead of older printk(KERN_LVL)
Just a upgrade of print utilities usage no functional changes.

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

