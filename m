Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 190F76AB967
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 10:12:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbjCFJMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 04:12:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjCFJMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 04:12:18 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F273022A08;
        Mon,  6 Mar 2023 01:12:17 -0800 (PST)
Date:   Mon, 06 Mar 2023 09:12:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1678093936;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cPqol8GguYxpQaSlhqCPqr6CbtzNeeDD6oAyW1y2hbA=;
        b=HdZvp+3kXRmwPfzSNcPXFWMrekFwyI7Q8plsCHF/phdRhJmlbrKzYrMXFI3bjqxzGx7sRr
        8OCGjjDnHKG5mSVqTUEZro/2TqCryP1im36ZOwJ8TVo6M4dNXyGaaYY8dnGKDblTX2zisl
        pWmmwrQ82t7SKkD8BE3OizAOfaQbvpyYnMmpOnpREHxp/FOIDuv4mY5NDzcy0GKu8n+Bck
        Kz4tmDZYLbdbIZqq1WqYbuB50QbwsU2wNXVHLIoq6dKiw4XmfUjFIYyKHnHGzcceCPBJg6
        4993/NiEIBvgn5IlxNHU+G1cKa/y2TUG7i15J3L4acXQmQB4h2er0LNukxZnKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1678093936;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cPqol8GguYxpQaSlhqCPqr6CbtzNeeDD6oAyW1y2hbA=;
        b=R16gBApjqTZp2yvHr+kdlNCtgOqBE742n6rYycr9x3GGiZjtMw6GiwO+OY9Ad0x76SHHrX
        wnqxr2AkFigbabAA==
From:   tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= 
        <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/MCE/AMD: Make kobj_type structure constant
Cc:     linux@weissschuh.net, "Borislav Petkov (AMD)" <bp@alien8.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230217-kobj_type-mce-amd-v1-1-40ef94816444@weissschuh.net>
References: <20230217-kobj_type-mce-amd-v1-1-40ef94816444@weissschuh.net>
MIME-Version: 1.0
Message-ID: <167809393567.5837.232629854886011130.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     7214b32b6f4c6c1385a52f2e3a7107f28349f505
Gitweb:        https://git.kernel.org/tip/7214b32b6f4c6c1385a52f2e3a7107f2834=
9f505
Author:        Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
AuthorDate:    Fri, 17 Feb 2023 03:20:05=20
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 06 Mar 2023 09:57:27 +01:00

x86/MCE/AMD: Make kobj_type structure constant

Since

  ee6d3dd4ed48 ("driver core: make kobj_type constant.")

the driver core allows the usage of const struct kobj_type.

Take advantage of this to constify the structure definition to prevent
modification at runtime.

Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230217-kobj_type-mce-amd-v1-1-40ef94816444@=
weissschuh.net
---
 arch/x86/kernel/cpu/mce/amd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 23c5072..4881893 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -1029,7 +1029,7 @@ static const struct sysfs_ops threshold_ops =3D {
=20
 static void threshold_block_release(struct kobject *kobj);
=20
-static struct kobj_type threshold_ktype =3D {
+static const struct kobj_type threshold_ktype =3D {
 	.sysfs_ops		=3D &threshold_ops,
 	.default_groups		=3D default_groups,
 	.release		=3D threshold_block_release,
