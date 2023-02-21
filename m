Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD15269E1E1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 15:03:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234248AbjBUODQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 09:03:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234187AbjBUODO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 09:03:14 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA0040FE;
        Tue, 21 Feb 2023 06:03:13 -0800 (PST)
Date:   Tue, 21 Feb 2023 14:03:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676988192;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UMnIRuFdhYzLuCZJ0NnS3LeyrPS5DkHSs+EhmjHTZuY=;
        b=fP1p12QJehd1VP58RW9lWFh5MMchsXM7XdLFkZQtbDhRSzkoddCFPAxb+zmCwEDUGeiYqJ
        c0uy1uFBgfCzXUW+XmwmOXsl0HglsSoV4ZI/IiGhA9YfrWqXVr4Zmj/OgFQ7fm3z9FYEy/
        OKwAN97dSyMnyLnQZogyxr4ogFlj04APhAfAcss/xkqAwP+NTQqP/GJOzM0uwCrG7M5xdl
        1w0TbjiWsQnMjldsAXnh0Ufr+IZLw+xa4LPQ+uZEBWPKGYLZb4ch+vgbxHuTFNkLF6YVzM
        h3iZHbQJ2HSH7av9t5ornTpkx5BcYu9SoT0Bl5PJmeN0cieo4c+1uDi47kMn6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676988192;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UMnIRuFdhYzLuCZJ0NnS3LeyrPS5DkHSs+EhmjHTZuY=;
        b=p3tAXzAJX5QhYFIYu2RAa0aYxNgqJIiwpXr+no9JjT1M9T8tCnKeayfPQgk5et4W4lt80Q
        KwLQd4SV6XGytjDg==
From:   tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= 
        <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] genirq/irqdesc: Make kobj_type structures constant
Cc:     linux@weissschuh.net, Thomas Gleixner <tglx@linutronix.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20230217-kobj_type-irq-v1-1-fedfacaf8cdb@weissschuh.net>
References: <20230217-kobj_type-irq-v1-1-fedfacaf8cdb@weissschuh.net>
MIME-Version: 1.0
Message-ID: <167698819179.387.6141249909545840649.tip-bot2@tip-bot2>
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

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     ce7980ae9080f72f08d50355c4d9084d57aece63
Gitweb:        https://git.kernel.org/tip/ce7980ae9080f72f08d50355c4d9084d57a=
ece63
Author:        Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
AuthorDate:    Fri, 17 Feb 2023 03:16:25=20
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 21 Feb 2023 15:00:09 +01:00

genirq/irqdesc: Make kobj_type structures constant

Since commit ee6d3dd4ed48 ("driver core: make kobj_type constant.")
the driver core allows the usage of const struct kobj_type.

Take advantage of this to constify the structure definitions which prevents
modification at runtime.

Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20230217-kobj_type-irq-v1-1-fedfacaf8cdb@weis=
sschuh.net

---
 kernel/irq/irqdesc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index fd09962..240e145 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -277,7 +277,7 @@ static struct attribute *irq_attrs[] =3D {
 };
 ATTRIBUTE_GROUPS(irq);
=20
-static struct kobj_type irq_kobj_type =3D {
+static const struct kobj_type irq_kobj_type =3D {
 	.release	=3D irq_kobj_release,
 	.sysfs_ops	=3D &kobj_sysfs_ops,
 	.default_groups =3D irq_groups,
@@ -335,7 +335,7 @@ postcore_initcall(irq_sysfs_init);
=20
 #else /* !CONFIG_SYSFS */
=20
-static struct kobj_type irq_kobj_type =3D {
+static const struct kobj_type irq_kobj_type =3D {
 	.release	=3D irq_kobj_release,
 };
=20
