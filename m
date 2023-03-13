Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84B106B80A1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 19:31:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbjCMSbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 14:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbjCMSaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 14:30:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E955283888
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 11:30:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 320026147E
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 18:29:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49B4BC433EF;
        Mon, 13 Mar 2023 18:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678732175;
        bh=Wkc8ouE8preZxxsKKr+mW1QCYOu2NrmhAiEHH6XrvJ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sia3eX1jTyd6HFboYPForq+DFhgzXjzHJFJ3CKNpgDiTkRxSnzdvetgUuSrR3REvZ
         rxPHW7vLDroW30cVO3GV2OI7dbkenunW4WplYf0LDGfmbf5owZQ6HmMIcuI8Tm6pBz
         7qjswwHmKBucIQRmxi1knQDyNLlUJx+AHYzUWOZg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     rafael@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Joel Stanley <joel@jms.id.au>, Liang He <windhl@126.com>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 13/36] powerpc/powernv: move to use bus_get_dev_root()
Date:   Mon, 13 Mar 2023 19:28:55 +0100
Message-Id: <20230313182918.1312597-13-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230313182918.1312597-1-gregkh@linuxfoundation.org>
References: <20230313182918.1312597-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2991; i=gregkh@linuxfoundation.org; h=from:subject; bh=Wkc8ouE8preZxxsKKr+mW1QCYOu2NrmhAiEHH6XrvJ8=; b=owGbwMvMwCRo6H6F97bub03G02pJDCn82RWCF9Rn1zBn9X5d7J6Rft93Kr+jnp/wnO+Vhd8UB VeobDLsiGVhEGRikBVTZPmyjefo/opDil6Gtqdh5rAygQxh4OIUgIlsWsgwP9NjR1XwN4/5VgsS ll189TA8doHhEob5OXZX70gzLd+byRTa9f3E230vXay9AQ==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Direct access to the struct bus_type dev_root pointer is going away soon
so replace that with a call to bus_get_dev_root() instead, which is what
it is there for.

Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Joel Stanley <joel@jms.id.au>
Cc: Liang He <windhl@126.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Julia Lawall <Julia.Lawall@inria.fr>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
Note, this is a patch that is a prepatory cleanup as part of a larger
series of patches that is working on resolving some old driver core
design mistakes.  It will build and apply cleanly on top of 6.3-rc2 on
its own, but I'd prefer if I could take it through my driver-core tree
so that the driver core changes can be taken through there for 6.4-rc1.

 arch/powerpc/platforms/powernv/idle.c    |  9 +++++++--
 arch/powerpc/platforms/powernv/subcore.c | 10 ++++++++--
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
index 841cb7f31f4f..6dfe8d611164 100644
--- a/arch/powerpc/platforms/powernv/idle.c
+++ b/arch/powerpc/platforms/powernv/idle.c
@@ -1464,14 +1464,19 @@ static int __init pnv_init_idle_states(void)
 			power7_fastsleep_workaround_entry = false;
 			power7_fastsleep_workaround_exit = false;
 		} else {
+			struct device *dev_root;
 			/*
 			 * OPAL_PM_SLEEP_ENABLED_ER1 is set. It indicates that
 			 * workaround is needed to use fastsleep. Provide sysfs
 			 * control to choose how this workaround has to be
 			 * applied.
 			 */
-			device_create_file(cpu_subsys.dev_root,
-				&dev_attr_fastsleep_workaround_applyonce);
+			dev_root = bus_get_dev_root(&cpu_subsys);
+			if (dev_root) {
+				device_create_file(dev_root,
+						   &dev_attr_fastsleep_workaround_applyonce);
+				put_device(dev_root);
+			}
 		}
 
 		update_subcore_sibling_mask();
diff --git a/arch/powerpc/platforms/powernv/subcore.c b/arch/powerpc/platforms/powernv/subcore.c
index 7e98b00ea2e8..428532a69762 100644
--- a/arch/powerpc/platforms/powernv/subcore.c
+++ b/arch/powerpc/platforms/powernv/subcore.c
@@ -415,7 +415,9 @@ static DEVICE_ATTR(subcores_per_core, 0644,
 
 static int subcore_init(void)
 {
+	struct device *dev_root;
 	unsigned pvr_ver;
+	int rc = 0;
 
 	pvr_ver = PVR_VER(mfspr(SPRN_PVR));
 
@@ -435,7 +437,11 @@ static int subcore_init(void)
 
 	set_subcores_per_core(1);
 
-	return device_create_file(cpu_subsys.dev_root,
-				  &dev_attr_subcores_per_core);
+	dev_root = bus_get_dev_root(&cpu_subsys);
+	if (dev_root) {
+		rc = device_create_file(dev_root, &dev_attr_subcores_per_core);
+		put_device(dev_root);
+	}
+	return rc;
 }
 machine_device_initcall(powernv, subcore_init);
-- 
2.39.2

