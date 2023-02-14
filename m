Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66A53696470
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 14:19:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbjBNNTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 08:19:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbjBNNTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 08:19:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 907001C7E8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 05:19:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 14A03B81BF8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 13:19:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49279C4339B;
        Tue, 14 Feb 2023 13:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676380755;
        bh=DjZEIWt/JDSinUR024YMqT4RmixcO7Jc89zHxsl9vjM=;
        h=From:To:Cc:Subject:Date:From;
        b=qc+jzWzTrUcCoMjNx4FJpt11LJqUVnu/yCb3Bcgxr+KPdyzV2ALtpziwyD41sVRLD
         uYnOxhy2NE2lnwdermG4uwxLx0I6gx1vBA/BUQUEf4b9tHdRet7OD7BTXVacAmjLvR
         swVgK6dGlRaGISJksEEGBDkM+HN/DZNt5K7F/1ipJoY2TmUdgP8aAqeAOe6TsACrOT
         vm4aqvSac0VHKn+TWChxp5myYS3dix+FlsplwpHiRuhhhBjRvvzgRnA8qCnHGGLHJu
         dVhCN9pdQIZg+9SQ0FqyMhkFSlzWSRhIkOLMcAxKxcb/D+mzesJQfv2PUm3YQIEmqT
         qxJsKMAssByIA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dax/hmem: build hmem device support as module if possible
Date:   Tue, 14 Feb 2023 14:18:47 +0100
Message-Id: <20230214131913.1431969-1-arnd@kernel.org>
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

When device_hmem.o is enabled but dax itself is a loadable module, the
dax_hmem support fails to link because Kbuild never compiles built-in
code under drivers/dax:

ERROR: modpost: "walk_hmem_resources" [drivers/dax/hmem/dax_hmem.ko] undefined!

Make sure that drivers/dax is entered for compiling built-in code
even with CONFIG_DAX=m.

Fixes: 7dab174e2e27 ("dax/hmem: Move hmem device registration to dax_hmem.ko")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/Makefile b/drivers/Makefile
index 148ccfc2b5fe..20b118dca999 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -76,7 +76,7 @@ obj-$(CONFIG_FB_INTEL)          += video/fbdev/intelfb/
 obj-$(CONFIG_PARPORT)		+= parport/
 obj-y				+= base/ block/ misc/ mfd/ nfc/
 obj-$(CONFIG_LIBNVDIMM)		+= nvdimm/
-obj-$(CONFIG_DAX)		+= dax/
+obj-y				+= dax/
 obj-$(CONFIG_DMA_SHARED_BUFFER) += dma-buf/
 obj-$(CONFIG_NUBUS)		+= nubus/
 obj-y				+= cxl/
-- 
2.39.1

