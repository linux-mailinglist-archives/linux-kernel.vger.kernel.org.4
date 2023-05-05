Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13E266F7B5A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 05:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjEEDEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 23:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbjEEDDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 23:03:51 -0400
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4613B11B7C;
        Thu,  4 May 2023 20:03:50 -0700 (PDT)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4QCFrN1bVGz4y3Zj;
        Fri,  5 May 2023 11:03:48 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
        by mse-fl2.zte.com.cn with SMTP id 34533ca6093308;
        Fri, 5 May 2023 11:03:38 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp02[null])
        by mapi (Zmail) with MAPI id mid31;
        Fri, 5 May 2023 11:03:39 +0800 (CST)
Date:   Fri, 5 May 2023 11:03:39 +0800 (CST)
X-Zmail-TransId: 2afa6454720b650-79091
X-Mailer: Zmail v1.0
Message-ID: <202305051103396748797@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <sumit.semwal@linaro.org>
Cc:     <gustavo@padovan.org>, <christian.koenig@amd.com>,
        <linux-media@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linaro-mm-sig@lists.linaro.org>, <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBkbWEtYnVmL3N5bmNfZmlsZTogVXNlIGZkZ2V0KCk=?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 34533ca6093308
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 64547213.000/4QCFrN1bVGz4y3Zj
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ye Xingchen <ye.xingchen@zte.com.cn>

convert the fget() use to fdget().

Signed-off-by: Ye Xingchen <ye.xingchen@zte.com.cn>
---
 drivers/dma-buf/sync_file.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/dma-buf/sync_file.c b/drivers/dma-buf/sync_file.c
index af57799c86ce..222b13b1bdb8 100644
--- a/drivers/dma-buf/sync_file.c
+++ b/drivers/dma-buf/sync_file.c
@@ -78,18 +78,18 @@ EXPORT_SYMBOL(sync_file_create);

 static struct sync_file *sync_file_fdget(int fd)
 {
-	struct file *file = fget(fd);
+	struct struct fd f = fdget(fd);

-	if (!file)
+	if (!f.file)
 		return NULL;

-	if (file->f_op != &sync_file_fops)
+	if (f.file->f_op != &sync_file_fops)
 		goto err;

-	return file->private_data;
+	return f.file->private_data;

 err:
-	fput(file);
+	fdput(f);
 	return NULL;
 }

-- 
2.25.1
