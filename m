Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CFB96C5C64
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 02:54:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbjCWByM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 21:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjCWByK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 21:54:10 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FCA735B5;
        Wed, 22 Mar 2023 18:54:08 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0VeSOjFT_1679536441;
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0VeSOjFT_1679536441)
          by smtp.aliyun-inc.com;
          Thu, 23 Mar 2023 09:54:04 +0800
From:   Shuai Xue <xueshuai@linux.alibaba.com>
To:     tony.luck@intel.com
Cc:     xueshuai@linux.alibaba.com, baolin.wang@linux.alibaba.com,
        benjamin.cheatham@amd.com, bp@alien8.de, dan.j.williams@intel.com,
        james.morse@arm.com, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, rafael@kernel.org,
        zhuo.song@linux.alibaba.com
Subject: [PATCH v2] ACPI: APEI: EINJ: warn on invalid argument when explicitly indicated by platform
Date:   Thu, 23 Mar 2023 09:53:57 +0800
Message-Id: <20230323015357.8481-1-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230317073310.4237-1-xueshuai@linux.alibaba.com>
References: <20230317073310.4237-1-xueshuai@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

OSPM executes an EXECUTE_OPERATION action to instruct the platform to begin
the injection operation, then executes a GET_COMMAND_STATUS action to
determine the status of the completed operation. The ACPI Specification
documented error codes[1] are:

	0 = Success (Linux #define EINJ_STATUS_SUCCESS)
	1 = Unknown failure (Linux #define EINJ_STATUS_FAIL)
	2 = Invalid Access (Linux #define EINJ_STATUS_INVAL)

The original code report -EBUSY for both "Unknown Failure" and "Invalid
Access" cases. Actually, firmware could do some platform dependent sanity
checks and returns different error codes, e.g. "Invalid Access" to indicate
to the user that the parameters they supplied cannot be used for injection.

To this end, fix to return -EINVAL in the __einj_error_inject() error
handling case instead of always -EBUSY, when explicitly indicated by the
platform in the status of the completed operation.

[1] ACPI Specification 6.5 18.6.1. Error Injection Table

Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
changelog since v1:
- elaborate commit log based on follow up discussion with Tony
- pick up Reviewed-by tag of Tony
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

