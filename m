Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 323F56B80AA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 19:31:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbjCMSbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 14:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbjCMSa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 14:30:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA68F84809;
        Mon, 13 Mar 2023 11:30:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E0306B811DD;
        Mon, 13 Mar 2023 18:29:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56053C4339B;
        Mon, 13 Mar 2023 18:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678732183;
        bh=eoKf67z0RJnZv79uQSS4O970nfxW9TSz1wAks4pBByU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A5pZkIFW5L4V/98zs6OBmVYuIlG1i6es/nQYVUrj0P/iA0qiRIoGKniahO790i2C0
         ibG0+FXU9GeKK7FMeiwpsIyz7AVl9Rx5PuKYhWUYrQWYNveTcvvQhoAsfJeQgiwh2w
         PsBFyUCjVYJ7VplsjWB6FSh+rFDQ4nPoZW+6pPmk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     rafael@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
Subject: [PATCH 16/36] sh: dma-sysfs: move to use bus_get_dev_root()
Date:   Mon, 13 Mar 2023 19:28:58 +0100
Message-Id: <20230313182918.1312597-16-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230313182918.1312597-1-gregkh@linuxfoundation.org>
References: <20230313182918.1312597-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1572; i=gregkh@linuxfoundation.org; h=from:subject; bh=eoKf67z0RJnZv79uQSS4O970nfxW9TSz1wAks4pBByU=; b=owGbwMvMwCRo6H6F97bub03G02pJDCn82RUr5qbG39X19HhySf2YgPJ/t03OPxNClzwy1S/Xa WhO6kvriGVhEGRikBVTZPmyjefo/opDil6Gtqdh5rAygQxh4OIUgIn8zmOYZx1QlT3lkf7i13dq n6S0JTTeSZ+oxTA/OMiUfd234PQVsRfPuGhWvrl8otkTAA==
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

Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
Note, this is a patch that is a prepatory cleanup as part of a larger
series of patches that is working on resolving some old driver core
design mistakes.  It will build and apply cleanly on top of 6.3-rc2 on
its own, but I'd prefer if I could take it through my driver-core tree
so that the driver core changes can be taken through there for 6.4-rc1.

 arch/sh/drivers/dma/dma-sysfs.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/sh/drivers/dma/dma-sysfs.c b/arch/sh/drivers/dma/dma-sysfs.c
index 8ef318150f84..431bc18f0a41 100644
--- a/arch/sh/drivers/dma/dma-sysfs.c
+++ b/arch/sh/drivers/dma/dma-sysfs.c
@@ -45,13 +45,19 @@ static DEVICE_ATTR(devices, S_IRUGO, dma_show_devices, NULL);
 
 static int __init dma_subsys_init(void)
 {
+	struct device *dev_root;
 	int ret;
 
 	ret = subsys_system_register(&dma_subsys, NULL);
 	if (unlikely(ret))
 		return ret;
 
-	return device_create_file(dma_subsys.dev_root, &dev_attr_devices);
+	dev_root = bus_get_dev_root(&dma_subsys);
+	if (dev_root) {
+		ret = device_create_file(dev_root, &dev_attr_devices);
+		put_device(dev_root);
+	}
+	return ret;
 }
 postcore_initcall(dma_subsys_init);
 
-- 
2.39.2

