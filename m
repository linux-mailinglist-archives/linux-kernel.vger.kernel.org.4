Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9B066F7AD5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 04:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbjEECTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 22:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbjEECTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 22:19:02 -0400
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F71A11DBC;
        Thu,  4 May 2023 19:18:58 -0700 (PDT)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4QCDrc3Hn0z8RTWm;
        Fri,  5 May 2023 10:18:56 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
        by mse-fl1.zte.com.cn with SMTP id 3452IkoU063354;
        Fri, 5 May 2023 10:18:46 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp02[null])
        by mapi (Zmail) with MAPI id mid31;
        Fri, 5 May 2023 10:18:47 +0800 (CST)
Date:   Fri, 5 May 2023 10:18:47 +0800 (CST)
X-Zmail-TransId: 2afa645467877be-c82af
X-Mailer: Zmail v1.0
Message-ID: <202305051018472856954@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <sumit.semwal@linaro.org>
Cc:     <christian.koenig@amd.com>, <linux-media@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        <linaro-mm-sig@lists.linaro.org>, <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBkbWEtYnVmOiBVc2UgZmRnZXQoKQ==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 3452IkoU063354
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 64546790.001/4QCDrc3Hn0z8RTWm
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ye Xingchen <ye.xingchen@zte.com.cn>

convert the fget() use to fdget().

Signed-off-by: Ye Xingchen <ye.xingchen@zte.com.cn>
---
 drivers/dma-buf/dma-buf.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index aa4ea8530cb3..bf4980b6f80c 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -729,19 +729,17 @@ EXPORT_SYMBOL_NS_GPL(dma_buf_fd, DMA_BUF);
  */
 struct dma_buf *dma_buf_get(int fd)
 {
-	struct file *file;
-
-	file = fget(fd);
+	struct fd f = fdget(fd);

-	if (!file)
+	if (!f.file)
 		return ERR_PTR(-EBADF);

-	if (!is_dma_buf_file(file)) {
-		fput(file);
+	if (!is_dma_buf_file(f.file)) {
+		fdput(f);
 		return ERR_PTR(-EINVAL);
 	}

-	return file->private_data;
+	return f.file->private_data;
 }
 EXPORT_SYMBOL_NS_GPL(dma_buf_get, DMA_BUF);

-- 
2.25.
