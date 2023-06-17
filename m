Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08642733F70
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 10:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346270AbjFQIHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 04:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232380AbjFQIHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 04:07:42 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 486472720;
        Sat, 17 Jun 2023 01:07:40 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QjpXQ0d10zTkrB;
        Sat, 17 Jun 2023 16:07:02 +0800 (CST)
Received: from huawei.com (10.175.104.170) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Sat, 17 Jun
 2023 16:07:37 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <rafael@kernel.org>
CC:     <lenb@kernel.org>, <james.morse@arm.com>, <tony.luck@intel.com>,
        <bp@alien8.de>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH] ACPI: APEI: mark some functions __init
Date:   Sat, 17 Jun 2023 16:07:08 +0800
Message-ID: <20230617080708.2002287-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.170]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hest_esrc_len() and apei_hest_parse() are only called inside __init
section. So mark them __init too.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 drivers/acpi/apei/hest.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/apei/hest.c b/drivers/acpi/apei/hest.c
index 6aef1ee5e1bd..2d78e808ab8b 100644
--- a/drivers/acpi/apei/hest.c
+++ b/drivers/acpi/apei/hest.c
@@ -55,7 +55,7 @@ static inline bool is_generic_error(struct acpi_hest_header *hest_hdr)
 	       hest_hdr->type == ACPI_HEST_TYPE_GENERIC_ERROR_V2;
 }
 
-static int hest_esrc_len(struct acpi_hest_header *hest_hdr)
+static int __init hest_esrc_len(struct acpi_hest_header *hest_hdr)
 {
 	u16 hest_type = hest_hdr->type;
 	int len;
@@ -88,7 +88,7 @@ static int hest_esrc_len(struct acpi_hest_header *hest_hdr)
 
 typedef int (*apei_hest_func_t)(struct acpi_hest_header *hest_hdr, void *data);
 
-static int apei_hest_parse(apei_hest_func_t func, void *data)
+static int __init apei_hest_parse(apei_hest_func_t func, void *data)
 {
 	struct acpi_hest_header *hest_hdr;
 	int i, rc, len;
-- 
2.27.0

