Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8706B80C3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 19:33:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbjCMSdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 14:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231314AbjCMScg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 14:32:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A07C85691
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 11:31:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F2E07B811C0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 18:30:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BFACC433EF;
        Mon, 13 Mar 2023 18:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678732215;
        bh=gLzKe4oxvagH/VFQPBqBGcEQROYxgF1p5m/hDhke2hc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F9T/FLVrOt4wSkN9Od4KU0TV6PCDVYzrTZtGNhT73tJMi+ne1oU2QYvvjULwH0P19
         +vYmTlzVJeA01UETaERBzd6OjA3oJJxGE8fKcYcL1sbqTYczo68aALj3USwO8RGlpz
         8q9DyDdu3dCsEeBialG+LXZMRl/RcWDrHrLSREOk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     rafael@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 09/36] x86/microcode: move to use bus_get_dev_root()
Date:   Mon, 13 Mar 2023 19:28:51 +0100
Message-Id: <20230313182918.1312597-9-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230313182918.1312597-1-gregkh@linuxfoundation.org>
References: <20230313182918.1312597-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1974; i=gregkh@linuxfoundation.org; h=from:subject; bh=gLzKe4oxvagH/VFQPBqBGcEQROYxgF1p5m/hDhke2hc=; b=owGbwMvMwCRo6H6F97bub03G02pJDCn82eUcHup7NCM6o6zrhO4kJLdd03y4wtV4mSlLvNKZ1 fJFO8w6YlkYBJkYZMUUWb5s4zm6v+KQopeh7WmYOaxMIEMYuDgFYCLpugyz2S2Smkq552qt26Ti 9d96nvL8rpk9DPP0ntjs+Xa2PfFnbMAO5gMi8W21bSEA
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

Cc: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
Note, this is a patch that is a prepatory cleanup as part of a larger
series of patches that is working on resolving some old driver core
design mistakes.  It will build and apply cleanly on top of 6.3-rc2 on
its own, but I'd prefer if I could take it through my driver-core tree
so that the driver core changes can be taken through there for 6.4-rc1.

 arch/x86/kernel/cpu/microcode/core.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 7a329e561354..3afcf3de0dd4 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -632,6 +632,7 @@ static const struct attribute_group cpu_root_microcode_group = {
 
 static int __init microcode_init(void)
 {
+	struct device *dev_root;
 	struct cpuinfo_x86 *c = &boot_cpu_data;
 	int error;
 
@@ -652,10 +653,14 @@ static int __init microcode_init(void)
 	if (IS_ERR(microcode_pdev))
 		return PTR_ERR(microcode_pdev);
 
-	error = sysfs_create_group(&cpu_subsys.dev_root->kobj, &cpu_root_microcode_group);
-	if (error) {
-		pr_err("Error creating microcode group!\n");
-		goto out_pdev;
+	dev_root = bus_get_dev_root(&cpu_subsys);
+	if (dev_root) {
+		error = sysfs_create_group(&dev_root->kobj, &cpu_root_microcode_group);
+		put_device(dev_root);
+		if (error) {
+			pr_err("Error creating microcode group!\n");
+			goto out_pdev;
+		}
 	}
 
 	/* Do per-CPU setup */
-- 
2.39.2

