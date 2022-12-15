Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7C364DEED
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 17:46:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbiLOQqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 11:46:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbiLOQqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 11:46:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3C21D661;
        Thu, 15 Dec 2022 08:46:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5DEE761DE1;
        Thu, 15 Dec 2022 16:46:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E17A3C433EF;
        Thu, 15 Dec 2022 16:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671122791;
        bh=A2zo+YEzj0mCFsWZY3hiedXJIbbizcIeakCXEv54ohE=;
        h=From:To:Cc:Subject:Date:From;
        b=LrDKRPEe12gso8I2SvBntC/pI7NoJbNtlrgEo3CCmh0mc/lqWZcW3xgKCr6is0K6T
         9lUYv42xu5J+puXNEqQM4wJsV2dh0SQEDX357DieOSofoQ4/4ldbr4oauLjRNwDyPT
         lkikrhIKCzBZ6KI3HuIuQoEN3UsHpAOEjWfk59lAvCd0MU/pttJ+uPJCjXa6VP38rk
         qUDLP1hyMShDP/wYLaRdcTN3WLSO5Z7vf7hRl7psErbQoqDpxrrMJSmjrNAaqOdea+
         4eV3w0fRv+sHQzSE7VthmIOvrPM8OLopLIEpluNEuVr26J4nRzs9CZlUQxo4e8LyQA
         ofB6/aFlR+Axw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Dipen Patel <dipenp@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hte: tegra: fix  'struct of_device_id' build error
Date:   Thu, 15 Dec 2022 17:46:19 +0100
Message-Id: <20221215164626.1209452-1-arnd@kernel.org>
X-Mailer: git-send-email 2.35.1
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

Without the extra #include, this driver produces a build failure
in some configurations.

drivers/hte/hte-tegra194-test.c:96:34: error: array type has incomplete element type 'struct of_device_id'
   96 | static const struct of_device_id tegra_hte_test_of_match[] = {

Fixes: 9a75a7cd03c9 ("hte: Add Tegra HTE test driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/hte/hte-tegra194-test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hte/hte-tegra194-test.c b/drivers/hte/hte-tegra194-test.c
index 5d776a185bd6..ce8c44e79221 100644
--- a/drivers/hte/hte-tegra194-test.c
+++ b/drivers/hte/hte-tegra194-test.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/err.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/interrupt.h>
-- 
2.35.1

