Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51EA6691CA2
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 11:24:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231764AbjBJKYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 05:24:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbjBJKYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 05:24:21 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CC3B6C7FC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 02:24:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 74577CE272C
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 10:24:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E858C433A4;
        Fri, 10 Feb 2023 10:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1676024651;
        bh=0hdsET54CaVYW45VsXim3ULKaluWSvH8kT2ZvUX73XY=;
        h=From:To:Cc:Subject:Date:From;
        b=wchrfjvK/7aEo4sSshodTstbHwdO4zb/DKjL6eI9IV9ro3L6w7kgqvrPC/2prG97Q
         PKM3Y3C4FDe5ood0nOxSEOXqQPWo84QUe84ekr0lbqGV1cyRimYfANpWi98R+EQngT
         ySWX0o4wrDIo6n3L+LsWj0zfsT/fqMV92WjCgsPo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH] driver core: cpu: don't hand-override the uevent bus_type callback.
Date:   Fri, 10 Feb 2023 11:24:08 +0100
Message-Id: <20230210102408.1083177-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2071; i=gregkh@linuxfoundation.org; h=from:subject; bh=0hdsET54CaVYW45VsXim3ULKaluWSvH8kT2ZvUX73XY=; b=owGbwMvMwCRo6H6F97bub03G02pJDMnPpF3vOt7+bhx2ylFzgniect6rn1v3Xfz7Ot1/5WvJU7Nc fLqMOmJYGASZGGTFFFm+bOM5ur/ikKKXoe1pmDmsTCBDGLg4BWAiU3YzLLikFf5l2Wy2Sbrs/nbyDh csJb//NmCYsf7YglV8y5YJrZGflxndpLiPU+MNAA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of having to change the uevent bus_type callback by hand at
runtime, set it at build time based on the build configuration options,
making this much simpler to maintain and understand (and allow to make
the structure constant.)

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/cpu.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index 8bb623039bb2..182c6122f815 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -125,17 +125,6 @@ static DEVICE_ATTR(release, S_IWUSR, NULL, cpu_release_store);
 #endif /* CONFIG_ARCH_CPU_PROBE_RELEASE */
 #endif /* CONFIG_HOTPLUG_CPU */
 
-struct bus_type cpu_subsys = {
-	.name = "cpu",
-	.dev_name = "cpu",
-	.match = cpu_subsys_match,
-#ifdef CONFIG_HOTPLUG_CPU
-	.online = cpu_subsys_online,
-	.offline = cpu_subsys_offline,
-#endif
-};
-EXPORT_SYMBOL_GPL(cpu_subsys);
-
 #ifdef CONFIG_KEXEC
 #include <linux/kexec.h>
 
@@ -348,6 +337,20 @@ static int cpu_uevent(const struct device *dev, struct kobj_uevent_env *env)
 }
 #endif
 
+struct bus_type cpu_subsys = {
+	.name = "cpu",
+	.dev_name = "cpu",
+	.match = cpu_subsys_match,
+#ifdef CONFIG_HOTPLUG_CPU
+	.online = cpu_subsys_online,
+	.offline = cpu_subsys_offline,
+#endif
+#ifdef CONFIG_GENERIC_CPU_AUTOPROBE
+	.uevent = cpu_uevent,
+#endif
+};
+EXPORT_SYMBOL_GPL(cpu_subsys);
+
 /*
  * register_cpu - Setup a sysfs device for a CPU.
  * @cpu - cpu->hotpluggable field set to 1 will generate a control file in
@@ -368,9 +371,6 @@ int register_cpu(struct cpu *cpu, int num)
 	cpu->dev.offline_disabled = !cpu->hotpluggable;
 	cpu->dev.offline = !cpu_online(num);
 	cpu->dev.of_node = of_get_cpu_node(num, NULL);
-#ifdef CONFIG_GENERIC_CPU_AUTOPROBE
-	cpu->dev.bus->uevent = cpu_uevent;
-#endif
 	cpu->dev.groups = common_cpu_attr_groups;
 	if (cpu->hotpluggable)
 		cpu->dev.groups = hotplugable_cpu_attr_groups;
-- 
2.39.1

