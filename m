Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3C55B6A46
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 11:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbiIMJGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 05:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbiIMJGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 05:06:33 -0400
Received: from us-smtp-delivery-115.mimecast.com (us-smtp-delivery-115.mimecast.com [170.10.133.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A601D55095
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 02:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxlinear.com;
        s=selector; t=1663059990;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=mTAKWZxrTR4aLotQeR306wv06XVq5Q1W4FyW8YJ7oiU=;
        b=SoSzNACoWlcQYTS44NAj5ZfdG8zlNx1kC46r2aEJGlt5X+yQYD3ILTX59RYKfTDdj8XmfY
        gmt0A6Zrtml0Ik/hTwTej0tc2I5zVzltyBpS/f6Rk4gjLUVtkU5g2SX2lu5qDEpvrR4uK1
        RjLee9i5wfiBG0gJOAXXZnvT8/JDOzA9vsDIrThi/fZa/yNIo5HTnd3tlsbA/WgEg73Z3X
        PKnkP/7AAm3NIcyU8dDRGCXRP/LXGgoVCc0gow/KMJ5RCDp9qwaBm9p9cme6S5o0JhJQ4V
        i/qHKa2dopXAARy3cIb3OX1Xe+BaSTES6T9HTTmJ+05jCgeX5VZ4Re7gB9pPhQ==
Received: from mail.maxlinear.com (174-47-1-83.static.ctl.one [174.47.1.83])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 us-mta-608-xsSsPUECPFOa3iDlInHszw-1; Tue, 13 Sep 2022 05:06:28 -0400
X-MC-Unique: xsSsPUECPFOa3iDlInHszw-1
Received: from sgsxdev001.isng.phoenix.local (10.226.81.111) by
 mail.maxlinear.com (10.23.38.120) with Microsoft SMTP Server id 15.1.2375.24;
 Tue, 13 Sep 2022 02:06:24 -0700
From:   Rahul Tanwar <rtanwar@maxlinear.com>
To:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <hpa@zytor.com>,
        <linux-lgm-soc@maxlinear.com>, Rahul Tanwar <rtanwar@maxlinear.com>
Subject: [PATCH] x86/devicetree: Add support for boot time interrupt mode config
Date:   Tue, 13 Sep 2022 17:06:20 +0800
Message-ID: <20220913090620.9193-1-rtanwar@maxlinear.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: maxlinear.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Presently, init/boot time interrupt delivery mode is enumerated only
for ACPI enabled systems by parsing MADT table or for older systems
by parsing MP table. But for OF based x86 systems, it is assumed &
fixed to legacy PIC mode.

Add support for configuration of init time interrupt delivery mode
for x86 OF based systems by introducing a new boolean property
'intel,no-imcr' for interrupt-controller node of local APIC. This
property emulates IMCRP Bit 7 of MP feature info byte 2 of MP
floating pointer structure.

Defaults to legacy PIC mode if absent. Configures it to virtual wire
compatibility mode if present.

Signed-off-by: Rahul Tanwar <rtanwar@maxlinear.com>
---
 arch/x86/kernel/devicetree.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/devicetree.c b/arch/x86/kernel/devicetree.c
index 5cd51f25f446..de14015317f8 100644
--- a/arch/x86/kernel/devicetree.c
+++ b/arch/x86/kernel/devicetree.c
@@ -167,7 +167,15 @@ static void __init dtb_lapic_setup(void)
 =09=09=09return;
 =09}
 =09smp_found_config =3D 1;
-=09pic_mode =3D 1;
+=09if (of_property_read_bool(dn, "intel,no-imcr")) {
+=09=09pr_info("    Virtual Wire compatibility mode.\n");
+=09=09pic_mode =3D 0;
+=09}
+=09else {
+=09=09pr_info("    IMCR and PIC compatibility mode.\n");
+=09=09pic_mode =3D 1;
+=09}
+
 =09register_lapic_address(lapic_addr);
 }
=20
--=20
2.17.1

