Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9796BE1F0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 08:33:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbjCQHd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 03:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjCQHdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 03:33:25 -0400
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F84F2ED7D;
        Fri, 17 Mar 2023 00:33:22 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0Ve20Ajj_1679038395;
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0Ve20Ajj_1679038395)
          by smtp.aliyun-inc.com;
          Fri, 17 Mar 2023 15:33:19 +0800
From:   Shuai Xue <xueshuai@linux.alibaba.com>
To:     tony.luck@intel.com
Cc:     xueshuai@linux.alibaba.com, baolin.wang@linux.alibaba.com,
        benjamin.cheatham@amd.com, bp@alien8.de, dan.j.williams@intel.com,
        james.morse@arm.com, jaylu102@amd.com, lenb@kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, zhuo.song@linux.alibaba.com
Subject: [PATCH] ACPI: APEI: EINJ: warn on invalid argument when explicitly indicated by platform
Date:   Fri, 17 Mar 2023 15:33:10 +0800
Message-Id: <20230317073310.4237-1-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix to return -EINVAL in the __einj_error_inject() error handling case
instead of -EBUSY, when explicitly indicated by the platform in the status
of the completed operation.

Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
 drivers/acpi/apei/einj.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
index b4373e575660..fa0b4320312e 100644
--- a/drivers/acpi/apei/einj.c
+++ b/drivers/acpi/apei/einj.c
@@ -489,9 +489,15 @@ static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
 	if (rc)
 		return rc;
 	val = apei_exec_ctx_get_output(&ctx);
-	if (val != EINJ_STATUS_SUCCESS)
+	if (val == EINJ_STATUS_FAIL)
 		return -EBUSY;
+	else if (val == EINJ_STATUS_INVAL)
+		return -EINVAL;
 
+	/*
+	 * The error is injected into the platform successfully, then it needs
+	 * to trigger the error.
+	 */
 	rc = apei_exec_run(&ctx, ACPI_EINJ_GET_TRIGGER_TABLE);
 	if (rc)
 		return rc;
-- 
2.20.1.12.g72788fdb

