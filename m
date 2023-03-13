Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 927206B808D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 19:30:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbjCMSaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 14:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbjCMSaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 14:30:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C076D503
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 11:29:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E67E61481
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 18:29:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E072C433D2;
        Mon, 13 Mar 2023 18:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678732172;
        bh=GZi6aIFaPbxyiWC7UgPxZNnPYWjFOCtg9+DHkUvetJc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wjYC2fVsQqfI5jh0QjqMMazt/qp4hQhyThWH9kCVBnHP1bow+OIbEgfcq3ow8wBJc
         zD42zt3S7WDI0mpOSupC59RB09h7Or69T0tSWWIo/DotEOx1J+jhb/MPlgBQ3dhTgB
         XYzC3m5S//TVyAc0td0hGo9n6uJJDpSOsvNO69OI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     rafael@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 12/36] powerpc/sysfs: move to use bus_get_dev_root()
Date:   Mon, 13 Mar 2023 19:28:54 +0100
Message-Id: <20230313182918.1312597-12-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230313182918.1312597-1-gregkh@linuxfoundation.org>
References: <20230313182918.1312597-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2139; i=gregkh@linuxfoundation.org; h=from:subject; bh=GZi6aIFaPbxyiWC7UgPxZNnPYWjFOCtg9+DHkUvetJc=; b=owGbwMvMwCRo6H6F97bub03G02pJDCn82eVP0u/d4E282/La+Y9Ge8br9zerjNax/HkmpCth9 X/H228nO2JZGASZGGTFFFm+bOM5ur/ikKKXoe1pmDmsTCBDGLg4BWAiYRwMC/b3P2fd75zX8XC9 8Nc57tnK866IszHMs1O3/T3dc4P9K86TE1i3JX65nm+wDAA=
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

Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
Note, this is a patch that is a prepatory cleanup as part of a larger
series of patches that is working on resolving some old driver core
design mistakes.  It will build and apply cleanly on top of 6.3-rc2 on
its own, but I'd prefer if I could take it through my driver-core tree
so that the driver core changes can be taken through there for 6.4-rc1.

 arch/powerpc/kernel/sysfs.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/sysfs.c b/arch/powerpc/kernel/sysfs.c
index ef9a61718940..0f39a6b84132 100644
--- a/arch/powerpc/kernel/sysfs.c
+++ b/arch/powerpc/kernel/sysfs.c
@@ -217,13 +217,18 @@ static DEVICE_ATTR(dscr_default, 0600,
 static void __init sysfs_create_dscr_default(void)
 {
 	if (cpu_has_feature(CPU_FTR_DSCR)) {
+		struct device *dev_root;
 		int cpu;
 
 		dscr_default = spr_default_dscr;
 		for_each_possible_cpu(cpu)
 			paca_ptrs[cpu]->dscr_default = dscr_default;
 
-		device_create_file(cpu_subsys.dev_root, &dev_attr_dscr_default);
+		dev_root = bus_get_dev_root(&cpu_subsys);
+		if (dev_root) {
+			device_create_file(dev_root, &dev_attr_dscr_default);
+			put_device(dev_root);
+		}
 	}
 }
 #endif /* CONFIG_PPC64 */
@@ -746,7 +751,12 @@ static DEVICE_ATTR(svm, 0444, show_svm, NULL);
 
 static void __init create_svm_file(void)
 {
-	device_create_file(cpu_subsys.dev_root, &dev_attr_svm);
+	struct device *dev_root = bus_get_dev_root(&cpu_subsys);
+
+	if (dev_root) {
+		device_create_file(dev_root, &dev_attr_svm);
+		put_device(dev_root);
+	}
 }
 #else
 static void __init create_svm_file(void)
-- 
2.39.2

