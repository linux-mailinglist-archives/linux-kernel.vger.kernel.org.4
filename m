Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8B9B6B809D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 19:31:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbjCMSbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 14:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbjCMSao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 14:30:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 720A98090E;
        Mon, 13 Mar 2023 11:30:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C3FBD61476;
        Mon, 13 Mar 2023 18:30:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1964C433EF;
        Mon, 13 Mar 2023 18:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678732202;
        bh=iWixNYysEt/57rzWPvGF+tU4T3O5fIRqKfjVPRFzTiE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rOW7zAdt3atmqn55xq4wkAhth6yviBG8RItVivIzGD3S2HYWjNpvHud9HHQrkbhsT
         JDVDHBPnIUb+T5ndB+erKVt1PixDzZYSOHzSDBVuBV3Q8SpButNkXzWeJwEdRz7i7a
         9Avkl8tTjbaQ6lY42jQeYvqjgQwzOZpn4xrW54E4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     rafael@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH 04/36] platform/x86: ibm_rtl: move to use bus_get_dev_root()
Date:   Mon, 13 Mar 2023 19:28:46 +0100
Message-Id: <20230313182918.1312597-4-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230313182918.1312597-1-gregkh@linuxfoundation.org>
References: <20230313182918.1312597-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1912; i=gregkh@linuxfoundation.org; h=from:subject; bh=iWixNYysEt/57rzWPvGF+tU4T3O5fIRqKfjVPRFzTiE=; b=owGbwMvMwCRo6H6F97bub03G02pJDCn82aWbzuQ+71jMOT/uaVDffRvPid97S9bPWt38uzBO9 YCnv2FERywLgyATg6yYIsuXbTxH91ccUvQytD0NM4eVCWQIAxenAEykq55hwe7DE9aL6kisd5Cb dOWFixnPmQU6qgzzdFuf85+qeHxJYq2xITff3l1CW8UzAQ==
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

Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Mark Gross <markgross@kernel.org>
Cc: platform-driver-x86@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
Note, this is a patch that is a prepatory cleanup as part of a larger
series of patches that is working on resolving some old driver core
design mistakes.  It will build and apply cleanly on top of 6.3-rc2 on
its own, but I'd prefer if I could take it through my driver-core tree
so that the driver core changes can be taken through there for 6.4-rc1.

 drivers/platform/x86/ibm_rtl.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/ibm_rtl.c b/drivers/platform/x86/ibm_rtl.c
index 5fc665f7d9b3..2ab7d9ac542d 100644
--- a/drivers/platform/x86/ibm_rtl.c
+++ b/drivers/platform/x86/ibm_rtl.c
@@ -199,16 +199,26 @@ static int rtl_setup_sysfs(void) {
 
 	ret = subsys_system_register(&rtl_subsys, NULL);
 	if (!ret) {
-		for (i = 0; rtl_attributes[i]; i ++)
-			device_create_file(rtl_subsys.dev_root, rtl_attributes[i]);
+		struct device *dev_root = bus_get_dev_root(&rtl_subsys);
+
+		if (dev_root) {
+			for (i = 0; rtl_attributes[i]; i ++)
+				device_create_file(dev_root, rtl_attributes[i]);
+			put_device(dev_root);
+		}
 	}
 	return ret;
 }
 
 static void rtl_teardown_sysfs(void) {
+	struct device *dev_root = bus_get_dev_root(&rtl_subsys);
 	int i;
-	for (i = 0; rtl_attributes[i]; i ++)
-		device_remove_file(rtl_subsys.dev_root, rtl_attributes[i]);
+
+	if (dev_root) {
+		for (i = 0; rtl_attributes[i]; i ++)
+			device_remove_file(dev_root, rtl_attributes[i]);
+		put_device(dev_root);
+	}
 	bus_unregister(&rtl_subsys);
 }
 
-- 
2.39.2

