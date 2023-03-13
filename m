Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9266B6B80A7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 19:31:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbjCMSbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 14:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbjCMSay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 14:30:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B197AA7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 11:30:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6D464B811EA
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 18:30:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9939C4339B;
        Mon, 13 Mar 2023 18:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678732210;
        bh=+YNkgrwftY9hNEquBq/R0SACBur2SPzGk0mDyKZ5lx8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=okHtIWSWvjP6x5fU3oAPAe28nKfepeMrYZE5gY44jigwo8Pvy+eFSWGY1iKI7084c
         eMJD8wiSOfUIW9x7X49LQ+8Y7WVN1aNZfFGpuajpT74d/A4XzeTDb+ESW3l9gqZaae
         REtLOq/OsvUMQzFZNWfGSbFjznNHPfmtc3eVaD4E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     rafael@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Steven Price <steven.price@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Donnefort <vdonnefort@google.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH 07/36] cpu/hotplug: move to use bus_get_dev_root()
Date:   Mon, 13 Mar 2023 19:28:49 +0100
Message-Id: <20230313182918.1312597-7-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230313182918.1312597-1-gregkh@linuxfoundation.org>
References: <20230313182918.1312597-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2278; i=gregkh@linuxfoundation.org; h=from:subject; bh=+YNkgrwftY9hNEquBq/R0SACBur2SPzGk0mDyKZ5lx8=; b=owGbwMvMwCRo6H6F97bub03G02pJDCn82WVXq/7d+B2dX5lz5v3EZVFBndty901+w2ix6kzpR Z25s9VDOmJZGASZGGTFFFm+bOM5ur/ikKKXoe1pmDmsTCBDGLg4BWAid9UY5vs++fYyJs9zXcVc /QmiC8tnv/J5859hwYK2x0G6ld+vWt9xu+etX3nmloTaOgA=
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

Direct access to the struct bus_type dev_root pointer is going away soon
so replace that with a call to bus_get_dev_root() instead, which is what
it is there for.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Phil Auld <pauld@redhat.com>
Cc: Steven Price <steven.price@arm.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Vincent Donnefort <vdonnefort@google.com>
Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
Note, this is a patch that is a prepatory cleanup as part of a larger
series of patches that is working on resolving some old driver core
design mistakes.  It will build and apply cleanly on top of 6.3-rc2 on
its own, but I'd prefer if I could take it through my driver-core tree
so that the driver core changes can be taken through there for 6.4-rc1.

 kernel/cpu.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 6c0a92ca6bb5..c59b73d13a3a 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -2569,22 +2569,33 @@ static const struct attribute_group cpuhp_smt_attr_group = {
 
 static int __init cpu_smt_sysfs_init(void)
 {
-	return sysfs_create_group(&cpu_subsys.dev_root->kobj,
-				  &cpuhp_smt_attr_group);
+	struct device *dev_root;
+	int ret = -ENODEV;
+
+	dev_root = bus_get_dev_root(&cpu_subsys);
+	if (dev_root) {
+		ret = sysfs_create_group(&dev_root->kobj, &cpuhp_smt_attr_group);
+		put_device(dev_root);
+	}
+	return ret;
 }
 
 static int __init cpuhp_sysfs_init(void)
 {
+	struct device *dev_root;
 	int cpu, ret;
 
 	ret = cpu_smt_sysfs_init();
 	if (ret)
 		return ret;
 
-	ret = sysfs_create_group(&cpu_subsys.dev_root->kobj,
-				 &cpuhp_cpu_root_attr_group);
-	if (ret)
-		return ret;
+	dev_root = bus_get_dev_root(&cpu_subsys);
+	if (dev_root) {
+		ret = sysfs_create_group(&dev_root->kobj, &cpuhp_cpu_root_attr_group);
+		put_device(dev_root);
+		if (ret)
+			return ret;
+	}
 
 	for_each_possible_cpu(cpu) {
 		struct device *dev = get_cpu_device(cpu);
-- 
2.39.2

