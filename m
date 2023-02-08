Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1163068E6DD
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 04:55:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjBHDzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 22:55:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbjBHDzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 22:55:11 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3608225E33
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 19:55:00 -0800 (PST)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1675828499;
        bh=SpstDqt0CVoivg8O2mX9Ce1hhNyx5bUIE+CCPz8ERM8=;
        h=From:Date:Subject:To:Cc:From;
        b=S3KcXh7Wwf51lk38hXH6toBSLdymB+O6LWglGClP1qGUOUlesoBM0ScsBF/Ws6FGu
         UgS/10oQSd5cBWNM2VOnMGZy0j+t1wO6oHXJJMytB87eUY95AudPFKLyJlgc0lQjSm
         VOe/xeo8PnbLgYY216HOuihmyymZ4idovRPivL3M=
Date:   Wed, 08 Feb 2023 03:54:51 +0000
Subject: [PATCH] samples/kobject: make kobj_type structure constant
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230208-kobj_type-samples-v1-1-fca804a8e9f3@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAAod42MC/x2NWwrCMBAAr1L224UkxUe8iogkcbWrMQ1ZLZXSu
 7v4OQPDLCDUmASO3QKNJhYei4LddJCGUO6EfFUGZ1xvnDngc4yPy/tbCSW8aiZB62lvvPXbtOt
 BuxiEMLZQ0qBl+eSssja68fwfnc7r+gPxfeuIeAAAAA==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1675828492; l=1142;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=SpstDqt0CVoivg8O2mX9Ce1hhNyx5bUIE+CCPz8ERM8=;
 b=So23VyrNc86c+AmVQARlvFVaPzwAx043mUOIUTrKQ2eV5gDLyYPUP5VehJT65o6v3P0WnWVLO
 MGVBON7xuo6ArQVxVp/puGy4ti1bdcRZOP+dEgfHvvPzNb1zsFEylJU
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

Take advantage of this to constify the structure definition to prevent
modification at runtime.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 samples/kobject/kset-example.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/kobject/kset-example.c b/samples/kobject/kset-example.c
index 52f1acabd479..342452282719 100644
--- a/samples/kobject/kset-example.c
+++ b/samples/kobject/kset-example.c
@@ -185,7 +185,7 @@ ATTRIBUTE_GROUPS(foo_default);
  * release function, and the set of default attributes we want created
  * whenever a kobject of this type is registered with the kernel.
  */
-static struct kobj_type foo_ktype = {
+static const struct kobj_type foo_ktype = {
 	.sysfs_ops = &foo_sysfs_ops,
 	.release = foo_release,
 	.default_groups = foo_default_groups,

---
base-commit: 0983f6bf2bfc0789b51ddf7315f644ff4da50acb
change-id: 20230208-kobj_type-samples-19e709195c63

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

