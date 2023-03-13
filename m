Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 857656B8096
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 19:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbjCMSaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 14:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231192AbjCMSah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 14:30:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF2408389D
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 11:30:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E5F461465
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 18:29:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69E3BC433D2;
        Mon, 13 Mar 2023 18:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678732169;
        bh=6cc07Yo5EzSV1mVa+Tl9FGlm0vk+66ho84vi9KwFE6E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cl050OeaHk/70eeZ/qIp465gBRu3j6q4XWi/RKOII5FNGcK9sW6PVPyiaKVHUA2x9
         sqFlBHzI74e2NGa2mEbFPpewoyL2BeOghUGuV0FUvRaj6dnmsIXevM2ry27KVFwlYL
         B9n2DQn+FaQm2DNAh+jHjIvQZHpk1s+NdcvRTElk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     rafael@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>,
        James Morse <james.morse@arm.com>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 11/36] arm64: cpufeature: move to use bus_get_dev_root()
Date:   Mon, 13 Mar 2023 19:28:53 +0100
Message-Id: <20230313182918.1312597-11-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230313182918.1312597-1-gregkh@linuxfoundation.org>
References: <20230313182918.1312597-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1838; i=gregkh@linuxfoundation.org; h=from:subject; bh=6cc07Yo5EzSV1mVa+Tl9FGlm0vk+66ho84vi9KwFE6E=; b=owGbwMvMwCRo6H6F97bub03G02pJDCn82eVJlo+P744yWWQfVb0uYdL9DexKNz8uL84pzHhdw D/50fRXHbEsDIJMDLJiiixftvEc3V9xSNHL0PY0zBxWJpAhDFycAjCRy+0MCy7cr0iM0fhy7f9c WZ+rF3LNVzUV5TDMr9702NJpvrjn2rzr69Z+sXWe482VCwA=
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

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: James Morse <james.morse@arm.com>
Cc: Kristina Martsenko <kristina.martsenko@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Vladimir Murzin <vladimir.murzin@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
Note, this is a patch that is a prepatory cleanup as part of a larger
series of patches that is working on resolving some old driver core
design mistakes.  It will build and apply cleanly on top of 6.3-rc2 on
its own, but I'd prefer if I could take it through my driver-core tree
so that the driver core changes can be taken through there for 6.4-rc1.

 arch/arm64/kernel/cpufeature.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 2e3e55139777..f3bab4bd0917 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1490,10 +1490,18 @@ static const DEVICE_ATTR_RO(aarch32_el0);
 
 static int __init aarch32_el0_sysfs_init(void)
 {
+	struct device *dev_root;
+	int ret = 0;
+
 	if (!allow_mismatched_32bit_el0)
 		return 0;
 
-	return device_create_file(cpu_subsys.dev_root, &dev_attr_aarch32_el0);
+	dev_root = bus_get_dev_root(&cpu_subsys);
+	if (dev_root) {
+		ret = device_create_file(dev_root, &dev_attr_aarch32_el0);
+		put_device(dev_root);
+	}
+	return ret;
 }
 device_initcall(aarch32_el0_sysfs_init);
 
-- 
2.39.2

