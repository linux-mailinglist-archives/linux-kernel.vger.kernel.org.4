Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01A0663779E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 12:26:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbiKXL0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 06:26:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiKXL0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 06:26:20 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AB9B2529C;
        Thu, 24 Nov 2022 03:26:19 -0800 (PST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4NHwfx2tNGz5BNRf;
        Thu, 24 Nov 2022 19:26:17 +0800 (CST)
Received: from szxlzmapp04.zte.com.cn ([10.5.231.166])
        by mse-fl2.zte.com.cn with SMTP id 2AOBQAQp098428;
        Thu, 24 Nov 2022 19:26:10 +0800 (+08)
        (envelope-from yang.yang29@zte.com.cn)
Received: from mapi (szxlzmapp02[null])
        by mapi (Zmail) with MAPI id mid14;
        Thu, 24 Nov 2022 19:26:13 +0800 (CST)
Date:   Thu, 24 Nov 2022 19:26:13 +0800 (CST)
X-Zmail-TransId: 2b04637f54d5ffffffffd03e764f
X-Mailer: Zmail v1.0
Message-ID: <202211241926133236370@zte.com.cn>
Mime-Version: 1.0
From:   <yang.yang29@zte.com.cn>
To:     <sumit.semwal@linaro.org>
Cc:     <christian.koenig@amd.com>, <linux-media@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        <linaro-mm-sig@lists.linaro.org>, <linux-kernel@vger.kernel.org>,
        <xu.panda@zte.com.cn>, <yang.yang29@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIGRtYS1idWY6IHVzZSBzdHJzY3B5KCkgdG8gaW5zdGVhZCBvZiBzdHJsY3B5KCk=?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 2AOBQAQp098428
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.138.novalocal with ID 637F54D9.000 by FangMail milter!
X-FangMail-Envelope: 1669289177/4NHwfx2tNGz5BNRf/637F54D9.000/10.5.228.133/[10.5.228.133]/mse-fl2.zte.com.cn/<yang.yang29@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 637F54D9.000/4NHwfx2tNGz5BNRf
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xu Panda <xu.panda@zte.com.cn>

The implementation of strscpy() is more robust and safer.
That's now the recommended way to copy NUL terminated strings.

Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
Signed-off-by: Yang Yang <yang.yang29@zte.com>
---
 drivers/dma-buf/dma-buf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index b6c36914e7c6..485cf4f3431e 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -51,7 +51,7 @@ static char *dmabuffs_dname(struct dentry *dentry, char *buffer, int buflen)
 	dmabuf = dentry->d_fsdata;
 	spin_lock(&dmabuf->name_lock);
 	if (dmabuf->name)
-		ret = strlcpy(name, dmabuf->name, DMA_BUF_NAME_LEN);
+		ret = strscpy(name, dmabuf->name, DMA_BUF_NAME_LEN);
 	spin_unlock(&dmabuf->name_lock);

 	return dynamic_dname(buffer, buflen, "/%s:%s",
-- 
2.15.2
