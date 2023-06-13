Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A348D72C6CD
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 16:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236794AbjFLOBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 10:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236177AbjFLOA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 10:00:57 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B603310E6
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 07:00:54 -0700 (PDT)
Received: from kwepemm600012.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QftcS0cSHzTl2s;
        Mon, 12 Jun 2023 22:00:24 +0800 (CST)
Received: from build.huawei.com (10.175.101.6) by
 kwepemm600012.china.huawei.com (7.193.23.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 12 Jun 2023 22:00:51 +0800
From:   Wenchao Hao <haowenchao2@huawei.com>
To:     Jan Kara <jack@suse.com>, <linux-kernel@vger.kernel.org>
CC:     <linfeilong@huawei.com>, Wenchao Hao <haowenchao2@huawei.com>
Subject: [PATCH 2/2] udf:check if buffer head's data when getting lvidiu
Date:   Tue, 13 Jun 2023 11:22:54 +0800
Message-ID: <20230613032254.1235752-3-haowenchao2@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20230613032254.1235752-1-haowenchao2@huawei.com>
References: <20230613032254.1235752-1-haowenchao2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600012.china.huawei.com (7.193.23.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_12_24,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can not always assume udf_sb_info->s_lvid_bh's data is valid. If the
data is corrupted, we would get an incorrect offset and cause the
following code access an illegal address.

Signed-off-by: Wenchao Hao <haowenchao2@huawei.com>
---
 fs/udf/super.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/udf/super.c b/fs/udf/super.c
index 6304e3c5c3d9..71481b60c871 100644
--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -114,6 +114,8 @@ struct logicalVolIntegrityDescImpUse *udf_sb_lvidiu(struct super_block *sb)
 
 	if (!UDF_SB(sb)->s_lvid_bh)
 		return NULL;
+	if (!udf_check_tagged_bh(sb, UDF_SB(sb)->s_lvid_bh))
+		return NULL;
 	lvid = (struct logicalVolIntegrityDesc *)UDF_SB(sb)->s_lvid_bh->b_data;
 	partnum = le32_to_cpu(lvid->numOfPartitions);
 	/* The offset is to skip freeSpaceTable and sizeTable arrays */
-- 
2.35.3

