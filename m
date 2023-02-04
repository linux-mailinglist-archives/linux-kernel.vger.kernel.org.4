Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8771168ACC1
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 23:00:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232640AbjBDWAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 17:00:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjBDWAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 17:00:02 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B012CCA26
        for <linux-kernel@vger.kernel.org>; Sat,  4 Feb 2023 14:00:01 -0800 (PST)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1675547999;
        bh=7y7U1qOcltVJ2tfalW2ml1UrIkc+ofbrHRaIuFqXAps=;
        h=From:Date:Subject:To:Cc:From;
        b=dHFQQkQfYf9QPVobGz3m5iigRqml7jXohwMqsv7RqNYFAp2yAfPc5ofdIEYyZzd0+
         qaZs44ZdmKXj0rNvs84hJgGZpG5uM2Jm7h+M5pBD+DUoW+exD65D3eYzyuWacKEdxk
         jr6bkieVzvMaMyMaWWl49jScctG8LREOLcn5CTs0=
Date:   Sat, 04 Feb 2023 21:59:50 +0000
Subject: [PATCH] kobject: make dynamic_kobj_ktype and kset_ktype const
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230204-kobj_type-kobj-v1-1-ddd1b4ef8ab5@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAFXV3mMC/x2NUQqDMBAFryL73UAShUKvUkrJJhuzrURJVBTx7
 i7+vXkwzAGVClOFV3NAoZUrj1nAPBrwyeWeFAdhsNq22upO/Uf8fed9onupYKK23dMgOg8ioau
 ksLjsk2h5GQY5p0KRt7vy/pznBWjHEPF1AAAA
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1675547994; l=1300;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=7y7U1qOcltVJ2tfalW2ml1UrIkc+ofbrHRaIuFqXAps=;
 b=Yf+tb+kj4PeLZn7wqiKjPexPiuxGW3/fiyThWaXu2hIHwQEQgAXeG6tTZf0R6Xr3TlG6pS4kJ
 azTjVuCmhNfBl56O/NQsdQcjlgEVIn4iGmToDxd4pf1r7e7PmzKos5d
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit ee6d3dd4ed48 ("driver core: make kobj_type constant.")
the driver core allows the usage of const struct kobj_type.

Take advantage of this to constify the structure definitions to prevent
modification at runtime.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 lib/kobject.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/kobject.c b/lib/kobject.c
index 985ee1c4f2c6..52e2f9634f61 100644
--- a/lib/kobject.c
+++ b/lib/kobject.c
@@ -729,7 +729,7 @@ static void dynamic_kobj_release(struct kobject *kobj)
 	kfree(kobj);
 }
 
-static struct kobj_type dynamic_kobj_ktype = {
+static const struct kobj_type dynamic_kobj_ktype = {
 	.release	= dynamic_kobj_release,
 	.sysfs_ops	= &kobj_sysfs_ops,
 };
@@ -913,7 +913,7 @@ static void kset_get_ownership(const struct kobject *kobj, kuid_t *uid, kgid_t *
 		kobject_get_ownership(kobj->parent, uid, gid);
 }
 
-static struct kobj_type kset_ktype = {
+static const struct kobj_type kset_ktype = {
 	.sysfs_ops	= &kobj_sysfs_ops,
 	.release	= kset_release,
 	.get_ownership	= kset_get_ownership,

---
base-commit: db27c22251e7c8f3a9d5bfb55c9c8c701a70bbb3
change-id: 20230204-kobj_type-kobj-d1f02471bbac

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

