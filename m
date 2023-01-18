Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 035016714A3
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 08:09:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjARHJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 02:09:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjARHIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 02:08:20 -0500
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 206706C54B;
        Tue, 17 Jan 2023 22:35:31 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VZpGQyN_1674023708;
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0VZpGQyN_1674023708)
          by smtp.aliyun-inc.com;
          Wed, 18 Jan 2023 14:35:10 +0800
From:   Shuai Xue <xueshuai@linux.alibaba.com>
To:     rafael@kernel.org, tony.luck@intel.com, bp@alien8.de
Cc:     lenb@kernel.org, james.morse@arm.com, jaylu102@amd.com,
        benjamin.cheatham@amd.com, dan.j.williams@intel.com,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        baolin.wang@linux.alibaba.com, xueshuai@linux.alibaba.com,
        zhuo.song@linux.alibaba.com
Subject: [PATCH] ACPI: APEI: EINJ: Limit error type to 32-bit width
Date:   Wed, 18 Jan 2023 14:35:04 +0800
Message-Id: <20230118063504.58026-1-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bit map of error types to inject is 32-bit width[1]. Add parameter
check to reflect the fact.

[1] ACPI Specification 6.4, Section 18.6.4. Error Types

Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
 drivers/acpi/apei/einj.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
index ab86b2f4e719..b4373e575660 100644
--- a/drivers/acpi/apei/einj.c
+++ b/drivers/acpi/apei/einj.c
@@ -616,6 +616,10 @@ static int error_type_set(void *data, u64 val)
 	u32 available_error_type = 0;
 	u32 tval, vendor;
 
+	/* Only low 32 bits for error type are valid */
+	if (val & GENMASK_ULL(63, 32))
+		return -EINVAL;
+
 	/*
 	 * Vendor defined types have 0x80000000 bit set, and
 	 * are not enumerated by ACPI_EINJ_GET_ERROR_TYPE
-- 
2.20.1.12.g72788fdb

