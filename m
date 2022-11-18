Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A929D62EDA7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 07:34:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240997AbiKRGeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 01:34:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbiKRGd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 01:33:56 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADED665840;
        Thu, 17 Nov 2022 22:33:55 -0800 (PST)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4ND6Rv4vG6zRpK0;
        Fri, 18 Nov 2022 14:33:31 +0800 (CST)
Received: from dggpemm500015.china.huawei.com (7.185.36.181) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 18 Nov 2022 14:33:54 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500015.china.huawei.com
 (7.185.36.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 18 Nov
 2022 14:33:53 +0800
From:   Wang ShaoBo <bobo.shaobowang@huawei.com>
CC:     <rafael.j.wysocki@intel.com>, <rafael@kernel.org>,
        <lenb@kernel.org>, <yu.c.chen@intel.com>,
        <linux-acpi@vger.kernel.org>, <guohanjun@huawei.com>,
        <liwei391@huawei.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] ACPI: pfr_update: use ACPI_FREE() to free acpi_object
Date:   Fri, 18 Nov 2022 14:32:19 +0800
Message-ID: <20221118063219.2612473-3-bobo.shaobowang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221118063219.2612473-1-bobo.shaobowang@huawei.com>
References: <20221118063219.2612473-1-bobo.shaobowang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500015.china.huawei.com (7.185.36.181)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

acpi_evaluate_dsm_typed()/acpi_evaluate_dsm() should be coupled with
ACPI_FREE() to free the ACPI memory, because we need to track the
allocation of acpi_object when ACPI_DBG_TRACK_ALLOCATIONS enabled,
so use ACPI_FREE() instead of kfree().

Fixes: 0db89fa243e5 ("ACPI: Introduce Platform Firmware Runtime Update device driver")
Signed-off-by: Wang ShaoBo <bobo.shaobowang@huawei.com>
---
 drivers/acpi/pfr_update.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/pfr_update.c b/drivers/acpi/pfr_update.c
index 6bb0b778b5da..9d2bdc13253a 100644
--- a/drivers/acpi/pfr_update.c
+++ b/drivers/acpi/pfr_update.c
@@ -178,7 +178,7 @@ static int query_capability(struct pfru_update_cap_info *cap_hdr,
 	ret = 0;
 
 free_acpi_buffer:
-	kfree(out_obj);
+	ACPI_FREE(out_obj);
 
 	return ret;
 }
@@ -224,7 +224,7 @@ static int query_buffer(struct pfru_com_buf_info *info,
 	ret = 0;
 
 free_acpi_buffer:
-	kfree(out_obj);
+	ACPI_FREE(out_obj);
 
 	return ret;
 }
@@ -385,7 +385,7 @@ static int start_update(int action, struct pfru_device *pfru_dev)
 	ret = 0;
 
 free_acpi_buffer:
-	kfree(out_obj);
+	ACPI_FREE(out_obj);
 
 	return ret;
 }
-- 
2.25.1

