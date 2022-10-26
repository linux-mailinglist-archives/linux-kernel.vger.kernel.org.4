Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0A260DC25
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 09:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233186AbiJZHcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 03:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233139AbiJZHcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 03:32:32 -0400
X-Greylist: delayed 376 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 26 Oct 2022 00:32:29 PDT
Received: from mail-m11874.qiye.163.com (mail-m11874.qiye.163.com [115.236.118.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86197A50F5;
        Wed, 26 Oct 2022 00:32:29 -0700 (PDT)
Received: from caicai-HWPC.. (unknown [IPV6:240e:36a:141c:3700:9049:ecf7:8648:6a1c])
        by mail-m11874.qiye.163.com (Hmail) with ESMTPA id 94E973C052D;
        Wed, 26 Oct 2022 15:26:09 +0800 (CST)
From:   Yupeng Li <liyupeng@zbhlos.com>
To:     Shyam-sundar.S-k@amd.com, hdegoede@redhat.com, markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        caizp2008@163.com, Yupeng Li <liyupeng@zbhlos.com>
Subject: [PATCH 1/1] platform/x86/amd: Fix pmc compile dependency errors.
Date:   Wed, 26 Oct 2022 15:25:31 +0800
Message-Id: <20221026072531.346013-1-liyupeng@zbhlos.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDSR5JVhhNQ0NCTR1MS0gYHVUTARMWGhIXJBQOD1
        lXWRgSC1lBWUlPSx5BSE0aQUpPShhBSExLS0FCS09CQR4YHUxBQ01PQ0FNGkoYWVdZFhoPEhUdFF
        lBWU9LSFVKSktISkxVSktLVUtZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OTo6Cyo*KT0aLR0fS0w0LEw0
        GixPFElVSlVKTU1NTE1CSkxLSk9KVTMWGhIXVRcSAg4LHhUcOwEZExcUCFUYFBZFWVdZEgtZQVlJ
        T0seQUhNGkFKT0oYQUhMS0tBQktPQkEeGB1MQUNNT0NBTRpKGFlXWQgBWUFISkhONwY+
X-HM-Tid: 0a84132f2d632eb0kusn94e973c052d
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When disabled CONFIG_SUSPEND and CONFIG_DEBUG_FS, get_metrics_table
and amd_pmc_idlemask_read is defined under two conditions of this,
pmc build with implicit declaration of function error.Some build error
messages are as follows:

 CC [M]  drivers/platform/x86/amd/pmc.o
drivers/platform/x86/amd/pmc.c: In function ‘smu_fw_info_show’:
drivers/platform/x86/amd/pmc.c:436:6: error: implicit declaration of function ‘get_metrics_table’ [-Werror=implicit-function-declaration]
  436 |  if (get_metrics_table(dev, &table))
      |      ^~~~~~~~~~~~~~~~~
drivers/platform/x86/amd/pmc.c: In function ‘amd_pmc_idlemask_show’:
drivers/platform/x86/amd/pmc.c:508:8: error: implicit declaration of function ‘amd_pmc_idlemask_read’; did you mean ‘amd_pmc_idlemask_show’? [-Werror=implicit-function-declaration]
  508 |   rc = amd_pmc_idlemask_read(dev, NULL, s);
      |        ^~~~~~~~~~~~~~~~~~~~~
      |        amd_pmc_idlemask_show
cc1: some warnings being treated as errors

Signed-off-by: Yupeng Li <liyupeng@zbhlos.com>
Reviewed-by: Caicai <caizp2008@163.com>
---
 drivers/platform/x86/amd/pmc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/amd/pmc.c b/drivers/platform/x86/amd/pmc.c
index ce859b300712..2b08039921b8 100644
--- a/drivers/platform/x86/amd/pmc.c
+++ b/drivers/platform/x86/amd/pmc.c
@@ -433,8 +433,10 @@ static int smu_fw_info_show(struct seq_file *s, void *unused)
 	struct smu_metrics table;
 	int idx;
 
+#if defined(CONFIG_SUSPEND) || defined(CONFIG_DEBUG_FS)
 	if (get_metrics_table(dev, &table))
 		return -EINVAL;
+#endif
 
 	seq_puts(s, "\n=== SMU Statistics ===\n");
 	seq_printf(s, "Table Version: %d\n", table.table_version);
@@ -503,11 +505,12 @@ static int amd_pmc_idlemask_show(struct seq_file *s, void *unused)
 		if (rc)
 			return rc;
 	}
-
 	if (dev->major > 56 || (dev->major >= 55 && dev->minor >= 37)) {
+#if defined(CONFIG_SUSPEND) || defined(CONFIG_DEBUG_FS)
 		rc = amd_pmc_idlemask_read(dev, NULL, s);
 		if (rc)
 			return rc;
+#endif
 	} else {
 		seq_puts(s, "Unsupported SMU version for Idlemask\n");
 	}
-- 
2.34.1

