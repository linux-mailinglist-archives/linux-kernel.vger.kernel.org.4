Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 992C66B8090
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 19:30:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbjCMSaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 14:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbjCMSaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 14:30:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56D0C23C6B
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 11:29:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 53CDCB811E1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 18:29:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8753C433EF;
        Mon, 13 Mar 2023 18:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678732181;
        bh=KGCzZ+imnvEdkljNiLcYF+bxrlXNtuGGw3dcz4zdHvo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0EqNGbMlKRwDuQj2dv0OxR31F1eYi9XirJZNBzLWeQT0SJ0Tyj0MKz5pKs+mZRJL6
         7PzwqYLKmtqYNSlx7l7k9SAXBmifeT86dP89Uc4zHFLEFEmYy7uqMCbm7BRtuBkXxk
         DJVr/GVlGmC5Yf0GFy2QmfbwsvE9ZrJXOT4tlcHM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     rafael@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 15/36] powerpc/fsl: move to use bus_get_dev_root()
Date:   Mon, 13 Mar 2023 19:28:57 +0100
Message-Id: <20230313182918.1312597-15-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230313182918.1312597-1-gregkh@linuxfoundation.org>
References: <20230313182918.1312597-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2249; i=gregkh@linuxfoundation.org; h=from:subject; bh=KGCzZ+imnvEdkljNiLcYF+bxrlXNtuGGw3dcz4zdHvo=; b=owGbwMvMwCRo6H6F97bub03G02pJDCn82RXRPonuPMsPTv2Q7DfVuXbJ92m3+Qucvn7XsV38a 9bU45e8OmJZGASZGGTFFFm+bOM5ur/ikKKXoe1pmDmsTCBDGLg4BWAi9Z8ZZrO+cE3qCChKUzi2 /fKlb7ckbGazRjLMM3HMyHx1alexjd3s80oJZTt7JW8xAwA=
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
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
Note, this is a patch that is a prepatory cleanup as part of a larger
series of patches that is working on resolving some old driver core
design mistakes.  It will build and apply cleanly on top of 6.3-rc2 on
its own, but I'd prefer if I could take it through my driver-core tree
so that the driver core changes can be taken through there for 6.4-rc1.

 arch/powerpc/sysdev/fsl_mpic_timer_wakeup.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_mpic_timer_wakeup.c b/arch/powerpc/sysdev/fsl_mpic_timer_wakeup.c
index c2baa283e624..147b5d8bb904 100644
--- a/arch/powerpc/sysdev/fsl_mpic_timer_wakeup.c
+++ b/arch/powerpc/sysdev/fsl_mpic_timer_wakeup.c
@@ -116,6 +116,7 @@ static struct device_attribute mpic_attributes = __ATTR(timer_wakeup, 0644,
 
 static int __init fsl_wakeup_sys_init(void)
 {
+	struct device *dev_root;
 	int ret;
 
 	fsl_wakeup = kzalloc(sizeof(struct fsl_mpic_timer_wakeup), GFP_KERNEL);
@@ -124,16 +125,26 @@ static int __init fsl_wakeup_sys_init(void)
 
 	INIT_WORK(&fsl_wakeup->free_work, fsl_free_resource);
 
-	ret = device_create_file(mpic_subsys.dev_root, &mpic_attributes);
-	if (ret)
-		kfree(fsl_wakeup);
+	dev_root = bus_get_dev_root(&mpic_subsys);
+	if (dev_root) {
+		ret = device_create_file(dev_root, &mpic_attributes);
+		put_device(dev_root);
+		if (ret)
+			kfree(fsl_wakeup);
+	}
 
 	return ret;
 }
 
 static void __exit fsl_wakeup_sys_exit(void)
 {
-	device_remove_file(mpic_subsys.dev_root, &mpic_attributes);
+	struct device *dev_root;
+
+	dev_root = bus_get_dev_root(&mpic_subsys);
+	if (dev_root) {
+		device_remove_file(dev_root, &mpic_attributes);
+		put_device(dev_root);
+	}
 
 	mutex_lock(&sysfs_lock);
 
-- 
2.39.2

