Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCA886960C2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 11:31:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232481AbjBNKbD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 05:31:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjBNKbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 05:31:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18FA223871;
        Tue, 14 Feb 2023 02:30:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8045761515;
        Tue, 14 Feb 2023 10:30:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82987C433EF;
        Tue, 14 Feb 2023 10:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676370657;
        bh=QJBK9fHdKNNn92kOAjyh7kUpQvGURF1xEy3HVB5T/Dc=;
        h=From:To:Cc:Subject:Date:From;
        b=JKND1mVz0GMn70yw0aPGiB3Ta6kH+7ZpQQNnJ8enVN0JD6eyZ/59oLMx0Jh8YnJ7l
         u5l3Zx9H9WXfBjK7r/JHtiOw/veDF4MhF4h/uPfEvHmb0SVSat3hR/bCYWR/B0+00X
         lT3OvgGvcr/x/ax118lxVMXvEA6nTnAXCgRonN/9AuZu1KFO32fuSRu7gzzGP3PNlO
         zF24WVGsOfq7oM13G6hTw38p96vjR7gV2IQXydK8Dd0maJzn7XUT3EOjPyT7ZGacXx
         vpC37pv8MRmPzOL70eOL3iIw/VbD2294RGrLCP81SBCZHFHqjF3nmawqsjdh4OZPoD
         easqmDgagv5Cw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Gregory Price <gregory.price@memverge.com>,
        John Ogness <john.ogness@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>, nvdimm@lists.linux.dev,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dax: clx: add CXL_REGION dependency
Date:   Tue, 14 Feb 2023 11:30:49 +0100
Message-Id: <20230214103054.1082908-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

There is already a dependency on CXL_REGION, which depends on CXL_BUS,
but since CXL_REGION is a 'bool' symbol, it's possible to configure
DAX as built-in even though CXL itself is a loadable module:

x86_64-linux-ld: drivers/dax/cxl.o: in function `cxl_dax_region_probe':
cxl.c:(.text+0xb): undefined reference to `to_cxl_dax_region'
x86_64-linux-ld: drivers/dax/cxl.o: in function `cxl_dax_region_driver_init':
cxl.c:(.init.text+0x10): undefined reference to `__cxl_driver_register'
x86_64-linux-ld: drivers/dax/cxl.o: in function `cxl_dax_region_driver_exit':
cxl.c:(.exit.text+0x9): undefined reference to `cxl_driver_unregister'

Prevent this with another depndency on the tristate symbol.

Fixes: 09d09e04d2fc ("cxl/dax: Create dax devices for CXL RAM regions")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/dax/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dax/Kconfig b/drivers/dax/Kconfig
index 8c67a24592e3..a88744244149 100644
--- a/drivers/dax/Kconfig
+++ b/drivers/dax/Kconfig
@@ -46,7 +46,7 @@ config DEV_DAX_HMEM
 
 config DEV_DAX_CXL
 	tristate "CXL DAX: direct access to CXL RAM regions"
-	depends on CXL_REGION && DEV_DAX
+	depends on CXL_BUS && CXL_REGION && DEV_DAX
 	default CXL_REGION && DEV_DAX
 	help
 	  CXL RAM regions are either mapped by platform-firmware
-- 
2.39.1

