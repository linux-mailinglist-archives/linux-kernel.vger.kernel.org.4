Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E00A6F7CD3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 08:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbjEEGMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 02:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjEEGMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 02:12:48 -0400
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F70E1490F
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 23:12:46 -0700 (PDT)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4QCL2N02z5z5B14q;
        Fri,  5 May 2023 14:12:44 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
        by mse-fl1.zte.com.cn with SMTP id 3456Cbab063060;
        Fri, 5 May 2023 14:12:37 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp02[null])
        by mapi (Zmail) with MAPI id mid31;
        Fri, 5 May 2023 14:12:39 +0800 (CST)
Date:   Fri, 5 May 2023 14:12:39 +0800 (CST)
X-Zmail-TransId: 2afa64549e57ffffffff917-7d156
X-Mailer: Zmail v1.0
Message-ID: <202305051412396252364@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <jgg@ziepe.ca>
Cc:     <kevin.tian@intel.com>, <joro@8bytes.org>, <will@kernel.org>,
        <robin.murphy@arm.com>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBpb21tdWZkL3NlbGZ0ZXN0OiBVc2UgZmRnZXQoKSBhbmQgZmRwdXQoKQ==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 3456Cbab063060
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 64549E5C.000/4QCL2N02z5z5B14q
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ye Xingchen <ye.xingchen@zte.com.cn>

convert the fget()/fput() uses to fdget()/fdput().

Signed-off-by: Ye Xingchen <ye.xingchen@zte.com.cn>
---
 drivers/iommu/iommufd/selftest.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 74c2076105d4..d3512fa673a5 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -583,17 +583,16 @@ static const struct file_operations iommfd_test_staccess_fops;

 static struct selftest_access *iommufd_access_get(int fd)
 {
-	struct file *file;
+	struct fd f = fdget(fd);

-	file = fget(fd);
-	if (!file)
+	if (!f.file)
 		return ERR_PTR(-EBADFD);

-	if (file->f_op != &iommfd_test_staccess_fops) {
-		fput(file);
+	if (f.file->f_op != &iommfd_test_staccess_fops) {
+		fdput(f);
 		return ERR_PTR(-EBADFD);
 	}
-	return file->private_data;
+	return f.file->private_data;
 }

 static void iommufd_test_access_unmap(void *data, unsigned long iova,
-- 
2.25.1
