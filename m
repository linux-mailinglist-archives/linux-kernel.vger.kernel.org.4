Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 499846CB49D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 05:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbjC1DLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 23:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbjC1DLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 23:11:41 -0400
Received: from mail.nfschina.com (unknown [42.101.60.237])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F6B212B;
        Mon, 27 Mar 2023 20:11:40 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id E44871A00AD8;
        Tue, 28 Mar 2023 11:11:46 +0800 (CST)
X-Virus-Scanned: amavisd-new at nfschina.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (localhost.localdomain [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id YjWVj1woUHxv; Tue, 28 Mar 2023 11:11:45 +0800 (CST)
Received: from localhost.localdomain (unknown [180.167.10.98])
        (Authenticated sender: yuzhe@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id B58B41A00994;
        Tue, 28 Mar 2023 11:11:44 +0800 (CST)
From:   Yu Zhe <yuzhe@nfschina.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com,
        quic_sayalil@quicinc.com, quic_c_sbhanu@quicinc.com,
        quic_luliang@quicinc.com, m.szyprowski@samsung.com,
        wsa+renesas@sang-engineering.com, yebin10@huawei.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, liqiong@nfschina.com,
        Yu Zhe <yuzhe@nfschina.com>
Subject: [PATCH v2] mmc: core: remove unnecessary (void*) conversions
Date:   Tue, 28 Mar 2023 11:10:49 +0800
Message-Id: <20230328031049.22749-1-yuzhe@nfschina.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20230317064729.24407-1-yuzhe@nfschina.com>
References: <20230317064729.24407-1-yuzhe@nfschina.com>
X-Spam-Status: No, score=2.6 required=5.0 tests=RCVD_IN_VALIDITY_RPBL,
        RDNS_NONE,SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pointer variables of void * type do not require type cast.

Signed-off-by: Yu Zhe <yuzhe@nfschina.com>
Reviewed-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/mmc/core/debugfs.c  | 2 +-
 drivers/mmc/core/mmc_test.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
index fe6808771bc7..2c97b94aab23 100644
--- a/drivers/mmc/core/debugfs.c
+++ b/drivers/mmc/core/debugfs.c
@@ -246,7 +246,7 @@ DEFINE_DEBUGFS_ATTRIBUTE(mmc_err_state, mmc_err_state_get, NULL, "%llu\n");
 
 static int mmc_err_stats_show(struct seq_file *file, void *data)
 {
-	struct mmc_host *host = (struct mmc_host *)file->private;
+	struct mmc_host *host = file->private;
 	const char *desc[MMC_ERR_MAX] = {
 		[MMC_ERR_CMD_TIMEOUT] = "Command Timeout Occurred",
 		[MMC_ERR_CMD_CRC] = "Command CRC Errors Occurred",
diff --git a/drivers/mmc/core/mmc_test.c b/drivers/mmc/core/mmc_test.c
index 156d34b2ed4d..0f6a563103fd 100644
--- a/drivers/mmc/core/mmc_test.c
+++ b/drivers/mmc/core/mmc_test.c
@@ -3045,7 +3045,7 @@ static LIST_HEAD(mmc_test_file_test);
 
 static int mtf_test_show(struct seq_file *sf, void *data)
 {
-	struct mmc_card *card = (struct mmc_card *)sf->private;
+	struct mmc_card *card = sf->private;
 	struct mmc_test_general_result *gr;
 
 	mutex_lock(&mmc_test_lock);
@@ -3079,8 +3079,8 @@ static int mtf_test_open(struct inode *inode, struct file *file)
 static ssize_t mtf_test_write(struct file *file, const char __user *buf,
 	size_t count, loff_t *pos)
 {
-	struct seq_file *sf = (struct seq_file *)file->private_data;
-	struct mmc_card *card = (struct mmc_card *)sf->private;
+	struct seq_file *sf = file->private_data;
+	struct mmc_card *card = sf->private;
 	struct mmc_test_card *test;
 	long testcase;
 	int ret;
-- 
2.11.0

